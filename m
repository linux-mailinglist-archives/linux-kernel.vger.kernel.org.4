Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C32D6C1466
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCTOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCTOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:10:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2454440DA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:10:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p16so7597239wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679321399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htLtQDgflxVCtls627rP/k7MKZwMTANV654yyEH5hZU=;
        b=ZnCU9yvtryvvvyX8+KZ+3J83oYhk9FeSUCXcuqFm4XEBHKT1OKsVupA9Hr4/CotM/a
         hbPMd6uKHzs/xqVw2PglL5dT1Ldq8E2Q0IP7BvQg4FggR67WwxiVU2UGXu52V/IIeypI
         t5yX8CaNptJqa0Hp92u7+HjJq+lxFNm+DPA3eLxfXUlXthysMO+ebAjJt1FhrI++/7cV
         SL6VCq9ZFU0rF++G2A4S6M7a70vIO0zuNwap3eA/VOocXa9G7lQXD6dTWR3PUYujGreH
         gqlLCJvLiR3Va6+e+cCUI8h/A7slwUXDfsBChWBct5hPlmt1tZT8oniIIHp1DFjNBOKS
         FBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htLtQDgflxVCtls627rP/k7MKZwMTANV654yyEH5hZU=;
        b=JEjmnTkNm8rZeXYFeGYZK8Ns9U+uG2p+oWD/zX0IH4Q8Imc6+sSLim8gwWBtZD4fO7
         HfZTOpwDLxFqTcv49QKPEph6Gc4yAH+L7iCfknzVIPrA5ndwVaHTVrjEycTLrfZjsPVh
         bh7FBiJaLiDknDr/xqjyKpAUJ29jd/UpzDFAhnWCrUOb7415kCDEOse+AabhFCy0B3Ws
         aWd0FH9iQ/3Dsb0HH5M+QDS9dZf31oEQ2qSbcHMFaNWMcOAmA4Ja6/vThWZKwelwDdgb
         q5/EKZh1NCZzGMZDs0YxmsveyETcKf6IatnF48FNz9yHprPhy45Ohe7e+PZNAz7xMouH
         3Txg==
X-Gm-Message-State: AO0yUKUKevpaBP0oGFB5/Pkpu+PvqVpHyBFbXldFZthOI0FSh6m74j2f
        ihFA1bUwEPCCP/LCCqgV+8Y=
X-Google-Smtp-Source: AK7set/vbtlUj96cQeTIX7lwt9hh7zWN8V/T6JHrsCZmTW7W6CnmQuOAuRk0hIkYPvuQI/6+uNIxsA==
X-Received: by 2002:a7b:c845:0:b0:3ed:76c3:50e9 with SMTP id c5-20020a7bc845000000b003ed76c350e9mr10678365wml.17.1679321399353;
        Mon, 20 Mar 2023 07:09:59 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id bg7-20020a05600c3c8700b003eb2e33f327sm28160504wmb.2.2023.03.20.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:09:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Date:   Mon, 20 Mar 2023 15:09:57 +0100
Message-ID: <1788637.Zkmt1EvEu4@suse>
In-Reply-To: <ZBf2fNF4AC3ovR1B@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine> <2599595.k3LOHGUjKi@suse>
 <ZBf2fNF4AC3ovR1B@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 20 marzo 2023 07:00:28 CET Khadija Kamran wrote:
