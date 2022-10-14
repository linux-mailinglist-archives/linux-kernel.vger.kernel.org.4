Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7928E5FEEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJNNb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJNNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:31:25 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7AC1C7104;
        Fri, 14 Oct 2022 06:31:23 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 29EDVAbm009635;
        Fri, 14 Oct 2022 22:31:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 29EDVAbm009635
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665754271;
        bh=eoO4dT7/oE91n2LdemDyH/9TSUzar9QMEDiS2eiitmQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ATiYKVcA4e0RZgOhzHxW9xgv1sxtWf++e8DH9R3JQ9uLDt6a3cqaZoN5roh7LV38L
         qgMxVuPIN+uLvryPk8kqgft94DHItd8JK/4cBfo4f38am5XZag4ZX3aPC6P9fLU6Wf
         RyiUHQSE5WpfCHdmrW5Vzl8MEPpqEGxoA1emP1xX6RlColJpIZ6bpBwORCZNlZXem7
         1x806h4Zn5I7RJXxuhG05CmDvDULTSe/8zuZPIu+zLTkKnIZgE05dLLMizSVNwmLdD
         PktZd95AeD2TFiywRCpw/tSSlcTZJSyw0Yw8h9J894NiwgLCyCziyZPfMKrWzDgVtD
         pBlntivHho8kw==
X-Nifty-SrcIP: [209.85.160.45]
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so5814250fac.11;
        Fri, 14 Oct 2022 06:31:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf0L7PBMCJYSAUkd5e+7h7LiaFRQ6RARmSnvQB4wYJcNA2cRPXVT
        QeqbfMuMwDP/oZGs8gPk7Vvmgc/nC8eqSXQvPmc=
X-Google-Smtp-Source: AMsMyM48rOk4RS1W8P1kWSTh8sIj+I5oTEn0bZai5fiS3d4C6lV+k5+G6w/5CYS/6+156Yhy0F/Kb6wcoz3pZhGxiuw=
X-Received: by 2002:a05:6870:8a09:b0:132:554d:2f3d with SMTP id
 p9-20020a0568708a0900b00132554d2f3dmr8390681oaq.194.1665754269746; Fri, 14
 Oct 2022 06:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221007203236.1750890-1-ndesaulniers@google.com>
 <Y0htZDJoTuQegVQR@dev-arch.thelio-3990X> <20221013204151.skzateatn2keencb@google.com>
 <CAKwvOdmoXLvfgEWx740mw+Uqy3nfPM=a7ywVeOJ5XivGT=yRog@mail.gmail.com>
In-Reply-To: <CAKwvOdmoXLvfgEWx740mw+Uqy3nfPM=a7ywVeOJ5XivGT=yRog@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 14 Oct 2022 22:30:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT7yY3VL=so0+h=fsefT2QXsKHn4KjCFJ5VtGGkvSRjLg@mail.gmail.com>
Message-ID: <CAK7LNAT7yY3VL=so0+h=fsefT2QXsKHn4KjCFJ5VtGGkvSRjLg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add -fno-discard-value-names to cmd_cc_ll_c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 5:54 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Oct 13, 2022 at 1:41 PM Fangrui Song <maskray@google.com> wrote:
> >
> > On 2022-10-13, Nathan Chancellor wrote:
> > >On Fri, Oct 07, 2022 at 01:32:36PM -0700, Nick Desaulniers wrote:
> > >> When debugging LLVM IR, it can be handy for clang to not discard value
> > >> names used for local variables and parameters. Compare the generated IR.
> > >>
> > >> Implicit Default (-fdiscard-value-names):
> > >>   define i32 @core_sys_select(i32 %0, ptr %1, ptr %2, ptr %3, ptr %4) {
> > >>     %6 = alloca i64
> > >>     %7 = alloca %struct.poll_wqueues
> > >>     %8 = alloca [64 x i32]
> > >>
> > >> Explicit -fno-discard-value-names:
> > >>   define i32 @core_sys_select(i32 %n, ptr %inp, ptr %outp, ptr %exp,
> > >>                               ptr %end_time) {
> > >>     %expire.i = alloca i64
> > >>     %table.i = alloca %struct.poll_wqueues
> > >>     %stack_fds = alloca [64 x i32]
> > >>
> > >> The rule for generating human readable LLVM IR (.ll) is only useful as a
> > >> debugging feature:
> > >>
> > >> $ make LLVM=1 fs/select.ll
> > >>
> > >> Clang defaults to -fdiscard-value-names to save memory when generating
> > >> LLVM IR. For debugging purposes, the improvement in readability at a
> > >> cost of more verbose IR is a cost we're happy to pay.
> >
> > A LLVM_ENABLE_ASSEERTIONS=off build of Clang defaults to -fdiscard-value-names.
> >
> > A LLVM_ENABLE_ASSEERTIONS=on build of Clang defaults to -fno-discard-value-names.
> >
> > See clang/lib/Driver/ToolChains/Clang.cpp:5030
>
> Thanks!
>
> I thought I recalled this; I was literally just rereading through
> https://github.com/ClangBuiltLinux/linux/issues/1467#issuecomment-1046071624
> again to understand.
>
> That would be useful to include in the commit message, and is more
> precise than "Clang defaults to -fdiscard-value-names to save memory
> when generating LLVM IR."  Masahiro, would you mind including or
> replacing that, or shall I send a v2?




Can you send v2, or provide the entire new commit description?
Thank you.








>
> I was surprised to find later in the day that I was running an
> assertions-disabled (ie. release) build of clang, which I almost never
> do!  Non-llvm-developers are more likely to be using release builds
> than assertions-enabled builds of llvm, so this patch still very much
> has merit.
>
> >
> > >> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > >Thanks for the patch!
> > >
> > >Link: https://github.com/ClangBuiltLinux/linux/issues/1467
> > >Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Reviewed-by: Fangrui Song <maskray@google.com>
> >
> > >> ---
> > >>  scripts/Makefile.build | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > >> index 27be77c0d6d8..d0e4f476dfee 100644
> > >> --- a/scripts/Makefile.build
> > >> +++ b/scripts/Makefile.build
> > >> @@ -140,7 +140,7 @@ $(obj)/%.symtypes : $(src)/%.c FORCE
> > >>  # LLVM assembly
> > >>  # Generate .ll files from .c
> > >>  quiet_cmd_cc_ll_c = CC $(quiet_modtag)  $@
> > >> -      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -o $@ $<
> > >> +      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -fno-discard-value-names -o $@ $<
> > >>
> > >>  $(obj)/%.ll: $(src)/%.c FORCE
> > >>      $(call if_changed_dep,cc_ll_c)
> > >>
> > >> base-commit: 93ed07a23fd08b8613f64cf0a15d7fbdaca010fd
> > >> --
> > >> 2.38.0.rc2.412.g84df46c1b4-goog
> > >>
> > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
