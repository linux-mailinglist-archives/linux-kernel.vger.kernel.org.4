Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A86AC8C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCFQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCFQyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:54:01 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBF3BDBC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:53:36 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-176eae36feaso1329265fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678121560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytZixfd05EJ3UI8U8BH9RVRDLterPGH0uspfhRObNw4=;
        b=hG1hHofJcUxg4OGAgDXqzh5F8vwuSjcxHvdROkQLLVklCH3lhAdmnefFky6Tahvp1J
         IDVmZVBsA+2sCdEHimYLfrHP1VN2hGxVjwmF/dxmYvGXK1nLnfZ0pzgL1yiDsjvqAZpo
         YKRReak8JAA9smIKVyP73pyuLoiHbuvw7mnr6o2Gl0QIJa/zJCRx4Y6y1e/Nzn0WayLW
         zOgpKs1WhYX49dBehRntUVDwwsoahA4Tb0VKaiocZZ1R4UrRCZrkr2NqteNx2ItFY882
         sOd61cs6DYP5SyRq1frWK3WEP6khJgLAnEYpKmAhmKBIJmxMJ0bcVfciCbakX/JR09Ps
         sV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678121560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytZixfd05EJ3UI8U8BH9RVRDLterPGH0uspfhRObNw4=;
        b=ijM4PeCyCbJceGLO1FMStYSOpMYK+6O/fqhN5F0119RTWZRc2ccB/Ap1gAwvsO3Ohr
         a9rZQGN4g99oDCBPKpJS3GwTqDzkJelNxqLD4N1LYPq9J+dZ2tRCYjVkjA6GV8wCkgpP
         B1novjiFtCaVPeP0ejEe5Pf3NQsZl1Lcsl+AUqt8cYeFhqqvOhxMRx9aBoeOreh/fo25
         pmFjUV7y4nPXrRvEvBLdt2HDAbguo1Z24QcbH8jcYqxlkSn4wEMXbvTxIe1Z7OD3D1RA
         tp3a3MUUUP1h5ANB0Lm9023/hrhRXJEQx65XSnhlOCw0VI2+JnRVjqjRxFkNFYPdfa25
         liPg==
X-Gm-Message-State: AO0yUKUCRlvnQQ/S0G7pS6FyA616mEszWur366DXF5YsPeUBs60zywwz
        391Tp1apoaGmUe8XdnQSzoeE+x4ggcE=
X-Google-Smtp-Source: AK7set9Wy1GZFDC7vrGidWGSjHwdyPMPOkOE+UYCRK0t7Ci2+wYPa93WlxMtTGzOQk3nSof2SVGhXw==
X-Received: by 2002:a05:6870:c095:b0:175:719d:1ff4 with SMTP id c21-20020a056870c09500b00175719d1ff4mr6830098oad.58.1678121560582;
        Mon, 06 Mar 2023 08:52:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id eb37-20020a056870a8a500b0017630fe87e5sm4123786oab.33.2023.03.06.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 08:52:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Mar 2023 08:52:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc1
Message-ID: <481b19b5-83a0-4793-b4fd-194ad7b978c3@roeck-us.net>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 03:24:41PM -0800, Linus Torvalds wrote:
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

Build results:
	total: 153 pass: 146 fail: 7
Failed builds:
	alpha:allmodconfig
	csky:allmodconfig
	m68k:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
	sparc64:allmodconfig
Qemu test results:
	total: 511 pass: 459 fail: 52
