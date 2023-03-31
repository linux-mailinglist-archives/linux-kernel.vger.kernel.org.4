Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2536D2A17
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjCaVnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaVnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:43:20 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219C518F9A;
        Fri, 31 Mar 2023 14:43:18 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id 89so17145901uao.0;
        Fri, 31 Mar 2023 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680298996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5CSgtedxihi2QZcr+Ghagbg1u9AWPYWX/Bwef/bbyo=;
        b=ZY/og5wWRWYU0c+i+G/s5X9D3y6gf3ry2Ktx6KHUiQ0zDAsweH1K786Z3ls3IGnP1a
         e1T38nQdWO1zotYVYYD2d0U3rRoRkoo6hXjhZnKjqYb/Y87uuRduhOeuO4gq1RbxMWRT
         Z9O7YBsa8XH5Bygu/+oh8liZ7vGdlyd3a3CFyEUl4UtgPFX1qjOZbqTFVf2Ce77bsE/f
         EjfJZfGmE2gwH4k6Ygs1QovRxLD5l3+wqHJQZ/S+yn+S82fUSOy+ikatTWqz6lD6y462
         NVij3HpXqQAjaVMJRiLBpXZnmynXeW5cdx8xRfykYz+D8p8sXlaRk7I8FGY4GeItYLZD
         orQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680298996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5CSgtedxihi2QZcr+Ghagbg1u9AWPYWX/Bwef/bbyo=;
        b=AoRsYrqLDfT/AppdEUsFxBFDrHELE1nxAvTOi4y3PbqMwX9BhGhiGetPFcfEpPgVmk
         48FL3j7FcYWRz088uLbT13OaqdBNAZ/YILEemOR5oyQfu0Ds5urcZ8IJAeIquhDTnOgj
         DmzQaiVmO7QEtHdWMBhfgBIGP78ZL9IsY10RsxuXlmZx8mMKuGOw7QkA1UioYTYXHXkX
         JclnLkXujui7CY8KXBkLIJNtVmTJ+5LZgY2qWorhar0AYGmi8Q1t2i5g1XoFEFcQQrWt
         qhmCz+faUjk8qSqcGUqwhMzabkN/DB2BxRJuCTHgvJFrZxCgT8OYtlnL3FXvdkcyJGIp
         ST6Q==
X-Gm-Message-State: AAQBX9fmLBYJHHKD6M2B1F9aMvGv7L3CmvkdQK20EI2Mh570CrR9HJod
        h3JXbhUzHmMN518pgLk/B64pDxO/XkgCy5IKRCM=
X-Google-Smtp-Source: AKy350aH4QV+sBvoDO7KIHxo3oosn6j3G4EBfrsHcHJMBbdepjtCofOfSW8O8oCDEEzPcAB1W5J/l8k3ypJAmk4aUiA=
X-Received: by 2002:ab0:5b45:0:b0:73f:f15b:d9e3 with SMTP id
 v5-20020ab05b45000000b0073ff15bd9e3mr3279106uae.0.1680298996597; Fri, 31 Mar
 2023 14:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org> <CAJfuBxwng_fB5XH5LEWAWwN29fitGLBZ8hpdW3+4HjO_MDK1Eg@mail.gmail.com>
 <ZCcwkCBgyxOgROVu@bombadil.infradead.org>
In-Reply-To: <ZCcwkCBgyxOgROVu@bombadil.infradead.org>
From:   jim.cromie@gmail.com
Date:   Fri, 31 Mar 2023 15:42:50 -0600
Message-ID: <CAJfuBxzP0-sk59H6DTkkng+mFa0WWJdr7fVj=iKsaLT_J1YXuQ@mail.gmail.com>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with module_memory")
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, song@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 1:12=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Fri, Mar 31, 2023 at 11:08:23AM -0600, jim.cromie@gmail.com wrote:
> > :#> uptime
> >  09:45:32 up 1 day, 23:07,  0 users,  load average: 0.07, 0.04, 0.01
> > :#> uname -a
> > Linux (none) 6.3.0-rc1-f2-00001-gac3b43283923 #359 SMP PREEMPT_DYNAMIC
> > Wed Mar 29 09:33:11 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
> >
> > the leaks I sent previously might be from/on a different commit,
> > heres the relevant one
> >
> > fwiw, the config is unremarkable.  it started with
> > CONFIG_BUILD_SALT=3D"5.16.8-200.fc35.x86_64"
> > then `make localmodconfig` to drop anything I dont have hw for
> > then `virtme-configkernel --update` to pick up the 9p,etc config option=
s
> > And some extra DEBUG_* options
> > If you'd like to see runs with others, or see the config itself, please=
 ask.
