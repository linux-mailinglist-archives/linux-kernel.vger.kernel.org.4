Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09FA6873DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjBBDdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBBDdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:33:40 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4426559C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:33:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h24so1083537lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6XW6JurKnWqV6fcEVNRtarryDrYtMRes2S1d6gBzdc=;
        b=POVPLJCSQpKruBBrx8EGEATxR8b1o1pHCmLWc6vqw9YpwFkQZTfbs0iIdUjIAnbuf5
         ylKEqAwof7ssPwnfMK8DYqxhHl1yVxwKC56T+ztLaTz6opurVjs6dCzTBMHI2S7OCxO0
         xaBziVxqPTKHp3SkdlDH6NBlWHCm3CEEhE1AbgOc99FVaE0kjMWTZLzNa7jL1jwX7i8k
         hI40/efw6DFeMcLPtLlrEgcDermP4Y/td3Agajd1RPSW7fZj8U7KoSwx/ar9miRokCi0
         38dhBcpdxIDoBqUN7xpsFZleCsa+1LigQvI6cTf6VL4l8/zGfTnRqHp3zJloIjVv2/rG
         JykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6XW6JurKnWqV6fcEVNRtarryDrYtMRes2S1d6gBzdc=;
        b=URRrfcYAx/TgzQXsDdHlgYEXof6jU8OcB/RwZ8bmpT3BWFH/Iy4mPtUgKrxQGcQCPj
         YgzC45IJPUb8tkRD355IHmJMzdNSDQcrgiI+5sp/PiQit3RX6FdpZNyTB05gJlXSQkKq
         bw0lHRlMYu2oGaMR3fXXDrND1Ul0c80Y6zmYbvwRzVr8HSbV1xLq+qNRlifz+YRQ2KlV
         qMT6S7HCz3msI+5Soa/HZfGJE3ZS6XePANWder18Df/HUcG9oKmAB6pOxL15Rje1wY94
         zbk/bO18isv1GISa2L11evHnmRINr9wNmWzo6Dshk3LFqU51mY0kUL/emynM1TC2uo8/
         6lvA==
X-Gm-Message-State: AO0yUKW5XtGDnEFAyIZp+fmxg42aDPrPdvtMGde4x52XlyKcgEaeT+6y
        eqAaqraoS9aUIfwLKVvzbBg6xH20y2TnhNd2dVRrGqQ79dk=
X-Google-Smtp-Source: AK7set+oVEG0h8jefVUbLdIDnA7uHHrxx9vMfbTniJIK4k/Tl2DT1nLmeE8zE4HJQgnVWqKGttsQsIoyBcFvKLkYfTI=
X-Received: by 2002:a05:6512:2103:b0:4b5:6dbc:b719 with SMTP id
 q3-20020a056512210300b004b56dbcb719mr844751lfr.270.1675308816982; Wed, 01 Feb
 2023 19:33:36 -0800 (PST)
MIME-Version: 1.0
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
 <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
 <CAEr6+ECO-=jfhzHrcdKGx0MsjMBMiN6wsBPCfv7CaXo_amAWWg@mail.gmail.com> <02806f85-bc09-d316-f058-3947353cb190@loongson.cn>
