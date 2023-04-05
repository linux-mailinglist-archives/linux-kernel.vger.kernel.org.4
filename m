Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C016D7217
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbjDEBjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDEBjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:39:12 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E348C2D79;
        Tue,  4 Apr 2023 18:39:08 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id g17so30119582vst.10;
        Tue, 04 Apr 2023 18:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680658748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWLTiS/vkM1oU0k2UhlCdVsqRz3tzpSuZmnhgQ4KoBA=;
        b=qVwp09jD2PqiRkfS0KP/iVxMM4ntEVZnx0dBecyHjhw/wH72mjMyFqnUBz+L1eHusF
         fiEQtb5DtYboDgqR7y4rEye9ecXuuOfkxM0f+JZ89HfzmF+boz1EarQ61xFTCPN0GqJE
         SJGTttkebwKNeko/et9OgQWQvwMy3MOnrcjRRG/6DgHZBgvof4f6Mb0+Qqg4Qf+yckQT
         aiszc/bXPiN9caGfoFYZOmJU0FqPz3cw8r9pvrQo3QNPF6stnhYb0XsUfa4vzUrns5PN
         8bVCHorwUIkfwozFfI7nUBaQs+Fhs16asFeqgCVmw+08qNyqweaG5KKTL5VNxnfuF47v
         LEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680658748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWLTiS/vkM1oU0k2UhlCdVsqRz3tzpSuZmnhgQ4KoBA=;
        b=ZAE1rrOMWopsf8RpTZs3ANyM+rPiDt24ZtAzB5ePa/+HbD6vap6FZSBH95fOkwjsgc
         SnaZGBbH16dd9XtHhDBYXQF4SreKPPDiFmbfLtDTxcdDrtY+cTsTcFySRQrtYhD9ClWk
         Cz/tD81Jilag4qMgHSB3mWJEIGPId4oezU9cbKSv0wfxHvz/F4grT27rYDb1RR9iLjpW
         WsOP43ydnlaj797CoCmuEeH3vusUig+jEEB5lYElB1xMLzbvzmvaKJU2lRIHjXVHn8eh
         5K/1qslgH6dsu1r4RZovucpjptFMD9NOfATFpTQIqImscoePQ2It2d73VXC14x5xp2XA
         VFKA==
X-Gm-Message-State: AAQBX9eBO7TaCu46H8fqNnMhVYQMBl+DNJX2GQTdmH28rAxlAboZsVzn
        iPlwPDgDdvoAJyO0+wDcDkT5RswuZsyGI2q2gDO/T0W7jkA=
X-Google-Smtp-Source: AKy350YhtKU2LyeAhHTVeVzjVFroIEwk2dGT/suZrA5/G0Z523sc3exIWd9rHslPNPMARq+Eh1r7Y9cPE58J9Bp7QzM=
X-Received: by 2002:a67:d90f:0:b0:425:875f:50c6 with SMTP id
 t15-20020a67d90f000000b00425875f50c6mr3845179vsj.5.1680658747918; Tue, 04 Apr
 2023 18:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org> <CAPhsuW6P5AYVKMk=G1bEUz5PGZKmTJwtgQBmE-P4iAo7dOr5yA@mail.gmail.com>
 <ZCs6jpo1nYe1Wm08@bombadil.infradead.org>
In-Reply-To: <ZCs6jpo1nYe1Wm08@bombadil.infradead.org>
From:   jim.cromie@gmail.com
Date:   Tue, 4 Apr 2023 19:38:41 -0600
Message-ID: <CAJfuBxzGJvrJo9nTXxZ3xZ7QmdSb6YxBw-bojZjQTpACBeK_sQ@mail.gmail.com>
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

