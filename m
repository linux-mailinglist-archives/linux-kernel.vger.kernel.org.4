Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985BA645649
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiLGJQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiLGJQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:16:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C42FFF9;
        Wed,  7 Dec 2022 01:16:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 055C560F0A;
        Wed,  7 Dec 2022 09:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B959C433B5;
        Wed,  7 Dec 2022 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670404563;
        bh=M6Ekm/pBdbN2VgTeBU6QuIeBCliKnzJIhys71gOS+d0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SBj3erXrpM7SKu2ifbOUpX3wKID68lmLvBnU0RGS2/++cQNasZXKvMM2OJ9LTK1eh
         gc8Ub8ieF6mOax/guLupkvNN6UCV9Mlz86F13PIukxhrLZGPGKnk4zG2kpPmEC5Hws
         AVdIYQLv09SWsTNXr+6/3iv66otl/zTN+ac2d1BPO1ZREPcEAGbXCKW88gm/jAnON9
         uSsr2h5EBygWTHNAoFmrj2uiPvmrUAs6uOc9JFBFpEuzElQvo4tzB1EWvZ8l7LUTpK
         TGS71hUMTk9TFeTQU7+lGkMAqzsXcPRhYRnBmXZkFwhojgKS2+ihPibqENF75FZoCc
         lPOvHVd3/8j9g==
Received: by mail-ej1-f53.google.com with SMTP id m18so10914503eji.5;
        Wed, 07 Dec 2022 01:16:03 -0800 (PST)
X-Gm-Message-State: ANoB5pn3LdjrlVLsy6J/lbjfi2BitRw4GAsD0k6hUdIM2yEWTOAnv6fN
        9LQjLhcdP0upuFkGrHMRLgkvnHQH2OztbB0iUqQ=
X-Google-Smtp-Source: AA0mqf67yTNxeGO6KdbhCdkH31rJ/Paiugzi9lc5kAdca+uBigxLbwyxQZlYijCAZ9E2wUfKATEqoUcb5D3fczCp98c=
X-Received: by 2002:a17:906:8309:b0:7c0:dab0:d722 with SMTP id
 j9-20020a170906830900b007c0dab0d722mr13703762ejx.353.1670404561525; Wed, 07
 Dec 2022 01:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
 <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
 <Y4/KoiFhdvRBDdzH@spud> <CAJF2gTQX6361ME9UkOykvUEQifqioLMqovbfpqugkk174pKqfA@mail.gmail.com>
 <Y5BJ/EeBTEJK2QLF@spud>
In-Reply-To: <Y5BJ/EeBTEJK2QLF@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Dec 2022 17:15:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRFif+Ntkq0MUekRy74uFn1gnzZcGNOAdQakNi68djS_g@mail.gmail.com>
Message-ID: <CAJF2gTRFif+Ntkq0MUekRy74uFn1gnzZcGNOAdQakNi68djS_g@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        mick@ics.forth.gr, corbet@lwn.net, alexandre.ghiti@canonical.com,
        vgoyal@redhat.com, bhe@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        bagasdotme@gmail.com, dyoung@redhat.com,
        Palmer Dabbelt <palmer@dabbelt.com>, heiko@sntech.de,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        hschauhan@nulltrace.org, yixun.lan@gmail.com,
        kexec@lists.infradead.org, heinrich.schuchardt@canonical.com,
        linux-doc@vger.kernel.org, crash-utility@redhat.com,
        linux-kernel@vger.kernel.org, k-hagio-ab@nec.com,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 4:08 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Wed, Dec 07, 2022 at 11:34:57AM +0800, Guo Ren wrote:
> > On Wed, Dec 7, 2022 at 7:05 AM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > Hey Palmer, Xianting,
> > >
> > > On Fri, Dec 02, 2022 at 04:49:39PM -0800, Palmer Dabbelt wrote:
> > > > On Wed, 26 Oct 2022 22:42:06 +0800, Xianting Tian wrote:
> > > > > As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> > > > > need to update according to Bagas's comments.
> > > > > https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> > > > >
> > > > > As others patches in above patch set already applied, so this patch set only contains below two
> > > > > patches.
> > > > >
> > > > > [...]
> > > >
> > > > Applied, thanks!
> > > >
> > > > [1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
> > > >       https://git.kernel.org/palmer/c/649d6b1019a2
> > >
> > > So this patch seems to be causing issues for the nommu build:
> > > https://lore.kernel.org/oe-kbuild-all/202212062250.tR0otHcz-lkp@intel.com/
> > >
> > > I had a bit of a poke at trying to see if there were some headers we
> > > could pull in before actually checking the .config only to see:
> > > # CONFIG_MMU is not set
> > >
> > > Do we have to wrap the whole thing in a `#ifdef CONFIG_MMU` to fix
> > > compilation here?
> > The problem does not belong to the patch.
> >
> > Could I send a fixup patch? like this?
>
> That seems like a sane dependancy, but did you build that config?
> This doesn't fix the problem for me :/
Sorry, It's the wrong fixup. Here is the new version, and tested. Thx
for the report.

https://lore.kernel.org/linux-riscv/20221207091112.2258674-1-guoren@kernel.org/

>
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ef8d66de5f38..d8c07999426c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -512,6 +512,7 @@ config ARCH_HAS_KEXEC_PURGATORY
> >
> >  config CRASH_DUMP
> >         bool "Build kdump crash kernel"
> > +       depends on KEXEC
> >         help
> >           Generate crash dump after being started by kexec. This should
> >           be normally only set in special crash dump kernels which are
> >
> > >
> > > Thanks,
> > > Conor.
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



-- 
Best Regards
 Guo Ren