> On Thu, Mar 16, 2023 at 09:07:09PM +0100, Fabio M. De Francesco wrote:
> > On gioved=EC 16 marzo 2023 19:35:09 CET Khadija Kamran wrote:
> > > On Thu, Mar 16, 2023 at 05:17:47PM +0100, Fabio M. De Francesco wrote:
> > > > On gioved=EC 16 marzo 2023 16:09:08 CET Khadija Kamran wrote:
> > [snip]
> >=20
> > > Hey Fabio!
> > >=20
> > > Hope you are doing well. After  spending a lot of time on this I am
> > > stuck now. Kindly help me resolve this issue or understand it better.
> > >=20
> > > Following your instructions I deleted my config file and copied one f=
rom
> > > the /boot/ directory. After that I enabled the dependencies(CONFIG_OF=
=3Dy
> > > and CONFIG_HAS_IOMEM=3Dy). I was successfully able to enable axis-fif=
o as
> > > a module.
> > >=20
> > > I then ran the following commands:
> > >  - make drivers/staging/axis-fifo/
>=20
> Hey Fabio!
> Sorry for reaching out to you very late. For the past two days I have
> had problems with my Virtual Machine. It is stuck at boot, and this
> happened after it accidentally shut down. I have tried to resolve this
> problem but nothing is working. Currently I have boot into an older
> kernel version from the GRUB menu.
>=20
> I am also sharing the error here:
> Gave up waiting for root device. Common problems:
> -Boot args (cat /proc/cmdline)
>   -Check rootdelay=3D (did the system wait long enough?)
> -Missing modules (cat /proc/modules; ls /dev)
> ALERT! UUID=3D718ed077-947d-4018-80ad-59825678e81d does not exist.
> Dropping to a shell!
> BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.2) built-in shell (ash)
> Enter 'help' for a list of built-in commands.
>=20
> I have Windows10 installed and I have created Ubunutu 22.04.1 VM on VMWare
> with 13GB RAM and 2 processors(4 cores each).
>=20
> (initramfs)_
>=20
> > No, this is not the right command... you are not invoking the linker to=
=20
make
> > the .ko object.
> >=20
> > Use "make M=3Ddrivers/staging/axis-fifo/"
> > or "make M=3Ddrivers/staging/axis-fifo/ W=3D1 -j8" (the latter to enabl=
e level
> > '1' warning and run on your 2 * 4 logical cores).
>=20
> This command gives error saying:
> scripts/Makefile.build:41: /drivers/staging/axis-fifo/Makefile:
> No such file or directory
> make[1]: *** No rule to make target '/drivers/staging/axis-fifo/Makefile'=
=2E=20
> Stop. make: *** [Makefile:2028: /drivers/staging/axis-fifo] Error 2
>=20
> > >  - sudo make modules_install install(this command took hours) :'(
> >=20
> > This is odd, it shouldn't :-/
> >=20
> > As I said in another message, I'll set aside some time to help you chec=
k=20
if
> > you need to fine tune your VM and Hypervisor configuration.
> >=20
> > I'm returning on the same subject we have been talked about because you=
=20
said
> > at least twice that your builds and install are too slow. We'll try to
> > diagnose it in an IRC session on #kernel-outreachy (I'm pretty sure for=
=20
the
> > first days of next week - I'll send an invite).
>=20
> Yes I would love that. Kindly help me with this.
> Thank you!
>=20
> Regards,
> Khadija Kamran
>=20
> > > > When you are done with build, install, and final reboot to test if=
=20
your
> > > > module can "modprobe" or "insmod" (i.e. link with the running custom
> >=20
> > kernel
> >=20
> > > > you built, installed and boot), try to compare the output of the
> > > > following
> > > > commands:
> > > >=20
> > > > # uname -a
> > > > Linux suse 6.2.2-1-default #1 SMP PREEMPT_DYNAMIC Thu Mar  9 06:06:=
13
> > > > UTC
> > > > 2023 (44ca817) x86_64 x86_64 x86_64 GNU/Linux
> > >=20
> > > The above command works
> > >=20
> > > > AND
> > > >=20
> > > > # modinfo <name of the module you are testing here>
> > >=20
> > > On running 'modinfo axis-fifo' I get error saying module axis-fifo not
> > > found.
> >=20
> > Try again after building with "M=3Ddrivers/staging" (as said above). Do=
n't
> > forget to run "make modules_install install" and then reboot into your
> > custom
> > built Kernel, not the distribution's kernel.
> >=20
> > While you are there, run "lsmod" to see all loaded modules. Pick one
> > randomly
> > from the output list and run "modinfo
> > name_of_the_module_you_want_info_about".>=20
> > > > I'm running "modinfo kvm" (but showing only two of many lines):
> > > >=20
> > > > # modinfo kvm
> > > > filename:       /lib/modules/6.2.2-1-default/kernel/arch/x86/kvm/
> >=20
> > kvm.ko.zst
> >=20
> > > > vermagic:       6.2.2-1-default SMP preempt mod_unload modversions
> > > >=20
> > > > Can you see that the kernel in "uname -a" and the filename and=20
vermagic
> >=20
> > have
> >=20
> > > > the same "6.2.2-1-default"? Well, so I'm sure I'm running the right
> > > > Kernel
> > > > and inserted the appropriate "kvm" module.
> > > >=20
> > > > Furthermore, before rebooting your custom kernel, you may also look=
 at
