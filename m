Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DBB5F9D49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiJJLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJJLGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:06:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599A3743F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D6C6B80E7B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438E4C433B5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665399992;
        bh=p20guC7JbhmvHgzm9d8sCMBUnajy1RNAbyXX6SeVkp0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XBlCOoZ47p0xWeSu2bZBdT2rUpSCm3oQD2Ou98TQeRQIHXjyUrKFfYWNbnfHnodCe
         7WkdamgKpca5vcbtXFFrekdbNPO9UkdkDSiHX5zMVW0yfs8HteZlIJd8TGwl6XySE8
         QIk0WntM02NbzBDBBlsOicT9XD0jkL1VMwfAQb9hK98DOuOo527DaIKYo4xCbHpaRx
         8GWpS4z6zMV/RvcmLkR16pTgn4vWqxKbYq3A06k1GaxYc7AZKGW6rP43oxemQDNJXc
         qtSrepencBp90TR3nTJgt7M3ck6c24y5HMAAT+osB/VjS7z5oIsr7UZtefTy+tzFK/
         ZnnVL82Huoung==
Received: by mail-lf1-f46.google.com with SMTP id m19so14695588lfq.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:06:32 -0700 (PDT)
X-Gm-Message-State: ACrzQf3lXkDvYL73QX7GfdD1mspsxtJSpXSllhTVXre3ZJrrA2KahPN8
        ds7UVYyninc/SZYnZ6/VMfArtc26d4uueyOzRNQ=
X-Google-Smtp-Source: AMsMyM7nEc2ju6TICsd8RmqK7xJ4TdAiPz4O5ajV/lV0ZK9cJMBuJkisacoHBk4yfaBh2/W8xGkjaj1eRiHOS+kcBcU=
X-Received: by 2002:a05:6512:2026:b0:4a2:3bb6:302 with SMTP id
 s6-20020a056512202600b004a23bb60302mr6421638lfs.539.1665399990179; Mon, 10
 Oct 2022 04:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-2-thunder.leizhen@huawei.com> <CAMj1kXHOv23JY35fZ45k=Pzi=ROd6BOCxqPkfXLh2520qhoFzQ@mail.gmail.com>
 <1ab4c651-f0ab-1107-1784-ad255dabc33a@huawei.com>
In-Reply-To: <1ab4c651-f0ab-1107-1784-ad255dabc33a@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Oct 2022 13:06:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHn70rRaB=BgCrMoqQxRcq=HzZ0NWFYL+FqV_037PaY3w@mail.gmail.com>
Message-ID: <CAMj1kXHn70rRaB=BgCrMoqQxRcq=HzZ0NWFYL+FqV_037PaY3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
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

On Mon, 10 Oct 2022 at 12:58, Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2022/10/10 18:20, Ard Biesheuvel wrote:
> > On Mon, 10 Oct 2022 at 11:56, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>
> >> Fix the following warnings:
> >>  warning: incorrect type in initializer (different address spaces)
> >>     expected unsigned short [noderef] __user *register __p
> >>     got unsigned short [usertype] *
> >>  warning: cast removes address space '__user' of expression
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  arch/arm/kernel/traps.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> >> index 20b2db6dcd1ced7..34aa80c09c508c1 100644
> >> --- a/arch/arm/kernel/traps.c
> >> +++ b/arch/arm/kernel/traps.c
> >> @@ -188,9 +188,9 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
> >>                         }
> >>                 } else {
> >>                         if (thumb)
> >> -                               bad = get_user(val, &((u16 *)addr)[i]);
> >> +                               bad = get_user(val, &((u16 __user *)addr)[i]);
> >>                         else
> >> -                               bad = get_user(val, &((u32 *)addr)[i]);
> >> +                               bad = get_user(val, &((u32 __user *)addr)[i]);
> >>                 }
> >>
> >>                 if (!bad)
> >> @@ -455,15 +455,15 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
> >>         if (processor_mode(regs) == SVC_MODE) {
> >>  #ifdef CONFIG_THUMB2_KERNEL
> >>                 if (thumb_mode(regs)) {
> >> -                       instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> >> +                       instr = __mem_to_opcode_thumb16(((__force u16 *)pc)[0]);
> >
> > Shouldn't this be __user as well? (and below)
>
> unsigned int instr;
> void __user *pc;
>
> The __user can clear the warning, but a new warning will be generated.
>
> instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
>       ^new                           ^old
>
> arch/arm/kernel/traps.c:473:33: warning: dereference of noderef expression
>

This is because dereferencing a __user pointer is not permitted.

So this code should be using get_kernel_nofault() here not a plain
dereference of PC. So better to fix that properly instead of papering
over it with a __force cast just to make sparse happy.


> >
> >>                         if (is_wide_instruction(instr)) {
> >>                                 u16 inst2;
> >> -                               inst2 = __mem_to_opcode_thumb16(((u16 *)pc)[1]);
> >> +                               inst2 = __mem_to_opcode_thumb16(((__force u16 *)pc)[1]);
> >>                                 instr = __opcode_thumb32_compose(instr, inst2);
> >>                         }
> >>                 } else
> >>  #endif
> >> -                       instr = __mem_to_opcode_arm(*(u32 *) pc);
> >> +                       instr = __mem_to_opcode_arm(*(__force u32 *) pc);
> >>         } else if (thumb_mode(regs)) {
> >>                 if (get_user(instr, (u16 __user *)pc))
> >>                         goto die_sig;
> >> --
> >> 2.25.1
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > .
> >
>
> --
> Regards,
>   Zhen Lei