>
> If you wanna see things explode
>
> echo 0 > /proc/sys/vm/oom_dump_tasks
> ./stress-ng --module 20 --module-name xfs
>
> This assumes xfs is not already loaded, and has all dependencies already
> loaded. What would test the load_module() path.
>
> If you wanna see if the test is earlier, you can try a module which
> is already loaded on your system.
>
> > :#> uname -a
> > Linux (none) 6.3.0-rc1-f2-00001-gac3b43283923 #359 SMP PREEMPT_DYNAMIC
> > Wed Mar 29 09:33:11 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
> > :#> ./grok_kmemleak -n
> > not: bless( {
> >   'backtraces' =3D> {
> >     '[<0000000058fb276d>] __kmalloc_node_track_caller+0x4a/0x140
> >     [<00000000a2f80203>] memdup_user+0x26/0x90
> >     [<00000000f7cd3624>] strndup_user+0x3f/0x60
> >     [<0000000098fd26c5>] load_module+0x188b/0x20e0
>
> Can you do:
>
> gdb vmlinux
> l *(load_module+0x188b)
>
> And provide the output?

(gdb) l *(load_module+0x188b)
0xffffffff8122a4bb is in load_module
(/home/jimc/projects/lx/wk-next/kernel/module/main.c:2820).
2815 goto free_modinfo;
2816
2817 flush_module_icache(mod);
2818
2819 /* Now copy in args */
2820 mod->args =3D strndup_user(uargs, ~0UL >> 1);
2821 if (IS_ERR(mod->args)) {
2822 err =3D PTR_ERR(mod->args);
2823 goto free_arch_cleanup;
2824 }

>
> > }, 'LeakSet' )
> > mods: bless( {
> >   'backtraces' =3D> {
> >     '[<0000000058fb276d>] __kmalloc_node_track_caller+0x4a/0x140
> >     [<00000000ab7b01fd>] kstrdup+0x32/0x60
> >     [<000000005ed25b98>] kobject_set_name_vargs+0x1c/0x90
> >     [<0000000090fe19ca>] kobject_init_and_add+0x4d/0x90
> >     [<0000000045666935>] mod_sysfs_setup+0xa9/0x6e0
>
> Ok that is a specific enough hint. I'll take a review of this sysfs
> path see what changed that could break.

(gdb) l *(mod_sysfs_setup+0xa9)
0xffffffff8122d2d9 is in mod_sysfs_setup
(/home/jimc/projects/lx/wk-next/kernel/module/sysfs.c:361).
356
357 mod->mkobj.mod =3D mod;
358
359 memset(&mod->mkobj.kobj, 0, sizeof(mod->mkobj.kobj));
360 mod->mkobj.kobj.kset =3D module_kset;
361 err =3D kobject_init_and_add(&mod->mkobj.kobj, &module_ktype, NULL,
362    "%s", mod->name);
363 if (err)
364 mod_kobject_put(mod);
365
(gdb)

>
> >     [<00000000d6f7187b>] load_module+0x1de3/0x20e0

(gdb) l *(load_module+0x1de3)
0xffffffff8122aa13 is in load_module
(/home/jimc/projects/lx/wk-next/kernel/module/main.c:2856).
2851 pr_warn("%s: parameters '%s' after `--' ignored\n",
2852        mod->name, after_dashes);
2853 }
2854
2855 /* Link in to sysfs. */
2856 err =3D mod_sysfs_setup(mod, info, mod->kp, mod->num_kp);
2857 if (err < 0)
2858 goto coming_cleanup;
2859
2860 if (is_livepatch_module(mod)) {



> >     [<0000000074361279>] __do_sys_finit_module+0x93/0xf0
> >     [<000000004caeb948>] do_syscall_64+0x34/0x80
> >     [<000000009f5d036c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' =3D>=
 16
> >   },
>>   Luis
