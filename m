Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118925FA1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJJQP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJJQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:15:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420251DA50
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0680BB80EDE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D62C433D6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665418509;
        bh=om7uOrohlA3DSMfGJxxCgfAF8f1BgeKU2IP+O5pWDVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NIUSIsSODLifnZ2YzL1Ktgcg+0C/FN8QA6ESyPMX5eG+oEDtG182T62pvQ/UeGx8o
         WTCTDMmvRL7UuUygG9E1kYXlocgelyd0nl5NYzKCs9kE9LS+ZWOvhldYaeQnqMzp/h
         2dxU8C/wMiCioiak/dEhGLUJnVfWSI/zd1c9ey68ABZ4n2EfbgoDvzM37my1ZKicFT
         IBhKuyQlPfrrGtmvswKIqzsZH34UBY5evXQ5wW+qhgflARSvq9WzlWZMdHiN7PGklk
         aeX77IvmeF7GroKR/6ty8RYo2MD0K2QDjAUNFdO8J49lfRIxqQRoNVyu3Tv9edYUgc
         x0d/DdTZSuw2g==
Received: by mail-lj1-f173.google.com with SMTP id m14so13823033ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:15:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ztIN7cHIUdRe5CbQHtrqa6IW2o5qydiu8lu74MwVcA24D3b72
        u3VM4NdMZwjXIUr0b+L2/38PR4fF+JXhpc0bG1E=
X-Google-Smtp-Source: AMsMyM5NJzYVopZhHbOOXSJzxb2HYaAX9Ura9jlw0ZCqR+aCKHVJ1g3ljeLVUdPA+SFCGvWq7X5/WRnZROW01llDLVM=
X-Received: by 2002:a2e:b621:0:b0:26e:535f:a90f with SMTP id
 s1-20020a2eb621000000b0026e535fa90fmr5864811ljn.69.1665418507644; Mon, 10 Oct
 2022 09:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-2-thunder.leizhen@huawei.com> <CAMj1kXHOv23JY35fZ45k=Pzi=ROd6BOCxqPkfXLh2520qhoFzQ@mail.gmail.com>
 <1ab4c651-f0ab-1107-1784-ad255dabc33a@huawei.com> <CAMj1kXHn70rRaB=BgCrMoqQxRcq=HzZ0NWFYL+FqV_037PaY3w@mail.gmail.com>
 <Y0RDblEkJ0h+DfCB@shell.armlinux.org.uk>
In-Reply-To: <Y0RDblEkJ0h+DfCB@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Oct 2022 18:14:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8ZCQG-Vk1mNwmLX2emUUFqs5b8SWxz26L7FUF5Sjx0A@mail.gmail.com>
Message-ID: <CAMj1kXG8ZCQG-Vk1mNwmLX2emUUFqs5b8SWxz26L7FUF5Sjx0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 at 18:08, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Oct 10, 2022 at 01:06:19PM +0200, Ard Biesheuvel wrote:
> > On Mon, 10 Oct 2022 at 12:58, Leizhen (ThunderTown)
> > <thunder.leizhen@huawei.com> wrote:
> > >
> > >
> > >
> > > On 2022/10/10 18:20, Ard Biesheuvel wrote:
> > > > On Mon, 10 Oct 2022 at 11:56, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> > > >>
> > > >> Fix the following warnings:
> > > >>  warning: incorrect type in initializer (different address spaces)
> > > >>     expected unsigned short [noderef] __user *register __p
> > > >>     got unsigned short [usertype] *
> > > >>  warning: cast removes address space '__user' of expression
> > > >>
> > > >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > > >> ---
> > > >>  arch/arm/kernel/traps.c | 10 +++++-----
> > > >>  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >>
> > > >> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> > > >> index 20b2db6dcd1ced7..34aa80c09c508c1 100644
> > > >> --- a/arch/arm/kernel/traps.c
> > > >> +++ b/arch/arm/kernel/traps.c
> > > >> @@ -188,9 +188,9 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
> > > >>                         }
> > > >>                 } else {
> > > >>                         if (thumb)
> > > >> -                               bad = get_user(val, &((u16 *)addr)[i]);
> > > >> +                               bad = get_user(val, &((u16 __user *)addr)[i]);
> > > >>                         else
> > > >> -                               bad = get_user(val, &((u32 *)addr)[i]);
> > > >> +                               bad = get_user(val, &((u32 __user *)addr)[i]);
> > > >>                 }
> > > >>
> > > >>                 if (!bad)
> > > >> @@ -455,15 +455,15 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
> > > >>         if (processor_mode(regs) == SVC_MODE) {
> > > >>  #ifdef CONFIG_THUMB2_KERNEL
> > > >>                 if (thumb_mode(regs)) {
> > > >> -                       instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> > > >> +                       instr = __mem_to_opcode_thumb16(((__force u16 *)pc)[0]);
> > > >
> > > > Shouldn't this be __user as well? (and below)
> > >
> > > unsigned int instr;
> > > void __user *pc;
> > >
> > > The __user can clear the warning, but a new warning will be generated.
> > >
> > > instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> > >       ^new                           ^old
> > >
> > > arch/arm/kernel/traps.c:473:33: warning: dereference of noderef expression
> > >
> >
> > This is because dereferencing a __user pointer is not permitted.
> >
> > So this code should be using get_kernel_nofault() here not a plain
> > dereference of PC. So better to fix that properly instead of papering
> > over it with a __force cast just to make sparse happy.
>
> Why? We won't get here unless the PC can be dereferenced. If it's not
> able to be dereferenced, then we'd be dealing with a prefetch abort.
>

If that is guaranteed (i.e., there is no way we might be racing with a
module unload on another CPU or something like that), then I agree
that dereferencing PC is fine.