Failed tests:
	arm:smdkc210:exynos_defconfig:cpuidle:nocrypto:mem128:exynos4210-smdkv310:initrd
	arm:smdkc210:exynos_defconfig:cpuidle:nocrypto:sd2:mem128:exynos4210-smdkv310:rootfs
	arm:realview-eb:realview_defconfig:realview_eb:mem512:net,default:arm-realview-eb:initrd
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:mem256:net,nic:net,nic:imx6ul-14x14-evk:initrd
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:sd:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb0:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb1:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:mem256:net,nic:imx7d-sdb:initrd
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:usb1:mem256:net,nic:imx7d-sdb:rootfs
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:sd:mem256:net,nic:imx7d-sdb:rootfs
	arm:vexpress-a9:multi_v7_defconfig:nolocktests:flash64:mem128:net,default:vexpress-v2p-ca9:rootfs
	arm:sabrelite:multi_v7_defconfig:mem256:net,default:imx6dl-sabrelite:initrd
	arm:sabrelite:multi_v7_defconfig:mmc1:mem256:net,default:imx6dl-sabrelite:rootfs
	arm:sabrelite:multi_v7_defconfig:usb0:mem256:net,default:imx6dl-sabrelite:rootfs
	arm:sabrelite:multi_v7_defconfig:usb1:mem256:net,default:imx6dl-sabrelite:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:mem128:net,default:zynq-zc702:initrd
	arm:xilinx-zynq-a9:multi_v7_defconfig:usb0:mem128:net,default:zynq-zc702:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:sd:mem128:net,default:zynq-zc702:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:sd:mem128:net,default:zynq-zc706:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:usb0:mem128:zynq-zed:rootfs
	arm:cubieboard:multi_v7_defconfig:mem512:net,default:sun4i-a10-cubieboard:initrd
	arm:cubieboard:multi_v7_defconfig:usb:mem512:net,default:sun4i-a10-cubieboard:rootfs
	arm:cubieboard:multi_v7_defconfig:sata:mem512:net,default:sun4i-a10-cubieboard:rootfs
	arm:orangepi-pc:multi_v7_defconfig:net,nic:sun8i-h3-orangepi-pc:initrd
	arm:orangepi-pc:multi_v7_defconfig:sd:net,nic:sun8i-h3-orangepi-pc:rootfs
	arm:orangepi-pc:multi_v7_defconfig:usb0:net,nic:sun8i-h3-orangepi-pc:rootfs
	arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs
	ppc:mac99:ppc_book3s_defconfig:smp:ide:net,e1000:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,ne2k_pci:initrd
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,pcnet:ide:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000:sdhci:mmc:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000e:nvme:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,virtio-net:scsi[DC395]:rootfs
	riscv:sifive_u:defconfig:net,default:initrd
	riscv:sifive_u:defconfig:sd:net,default:rootfs
	riscv:sifive_u:defconfig:mtd32:net,default:rootfs
	sparc32:SS-4:nodebugobj:smp:scsi:net,default:hd
	sparc32:SS-5:nodebugobj:smp:scsi:net,default:cd
	sparc32:SS-10:nodebugobj:smp:scsi:net,default:hd
	sparc32:SS-20:nodebugobj:smp:scsi:net,default:hd
	sparc32:SS-600MP:nodebugobj:smp:scsi:net,default:hd
	sparc32:Voyager:nodebugobj:smp:noapc:scsi:net,default:hd
	i386:q35:Westmere-IBRS:defconfig:smp:efi32:scsi[53C810]:net,virtio-net-pci:hd
	i386:q35:Opteron_G1:defconfig:smp:efi32:net,i82558a:initrd
	i386:q35:core2duo:defconfig:smp:efi32:usb:net,i82559er:hd
	i386:pc:Westmere:defconfig:pae:smp:efi32:usb:net,pcnet:hd
	x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC395]:hd
	x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:scsi[MEGASAS2]:hd
	x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd
	x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-pci]:hd
	x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-pci-old]:hd
	x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio:hd

Guenter

---
Build failures:

alpha:allmodconfig
arm:allmodconfig
csky:allmodconfig
m68k:allmodconfig
mips:allmodconfig
openrisc:allmodconfig
parisc:ppc32_allmodconfig
powerpc:ppc32_allmodconfig
s390:allmodconfig
xtensa:allmodconfig

drivers/media/i2c/imx290.c:1090:12: error: 'imx290_runtime_suspend' defined but not used [-Werror=unused-function]
 1090 | static int imx290_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/media/i2c/imx290.c:1082:12: error: 'imx290_runtime_resume' defined but not used [-Werror=unused-function]
 1082 | static int imx290_runtime_resume(struct device *dev)

Seen whenever CONFIG_PM_SLEEP is not enabled. Introduced by commit 02852c01f654
("media: i2c: imx290: Initialize runtime PM before subdev");

Caused by commit 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev").

Fix: https://patchwork.kernel.org/project/linux-media/patch/20230207161316.293923-1-arnd@kernel.org/

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---

sparc64:allmodconfig
parisc:allmodconfig

fs/btrfs/inode.c: In function 'btrfs_lookup_dentry':
fs/btrfs/inode.c:5730:21: error: 'location.type' may be used uninitialized [-Werror=maybe-uninitialized]
 5730 |         if (location.type == BTRFS_INODE_ITEM_KEY) {
      |             ~~~~~~~~^~~~~
fs/btrfs/inode.c:5719:26: note: 'location' declared here
 5719 |         struct btrfs_key location;
      |                          ^~~~~~~~

Seen with gcc 11.x and later when trying to build sparc64 or parisc images.
Not observed with other architectures.
Caused (exposed) by commit 1ec49744ba83 ("btrfs: turn on -Wmaybe-uninitialized").
The failing code is

	ret = btrfs_inode_by_name(BTRFS_I(dir), dentry, &location, &di_type);
        if (ret < 0)
                return ERR_PTR(ret);

        if (location.type == BTRFS_INODE_ITEM_KEY) {

and in btrfs_inode_by_name():

        ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 1, &fname);
        if (ret)
                goto out;

It appears that gcc believes that fscrypt_setup_filename() may return
a positive value. If that happens, location.type would indeed be
uninitialized. Changing the above code to

        ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 1, &fname);
        if (ret < 0)
                goto out;

