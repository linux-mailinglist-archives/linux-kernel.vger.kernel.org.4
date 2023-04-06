Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301F36D8DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjDFDOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjDFDOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:14:44 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B786B9;
        Wed,  5 Apr 2023 20:14:40 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id z17so26668133vsf.4;
        Wed, 05 Apr 2023 20:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680750879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEUcBKU8Pf7XloHuNZtmst7SfGO1+7AVmWPZtPjEXWY=;
        b=dAZr45VwmxURGEZrWh7EmObgpcMZSkPOpvni1HTdUBi+n5hGsJsjFPIDGzAM6KlP6P
         JZCRfavEBE1r2nJqYppIbgc97c1iZZBBh/fW93xoZxZchTrMx0xInq2NI9Axh3dxoUpK
         A0cuBtXFPDNv0eC+owos/cHkg+BBw0YZ7Ko/G85uMXuO3cET8tNGxIT3WcfwN1b2mZaV
         eIxj2GEAeY1H2DKl/tsxbegU1Ecl2sf5brjPyS1C8wfAhjKm7m8BA1ohtlU/odZMhydE
         9lGCmpkAZHuCvgWjv7tUtNIiZFXkjoH+zvdjGeSJwKQ/eAPOinmYIX/R0C//3gFvlVJL
         PsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680750879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEUcBKU8Pf7XloHuNZtmst7SfGO1+7AVmWPZtPjEXWY=;
        b=VtxproSc3PpzwO8FaRjr+OyykOdUnE8/CphBYl9OLz2AP4/dkeS4hkBNzeK2w6g9El
         S7oCE+zmTrPl/Ww701cX3Yv5T+QN2w9LHvmlonGN8AfrKOGY9ysm5pfih7ed7n00kFa5
         0Vr2W/czDs9gGNaeufwrrQOkXM4dIjHOLFwxi4WdtH4GQBUEKAhXGjbJY/0stTq9Aijm
         /u4A1Siz9SwhD5++UUwhEK3H39ehsYewpH6A2PffMPZokNDOdHQEesMq8vpo70ttEmDO
         b+1lu/YFXZJ/se2HSLmS14Z5C6ZKOd/bFBu/jgHqwk1F+9qlgDFqolaUbs8zkbX7JAL0
         yUyw==
X-Gm-Message-State: AAQBX9e3ezdsK6Ix1l/200DEsdK3thbcjd4nWDes1H2u9Ij162FljW8y
        Kb+RVQym5rH4A8x1wjR5TSnf4pDCbbG8vi6pF+IKdxJq/pg=
X-Google-Smtp-Source: AKy350YTSgAsmE3aTSin1b1R3S/8xXEg9UDmlej9JxKaHtP9JH0OL7uIEbjoQTkkhf8fmBcv15OvV2mpPYttzHEQ2eE=
X-Received: by 2002:a67:d21c:0:b0:42a:2785:1031 with SMTP id
 y28-20020a67d21c000000b0042a27851031mr3783494vsi.5.1680750879102; Wed, 05 Apr
 2023 20:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org> <CAPhsuW6P5AYVKMk=G1bEUz5PGZKmTJwtgQBmE-P4iAo7dOr5yA@mail.gmail.com>
 <ZCs6jpo1nYe1Wm08@bombadil.infradead.org> <CAJfuBxzGJvrJo9nTXxZ3xZ7QmdSb6YxBw-bojZjQTpACBeK_sQ@mail.gmail.com>
 <ZCzWdLOg1i2p1Q67@bombadil.infradead.org>
In-Reply-To: <ZCzWdLOg1i2p1Q67@bombadil.infradead.org>
From:   jim.cromie@gmail.com
Date:   Wed, 5 Apr 2023 21:14:12 -0600
Message-ID: <CAJfuBxw7F5yN=F=i_0ZZ0b2EpWU4T=RXaf13qG9XVq6tG-EGJQ@mail.gmail.com>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with module_memory")
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
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

On Tue, Apr 4, 2023 at 8:01=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Tue, Apr 04, 2023 at 07:38:41PM -0600, jim.cromie@gmail.com wrote:
> > On Mon, Apr 3, 2023 at 2:44=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.=
org> wrote:
> > >
> > > On Fri, Mar 31, 2023 at 05:27:04PM -0700, Song Liu wrote:
> > > > On Fri, Mar 31, 2023 at 12:00=E2=80=AFAM Luis Chamberlain <mcgrof@k=
ernel.org> wrote:
> > > > >
> > > > > On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wr=
ote:
> > > > > > hi Luis, etal
> > > > > >
> > > > > > kmemleak is reporting 19 leaks during boot
> > > > > >
> > > > > > because the hexdumps appeared to have module-names,
> > > > > > and Ive been hacking nearby, and see the same names
> > > > > > every time I boot my test-vm, I needed a clearer picture
> > > > > > Jason corroborated and bisected.
> > > > > >
> > > > > > the 19 leaks split into 2 groups,
> > > > > > 9 with names of builtin modules in the hexdump,
> > > > > > all with the same backtrace
> > > > > > 9 without module-names (with a shared backtrace)
> > > > > > +1 wo name-ish and a separate backtrace
> > > > >
> > > > > Song, please take a look.
> > > >
> > > > I will look into this next week.
> > >
> > > I'm thinking this may be it, at least this gets us to what we used to=
 do
