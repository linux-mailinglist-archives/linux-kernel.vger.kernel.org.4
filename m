Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500426C4132
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCVDlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCVDk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:40:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203405ADE9;
        Tue, 21 Mar 2023 20:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F5CB81AF8;
        Wed, 22 Mar 2023 03:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF54C433D2;
        Wed, 22 Mar 2023 03:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679456441;
        bh=UwtGB3rw8LcXqubG8rIlvKuhQG9IX5FWTqplcKL6hK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U7jCJpuKkrasEsm1skJSHc6swKBYv4/pNOlnQvmohxWo08F1XCzPqEgu4gwrajeUK
         t5QKkI31bcg5vZXfOHPysPRZAWgStgDHnkuMcz1hsGFnwOCXeDvlj8F/MQIjvwgz61
         ZvPBUJX2sHwM4jjjomcfRGoVvhNrSmwT/TLPDFHD96UMvGDhPfW9SSqJP1Fil8LvmQ
         +SM6kUNQ03hEr+AQSkWtU/hdEilGb+isfc98ubB2BYDTSnO4mjhMkohY/rSbdP5zzX
         /eqR4e8jw2tNvQM3aTp+bf/5+INygqldmexgZrHMtUQQbhLJf6A/7ZOxZKH6NWbT5q
         TxBkIGcsLge9w==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-177ca271cb8so18319550fac.2;
        Tue, 21 Mar 2023 20:40:41 -0700 (PDT)
X-Gm-Message-State: AAQBX9dCN6s/sd4vphjAgwK/D3RL9toqM/W5xIdhGTtYUu9NBMmCPv83
        32LImRhp9zqGvLKhzq3BxcoNkpAMF2dsZAm5RjU=
X-Google-Smtp-Source: AKy350ZdFjUh7xYHJcDwY34s1k2AaCtlnVnxko/Zv/Om7WBQQv5KFArj63B6aim3QjfklaTTG0DbfsyBlMhvRU2di7k=
X-Received: by 2002:a05:6871:f8c:b0:17b:1895:a637 with SMTP id
 vn12-20020a0568710f8c00b0017b1895a637mr28224oab.11.1679456440624; Tue, 21 Mar
 2023 20:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <17ab5a21-5512-5388-f9fa-c462b2ebd351@alu.unizg.hr> <7349a16f-6e7e-51d4-4686-ec7e688d891b@alu.unizg.hr>
In-Reply-To: <7349a16f-6e7e-51d4-4686-ec7e688d891b@alu.unizg.hr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Mar 2023 12:40:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxu0hjOp6N7jnLWvqWb0h3LPPSAgF7+7+c-eB7Fmc9dA@mail.gmail.com>
Message-ID: <CAK7LNARxu0hjOp6N7jnLWvqWb0h3LPPSAgF7+7+c-eB7Fmc9dA@mail.gmail.com>
Subject: Re: BUG: scripts/kconfig/merge_config.sh: typo in variable name
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kbuild@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 5:14=E2=80=AFAM Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 3/21/2023 2:04 PM, Mirsad Goran Todorovac wrote:
> > Hi all,
> >
> > There is a typo in variable name in scripts/kconfig/merge_config.sh, wi=
th the
> > script returning:
> >
> > $ ./scripts/kconfig/merge_config.sh -y -m ../.config tools/testing/self=
tests/net/config
> > ./scripts/kconfig/merge_config.sh: 148: ./scripts/kconfig/merge_config.=
sh: Previous: not found
> >
> > Problem is probably best explained by this diff:
> >
> > ---
> > diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_co=
nfig.sh
> > index 32620de473ad..902eb429b9db 100755
> > --- a/scripts/kconfig/merge_config.sh
> > +++ b/scripts/kconfig/merge_config.sh
> > @@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
> >                  NEW_VAL=3D$(grep -w $CFG $MERGE_FILE)
> >                  BUILTIN_FLAG=3Dfalse
> >                  if [ "$BUILTIN" =3D "true" ] && [ "${NEW_VAL#CONFIG_*=
=3D}" =3D "m" ] && [ "${PREV_VAL#CONFIG_*=3D}" =3D "y" ]; then
> > -                       ${WARNOVVERIDE} Previous  value: $PREV_VAL
> > +                       ${WARNOVERRIDE} Previous  value: $PREV_VAL
> >                          ${WARNOVERRIDE} New value:       $NEW_VAL
> >                          ${WARNOVERRIDE} -y passed, will not demote y t=
o m
> >                          ${WARNOVERRIDE}
> >
> > Hope this helps.
>
> P.S.
>
> Later I thought of searching the committer of the patch that introduced t=
he change,
> so I Cc:ed Mark.
>
> Best regards,
> Mirsad

Good catch.

Will you please send a patch with your signed-off?







> --
> Mirsad Todorovac
> Sistem in=C5=BEenjer
> Grafi=C4=8Dki fakultet | Akademija likovnih umjetnosti
> Sveu=C4=8Dili=C5=A1te u Zagrebu
>
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
> tel. +385 (0)1 3711 451
> mob. +385 91 57 88 355



--=20
Best Regards
Masahiro Yamada