or, alternatively,

	ret = btrfs_inode_by_name(BTRFS_I(dir), dentry, &location, &di_type);
        if (ret)
                return ERR_PTR(ret);

would fix the problem.

Side note: gcc on other architectures (e.g., x86) does _not_ report an error
even if btrfs_inode_by_name() is made to return a positive value without
initializing location.type.

Fix: Not available as far as I know.

Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>

===
Runtime failures:

Various crashes, affecting several architectures.

[   11.664666] BUG: unable to handle page fault for address: 000000000002d3db
[   11.664827] #PF: supervisor read access in kernel mode
[   11.664891] #PF: error_code(0x0000) - not-present page
[   11.664983] PGD 800000000430d067 P4D 800000000430d067 PUD 41a2067 PMD 0
[   11.665179] Oops: 0000 [#1] PREEMPT SMP PTI
[   11.665319] CPU: 0 PID: 273 Comm: dd Tainted: G                 N 6.3.0-rc1 #1
[   11.665463] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   11.665602] RIP: 0010:__lock_acquire+0x5c6/0x2740
[   11.665819] Code: 00 83 f8 2f 0f 87 7c 08 00 00 3b 05 cc 62 a2 02 41 bd 01 00 00 00 0f 86 f6 00 00 00 89 05 ba 62 a2 02 e9 eb 00 00 00 45 31 ed <48> 81 3f a0 a8 52 b4 45 0f 45 e8 83 fe 01 0f 87 85 fa ff ff 89 f0
[   11.666011] RSP: 0018:ffffb0038039fbf8 EFLAGS: 00000046
[   11.666088] RAX: 0000000000000000 RBX: ffff8f1304238040 RCX: 0000000000000000
[   11.666163] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000002d3db
[   11.666235] RBP: 000000000002d3db R08: 0000000000000001 R09: 0000000000000001
[   11.666315] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   11.666408] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   11.666504] FS:  00007f78c78e3b28(0000) GS:ffff8f130f000000(0000) knlGS:0000000000000000
[   11.666591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.666655] CR2: 000000000002d3db CR3: 00000000042d2000 CR4: 00000000000006f0
[   11.666768] Call Trace:
[   11.666873]  <TASK>
[   11.666958]  ? lock_acquire+0xcb/0x330
[   11.667043]  lock_acquire+0xcb/0x330
[   11.667102]  ? add_timer_on+0x92/0x150
[   11.667163]  _raw_spin_lock+0x2b/0x40
[   11.667210]  ? add_timer_on+0x92/0x150
[   11.667255]  add_timer_on+0x92/0x150
[   11.667302]  try_to_generate_entropy+0x256/0x280
[   11.667379]  ? __pfx_entropy_timer+0x10/0x10
[   11.667436]  ? inode_security+0x2e/0x70
[   11.667484]  ? selinux_file_permission+0x11a/0x150
[   11.667539]  urandom_read_iter+0x23/0x90
[   11.667583]  vfs_read+0x226/0x2f0
[   11.667637]  ksys_read+0x64/0xe0
[   11.667680]  do_syscall_64+0x3f/0x90
[   11.667725]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   11.667817] RIP: 0033:0x7f78c78a1be2
[   11.667965] Code: c3 8b 07 85 c0 75 24 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> e9 70 d2 ff ff 41 54 b8 02 00 00 00 49 89 f4 be 00 88 08 00 55
[   11.668127] RSP: 002b:00007ffe531be798 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   11.668209] RAX: ffffffffffffffda RBX: 00007f78c78e3b28 RCX: 00007f78c78a1be2
[   11.668276] RDX: 0000000000000020 RSI: 00007f78c78e4d00 RDI: 0000000000000000
[   11.668378] RBP: 00007f78c78e4d00 R08: 0000000000000000 R09: 0000000000000000
[   11.668451] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   11.668517] R13: 0000000000000000 R14: 00007f78c78e4d00 R15: 0000000000000000
[   11.668613]  </TASK>
[   11.668669] Modules linked in:
[   11.668794] CR2: 000000000002d3db
[   11.669015] ---[ end trace 0000000000000000 ]---

Bisect (on arm):

