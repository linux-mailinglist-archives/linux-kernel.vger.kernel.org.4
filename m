Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD776C5F95
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCWGZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWGZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E381ADFA;
        Wed, 22 Mar 2023 23:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4EB62474;
        Thu, 23 Mar 2023 06:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BD2C4339B;
        Thu, 23 Mar 2023 06:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679552698;
        bh=w9Ao7cH0pGPsEfJbtTzl3sq2ipsj2D5zZKW+SIl5uYE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SVAigotbftAI3PjqBv+vwwwbemPq/dqLgueuXaypEFFzqVxyTl0U+GhMdQI1Iu8t8
         ALc6SLEFkFEulBp15Qv1nvSikWvsZI+SQIS9SuAb0GGGuNAML9fTbXWAVhKZj306bM
         YrHstZpx6qWsYCDVnXn5OGOd37KCX1OIsedB5H8VqlnNwIkGooQIjbK8r4uEmhdhkS
         iU6HIqVrARsdwJR8R5oFfpkhqh7y45/l7cj9kcHcn/i71CbCYN/xnNwSAwCFEIb7UO
         j8fcPY+OUbKYsL7kNaXB7M/5E+vrrRJb8VdfJo74cLHSWLe3m2N9a7TRT1gJM2iX3i
         c2PmBQf1RfX4A==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso21742077fac.4;
        Wed, 22 Mar 2023 23:24:58 -0700 (PDT)
X-Gm-Message-State: AO0yUKXOWEgBIJLuT1RF4vQ14pV+WEkUvHRWYTnCu6c2DvU2P89f5Rz7
        lgE337nWDzCr80hlk0GqFKa5ro3jzK16xd8+6G8=
X-Google-Smtp-Source: AKy350bUdkj7ZUbSk/lzBDCm+OuMdsZGjDqrN7Jo4LFIes+c0qHpmCIpgQYfswkEDwHj0mg68CXJ+bDPmAggHg3Ojno=
X-Received: by 2002:a05:6870:ea86:b0:17e:2e88:40dc with SMTP id
 s6-20020a056870ea8600b0017e2e8840dcmr629978oap.11.1679552697824; Wed, 22 Mar
 2023 23:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
 <c93723aa-f01c-9f1e-c9c7-aa79f38390c1@infradead.org> <cb386732-7509-497d-8641-473ad853c9ed@alu.unizg.hr>
In-Reply-To: <cb386732-7509-497d-8641-473ad853c9ed@alu.unizg.hr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Mar 2023 15:24:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAS7DEtpS2HMK=a7egwRdj-uD9JhxsOcKpfpstiiFLhQ@mail.gmail.com>
Message-ID: <CAK7LNARAS7DEtpS2HMK=a7egwRdj-uD9JhxsOcKpfpstiiFLhQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] scripts: merge_config: Fix typo in variable name.
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 3:15=E2=80=AFAM Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 22. 03. 2023. 16:20, Randy Dunlap wrote:
> >
> >
> > On 3/22/23 01:51, Mirsad Goran Todorovac wrote:
> >> ${WARNOVERRIDE} was misspelled as ${WARNOVVERIDE}, which caused a shel=
l
> >> syntax error in certain paths of the script execution.
> >>
> >
> > Fixes: 46dff8d7e381e ("scripts: merge_config: Add option to suppress wa=
rning on overrides")
> >
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> >
> > Thanks.
>
> Hi, Randy,
>
> I think this time thanks go to the Heavens, for preserving my physical in=
tegrity.
>
> Though I don't know of a bike with ABS.




Applied to linux-kbuild/fixes,
fixing another typo "Signed-of-by".


You do not need to spell it out by yourself.

"git commit -s" will insert the Signed-off-by tag.







> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Masahiro Yamada <masahiroy@kernel.org>
> >> Cc: linux-kbuild@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-of-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> >> ---
> >>  scripts/kconfig/merge_config.sh | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_c=
onfig.sh
> >> index 32620de473ad..902eb429b9db 100755
> >> --- a/scripts/kconfig/merge_config.sh
> >> +++ b/scripts/kconfig/merge_config.sh
> >> @@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
> >>              NEW_VAL=3D$(grep -w $CFG $MERGE_FILE)
> >>              BUILTIN_FLAG=3Dfalse
> >>              if [ "$BUILTIN" =3D "true" ] && [ "${NEW_VAL#CONFIG_*=3D}=
" =3D "m" ] && [ "${PREV_VAL#CONFIG_*=3D}" =3D "y" ]; then
> >> -                    ${WARNOVVERIDE} Previous  value: $PREV_VAL
> >> +                    ${WARNOVERRIDE} Previous  value: $PREV_VAL
> >>                      ${WARNOVERRIDE} New value:       $NEW_VAL
> >>                      ${WARNOVERRIDE} -y passed, will not demote y to m
> >>                      ${WARNOVERRIDE}
>
> Best regards,
> Mirsad
>
> --
> Mirsad Goran Todorovac
> Sistem in=C5=BEenjer
> Grafi=C4=8Dki fakultet | Akademija likovnih umjetnosti
> Sveu=C4=8Dili=C5=A1te u Zagrebu
>
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
> The European Union
>


--=20
Best Regards
Masahiro Yamada
