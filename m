Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8626B03B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCHKHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCHKHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:07:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63CC43440
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:07:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v11so17156781plz.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678270068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJzcc6rKR0/tJP4lO1Zyy6/g4sV6V23DXqlI9X2wTrc=;
        b=dCSpcvbFiVJczZSZf05BTKfBfJqu4a2BMXshWHoRhZPYqHAGUiwAwOE3q/5t3pikj4
         do3uU7A8nvTTTj6oqeJEW1WteP8Y56FeKrSvdvhelMWlwye8f7vwiODoKBjLiyl9idw4
         VQtyflVLgF5aZsvzdR/b0XU7gS/734/8vSQ5qvxfvvJGFX2Q+FdUboKWjSvRoFw4O3IN
         Eti5UKQfJMuXQNQLVmn1WjQK5Vl7ULwrxQJ/Uhj1lFwoT4Ut6vbOeZJXCKnYDQh09jbN
         cKD6vLZzBSMIS+wpf+VohzWdDuqCg2Azvkob06R8gj9WQXpxgHLC/TtkFVxqma/J6CoM
         67eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJzcc6rKR0/tJP4lO1Zyy6/g4sV6V23DXqlI9X2wTrc=;
        b=cgJV8wo7lERelORviHXU4P1Q91lMxgPUA6WoiWeq9/CDLOtoF+HpfQ7mtUpPMNni8Q
         bYAI7uxaClXrNuD5ACO0gEV63/eksKSfFmUAZoURjAb7LT4kNHSTsYWn0jPts4MYS/9c
         uAfSlsgDJxr2oj2mVu4u1IDxXhowB73ZCMAHMy987ALNvGa4NDSfoP2ziJtjzdS6JkNv
         A2IiwlD6Tw8Mb8w9kbbnqrg4tsuYwC/o1YeceaA5VTrCk1MUNiwLRCf1tJU/+gR+c7CI
         ZA8o5bPfDIBAA4GP2MvtSHl+ptKVVqcYLXteukSy2aezZ3j/nqVa75m+TW6nCxh9yRwo
         3ovw==
X-Gm-Message-State: AO0yUKUkU3JRFtH0YJWYQL1kAtNvOcHJHq9RYyb3O572abaDKmgcoddr
        1df+H8FeEsdDBtX79iS+qm0J5vXi5zbCCekP9daOoRpqNYsWhQ==
X-Google-Smtp-Source: AK7set/mDMvw2QSltP121J0ZchHsEbTyS6nQNIk3D+lK/r5s25PVzFJPhTu3QQrKq0RaQMYYiPkVxMlKminD8zVOHos=
X-Received: by 2002:a17:90a:6389:b0:236:6e4c:8a1e with SMTP id
 f9-20020a17090a638900b002366e4c8a1emr6354749pjj.1.1678270068002; Wed, 08 Mar
 2023 02:07:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:fa6:b0:5f:9f12:d99c with HTTP; Wed, 8 Mar 2023
 02:07:46 -0800 (PST)
In-Reply-To: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Wed, 8 Mar 2023 11:07:46 +0100
Message-ID: <CADo9pHgCSdrwG7J8NZB3EBpvfH9KCpmitXKA88tSqqPAgPC9zA@mail.gmail.com>
Subject: Re: Linux 6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        droidbittin@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Works on my machine :)