# bad: [fe15c26ee26efa11741a7b632e9f23b01aca4cc6] Linux 6.3-rc1
# good: [b01fe98d34f3bed944a93bd8119fed80c856fad8] Merge tag 'i2c-for-6.3-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect start 'HEAD' 'b01fe98d34f3'
# good: [1a90673e17b6bcc6b6e8c072015956a6204e0f2d] Merge tag 'pull-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good 1a90673e17b6bcc6b6e8c072015956a6204e0f2d
# good: [0fb7fb713461e44b12e72c292bf90ee300f40710] genirq/msi, platform-msi: Ensure that MSI descriptors are unreferenced
git bisect good 0fb7fb713461e44b12e72c292bf90ee300f40710
# good: [7f9ec7d8169b5281eff2b907d8ffb1bf56045f73] Merge tag 'x86-urgent-2023-03-05' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 7f9ec7d8169b5281eff2b907d8ffb1bf56045f73
# good: [f915322fe014c5c515119381e886faf07b3c9d31] Merge tag 'v6.3-p2' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good f915322fe014c5c515119381e886faf07b3c9d31
# bad: [596ff4a09b8981790e15572e8e7bc904df5835e7] cpumask: re-introduce constant-sized cpumask optimizations
git bisect bad 596ff4a09b8981790e15572e8e7bc904df5835e7
# first bad commit: [596ff4a09b8981790e15572e8e7bc904df5835e7] cpumask: re-introduce constant-sized cpumask optimizations

Reverting the bad commit fixes the problem.

---
There are also some recently introduced runtime warnings in calls from ct_nmi_enter()
which I am still trying to bisect.

   28.758119] ------------[ cut here ]------------
[   28.758418] WARNING: CPU: 0 PID: 301 at kernel/locking/lockdep.c:5527 check_flags+0x170/0x258
[   28.759084] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
[   28.759127] Modules linked in:
[   28.759652] CPU: 0 PID: 301 Comm: run.sh Tainted: G                 N 6.2.0-13115-gee3f96b16468 #1
[   28.759959] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   28.760324]  unwind_backtrace from show_stack+0x10/0x14
[   28.760567]  show_stack from dump_stack_lvl+0x68/0x90
[   28.760708]  dump_stack_lvl from __warn+0x70/0x1e0
[   28.760863]  __warn from warn_slowpath_fmt+0x118/0x230
[   28.761015]  warn_slowpath_fmt from check_flags+0x170/0x258
[   28.761179]  check_flags from lock_is_held_type+0x6c/0x308
[   28.761326]  lock_is_held_type from rcu_read_lock_sched_held+0x3c/0x70
[   28.761505]  rcu_read_lock_sched_held from trace_rcu_dyntick+0x7c/0x128
[   28.761698]  trace_rcu_dyntick from ct_nmi_enter+0x6c/0xe4
[   28.761857]  ct_nmi_enter from irq_enter+0x8/0x10
[   28.762021]  irq_enter from generic_handle_arch_irq+0xc/0x64
[   28.762187]  generic_handle_arch_irq from call_with_stack+0x18/0x20
[   28.762370]  call_with_stack from __irq_svc+0x9c/0xbc
[   28.762594] Exception stack(0xd1b15f60 to 0xd1b15fa8)
[   28.762849] 5f60: ecac8b10 40000000 b6ec9418 c1c2607c 00000000 40000000 c557b00b 00000001
[   28.763056] 5f80: 00000b00 c0101278 c557b0f0 00000000 00000051 d1b15fb0 c01011c4 c0103c00
[   28.763249] 5fa0: 40000013 ffffffff
[   28.763394]  __irq_svc from vfp_support_entry+0x1c/0x30
[   28.763659] irq event stamp: 6348
[   28.763783] hardirqs last  enabled at (6347): [<c010106c>] __und_usr+0x6c/0x98
[   28.764030] hardirqs last disabled at (6348): [<c0100bd4>] __irq_svc+0x54/0xbc
[   28.764232] softirqs last  enabled at (6328): [<c0103814>] vfp_sync_hwstate+0x48/0x8c
[   28.764453] softirqs last disabled at (6326): [<c01037cc>] vfp_sync_hwstate+0x0/0x8c
[   28.764665] ---[ end trace 0000000000000000 ]---
[   28.764907] irq event stamp: 6348
[   28.765018] hardirqs last  enabled at (6347): [<c010106c>] __und_usr+0x6c/0x98
[   28.765202] hardirqs last disabled at (6348): [<c0100bd4>] __irq_svc+0x54/0xbc
[   28.765386] softirqs last  enabled at (6328): [<c0103814>] vfp_sync_hwstate+0x48/0x8c
[   28.765575] softirqs last disabled at (6326): [<c01037cc>] vfp_sync_hwstate+0x0/0x8c
