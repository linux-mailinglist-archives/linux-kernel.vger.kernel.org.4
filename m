Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23B468BC8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBFMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBFMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:13:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E6512051
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:13:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4DDDB80EC0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3B7C433D2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675685597;
        bh=Ks+3bWX8BMBQ1+7CdXHspGcVXJ2Qn/DY7u+Hkp8zSrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPWBFefIHR8JRaFXU4l+xk69wU3NZfrWepDWxuheqGJLvbn6l7WlR8677cImYkWLs
         izbNClwdBlqWMuWlZOuytrpEEFzgCfYD1LQy26MlbEGKCgeZDDJYWE8BCrvJMWiO1P
         nfbZV5ElQhmngJpI1WXymjizo/zr8bLC9wEU/vWFrKC2BvP5jIWLIKtBJE7VHtJy0W
         rYfFiYU5wzLFCQ48eBi2AwPDISp8qLtNWX63eWyPbMJIRh6fvsSAlaSp9nvJwQe+re
         y3y1JUFsbbPgk0aJyp1gQWaD0++sktmqClZPPIzL49CEMsvegkdQqq2MkdUWd3c61h
         3hx1uEJIo8Zbw==
Received: by mail-ed1-f48.google.com with SMTP id u21so11438205edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 04:13:17 -0800 (PST)
X-Gm-Message-State: AO0yUKXg98eerTDKtdfN8lA/ScvBUFFu/wMUlvhAdrUnhervMPAfcKIg
        /xzxa4s663af47q+vrh5LgW4Rl7Q12m1Vk+dbok=
X-Google-Smtp-Source: AK7set8asN6FOn8+WUmAov8wIo1dn46oFQk0RdBFmZbl0rjD7eA3kd09j/F0iNyrgtzlttyU1SbTIqAVb0C19xb0+g4=
X-Received: by 2002:a50:cc9a:0:b0:4aa:a4f7:2304 with SMTP id
 q26-20020a50cc9a000000b004aaa4f72304mr1702807edi.38.1675685595641; Mon, 06
 Feb 2023 04:13:15 -0800 (PST)
MIME-Version: 1.0
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
 <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
 <CAEr6+ECO-=jfhzHrcdKGx0MsjMBMiN6wsBPCfv7CaXo_amAWWg@mail.gmail.com>
 <02806f85-bc09-d316-f058-3947353cb190@loongson.cn> <CAEr6+EBYF2xqZWEuZaz5un5FF3Jb-rSAQp3s3uojsovm9RcUYA@mail.gmail.com>
In-Reply-To: <CAEr6+EBYF2xqZWEuZaz5un5FF3Jb-rSAQp3s3uojsovm9RcUYA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 6 Feb 2023 20:13:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5dJGrL3kEwzC-XwMqJTCsYHq-YVDTDRntGcYg9RMz02w@mail.gmail.com>
Message-ID: <CAAhV-H5dJGrL3kEwzC-XwMqJTCsYHq-YVDTDRntGcYg9RMz02w@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff,

Now I add kprobes on ftrace support in
https://github.com/loongson/linux/commits/loongarch-next, please test
again. Thank you.

Huacai

