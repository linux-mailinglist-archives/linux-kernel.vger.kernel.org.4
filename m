Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F306263CFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiK3HXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3HXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:23:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07705A6D5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5C461A47
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB90C433D6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669792979;
        bh=l8TG0zDhu2CtfxNlo3/zXzaH7ZIK0gStVku6u+BPku4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LTp7lFL1uBRZI7S3tOANwcYEZwp0WoQj3LT9RPG0sgVQLz4ZP6akLMOXzpiZ5xvji
         /ABbXWcD5ppaarzrPr4BCdAfTsWrqE+4k6SzYVQy+GDaIGjIeD4OJZxiXTL7ViiwjB
         6gVa2/JzN0vso1FXhvZ5kj43NNZqRtzJiOJm2+tOtes+5RHWil2JCTHKy0NJNkOuM2
         K1ExdELjpUiejxLn+w/+z8BE9RDYu+cgidFw86G4+Q6cUu01dMPOh7a0ST+6PiZt/G
         nvlCR9H9WwKFtkUqM3msKFe8WGicuQ7DgAhsFsEQo6WcYZ0R13S3dFuJoAg3ip13Eb
         nTg1QjxNwI0dw==
Received: by mail-ej1-f42.google.com with SMTP id ha10so39241818ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:22:59 -0800 (PST)
X-Gm-Message-State: ANoB5pmi00LcGhzSjnKgseOFH4NcfS8fWOkgTN4IJjSSvV4wgNRdVZPR
        7Yd3GYgK3DvjX5v91JTDloXUSjPzppTDsZiul4Y=
X-Google-Smtp-Source: AA0mqf49bMbZfOFPJ53XdR+Xd3Pu2yDNAwaf+OSHZXIyf8yZNlV4ZZsWp/eqX8qI99PoUS2/j/0pUXpnWhRcE62O46I=
X-Received: by 2002:a17:906:99d3:b0:78d:c7fd:f755 with SMTP id
 s19-20020a17090699d300b0078dc7fdf755mr36020981ejn.702.1669792977892; Tue, 29
 Nov 2022 23:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20221128154506.2691-1-suagrfillet@gmail.com> <CAAYs2=iYn8sLQB8oh+RzTKd2VKs8MXOLX6Mwpamx5gdVVN6mkA@mail.gmail.com>
In-Reply-To: <CAAYs2=iYn8sLQB8oh+RzTKd2VKs8MXOLX6Mwpamx5gdVVN6mkA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 30 Nov 2022 15:22:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQKgqs4zePmW00Nd1PAUk76ZCRfyfPFzigQn3Pg0-=SEQ@mail.gmail.com>
Message-ID: <CAJF2gTQKgqs4zePmW00Nd1PAUk76ZCRfyfPFzigQn3Pg0-=SEQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv/ftrace: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, wangkefeng.wang@huawei.com,
        juerg.haefliger@canonical.com, anshuman.khandual@arm.com,
        alexandre.ghiti@canonical.com, conor.dooley@microchip.com,
        atishp@atishpatra.org, heiko@sntech.de, palmer@dabbelt.com,
        apatel@ventanamicro.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 29, 2022 at 8:05 PM Song Shuai <suagrfillet@gmail.com> wrote:
>
> Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=80 15:45=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Song Shuai <suagrfillet@gmail.com>
> >
> > In RISC-V, -fpatchable-function-entry option is used to support
> > dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> > PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> > don't have to be called to create the __mcount_loc section before
> > the vmlinux linking.
> >
> > Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> > Makefile not to run recordmcount.
> >
> > Link: https://lore.kernel.org/linux-riscv/CAAYs2=3Dj3Eak9vU6xbAw0zPuoh0=
0rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > Tested-by: Guo Ren <guoren@kernel.org>
> This patch has conflicts with the commit ("riscv: ftrace: Add
> DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> support") and its next commit in this file.
>
> How about reposting this patch based on the above commits and folding
> it into the v5 version?
Okay, it's the proper reason to merge them. Thx!

>
> Here pastes the link for your convenience.
> https://lore.kernel.org/linux-riscv/20221129033230.255947-7-guoren@kernel=
.org/T/#u
>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index fa78595a6089..afc520a45ded 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -277,6 +277,7 @@ config ARCH_RV64I
> >         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option=
,-fpatchable-function-entry=3D8)
> >         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > +       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FT=
RACE
> >         select HAVE_FUNCTION_GRAPH_TRACER
> >         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> >         select SWIOTLB if MMU
> > --
> > 2.34.1
> >
>
>
> --
> Thanks,
> Song



--=20
Best Regards
 Guo Ren