On Mon, Apr 3, 2023 at 2:44=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Fri, Mar 31, 2023 at 05:27:04PM -0700, Song Liu wrote:
> > On Fri, Mar 31, 2023 at 12:00=E2=80=AFAM Luis Chamberlain <mcgrof@kerne=
l.org> wrote:
> > >
> > > On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> > > > hi Luis, etal
> > > >
> > > > kmemleak is reporting 19 leaks during boot
> > > >
> > > > because the hexdumps appeared to have module-names,
> > > > and Ive been hacking nearby, and see the same names
> > > > every time I boot my test-vm, I needed a clearer picture
> > > > Jason corroborated and bisected.
> > > >
> > > > the 19 leaks split into 2 groups,
> > > > 9 with names of builtin modules in the hexdump,
> > > > all with the same backtrace
> > > > 9 without module-names (with a shared backtrace)
> > > > +1 wo name-ish and a separate backtrace
> > >
> > > Song, please take a look.
> >
> > I will look into this next week.
>
> I'm thinking this may be it, at least this gets us to what we used to do
> as per original Catalinas' 4f2294b6dc88d ("kmemleak: Add modules
> support") and right before Song's patch.
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 6b6da80f363f..3b9c71fa6096 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2240,7 +2240,10 @@ static int move_module(struct module *mod, struct =
load_info *info)
>                  * which is inside the block. Just mark it as not being a
>                  * leak.
>                  */
> -               kmemleak_ignore(ptr);
> +               if (type =3D=3D MOD_INIT_TEXT)
> +                       kmemleak_ignore(ptr);
> +               else
> +                       kmemleak_not_leak(ptr);
>                 if (!ptr) {
>                         t =3D type;
>                         goto out_enomem;
>
> We used to use the grey area for the TEXT but the original commit
> doesn't explain too well why we grey out init but not the others. Ie
> why kmemleak_ignore() on init and kmemleak_not_leak() on the others.
>
> Catalinas, any thoughts / suggestions? Should we just stick to
> kmemleak_not_leak() for both now?
>
>   Luis

So I have mixed results.

your patch fixed the 19 leaks on my worktree / branch where I found them.

on top of
ac3b43283923 module: replace module_layout with module_memory

it fixed the (same) 19, but gets a few new ones.
whats weird is that once they report, they disappear from
/sys/kernel/debug/kmemleak

heres that kmemleak report, with a little preceding / setup,
performed by this bash scripting

drms_unload() {
    for m in i915 amdgpu nouveau \
iommu_v2 video i2c_algo_bit mxm_wmi wmi intel_rapl_msr \
drm_display_helper cec drm_kms_helper drm_ttm_helper ttm gpu_sched
drm_buddy drm;
    do
rmmod $m ;
    done
}
drms_load() {
    uname -a
    for m in i915 amdgpu nouveau;
    do
       modprobe $m $*
    done
}
cycle_drms() {
    for i in 1 $*; do # loop 1+argc times
      time drms_load
      drms_unload
    done
}

leak_drive () {

    [[ -f /sys/kernel/debug/kmemleak ]] || {
       echo "need KMEMLEAK"
       return
    }
    let count=3D0
    #echo ok testing, each dot is 10 secs
    while true; do

var=3D`cat /sys/kernel/debug/kmemleak`
if [[ -z $var ]] ; then
    cycle_drms
    echo scan >/sys/kernel/debug/kmemleak
else
    break
fi
((count=3D$count+1))
echo finished pass $count
    done
    cat /sys/kernel/debug/kmemleak
    dmesg | grep /sys/kernel/debug/kmemleak
    uname -a
}


finished pass 6
Linux (none) 6.3.0-rc1-f2-00002-g30504a44c558 #360 SMP PREEMPT_DYNAMIC
Tue Apr  4 15:25:05 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
[   51.768797] ACPI: bus type drm_connector registered
[   52.039443] AMD-Vi: AMD IOMMUv2 functionality not available on this
system - This is not a bug.
[   52.795766] [drm] amdgpu kernel modesetting enabled.
[   52.796288] amdgpu: CRAT table not found
[   52.796502] amdgpu: Virtual CRAT table created for CPU
[   52.796964] amdgpu: Topology: Add CPU node

real 0m1.354s
user 0m0.002s
sys 0m0.919s
rmmod: ERROR: Module intel_rapl_msr is not currently loaded
[   53.401823] ACPI: bus type drm_connector unregistered
[   53.595705] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
finished pass 7
unreferenced object 0xffff8880059b0240 (size 192):
  comm "modprobe", pid 716, jiffies 4294714739 (age 6.065s)
  hex dump (first 32 bytes):
    00 db 50 c0 ff ff ff ff 00 00 00 00 00 00 00 00  ..P.............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000406104d4>] __kmalloc+0x49/0x150
    [<00000000fe00c883>] __register_sysctl_table+0x51/0x7f0
    [<00000000438011af>] 0xffffffffc04faa78
    [<000000009a44098c>] 0xffffffffc037f01b
    [<00000000de0b0c0b>] do_one_initcall+0x43/0x210
    [<0000000016200549>] do_init_module+0x60/0x240
    [<00000000e5f75cca>] __do_sys_finit_module+0x93/0xf0
    [<0000000014ed2961>] do_syscall_64+0x34/0x80
    [<00000000d14e8c97>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
unreferenced object 0xffff88800ce25800 (size 256):
  comm "modprobe", pid 716, jiffies 4294714739 (age 6.065s)
  hex dump (first 32 bytes):
    78 58 e2 0c 80 88 ff ff 00 00 00 00 00 00 00 00  xX..............
    00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000406104d4>] __kmalloc+0x49/0x150
    [<00000000ec6658c8>] __register_sysctl_table+0x569/0x7f0
    [<00000000438011af>] 0xffffffffc04faa78
    [<000000009a44098c>] 0xffffffffc037f01b
    [<00000000de0b0c0b>] do_one_initcall+0x43/0x210
    [<0000000016200549>] do_init_module+0x60/0x240
    [<00000000e5f75cca>] __do_sys_finit_module+0x93/0xf0
    [<0000000014ed2961>] do_syscall_64+0x34/0x80
    [<00000000d14e8c97>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   53.595705] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
Linux (none) 6.3.0-rc1-f2-00002-g30504a44c558 #360 SMP PREEMPT_DYNAMIC
Tue Apr  4 15:25:05 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux

at this point, kmemleak is empty.
Im guessing thats because the leak was in / under  do_init_module,
and __init mem is recycled.

Maybe its also why the leak-trace has 2 entries without symbol info
Heres the levels above & below those mystery levels

(gdb) l *(do_one_initcall+0x43)
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
(gdb) l *(__register_sysctl_table+0x569)
0xffffffff814e5e99 is in __register_sysctl_table
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
(gdb)