> > > > the
> > > > directory in the Kernel where you compiled your module and search f=
or
> >=20
> > "*.o"
> >=20
> > > > "*mod*" and "*.ko" files. If you have them, you built your module
> >=20
> > properly.
> >=20
> > > There is a "*.o" file and "*.mod" file but there is no "*.ko" file in
> > > the axis-fifo directory.
> > >=20
> > > Kindly help me with this.
> > >=20
> > > Regards,
> > > Khadija
> > >=20
> > > > Thanks,
> > > >=20
> > > > Fabio
> >=20
> > Let me know if this time it works.
> >=20
> > Fabio
> >=20
> > P.S.: Have you had time to read that "Linux Kernel Module Programming"=
=20
guide
> > I sent you the link of? You can find a lot of information about modules
> > there. I'd strongly recommend you to read it.

Khadija,

I think that you are trying to skip some passages. Let me explain better...

Soon after copying from /boot your new .config you should run "make=20
menuconfig" or "make oldconfig" to re-create the necessary dependence and=20
other files which are required to build properly.

I'd suggest "make menuconfig" so that you can check if you enabled correctl=
y=20
the module(s) you are interested to build and other built-in options you ma=
y=20
optionally need.

Then you must rebuild and install. So...

1) "make menuconfig" (don't forget to save before exiting),
2) "make W=3D1 -j8" (because you have 8 logical cores reserved to your VMWa=
re=20
VM, correct?).
3) "make modules_install install".

At this point check that you have a fresh kernel image in /boot, that /boot/
grub/grub.conf contains a new entry with your freshly built custom kernel s=
o=20
that you can boot it from selecting the proper entry in the menu that you'l=
l=20
see after reboot. Also check that you have axis-fifo.ko under /lib/modules/
<the new kernel version>/build/drivers/staging/axis-fifo/.

=46or example in my VM for test I see axis-fifo with...

ls -l /lib/modules/6.3.0-rc2-x86-32-debug+/build/drivers/staging/axis-fifo/
total 564
=2Drw-r--r-- 1 1001 fsgqa    196 Mar 16 20:57 .Module.symvers.cmd
=2Drw-r--r-- 1 1001 fsgqa    275 Mar 17 15:39 .axis-fifo.ko.cmd
=2Drw-r--r-- 1 1001 fsgqa    183 Mar 12 20:29 .axis-fifo.mod.cmd
=2Drw-r--r-- 1 1001 fsgqa  50093 Mar 17 15:39 .axis-fifo.mod.o.cmd
=2Drw-r--r-- 1 1001 fsgqa  61110 Mar 17 15:37 .axis-fifo.o.cmd
=2Drw-r--r-- 1 1001 fsgqa    147 Mar 17 15:37 .modules.order.cmd
=2Drw-r--r-- 1 1001 fsgqa      0 Mar 16 20:57 Module.symvers
=2Drw-r--r-- 1 1001 fsgqa 255748 Mar 17 15:39 axis-fifo.ko
=2Drw-r--r-- 1 1001 fsgqa     38 Mar 12 20:29 axis-fifo.mod
=2Drw-r--r-- 1 1001 fsgqa   2354 Mar 17 15:38 axis-fifo.mod.c
=2Drw-r--r-- 1 1001 fsgqa  44604 Mar 17 15:39 axis-fifo.mod.o
=2Drw-r--r-- 1 1001 fsgqa 128156 Mar 17 15:37 axis-fifo.o
=2Drw-r--r-- 1 1001 fsgqa     38 Mar 17 15:37 modules.order

(as you can see, the last time I built and installed the kernel and the axi=
s-
fifo driver's module was March 17, 15:39).

Please notice that my kernel has that "-x86-32-debug+" suffix after the ker=
nel=20
version but this depends on a special option I need to set to differentiate=
=20
"debug" kernels from "production" kernels. You may have something else that=
=20
your distribution appends.

If you can't find the module run again "ls -l" one level up, like in /lib/
modules/6.3.0-rc2-x86-32-debug+/build/drivers/staging/ to see if at least y=
ou=20
have any of the drivers/staging/ modules. Go one more layer up if you don't=
=20
find them.

If everything I cited above is where it is supposed to be and grub.conf is=
=20
properly configured with the new entry, reboot and enjoy your module (try=20
modprobe, modinfo, lsmod, and the likes).

=46abio=20

=46abio