> > > as per original Catalinas' 4f2294b6dc88d ("kmemleak: Add modules
> > > support") and right before Song's patch.
> > >
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index 6b6da80f363f..3b9c71fa6096 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -2240,7 +2240,10 @@ static int move_module(struct module *mod, str=
uct load_info *info)
> > >                  * which is inside the block. Just mark it as not bei=
ng a
> > >                  * leak.
> > >                  */
> > > -               kmemleak_ignore(ptr);
> > > +               if (type =3D=3D MOD_INIT_TEXT)
> > > +                       kmemleak_ignore(ptr);
> > > +               else
> > > +                       kmemleak_not_leak(ptr);
> > >                 if (!ptr) {
> > >                         t =3D type;
> > >                         goto out_enomem;
> > >
> > > We used to use the grey area for the TEXT but the original commit
> > > doesn't explain too well why we grey out init but not the others. Ie
> > > why kmemleak_ignore() on init and kmemleak_not_leak() on the others.
> > >
> > > Catalinas, any thoughts / suggestions? Should we just stick to
> > > kmemleak_not_leak() for both now?
> > >
> > >   Luis
> >
> > So I have mixed results.
> >
> > your patch fixed the 19 leaks on my worktree / branch where I found the=
m.
> >
> > on top of
> > ac3b43283923 module: replace module_layout with module_memory
> >
> > it fixed the (same) 19, but gets a few new ones.
> > whats weird is that once they report, they disappear from
> > /sys/kernel/debug/kmemleak

this disappearing act is still going on.
my script issues no echo clear > kmemleak


>
> I think I missed the MOD_INIT_DATA and MOD_INIT_RODATA. Can you try the
> patch below instead:
>
> From 6890bd43866c40e1b58a832361812cdc5d965e4c Mon Sep 17 00:00:00 2001
> From: Luis Chamberlain <mcgrof@kernel.org>
> Date: Tue, 4 Apr 2023 18:52:47 -0700
> Subject: [PATCH] module: fix kmemleak annotations for non init ELF sectio=
ns
>
> Commit ac3b43283923 ("module: replace module_layout with module_memory")
> reworked the way to handle memory allocations to make it clearer. But it
> lost in translation how we handle kmemleak_ignore() or kmemleak_not_leak(=
)
> for these sections.
>
> Fix this and clarify the comments a bit more.
>
> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
> Reported-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/module/main.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 5cc21083af04..fe0f3b8fd3a8 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2233,11 +2233,23 @@ static int move_module(struct module *mod, struct=
 load_info *info)
>                 ptr =3D module_memory_alloc(mod->mem[type].size, type);
>
>                 /*
> -                * The pointer to this block is stored in the module stru=
cture
> -                * which is inside the block. Just mark it as not being a
> -                * leak.
> +                * The pointer to these blocks of memory are stored on th=
e module
> +                * structure and we keep that around so long as the modul=
e is
> +                * around. We only free that memory when we unload the mo=
dule.
> +                * Just mark them as not being a leak then. The .init* EL=
F
> +                * sections *do* get freed after boot so we treat them sl=
ightly
> +                * differently and only grey them out as they work as typ=
ical
> +                * memory allocations which *do* get eventually get freed=
.
>                  */
> -               kmemleak_ignore(ptr);
> +               switch (type) {
> +               case MOD_INIT_TEXT: /* fallthrough */
> +               case MOD_INIT_DATA: /* fallthrough */
> +               case MOD_INIT_RODATA: /* fallthrough */
> +                       kmemleak_ignore(ptr);
> +                       break;
> +               default:
> +                       kmemleak_not_leak(ptr);
> +               }
>                 if (!ptr) {
>                         t =3D type;
>                         goto out_enomem;
> --
> 2.39.2
>

sorry for the delay, I was seeing heisen-responses, and several BUGs.
a make clean seems to have settled things mostly.
But in case theres any clues in there, Ive kept the paste-in of 2 BUGs

with
f23cd1ffca4b (HEAD) kmemleaks on ac3b43283923 ("module: replace
module_layout with module_memory")
ac3b43283923 module: replace module_layout with module_memory

heres the 1st run.  cuz it leaked, I reran in another vm, which got
different results.
I left it overnight doing nothing (laptop slept, vm with it),
and it BUG'd on a soft lockup
(much later, but the leaktrace does have a timerfd in it)
R11 looks poisoned.

[   49.994743] kmemleak: 1 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
finished pass 6
unreferenced object 0xffff888006fe8600 (size 256):
  comm "(udev-worker)", pid 422, jiffies 4294711998 (age 5.223s)
  hex dump (first 32 bytes):
    00 86 fe 06 80 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 70 92 a0 80 18 00 00 00  ........p.......
  backtrace:
    [<00000000da294bc2>] kmalloc_trace+0x26/0x90
    [<00000000af593495>] __do_sys_timerfd_create+0x58/0x190
    [<0000000044a7da2f>] do_syscall_64+0x34/0x80
    [<0000000013b2114c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   49.994743] kmemleak: 1 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
Linux (none) 6.3.0-rc1-f2-00002-gf23cd1ffca4b #361 SMP PREEMPT_DYNAMIC
Tue Apr  4 20:05:45 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
:#> cat /sys/kernel/debug/kmemleak
:#>:#> [16686.317671] watchdog: BUG: soft lockup - CPU#1 stuck for
85s! [kworker/1:0:707]
[16686.578795] Modules linked in: crc32_pclmul(E) intel_rapl_common(E)
ghash_clmulni_intel(E) crct10dif_pclmul(E) crc32c_intel(E) pcspkr(E)
serio_raw(E) i2c_piix4(E) [last unloaded: drm(E)]
[16686.579866] CPU: 1 PID: 707 Comm: kworker/1:0 Tainted: G
E      6.3.0-rc1-f2-00002-gf23cd1ffca4b #361
[16686.580479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.2-1.fc37 04/01/2014
[16686.580988] Workqueue: ata_sff ata_sff_pio_task
[16686.581217] RIP: 0010:_raw_spin_unlock_irq+0x11/0x30
[16686.581531] Code: 05 fc b3 23 7e 85 c0 74 01 c3 0f 1f 44 00 00 c3
66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 46 00 00 00 90 fb 0f 1f
44 00 00 <bf> 01 00 00 00 e8 55 c1 3b ff 65 8b 05 c6 b3 23 7e 85 c0 74
01 c3
[16686.582594] RSP: 0018:ffffc9000042fe90 EFLAGS: 00000246
[16686.582899] RAX: 0000000000000000 RBX: ffff888005dcc0b8 RCX: 00000000000=
00000
[16686.583424] RDX: 0000000000010376 RSI: ffff888005dcc17c RDI: ffff888007b=
8fe40
[16686.583900] RBP: ffff88807dcb2100 R08: ff6565725e607360 R09: 00000000000=
00001
[16686.584241] R10: 0000000000000058 R11: fefefefefefefeff R12: ffff88807dc=
bb500
[16686.584570] R13: 0000000000000000 R14: ffff888008bb20c0 R15: ffff888005d=
cc0c0
[16686.584891] FS:  0000000000000000(0000) GS:ffff88807dc80000(0000)
knlGS:0000000000000000
[16686.585252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16686.585596] CR2: 000055bbcb66c440 CR3: 000000000938d000 CR4: 00000000007=
50ee0
[16686.585979] PKRU: 55555554
[16686.586156] Call Trace:
[16686.586335]  <TASK>
[16686.586490]  process_one_work+0x1c3/0x3c0
[16686.586824]  worker_thread+0x4d/0x380
[16686.587073]  ? _raw_spin_lock_irqsave+0x23/0x50
[16686.587380]  ? rescuer_thread+0x370/0x370
[16686.587661]  kthread+0xe6/0x110
[16686.587881]  ? kthread_complete_and_exit+0x20/0x20
[16686.588221]  ret_from_fork+0x1f/0x30
[16686.588460]  </TASK>

using sh-script posted previously,

2nd run went like this:
the kmemleak modprobe traces look unchanged from last report,
but new rmmod leaks are seen here.
And kmemleak file is empty after the report.
It also BUG'd later on a soft lockup

finished pass 15
Linux (none) 6.3.0-rc1-f2-00002-gf23cd1ffca4b #361 SMP PREEMPT_DYNAMIC
Tue Apr  4 20:05:45 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
[ 2030.329359] ACPI: bus type drm_connector registered
[ 2030.686297] AMD-Vi: AMD IOMMUv2 functionality not available on this
system - This is not a bug.
[ 2031.600726] [drm] amdgpu kernel modesetting enabled.
[ 2031.601205] amdgpu: CRAT table not found
[ 2031.601403] amdgpu: Virtual CRAT table created for CPU
[ 2031.601797] amdgpu: Topology: Add CPU node

real 0m1.725s
user 0m0.000s
sys 0m0.956s
rmmod: ERROR: Module intel_rapl_msr is not currently loaded
[ 2032.328701] ACPI: bus type drm_connector unregistered
[ 2032.504633] kmemleak: 8 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
finished pass 16
unreferenced object 0xffff88800536eb40 (size 192):
  comm "modprobe", pid 927, jiffies 4296693079 (age 6.651s)
  hex dump (first 32 bytes):
    00 5b 50 c0 ff ff ff ff 00 00 00 00 00 00 00 00  .[P.............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<0000000097c7da82>] __kmalloc+0x49/0x150
    [<000000003bcf1708>] __register_sysctl_table+0x51/0x7f0
    [<00000000c0b7f00a>] 0xffffffffc04f2a78
    [<000000009ea66960>] 0xffffffffc066001b
    [<000000001412bcff>] do_one_initcall+0x43/0x210
    [<00000000c116532d>] do_init_module+0x60/0x240
    [<000000001f641d01>] __do_sys_finit_module+0x93/0xf0
    [<0000000034507d8b>] do_syscall_64+0x34/0x80
    [<0000000087a8ea8c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff888009e3b800 (size 256):
  comm "modprobe", pid 927, jiffies 4296693079 (age 6.651s)
  hex dump (first 32 bytes):
    78 b8 e3 09 80 88 ff ff 00 00 00 00 00 00 00 00  x...............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<0000000097c7da82>] __kmalloc+0x49/0x150
    [<00000000a17c20b9>] __register_sysctl_table+0x569/0x7f0
    [<00000000c0b7f00a>] 0xffffffffc04f2a78
    [<000000009ea66960>] 0xffffffffc066001b
    [<000000001412bcff>] do_one_initcall+0x43/0x210
    [<00000000c116532d>] do_init_module+0x60/0x240
    [<000000001f641d01>] __do_sys_finit_module+0x93/0xf0
    [<0000000034507d8b>] do_syscall_64+0x34/0x80
    [<0000000087a8ea8c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff888021c363c0 (size 96):
  comm "rmmod", pid 947, jiffies 4296694434 (age 5.296s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000085923eeb>] kmalloc_trace+0x26/0x90
    [<00000000920b2848>] kernfs_fop_open+0x30c/0x390
    [<0000000078b60e3b>] do_dentry_open+0x1de/0x410
    [<00000000140ea377>] path_openat+0xaa0/0x10a0
    [<000000008bcf35a2>] do_filp_open+0xa1/0x130
    [<00000000404bfb4b>] do_sys_openat2+0x74/0x130
    [<000000009fd3d965>] __x64_sys_openat+0x5c/0x70
    [<0000000034507d8b>] do_syscall_64+0x34/0x80
    [<0000000087a8ea8c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff888021c36540 (size 96):
  comm "rmmod", pid 947, jiffies 4296694434 (age 5.296s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000085923eeb>] kmalloc_trace+0x26/0x90
    [<00000000920b2848>] kernfs_fop_open+0x30c/0x390
    [<0000000078b60e3b>] do_dentry_open+0x1de/0x410
    [<00000000140ea377>] path_openat+0xaa0/0x10a0
    [<000000008bcf35a2>] do_filp_open+0xa1/0x130
    [<00000000404bfb4b>] do_sys_openat2+0x74/0x130
    [<000000009fd3d965>] __x64_sys_openat+0x5c/0x70
    [<0000000034507d8b>] do_syscall_64+0x34/0x80
    [<0000000087a8ea8c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff888021c36420 (size 96):
  comm "rmmod", pid 948, jiffies 4296694456 (age 5.274s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000085923eeb>] kmalloc_trace+0x26/0x90
    [<00000000920b2848>] kernfs_fop_open+0x30c/0x390
    [<0000000078b60e3b>] do_dentry_open+0x1de/0x410
    [<00000000140ea377>] path_openat+0xaa0/0x10a0
    [<000000008bcf35a2>] do_filp_open+0xa1/0x130
    [<00000000404bfb4b>] do_sys_openat2+0x74/0x130
    [<000000009fd3d965>] __x64_sys_openat+0x5c/0x70
    [<0000000034507d8b>] do_syscall_64+0x34/0x80
    [<0000000087a8ea8c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff888021c368a0 (size 96):
  comm "rmmod", pid 950, jiffies 4296694518 (age 5.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000085923eeb>] kmalloc_trace+0x26/0x90
    [<00000000920b2848>] kernfs_fop_open+0x30c/0x390
    [<0000000078b60e3b>] do_dentry_open+0x1de/0x410
    [<00000000140ea377>] path_openat+0xaa0/0x10a0
    [<000000008bcf35a2>] do_filp_open+0xa1/0x130
    [<00000000404bfb4b>] do_sys_openat2+0x74/0x130
    [<000000009fd3d965>] __x64_sys_openat+0x5c/0x70
    [<0000000034507d8b>] do_syscall_64+0x34/0x80
    [<0000000087a8ea8c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff888021c36ae0 (size 96):
  comm "rmmod", pid 950, jiffies 4296694519 (age 5.239s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000085923eeb>] kmalloc_trace+0x26/0x90
    [<00000000920b2848>] kernfs_fop_open+0x30c/0x390
    [<0000000078b60e3b>] do_dentry_open+0x1de/0x410
    [<00000000140ea377>] path_openat+0xaa0/0x10a0
    [<000000008bcf35a2>] do_filp_open+0xa1/0x130
    [<00000000404bfb4b>] do_sys_openat2+0x74/0x130
    [<000000009fd3d965>] __x64_sys_openat+0x5c/0x70
    [<0000000034507d8b>] do_syscall_64+0x34/0x80
    [<0000000087a8ea8c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 2032.504633] kmemleak: 8 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
Linux (none) 6.3.0-rc1-f2-00002-gf23cd1ffca4b #361 SMP PREEMPT_DYNAMIC
Tue Apr  4 20:05:45 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux

/sys/kernel/debug/kmemleak is empty, so my reader script gets nothing

:#> ./grok_kmemleak -ag
all: bless( {
  'backtraces' =3D> {},
  'hexdumps' =3D> {},
  'users' =3D> {}
}, 'LeakSet' )
mods: bless( {
  'backtraces' =3D> {},
  'hexdumps' =3D> {},
  'users' =3D> {}
}, 'LeakSet' )
:#> [17772.014943] hrtimer: interrupt took 4628209 ns
[17807.172581] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[18017.793102] watchdog: BUG: soft lockup - CPU#2 stuck for 253s!
[kworker/2:1:420]
[18017.793110] Modules linked in: crc32_pclmul(E) intel_rapl_common(E)
ghash_clmulni_intel(E) crct10dif_pclmul(E) crc32c_intel(E) pcspkr(E)
serio_raw(E) i2c_piix4(E) [last unloaded: drm(E)]
[18017.793173] CPU: 2 PID: 420 Comm: kworker/2:1 Tainted: G
E      6.3.0-rc1-f2-00002-gf23cd1ffca4b #361
[18017.793176] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.2-1.fc37 04/01/2014
[18017.793179] Workqueue: events_freezable_power_ disk_events_workfn
[18017.793240] RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40
[18017.793266] Code: 04 31 c0 5b c3 0f 1f 44 00 00 31 c0 eb f5 0f 1f
00 0f 1f 44 00 00 e8 f6 05 00 00 90 f7 c6 00 02 00 00 74 06 fb 0f 1f
44 00 00 <bf> 01 00 00 00 e8 fd c6 3b ff 65 8b 05 6e b9 23 7e 85 c0 74
01 c3
[18017.793268] RSP: 0018:ffffc9000058bb90 EFLAGS: 00000206
[18017.793269] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000000=
00000
[18017.793270] RDX: 0000000000000000 RSI: 0000000000000293 RDI: ffff888007f=
99900
[18017.793270] RBP: 0000000000000293 R08: 0000000000000001 R09: ffffffff82c=
6c380
[18017.793271] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888006b=
88000
[18017.793271] R13: ffff888006933000 R14: ffff888006914000 R15: 00000000000=
00000
[18017.793274] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000)
knlGS:0000000000000000
[18017.793275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18017.793276] CR2: 000055fa79d48440 CR3: 0000000009f97000 CR4: 00000000007=
50ee0
[18017.793282] PKRU: 55555554
[18017.793294] Call Trace:
[18017.793312]  <TASK>
[18017.793313]  ata_scsi_queuecmd+0x4f/0x70
[18017.793339]  scsi_queue_rq+0x36d/0xc20
[18017.793345]  blk_mq_dispatch_rq_list+0x2ab/0x830
[18017.793355]  ? _raw_spin_lock_irqsave+0x23/0x50
[18017.793358]  __blk_mq_sched_dispatch_requests+0x9d/0x120
[18017.793363]  blk_mq_sched_dispatch_requests+0x30/0x60
[18017.793365]  __blk_mq_run_hw_queue+0x85/0xa0
[18017.793366]  blk_execute_rq+0x9e/0x190
[18017.793368]  scsi_execute_cmd+0xfd/0x2d0
[18017.793370]  sr_check_events+0xc1/0x2b0
[18017.793374]  ? finish_task_switch.isra.0+0x9b/0x2f0
[18017.793394]  cdrom_check_events+0x14/0x30
[18017.793403]  disk_check_events+0x34/0xf0
[18017.793405]  process_one_work+0x1c3/0x3c0
[18017.793408]  worker_thread+0x4d/0x380
[18017.793409]  ? _raw_spin_lock_irqsave+0x23/0x50
[18017.793411]  ? rescuer_thread+0x370/0x370
[18017.793412]  kthread+0xe6/0x110
[18017.793415]  ? kthread_complete_and_exit+0x20/0x20
[18017.793417]  ret_from_fork+0x1f/0x30
[18017.793428]  </TASK>
[18020.504528] rcu: 0-...!: (1 GPs behind) idle=3D753c/0/0x1
softirq=3D100444/100444 fqs=3D470
[18020.504962] rcu: (detected by 0, t=3D273814 jiffies, g=3D67733, q=3D11 n=
cpus=3D3)
[18020.505425] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G            EL
   6.3.0-rc1-f2-00002-gf23cd1ffca4b #361
[18020.506002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.2-1.fc37 04/01/2014
[18020.506499] RIP: 0010:pv_native_safe_halt+0xb/0x10
[18020.506848] Code: c3 0f 23 f6 c3 0f 0b 0f 1f 84 00 00 00 00 00 0f
0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 eb 07 0f 00 2d 6f 69 24
00 fb f4 <c3> cc cc cc cc 8b 17 48 89 fe 89 d7 83 e7 fe 0f 01 f9 66 90
48 c1
[18020.508055] RSP: 0018:ffffffff82c03e98 EFLAGS: 00000282
[18020.508376] RAX: 0000000000000000 RBX: ffffffff82c0f2c0 RCX: 00000000000=
00001
[18020.508824] RDX: 4000000000000000 RSI: ffffffff824c92ca RDI: ffffffff824=
86ff1
[18020.509199] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000000=
00000
[18020.509532] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[18020.509897] R13: 0000000000000000 R14: ffffffff82c0ea10 R15: 00000000000=
00000
[18020.510375] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000)
knlGS:0000000000000000
[18020.510901] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18020.511251] CR2: 00007f1773c1e738 CR3: 0000000002c32000 CR4: 00000000007=
50ef0
[18020.511705] PKRU: 55555554
[18020.511884] Call Trace:
[18020.512076]  <TASK>
[18020.512183]  default_idle+0x5/0x10
[18020.512353]  default_idle_call+0x26/0xd0
[18020.512608]  do_idle+0x1cb/0x220
[18020.512832]  cpu_startup_entry+0x19/0x20
[18020.513098]  rest_init+0xcb/0xd0
[18020.513261]  arch_call_rest_init+0xa/0x20
[18020.513477]  start_kernel+0x734/0xb40
[18020.513653]  ? load_ucode_bsp+0x68/0x180
[18020.513847]  secondary_startup_64_no_verify+0xe5/0xeb
[18020.514089]  </TASK>

:#>


Im not sure when I did the make clean, maybe here.
it'd be a 'clean' explanation of the BUG struff.
I havent seen any today

so with some minor tweaks to my mod-load-unload leak_drive,
(to use different modules as workload, in case anything tickles different)

cycling on pcspkr, I get

doing cycle_ pcspkr
[   65.163494] input: PC Speaker as /devices/platform/pcspkr/input/input24
[   65.335487] kmemleak: 1 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
finished pass 21
unreferenced object 0xffff8880097a1120 (size 96):
  comm "bash", pid 412, jiffies 4294727350 (age 5.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000006a558d73>] kmalloc_trace+0x26/0x90
    [<0000000010830fb6>] kernfs_fop_open+0x30c/0x390
    [<000000002c6acb11>] do_dentry_open+0x1de/0x410
    [<00000000debed23e>] path_openat+0xaa0/0x10a0
    [<00000000f619d9cf>] do_filp_open+0xa1/0x130
    [<00000000b6a4c64d>] do_sys_openat2+0x74/0x130
    [<0000000007cd46d3>] __x64_sys_openat+0x5c/0x70
    [<0000000062074f8d>] do_syscall_64+0x34/0x80
    [<0000000044b0764d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   65.335487] kmemleak: 1 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
Linux (none) 6.3.0-rc1-f2-00002-gf23cd1ffca4b #362 SMP PREEMPT_DYNAMIC
Wed Apr  5 09:26:03 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
:#>

that leaktrace repeated verbatim when cycling on test_dynamic_debug

the leaktrace cycling drm modules is like I posted previously,
but repeated here, since its a new patch

finished pass 4
Linux (none) 6.3.0-rc1-f2-00002-gf23cd1ffca4b #362 SMP PREEMPT_DYNAMIC
Wed Apr  5 09:26:03 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
[  305.519903] ACPI: bus type drm_connector registered
[  305.768467] AMD-Vi: AMD IOMMUv2 functionality not available on this
system - This is not a bug.
[  306.487182] [drm] amdgpu kernel modesetting enabled.
[  306.487838] amdgpu: CRAT table not found
[  306.488124] amdgpu: Virtual CRAT table created for CPU
[  306.488585] amdgpu: Topology: Add CPU node

real 0m1.258s
user 0m0.002s
sys 0m0.876s
rmmod: ERROR: Module intel_rapl_msr is not currently loaded
[  307.066093] ACPI: bus type drm_connector unregistered
[  307.215619] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
finished pass 5
unreferenced object 0xffff888007f87180 (size 192):
  comm "modprobe", pid 504, jiffies 4294969152 (age 5.317s)
  hex dump (first 32 bytes):
    00 fb 50 c0 ff ff ff ff 00 00 00 00 00 00 00 00  ..P.............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000f63d45f6>] __kmalloc+0x49/0x150
    [<00000000f918d102>] __register_sysctl_table+0x51/0x7f0
    [<000000002fbfef58>] 0xffffffffc04fca78
    [<000000001dcc6780>] 0xffffffffc038601b
    [<00000000d82d83ab>] do_one_initcall+0x43/0x210
    [<000000002ef9c020>] do_init_module+0x60/0x240
    [<00000000859f64f2>] __do_sys_finit_module+0x93/0xf0
    [<000000006b72a46f>] do_syscall_64+0x34/0x80
    [<000000009dda0f8e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff888008a3c800 (size 256):
  comm "modprobe", pid 504, jiffies 4294969152 (age 5.317s)
  hex dump (first 32 bytes):
    78 c8 a3 08 80 88 ff ff 00 00 00 00 00 00 00 00  x...............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000f63d45f6>] __kmalloc+0x49/0x150
    [<000000001a756730>] __register_sysctl_table+0x569/0x7f0
    [<000000002fbfef58>] 0xffffffffc04fca78
    [<000000001dcc6780>] 0xffffffffc038601b
    [<00000000d82d83ab>] do_one_initcall+0x43/0x210
    [<000000002ef9c020>] do_init_module+0x60/0x240
    [<00000000859f64f2>] __do_sys_finit_module+0x93/0xf0
    [<000000006b72a46f>] do_syscall_64+0x34/0x80
    [<000000009dda0f8e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  307.215619] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
Linux (none) 6.3.0-rc1-f2-00002-gf23cd1ffca4b #362 SMP PREEMPT_DYNAMIC
Wed Apr  5 09:26:03 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux

expanding those traces (cuz I scripted it)

:#> ./grok_kmemleak -agp
paste in your selected input:
- ie pasted from above
unreferenced object 0xffff888007f87180 (size 192):
  comm "modprobe", pid 504, jiffies 4294969152 (age 5.317s)
  hex dump (first 32 bytes):
    00 fb 50 c0 ff ff ff ff 00 00 00 00 00 00 00 00  ..P.............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000f63d45f6>] __kmalloc+0x49/0x150
    [<00000000f918d102>] __register_sysctl_table+0x51/0x7f0
    [<000000002fbfef58>] 0xffffffffc04fca78
    [<000000001dcc6780>] 0xffffffffc038601b
    [<00000000d82d83ab>] do_one_initcall+0x43/0x210
    [<000000002ef9c020>] do_init_module+0x60/0x240
    [<00000000859f64f2>] __do_sys_finit_module+0x93/0xf0
    [<000000006b72a46f>] do_syscall_64+0x34/0x80
    [<000000009dda0f8e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff888008a3c800 (size 256):
  comm "modprobe", pid 504, jiffies 4294969152 (age 5.317s)
  hex dump (first 32 bytes):
    78 c8 a3 08 80 88 ff ff 00 00 00 00 00 00 00 00  x...............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000f63d45f6>] __kmalloc+0x49/0x150
    [<000000001a756730>] __register_sysctl_table+0x569/0x7f0
    [<000000002fbfef58>] 0xffffffffc04fca78
    [<000000001dcc6780>] 0xffffffffc038601b
    [<00000000d82d83ab>] do_one_initcall+0x43/0x210
    [<000000002ef9c020>] do_init_module+0x60/0x240
    [<00000000859f64f2>] __do_sys_finit_module+0x93/0xf0
    [<000000006b72a46f>] do_syscall_64+0x34/0x80
    [<000000009dda0f8e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
all: bless( {
  'backtraces' =3D> {
    '[<00000000f63d45f6>] __kmalloc+0x49/0x150
    [<000000001a756730>] __register_sysctl_table+0x569/0x7f0
    [<000000002fbfef58>] 0xffffffffc04fca78
    [<000000001dcc6780>] 0xffffffffc038601b
    [<00000000d82d83ab>] do_one_initcall+0x43/0x210
    [<000000002ef9c020>] do_init_module+0x60/0x240
    [<00000000859f64f2>] __do_sys_finit_module+0x93/0xf0
    [<000000006b72a46f>] do_syscall_64+0x34/0x80
    [<000000009dda0f8e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' =3D> 1,
    '[<00000000f63d45f6>] __kmalloc+0x49/0x150
    [<00000000f918d102>] __register_sysctl_table+0x51/0x7f0
    [<000000002fbfef58>] 0xffffffffc04fca78
    [<000000001dcc6780>] 0xffffffffc038601b
    [<00000000d82d83ab>] do_one_initcall+0x43/0x210
    [<000000002ef9c020>] do_init_module+0x60/0x240
    [<00000000859f64f2>] __do_sys_finit_module+0x93/0xf0
    [<000000006b72a46f>] do_syscall_64+0x34/0x80
    [<000000009dda0f8e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' =3D> 1
  },
  'hexdumps' =3D> {
    '00 fb 50 c0 ff ff ff ff 00 00 00 00 00 00 00 00  ..P.............' =3D=
> 1,
    '78 c8 a3 08 80 88 ff ff 00 00 00 00 00 00 00 00  x...............' =3D=
> 1
  },
  'users' =3D> {
    'comm "modprobe", pid 504,' =3D> 2
  }
}, 'LeakSet' )
# this leak backtrace has 1 occurrences
[<00000000f63d45f6>] __kmalloc+0x49/0x150
    [<00000000f918d102>] __register_sysctl_table+0x51/0x7f0
    [<000000002fbfef58>] 0xffffffffc04fca78
    [<000000001dcc6780>] 0xffffffffc038601b
    [<00000000d82d83ab>] do_one_initcall+0x43/0x210
    [<000000002ef9c020>] do_init_module+0x60/0x240
    [<00000000859f64f2>] __do_sys_finit_module+0x93/0xf0
    [<000000006b72a46f>] do_syscall_64+0x34/0x80
    [<000000009dda0f8e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
doing: gdb -q -ex 'l *(__kmalloc+0x49)'  -ex quit wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff81386319 is in __kmalloc
(/home/jimc/projects/lx/wk-next/mm/slab_common.c:966).
961 s =3D kmalloc_slab(size, flags);
962
963 if (unlikely(ZERO_OR_NULL_PTR(s)))
964 return s;
965
966 ret =3D __kmem_cache_alloc_node(s, flags, node, size, caller);
967 ret =3D kasan_kmalloc(s, ret, size, flags);
968 trace_kmalloc(caller, ret, size, s->size, flags, node);
969 return ret;
970 }
doing: gdb -q -ex 'l *(__register_sysctl_table+0x51)'  -ex quit
wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff814e5991 is in __register_sysctl_table
(/home/jimc/projects/lx/wk-next/include/linux/slab.h:584).
579 index =3D kmalloc_index(size);
580 return kmalloc_trace(
581 kmalloc_caches[kmalloc_type(flags)][index],
582 flags, size);
583 }
584 return __kmalloc(size, flags);
585 }
586 #else
587 static __always_inline __alloc_size(1) void *kmalloc(size_t size,
gfp_t flags)
588 {
doing: gdb -q -ex 'l *(0xffffffffc04fca78)'  -ex quit wk-next/builds/f2/vml=
inux
Reading symbols from wk-next/builds/f2/vmlinux...
doing: gdb -q -ex 'l *(0xffffffffc038601b)'  -ex quit wk-next/builds/f2/vml=
inux
Reading symbols from wk-next/builds/f2/vmlinux...
doing: gdb -q -ex 'l *(do_one_initcall+0x43)'  -ex quit
wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff81001093 is in do_one_initcall
(/home/jimc/projects/lx/wk-next/init/main.c:1306).
1301
1302 if (initcall_blacklisted(fn))
1303 return -EPERM;
1304
1305 do_trace_initcall_start(fn);
1306 ret =3D fn();
1307 do_trace_initcall_finish(fn, ret);
1308
1309 msgbuf[0] =3D 0;
1310
doing: gdb -q -ex 'l *(do_init_module+0x60)'  -ex quit wk-next/builds/f2/vm=
linux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff812287c0 is in do_init_module
(/home/jimc/projects/lx/wk-next/kernel/module/main.c:2481).
2476 freeinit->init_rodata =3D mod->mem[MOD_INIT_RODATA].base;
2477
2478 do_mod_ctors(mod);
2479 /* Start the module */
2480 if (mod->init !=3D NULL)
2481 ret =3D do_one_initcall(mod->init);
2482 if (ret < 0) {
2483 goto fail_free_freeinit;
2484 }
2485 if (ret > 0) {
doing: gdb -q -ex 'l *(__do_sys_finit_module+0x93)'  -ex quit
wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff8122af73 is in __do_sys_finit_module
(/home/jimc/projects/lx/wk-next/kernel/module/main.c:2987).
2982 } else {
2983 info.hdr =3D buf;
2984 info.len =3D len;
2985 }
2986
2987 return load_module(&info, uargs, flags);
2988 }
2989
2990 static inline int within(unsigned long addr, void *start,
unsigned long size)
2991 {
doing: gdb -q -ex 'l *(do_syscall_64+0x34)'  -ex quit wk-next/builds/f2/vml=
inux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff81ddad64 is in do_syscall_64
(/home/jimc/projects/lx/wk-next/arch/x86/entry/common.c:50).
45 */
46 unsigned int unr =3D nr;
47
48 if (likely(unr < NR_syscalls)) {
49 unr =3D array_index_nospec(unr, NR_syscalls);
50 regs->ax =3D sys_call_table[unr](regs);
51 return true;
52 }
53 return false;
54 }
doing: gdb -q -ex 'l *(entry_SYSCALL_64_after_hwframe+0x46)'  -ex quit
wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff81e0006a is at
/home/jimc/projects/lx/wk-next/arch/x86/entry/entry_64.S:120.
115
116 /* clobbers %rax, make sure it is after saving the syscall nr */
117 IBRS_ENTER
118 UNTRAIN_RET
119
120 call do_syscall_64 /* returns with IRQs disabled */
121
122 /*
123 * Try to use SYSRET instead of IRET if we're returning to
124 * a completely clean 64-bit userspace context.  If we're not,
# this leak backtrace has 1 occurrences
[<00000000f63d45f6>] __kmalloc+0x49/0x150
    [<000000001a756730>] __register_sysctl_table+0x569/0x7f0
    [<000000002fbfef58>] 0xffffffffc04fca78
    [<000000001dcc6780>] 0xffffffffc038601b
    [<00000000d82d83ab>] do_one_initcall+0x43/0x210
    [<000000002ef9c020>] do_init_module+0x60/0x240
    [<00000000859f64f2>] __do_sys_finit_module+0x93/0xf0
    [<000000006b72a46f>] do_syscall_64+0x34/0x80
    [<000000009dda0f8e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
doing: gdb -q -ex 'l *(__kmalloc+0x49)'  -ex quit wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff81386319 is in __kmalloc
(/home/jimc/projects/lx/wk-next/mm/slab_common.c:966).
961 s =3D kmalloc_slab(size, flags);
962
963 if (unlikely(ZERO_OR_NULL_PTR(s)))
964 return s;
965
966 ret =3D __kmem_cache_alloc_node(s, flags, node, size, caller);
967 ret =3D kasan_kmalloc(s, ret, size, flags);
968 trace_kmalloc(caller, ret, size, s->size, flags, node);
969 return ret;
970 }
doing: gdb -q -ex 'l *(__register_sysctl_table+0x569)'  -ex quit
wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff814e5ea9 is in __register_sysctl_table
(/home/jimc/projects/lx/wk-next/fs/proc/proc_sysctl.c:974).
969 char *new_name;
970
971 new =3D kzalloc(sizeof(*new) + sizeof(struct ctl_node) +
972       sizeof(struct ctl_table)*2 +  namelen + 1,
973       GFP_KERNEL);
974 if (!new)
975 return NULL;
976
977 node =3D (struct ctl_node *)(new + 1);
978 table =3D (struct ctl_table *)(node + 1);
doing: gdb -q -ex 'l *(0xffffffffc04fca78)'  -ex quit wk-next/builds/f2/vml=
inux
Reading symbols from wk-next/builds/f2/vmlinux...
doing: gdb -q -ex 'l *(0xffffffffc038601b)'  -ex quit wk-next/builds/f2/vml=
inux
Reading symbols from wk-next/builds/f2/vmlinux...
doing: gdb -q -ex 'l *(do_one_initcall+0x43)'  -ex quit
wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff81001093 is in do_one_initcall
(/home/jimc/projects/lx/wk-next/init/main.c:1306).
1301
1302 if (initcall_blacklisted(fn))
1303 return -EPERM;
1304
1305 do_trace_initcall_start(fn);
1306 ret =3D fn();
1307 do_trace_initcall_finish(fn, ret);
1308
1309 msgbuf[0] =3D 0;
1310
doing: gdb -q -ex 'l *(do_init_module+0x60)'  -ex quit wk-next/builds/f2/vm=
linux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff812287c0 is in do_init_module
(/home/jimc/projects/lx/wk-next/kernel/module/main.c:2481).
2476 freeinit->init_rodata =3D mod->mem[MOD_INIT_RODATA].base;
2477
2478 do_mod_ctors(mod);
2479 /* Start the module */
2480 if (mod->init !=3D NULL)
2481 ret =3D do_one_initcall(mod->init);
2482 if (ret < 0) {
2483 goto fail_free_freeinit;
2484 }
2485 if (ret > 0) {
doing: gdb -q -ex 'l *(__do_sys_finit_module+0x93)'  -ex quit
wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff8122af73 is in __do_sys_finit_module
(/home/jimc/projects/lx/wk-next/kernel/module/main.c:2987).
2982 } else {
2983 info.hdr =3D buf;
2984 info.len =3D len;
2985 }
2986
2987 return load_module(&info, uargs, flags);
2988 }
2989
2990 static inline int within(unsigned long addr, void *start,
unsigned long size)
2991 {
doing: gdb -q -ex 'l *(do_syscall_64+0x34)'  -ex quit wk-next/builds/f2/vml=
inux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff81ddad64 is in do_syscall_64
(/home/jimc/projects/lx/wk-next/arch/x86/entry/common.c:50).
45 */
46 unsigned int unr =3D nr;
47
48 if (likely(unr < NR_syscalls)) {
49 unr =3D array_index_nospec(unr, NR_syscalls);
50 regs->ax =3D sys_call_table[unr](regs);
51 return true;
52 }
53 return false;
54 }
doing: gdb -q -ex 'l *(entry_SYSCALL_64_after_hwframe+0x46)'  -ex quit
wk-next/builds/f2/vmlinux
Reading symbols from wk-next/builds/f2/vmlinux...
0xffffffff81e0006a is at
/home/jimc/projects/lx/wk-next/arch/x86/entry/entry_64.S:120.
115
116 /* clobbers %rax, make sure it is after saving the syscall nr */
117 IBRS_ENTER
118 UNTRAIN_RET
119
120 call do_syscall_64 /* returns with IRQs disabled */
121
122 /*
123 * Try to use SYSRET instead of IRET if we're returning to
124 * a completely clean 64-bit userspace context.  If we're not,
mods: bless( {
  'backtraces' =3D> {},
  'hexdumps' =3D> {},
  'users' =3D> {}
}, 'LeakSet' )
:#>
