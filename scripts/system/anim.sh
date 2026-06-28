allanime_refr="https://allanime.to"
allanime_base="allanime.day"
allanime_api="https://api.${allanime_base}"
get_links() {
    episode_link="$(curl -e "$allanime_refr" -s "https://${allanime_base}$*" -A "$agent" | sed 's|},{|\
|g' | sed -nE 's|.*link":"([^"]*)".*"resolutionStr":"([^"]*)".*|\2 >\1|p;s|.*hls","url":"([^"]*)".*"hardsub_lang":"en-US".*|\1|p')"

    case "$episode_link" in
        *repackager.wixmp.com*)
            extract_link=$(printf "%s" "$episode_link" | cut -d'>' -f2 | sed 's|repackager.wixmp.com/||g;s|\.urlset.*||g')
            for j in $(printf "%s" "$episode_link" | sed -nE 's|.*/,([^/]*),/mp4.*|\1|p' | sed 's|,|\
|g'); do
                printf "%s >%s\n" "$j" "$extract_link" | sed "s|,[^/]*|${j}|g"
            done | sort -nr
            ;;
        *vipanicdn* | *anifastcdn*)
            if printf "%s" "$episode_link" | head -1 | grep -q "original.m3u"; then
                printf "%s" "$episode_link"
            else
                extract_link=$(printf "%s" "$episode_link" | head -1 | cut -d'>' -f2)
                relative_link=$(printf "%s" "$extract_link" | sed 's|[^/]*$||')
                curl -e "$allanime_refr" -s "$extract_link" -A "$agent" | sed 's|^#.*x||g; s|,.*|p|g; /^#/d; $!N; s|\
| >|' | sed "s|>|>${relative_link}|g" | sort -nr
            fi
            ;;
        *) [ -n "$episode_link" ] && printf "%s\n" "$episode_link" ;;
    esac
    [ -z "$ANI_CLI_NON_INTERACTIVE" ] && printf "\033[1;32m%s\033[0m Links Fetched\n" "$provider_name" 1>&2
}

echo "$episode_link"