In-Reply-To: <02806f85-bc09-d316-f058-3947353cb190@loongson.cn>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Thu, 2 Feb 2023 11:33:23 +0800
Message-ID: <CAEr6+EBYF2xqZWEuZaz5un5FF3Jb-rSAQp3s3uojsovm9RcUYA@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 10:23 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 02/01/2023 05:40 PM, Jeff Xie wrote:
> > On Wed, Feb 1, 2023 at 12:56 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >>
> >> Hi, Jeff,
> >>
> >> Could you please pay some time to test this series? Thank you.
> >
> > Thanks for notifying me about the test.
> >
> > I have tested the patchset(based on the
> > https://github.com/loongson/linux/tree/loongarch-next),
> > I found that some functions can't  be probed e.g. scheduler_tick() or
> > uart_write_wakeup()
> > the two functions have the same point,  they are all run in the hardirq context.
> >
> > I don't know if it's related to the hardirq context, I haven't had
> > time to study this patchset carefully.
> > and they can be probed in the x86_64 arch.
> >
> > root@loongarch modules]# insmod ./kprobe_example.ko symbol=scheduler_tick
> > insmod: can't insert './kprobe_example.ko': invalid parameter
> >
> > dmesg:
> > [   39.806435] kprobe_init: register_kprobe failed, returned -22
> >
>
> Thanks for your test.
>
> On my test environment, I can not reproduce the above issue,
> here are the test results, it seems no problem.
>
> [root@linux loongson]# dmesg -c
> [root@linux loongson]# uname -m
> loongarch64
> [root@linux loongson]# modprobe kprobe_example symbol=scheduler_tick
> [root@linux loongson]# rmmod kprobe_example
> [root@linux loongson]# dmesg | tail -2
> [ 3317.138086] handler_post: <scheduler_tick> p->addr =
> 0x0000000065d12f66, estat = 0xc0000
> [ 3317.154086] kprobe_exit: kprobe at 0000000065d12f66 unregistered
>
> [root@linux loongson]# dmesg -c
> [root@linux loongson]# uname -m
> loongarch64
> [root@linux loongson]# modprobe kprobe_example symbol=uart_write_wakeup
> [root@linux loongson]# rmmod kprobe_example
> [root@linux loongson]# dmesg | tail -2
> [ 3433.502092] handler_post: <uart_write_wakeup> p->addr =
> 0x0000000019718061, estat = 0xc0000
> [ 3433.762085] kprobe_exit: kprobe at 0000000019718061 unregistered
>
> Additionally, "register_kprobe failed, returned -22" means the symbol
> can not be probed, here is the related code:
>
> register_kprobe()
>    check_kprobe_address_safe()
>
> static int check_kprobe_address_safe(struct kprobe *p,
>                                      struct module **probed_mod)
> {
>         int ret;
>
>         ret = check_ftrace_location(p);
>         if (ret)
>                 return ret;
>         jump_label_lock();
>         preempt_disable();
>
>         /* Ensure it is not in reserved area nor out of text */
>         if (!(core_kernel_text((unsigned long) p->addr) ||
>             is_module_text_address((unsigned long) p->addr)) ||
>             in_gate_area_no_mm((unsigned long) p->addr) ||
>             within_kprobe_blacklist((unsigned long) p->addr) ||
>             jump_label_text_reserved(p->addr, p->addr) ||
>             static_call_text_reserved(p->addr, p->addr) ||
>             find_bug((unsigned long)p->addr)) {
>                 ret = -EINVAL;
>                 goto out;
>         }
> ...
> }

Today I looked at the code, this has nothing to do with hardirq :-)
because I enabled this kernel option CONFIG_DYNAMIC_FTRACE, the
loongarch should not support the option yet.

#ifdef CONFIG_DYNAMIC_FTRACE
unsigned long ftrace_location(unsigned long ip);

#else /* CONFIG_DYNAMIC_FTRACE */

static inline unsigned long ftrace_location(unsigned long ip)
{
        return 0;
}

#endif


static int check_ftrace_location(struct kprobe *p)
{
        unsigned long addr = (unsigned long)p->addr;

        if (ftrace_location(addr) == addr) {
#ifdef CONFIG_KPROBES_ON_FTRACE
                p->flags |= KPROBE_FLAG_FTRACE;
#else   /* !CONFIG_KPROBES_ON_FTRACE */
                return -EINVAL;  // get error from here
#endif
        }
        return 0;
}

static int check_kprobe_address_safe(struct kprobe *p,
                                     struct module **probed_mod)
{
        int ret;

        ret = check_ftrace_location(p);
        if (ret)
                return ret; //  return -EINVAL
}


>
> Thanks,
> Tiezhu
>


-- 
Thanks,
JeffXie