On 3/6/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> So after several releases where the merge windows had something odd
> going on, we finally had just a regular "two weeks of just merge
> window". It was quite nice.
>
> In fact, it was quite nice in a couple of ways: not only didn't I have
> a hugely compressed merge window where I felt I had to cram as much as
> possible into the first few days, but the fact that we _have_ had a
> couple of merge windows where I really asked for people to have
> everything ready when the merge window opened seems to have set a
> pattern: the bulk of everything really did come in early.
>
> And again, that just makes the merge window work nicer for me, when I
> don't sit there waiting, knowing that there's stuff pending that just
> hasn't had a pull request done yet.
>
> So it all felt rather good. Of course, the fact that I had no machine
> issues, no holidays, and no travel coming up, then meant that I may
> have noticed a few more of the "people, please write good commit
> messages for merges" issues, so there's a possible downside to me not
> being as hurried as the last few merge windows have been.
>
> And of course, smooth or not, now that the merge window is closed, we
> need to make sure it all *works*. We had a couple of exciting merges
> already, and I think the fallout from that got sorted out, but I'm
> sure there's more to come. Let's hope the calming-down period of 6.3
> works as well as the merge window did... Knock wood.
>
> Anyway, as always, the shortlog is much too large to post, since we
> had 12500+ commits (and that's not counting the merges - closer to a
> thousand of those). So below is just my usual merge log which gives
> only a very high-level view of what I merged and from who. It all
> looks fairly normal, with ~55% of the patch being drivers, ~20% being
> architecture updates. and the rest being the usual random mix
> (documentation, tooling, networking, filesystem, and just core kernel
> stuff).
>
> Please do test,
>
>                 Linus
>
> ---
>
> Al Viro (8):
>     minix updates
>     sysv updates
>     alpha updates
>     ipc namespace update
>     misc vfs updates
>     alpha updates
>     VM_FAULT_RETRY fixes
>     vfs update
>
> Alex Williamson (1):
>     VFIO updates
>
> Alexandre Belloni (2):
>     i3c updates
>     RTC updates
>
> Andreas Gruenbacher (1):
>     gfs2 updates
>
> Andrew Morton (3):
>     MM updates
>     non-MM updates
>     misc fixes
>
> Anna Schumaker (1):
>     NFS client updates
>
> Ard Biesheuvel (1):
>     EFI updates
>
> Arnaldo Carvalho de Melo (1):
>     perf tools updates
>
> Arnd Bergmann (7):
>     ARM SoC updates
>     ARM defconfigs updates
>     SoC DT updates
>     asm-generic cleanups
>     ARM SoC driver updates
>     ARM SoC fixes
>     ARM SoC boardfile updates
>
> Bartosz Golaszewski (1):
>     gpio updates
>
> Benjamin Tissoires (1):
>     HID updates
>
> Bjorn Andersson (3):
>     hwspinlock updates
>     rpmsg updates
>     remoteproc updates
>
> Bjorn Helgaas (1):
>     PCI updates
>
> Borislav Petkov (7):
>     RAS updates
>     EDAC updates
>     x86 asm alternatives updates
>     x86 resource control updates
>     x86 microcode loader updates
>     x86 vdso updates
>     x86 cpuid updates
>
> Casey Schaufler (1):
>     smack update
>
> Catalin Marinas (2):
>     arm64 updates
>     arm64 fixes
>
> Christian Brauner (3):
>     vfs idmapping updates
>     vfs hardening update
>     vfs acl update
>
> Christoph Hellwig (1):
>     dma-mapping updates
>
> Chuck Lever (2):
>     nfsd updates
>     nfsd fix
>
> Corey Minyard (1):
>     IPMI updates
>
> Damien Le Moal (3):
>     ATA updates
>     zonefs updates
>     ATA fix
>
> Dan Williams (1):
>     Compute Express Link (CXL) updates
>
> Darrick Wong (3):
>     iomap updates
>     xfs updates
>     moar xfs updates
>
> Dave Airlie (2):
>     drm updates
>     drm fixes
>
> Dave Hansen (1):
>     Intel Trust Domain Extensions (TDX) updates
>
> Dave Kleikamp (1):
>     jfs update
>
> David Sterba (1):
>     btrfs updates
>
> David Teigland (1):
>     dlm updates
>
> Dmitry Torokhov (1):
>     input updates
>
> Eric Biggers (2):
>     fscrypt updates
>     fsverity updates
>
> Eric Van Hensbergen (1):
>     9p updates
>
> Gao Xiang (1):
>     erofs updates
>
> Geert Uytterhoeven (1):
>     m68k updates
>
> Greg KH (6):
>     USB / Thunderbolt driver updates
>     tty / serial driver updates
>     staging driver updates
>     char/misc and other driver subsystem updates
>     driver core updates
>     driver core fixes
>
> Greg Ungerer (1):
>     m68knommu updates
>
> Guenter Roeck (1):
>     hwmon updates
>
> Guo Ren (1):
>     csky update
>
> Gustavo Silva (1):
>     flexible-array updates
>
> Hans de Goede (1):
>     x86 platform driver updates
>
> Heiko Carstens (2):
>     s390 updates
>     more s390 updates
>
> Herbert Xu (2):
>     crypto update
>     crypto fix
>
> Huacai Chen (1):
>     LoongArch updates
>
> Ilya Dryomov (1):
>     ceph fixes
>
> Ingo Molnar (11):
>     locking updates
>     perf updates
>     scheduler updates
>     x86 asm updates
>     x86 boot updates
>     x86 build update
>     x86 core updates
>     x86 fpu updates
>     x86 mm update
>     x86 platform update
>     objtool updates
>
> Jaegeuk Kim (1):
>     f2fs updates
>
> Jakub Kicinski (2):
>     networking updates
>     networking fixes
>
> James Bottomley (2):
>     SCSI updates
>     more SCSI updates
>
> Jan Kara (2):
>     fsnotify updates
>     UDF and ext2 fixes
>
> Jarkko Sakkinen (1):
>     tpm updates
>
> Jason Gunthorpe (2):
>     iommufd updates
>     rdma updates
>
> Jassi Brar (1):
>     mailbox updates
>
> Jeff Layton (2):
>     file locking updates
>     i_version updates
>
> Jens Axboe (6):
>     io_uring updates
>     io_uring ITER_UBUF conversion
>     legacy dio update
>     block updates
>     block fixes
>     more io_uring updates
>
> Jens Wiklander (1):
>     TEE update
>
> Joerg Roedel (1):
>     iommu updates
>
> John Paul Adrian Glaubitz (1):
>     sh updates
>
> Jonathan Corbet (2):
>     documentation updates
>     Documentation stragglers
>
> Juergen Gross (1):
>     xen updates
>
> Julia Lawall (1):
>     coccinelle updates
>
> Kees Cook (2):
>     seccomp update
>     hardening updates
>
> Lee Jones (3):
>     MFD updates
>     backlight updates
>     LED updates
>
> Linus Walleij (1):
>     pin control updates
>
> Luis Chamberlain (2):
>     modules updates
>     sysctl update
>
> Mark Brown (5):
>     regmap updates
>     regulator updates
>     spi updates
>     regulator fixes
>     spi fixes
>
> Masahiro Yamada (1):
>     Kbuild updates
>
> Masami Hiramatsu (3):
>     kprobes updates
>     bootconfig updates
>     kprobes cleanup updates
>
> Mauro Carvalho Chehab (1):
>     media updates
>
> Michael Ellerman (2):
>     powerpc updates
>     powerpc fixes
>
> Michael Tsirkin (1):
>     virtio updates
>
> Micka=C3=ABl Sala=C3=BCn (1):
>     landlock updates
>
> Miguel Ojeda (3):
>     Rust updates
>     auxdisplay fix
>     Rust fix
>
> Mike Rapoport (1):
>     memblock updates
>
> Mike Snitzer (1):
>     device mapper updates
>
> Miklos Szeredi (1):
>     fuse updates
>
> Mimi Zohar (1):
>     integrity update
>
> Miquel Raynal (1):
>     MTD updates
>
> Namjae Jeon (1):
>     exfat updates
>
> Palmer Dabbelt (2):
>     RISC-V updates
>     more RISC-V updates
>
> Paolo Bonzini (1):
>     kvm updates
>
> Paul McKenney (5):
>     RCU updates
>     LKMM (Linux Kernel Memory Model) updates
>     x86 NMI diagnostics
>     nolibc updates
>     kernel concurrency sanitizer (KCSAN) updates
>
> Paul Moore (1):
>     audit update
>
> Petr Mladek (2):
>     printk updates
>     livepatching updates
>
> Rafael Wysocki (6):
>     power management updates
>     ACPI updates
>     thermal control updates
>     more power management updates
>     more ACPI updates
>     more thermal control updates
>
> Richard Weinberger (2):
>     jffs2, ubi and ubifs updates
>     UML updates
>
> Rob Herring (1):
>     devicetree updates
>
> Russell King (1):
>     ARM udpates
>
> Sebastian Reichel (2):
>     power supply and reset updates
>     more power supply updates
>
> Shuah Khan (2):
>     Kselftest update
>     KUnit update
>
> Stephen Boyd (1):
>     clk updates
>
> Steve French (3):
>     ksmbd server updates
>     cifs client updates
>     more cifs updates
>
> Steven Rostedt (4):
>     ktest updates
>     tracing tools updates
>     tracing fix
>     tracing updates
>
> Takashi Iwai (2):
>     sound updates
>     sound fixes
>
> Ted Ts'o (1):
>     ext4 updates
>
> Tejun Heo (2):
>     workqueue updates
>     cgroup updates
>
> Thierry Reding (1):
>     pwm updates
>
> Thomas Bogendoerfer (2):
>     MIPS updates
>     more MIPS updates
>
> Thomas Gleixner (5):
>     miscellaneous x86 cleanups
>     timer updates
>     irq updates
>     irq updates
>     x86 updates
>
> Tzung-Bi Shih (1):
>     chrome platform updates
>
> Ulf Hansson (1):
>     MMC updates
>
> Vinod Koul (3):
>     dmaengine updates
>     phy updates
>     soundwire updates
>
> Vlastimil Babka (1):
>     slab updates
>
> Wei Liu (1):
>     hyperv updates
>
> Wim Van Sebroeck (1):
>     watchdog updates
>
> Wolfram Sang (2):
>     i2c updates
>     more i2c updates
>
