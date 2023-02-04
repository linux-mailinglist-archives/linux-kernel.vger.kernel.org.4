Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B39B68ABFA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjBDSuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjBDSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79AC76BD;
        Sat,  4 Feb 2023 10:50:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 771E260A24;
        Sat,  4 Feb 2023 18:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04B3C4339C;
        Sat,  4 Feb 2023 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675536614;
        bh=wciRKNLfd2O3N94Bf4qAswd399veVPfGCY7eLVyHn5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t7WjJuQdvlPfktg0oHqSw7YA4rDDsp1Py0qXLyzkJ2gUHCiEXUon0SLY3mg7FtDSd
         lL1Xjg2ydlp7p0/ZwyxDXcEYSrpY5tWWVX8NArPrdkR7ejHIt+2DqWMqv1FdGaqdOQ
         vTFma0peHtNqhmtsa4wMdXZbPNAY8VkzbRQDyF61Dbhyree+q/+rOMgBMfCTY+98P2
         K9s+NU9fPYq2CF585fb8Db45ciFl0XCmYbQrurrnAJ0nA/BdNLYFvcwpEFoLJ/RT4o
         gybwCflAObutDzqMF+5lP+oFVeyj+M0wlf2sHM3aQAS99TQkLpvfxOEo4IjgwzCUav
         9W+PqHghcDoHQ==
Received: by mail-oi1-f176.google.com with SMTP id s66so6819352oib.7;
        Sat, 04 Feb 2023 10:50:14 -0800 (PST)
X-Gm-Message-State: AO0yUKXF0bWMAucN0Wq0nmemkkHFb0MjQxmG5FiaxE6xhc7hidFfs/gs
        VlSPAbRCf5KbqhKdaVN+p4RTo2B0+cMw/NZgHnQ=
X-Google-Smtp-Source: AK7set8kSC4lybtRg29gu0nEtjFDYQAKH8gXlwwyuldC2NQqfdIZHdBJNJL3KDnDA/WuDZhHN/AtcU5qM78q9Mpm/aY=
X-Received: by 2002:a05:6808:16a3:b0:377:f944:a8b7 with SMTP id
 bb35-20020a05680816a300b00377f944a8b7mr486307oib.194.1675536614087; Sat, 04
 Feb 2023 10:50:14 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230203123220eucas1p2f9686f08bcb22cf1e21aefd25070282a@eucas1p2.samsung.com>
 <20230203123140.2227880-1-l.stelmach@samsung.com>
In-Reply-To: <20230203123140.2227880-1-l.stelmach@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Feb 2023 03:49:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSJ8X8_TpxK=SBNWrAikHg4DRQ4yYi=NQDGXqefKyGog@mail.gmail.com>
Message-ID: <CAK7LNASSJ8X8_TpxK=SBNWrAikHg4DRQ4yYi=NQDGXqefKyGog@mail.gmail.com>
Subject: Re: [PATCH] merge_config.sh: do not report some differencess between
 input and output
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 9:32 PM =C5=81ukasz Stelmach <l.stelmach@samsung.com=
> wrote:
>
> If an input config file contains CONFIG_FOO=3Dn the output one
> will contain a line '# CONFIG_FOO is not set'. merge_config.sh
> should not report it as difference because the end result of
> CONFIG_FOO being disabled is achieved.
>
> Inexistence of CONFIG_FOO (because of unment dependencies) in case
> CONFIG_FOO=3Dn is requested, should also be ignored.
>
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  scripts/kconfig/merge_config.sh | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_conf=
ig.sh
> index e5b46980c22a..c6fd6722f1a4 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -196,9 +196,13 @@ for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_C=
ONFIG_EXP2" $TMP_FILE); do
>         REQUESTED_VAL=3D$(grep -w -e "$CFG" $TMP_FILE)
>         ACTUAL_VAL=3D$(grep -w -e "$CFG" "$KCONFIG_CONFIG" || true)
>         if [ "x$REQUESTED_VAL" !=3D "x$ACTUAL_VAL" ] ; then
> -               echo "Value requested for $CFG not in final .config"
> -               echo "Requested value:  $REQUESTED_VAL"
> -               echo "Actual value:     $ACTUAL_VAL"
> -               echo ""
> +               if [ "x$REQUESTED_VAL" !=3D "x$CFG=3Dn" -o \
> +                    \( "x$ACTUAL_VAL" !=3D "x"  -a \
> +                       "x$ACTUAL_VAL" !=3D "x# $CFG is not set" \) ]; th=
en
> +                       echo "Value requested for $CFG not in final .conf=
ig"
> +                       echo "Requested value:  $REQUESTED_VAL"
> +                       echo "Actual value:     $ACTUAL_VAL"
> +                       echo ""
> +               fi
>         fi
>  done
> --
> 2.30.2
>



[Problem 1]

The behaviour is inconsistent
between =3Dn and "is not set".



 Requested: CONFIG_FOO=3Dn
 Actual   : missing due to unmet dep

     -> suppress the report


 Requested: CONFIG_FOO is not set
 Actual   : missing due to unmet dep

     -> show the report



[Problem 2]

This patch introduces another consistency
because line 148 may report something similar.





--
Best Regards
Masahiro Yamada