On Thu, Feb 2, 2023 at 11:33 AM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> On Thu, Feb 2, 2023 at 10:23 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >
> >
> > On 02/01/2023 05:40 PM, Jeff Xie wrote:
> > > On Wed, Feb 1, 2023 at 12:56 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >>
> > >> Hi, Jeff,
> > >>
> > >> Could you please pay some time to test this series? Thank you.
> > >
> > > Thanks for notifying me about the test.
> > >
> > > I have tested the patchset(based on the
> > > https://github.com/loongson/linux/tree/loongarch-next),
> > > I found that some functions can't  be probed e.g. scheduler_tick() or
> > > uart_write_wakeup()
> > > the two functions have the same point,  they are all run in the hardirq context.
> > >
> > > I don't know if it's related to the hardirq context, I haven't had
> > > time to study this patchset carefully.
> > > and they can be probed in the x86_64 arch.
> > >
> > > root@loongarch modules]# insmod ./kprobe_example.ko symbol=scheduler_tick
> > > insmod: can't insert './kprobe_example.ko': invalid parameter
> > >
> > > dmesg:
> > > [   39.806435] kprobe_init: register_kprobe failed, returned -22
> > >
> >
> > Thanks for your test.
> >
> > On my test environment, I can not reproduce the above issue,
> > here are the test results, it seems no problem.
> >
> > [root@linux loongson]# dmesg -c
> > [root@linux loongson]# uname -m
> > loongarch64
> > [root@linux loongson]# modprobe kprobe_example symbol=scheduler_tick
> > [root@linux loongson]# rmmod kprobe_example
> > [root@linux loongson]# dmesg | tail -2
> > [ 3317.138086] handler_post: <scheduler_tick> p->addr =
> > 0x0000000065d12f66, estat = 0xc0000
> > [ 3317.154086] kprobe_exit: kprobe at 0000000065d12f66 unregistered
> >
> > [root@linux loongson]# dmesg -c
> > [root@linux loongson]# uname -m
> > loongarch64
> > [root@linux loongson]# modprobe kprobe_example symbol=uart_write_wakeup
> > [root@linux loongson]# rmmod kprobe_example
> > [root@linux loongson]# dmesg | tail -2
> > [ 3433.502092] handler_post: <uart_write_wakeup> p->addr =
> > 0x0000000019718061, estat = 0xc0000
> > [ 3433.762085] kprobe_exit: kprobe at 0000000019718061 unregistered
> >
> > Additionally, "register_kprobe failed, returned -22" means the symbol
> > can not be probed, here is the related code:
> >
> > register_kprobe()
> >    check_kprobe_address_safe()
> >
> > static int check_kprobe_address_safe(struct kprobe *p,
> >                                      struct module **probed_mod)
> > {
> >         int ret;
> >
> >         ret = check_ftrace_location(p);
> >         if (ret)
> >                 return ret;
> >         jump_label_lock();
> >         preempt_disable();
> >
> >         /* Ensure it is not in reserved area nor out of text */
> >         if (!(core_kernel_text((unsigned long) p->addr) ||
> >             is_module_text_address((unsigned long) p->addr)) ||
> >             in_gate_area_no_mm((unsigned long) p->addr) ||
> >             within_kprobe_blacklist((unsigned long) p->addr) ||
> >             jump_label_text_reserved(p->addr, p->addr) ||
> >             static_call_text_reserved(p->addr, p->addr) ||
> >             find_bug((unsigned long)p->addr)) {
> >                 ret = -EINVAL;
> >                 goto out;
> >         }
> > ...
> > }
>
> Today I looked at the code, this has nothing to do with hardirq :-)
> because I enabled this kernel option CONFIG_DYNAMIC_FTRACE, the
> loongarch should not support the option yet.
>
> #ifdef CONFIG_DYNAMIC_FTRACE
> unsigned long ftrace_location(unsigned long ip);
>
> #else /* CONFIG_DYNAMIC_FTRACE */
>
> static inline unsigned long ftrace_location(unsigned long ip)
> {
>         return 0;
> }
>
> #endif
>
>
> static int check_ftrace_location(struct kprobe *p)
> {
>         unsigned long addr = (unsigned long)p->addr;
>
>         if (ftrace_location(addr) == addr) {
> #ifdef CONFIG_KPROBES_ON_FTRACE
>                 p->flags |= KPROBE_FLAG_FTRACE;
> #else   /* !CONFIG_KPROBES_ON_FTRACE */
>                 return -EINVAL;  // get error from here
> #endif
>         }
>         return 0;
> }
>
> static int check_kprobe_address_safe(struct kprobe *p,
>                                      struct module **probed_mod)
> {
>         int ret;
>
>         ret = check_ftrace_location(p);
>         if (ret)
>                 return ret; //  return -EINVAL
> }
>
>
> >
> > Thanks,
> > Tiezhu
> >
>
>
> --
> Thanks,
> JeffXie
