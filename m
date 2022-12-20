Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17672651E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiLTKRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiLTKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:17:39 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B43B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:17:37 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id f189so11306886vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a4rfg2L9KSgOa69/j0v+NYQScWoGwQSBvVrkTtmbcyw=;
        b=ORQVG2WS1bFxxhxOytRf2iHAhdTypByzXWkMyL8Rzmg9rTeU9fsvQ0OEGoPPycT9v+
         E03seroLpRD6o6beFaDO/MtGsgmlJC+tP+IqlvJn6kWEPJQny1IyOGJ7jvR1mxhk6eey
         aVQAFdBT1WO4eOUcqiEVL0Tj61K//TGEX04IybtYkV1QAaqm0B3jTywc8ag/5Mj/TN3Z
         eIyzu1SFYHzatF6womSv5lSGGv1nN82fec4iFs1bhdCGN8k/rk4NHmQo9Jy5A75zuYGs
         Pi19kMqx6EIe/iCIlATSRQzqMPZbgYauNR7h7cL60dQy0J/MDFEVJsd4ene9Z9zpq2c7
         aFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4rfg2L9KSgOa69/j0v+NYQScWoGwQSBvVrkTtmbcyw=;
        b=LndIJJ2jnWLj0NhZLTNzwnk6vdx6Zjg7NKsXn6i61hftQK5VB79MdHdEuJn6gumfTi
         hqQwjXA+kj6DJJxNAohzbs9Csm06mJanGG9f2FHtqmfhSufGkpb355blTfF0Y8x8ecHf
         MjeZ32bW2Laq7Ujdzi5/juLS93kJqhFmtHL6USozRZjXWN/JtGQQ1iW93ypUGvS7env9
         shS8qr9lyXqGcd9Tu3IWMFh8+kjROdrHOs6rsdKIRXEJJMxAbJxJBaKmhgFcInf1oX2E
         G2N5/Hd1L6CUZUJ5p57JH+Bkc2cR2ob8iHJN1kMXP6RVjOrdgUJu/nSc0N42WLHnghoR
         NSaA==
X-Gm-Message-State: ANoB5pnnoxy4uKoef9bTbuVBBB/fdHZ7CYuKSSnsQBdEgWQtrCSCjUp6
        aRAINRPjAVgdmThAPfSVUf6EI0ajRck/pMvUQMOl4Q==
X-Google-Smtp-Source: AA0mqf47nj61kGDrAuBI2hwqSxLyhcB18R8nDl+W7uYZGnvuzCF/PP0wARvuJKMfsUlp0CXqCsdWulbk2iEjcbumgtE=
X-Received: by 2002:a67:ef45:0:b0:3b1:3676:fd01 with SMTP id
 k5-20020a67ef45000000b003b13676fd01mr14152489vsr.83.1671531456695; Tue, 20
 Dec 2022 02:17:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvz1eNS5fw1Wg5f4HqwdWPNg3EQyrGZVEOJ=OQzYzZ_YQ@mail.gmail.com>
 <20221220044740-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221220044740-mutt-send-email-mst@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Dec 2022 15:47:25 +0530
Message-ID: <CA+G9fYsfN7dwog+5nBXZtNDyWyoM424DNj2dvrNYbNz-7ug0xg@mail.gmail.com>
Subject: Re: next: kernel BUG at drivers/virtio/virtio.c:122!
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, 20 Dec 2022 at 15:20, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 20, 2022 at 02:51:54PM +0530, Naresh Kamboju wrote:
> > The qemu-x86_64 and qemu-arm64 boot failed with Linux next-20221220 tag.
> > It is always reproducible with gcc-11/ gcc-12 and clang tool chains.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > <5>[    0.000000] Linux version 6.1.0-next-20221220 (tuxmake@tuxmake)
> > (Debian clang version 16.0.0
> > (++20221218072110+9c1b82599dac-1~exp1~20221218072217.501), Debian LLD
> > 16.0.0) #1 SMP PREEMPT @1671498176
> > <5>[    0.000000] random: crng init done
> > <6>[    0.000000] Machine model: linux,dummy-virt
> > ....
> > <6>[    3.571098] loop: module loaded
> > <6>[    3.573410] virtio_blk virtio0: 1/0/0 default/read/poll queues
> > <5>[    3.578816] virtio_blk virtio0: [vda] 2816420 512-byte logical
> > blocks (1.44 GB/1.34 GiB)
> > <4>[    3.581234] ------------[ cut here ]------------
> > <2>[    3.581595] kernel BUG at drivers/virtio/virtio.c:122!
> > <0>[    3.582906] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > <4>[    3.583672] Modules linked in:
> > <4>[    3.584905] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > 6.1.0-next-20221220 #1
> > <4>[    3.585801] Hardware name: linux,dummy-virt (DT)
> > <4>[    3.586591] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT
> > -SSBS BTYPE=--)
> > <4>[    3.587349] pc : virtio_check_driver_offered_feature+0x60/0x6c
> > <4>[    3.588613] lr : virtblk_probe+0x7cc/0x8f0
> > <4>[    3.588915] sp : ffff80000802b840
> > <4>[    3.589314] x29: ffff80000802b850 x28: 0000000000000000 x27:
> > 0000000000000001
> > <4>[    3.590509] x26: 0000000000000001 x25: 0000000000000200 x24:
> > ffff0000c1699b00
> > <4>[    3.590832] x23: 00000000000000fe x22: ffff0000c0313c30 x21:
> > ffff0000c0313c00
> > <4>[    3.591568] x20: ffff0000c02f4080 x19: 0000000000000000 x18:
> > ffffffffffffffff
> > <4>[    3.592056] x17: 00000000ffffffea x16: 00000000fffffffe x15:
> > 0000000000000004
> > <4>[    3.592632] x14: 0000000000000fff x13: ffff800008028000 x12:
> > ffff80000802c000
> > <4>[    3.593157] x11: 000000000000000f x10: 000000000000000f x9 :
> > ffffae66eee314d8
> > <4>[    3.594048] x8 : 0000000000000000 x7 : 3631383837352e33 x6 :
> > 202020205b3e353c
> > <4>[    3.594429] x5 : 0000000000000001 x4 : 0000000000000000 x3 :
> > ffff80000802b780
> > <4>[    3.594956] x2 : ffff80000802b6f8 x1 : 0000000000000011 x0 :
> > ffff0000c02f4080
> > <4>[    3.595811] Call trace:
> > <4>[    3.596120]  virtio_check_driver_offered_feature+0x60/0x6c
> > <4>[    3.596632]  virtio_dev_probe+0x274/0x320
> > <4>[    3.597064]  really_probe+0x178/0x418
> > <4>[    3.597547]  __driver_probe_device+0x120/0x188
> > <4>[    3.597820]  driver_probe_device+0x48/0x22c
> > <4>[    3.598189]  __driver_attach+0xf8/0x250
> > <4>[    3.598656]  bus_for_each_dev+0x8c/0xd8
> > <4>[    3.599151]  driver_attach+0x30/0x3c
> > <4>[    3.599321]  bus_add_driver+0x11c/0x22c
> > <4>[    3.599684]  driver_register+0x84/0x120
> > <4>[    3.600175]  register_virtio_driver+0x38/0x48
> > <4>[    3.600575]  virtio_blk_init+0x6c/0xb4
> > <4>[    3.600759]  do_one_initcall+0xe0/0x2f8
> > <4>[    3.601197]  do_initcall_level+0xa8/0x150
> > <4>[    3.601703]  do_initcalls+0x60/0xa0
> > <4>[    3.601892]  do_basic_setup+0x28/0x34
> > <4>[    3.602229]  kernel_init_freeable+0x100/0x178
> > <4>[    3.602706]  kernel_init+0x2c/0x1b4
> > <4>[    3.603162]  ret_from_fork+0x10/0x20
> > <0>[    3.604398] Code: 540000a0 91001129 f1000508 54ffff61 (d4210000)
> > <4>[    3.606108] ---[ end trace 0000000000000000 ]---
> > <6>[    3.606714] note: swapper/0[1] exited with preempt_count 1
> > <0>[    3.608155] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b
> > <2>[    3.609173] SMP: stopping secondary CPUs
> > <0>[    3.610506] Kernel Offset: 0x2e66e4800000 from 0xffff800008000000
> > <0>[    3.610970] PHYS_OFFSET: 0x40000000
> > <0>[    3.611428] CPU features: 0x00000,003a612f,cd22773f
> > <0>[    3.612277] Memory Limit: none
> > <0>[    3.613192] ---[ end Kernel panic - not syncing: Attempted to
> > kill init! exitcode=0x0000000b ]---
> >
> > Ref Links,
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221220/testrun/13764099/suite/log-parser-test/test/check-kernel-bug/details/
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221220/testrun/13766814/suite/boot/test/clang-nightly-lkftconfig/details/
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2J9l3qxSBmPWVa1S2uWn0Xuwl1J/config
> >

>
> Could you post a bit more detail pls?

I request you to refer above links for more details,

All the required details are here in those links,
> - qemu version and command line

5.2 and 7.1

> - .config

defconfig
and defconfig+

arch:
  - arm64
   - x86_64

> - compiler / compiler flags if any
gcc-11, gcc-12 and clang-15 and clang-nightly

It is always reproducible on Qemu versions 5.2 and 7.1

qemu-system-x86, installed at version: 1:5.2+dfsg-9~bpo10+1, host
architecture: amd64
qemu-system-arm, installed at version: 1:7.1+dfsg-2~bpo11+3, host
architecture: amd64

qemu command line:

Boot command:
/usr/bin/qemu-system-x86_64
  -cpu host
  -enable-kvm
  -nographic
  -net nic,model=virtio,macaddr=DE:AD:BE:EF:66:38
  -net tap
  -m 1024
  -monitor none
  -kernel kernel/bzImage
  --append "root=/dev/sda  rootwait console=ttyS0,115200"
  -hda lkft-console-image-intel-core2-32-20221124230054.rootfs.ext4
  -m 4096
  -smp 4
  -nographic
  -drive format=qcow2,file=lava-guest.qcow2,media=disk,if=virtio,id=lavatest

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: e45fb347b630ee76482fe938ba76cf8eab811290
  git_describe: next-20221220
  kernel_version: 6.1.0
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2J9kbUD3iq8BS20NJ72fUupVavd/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/727258165
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2J9kbUD3iq8BS20NJ72fUupVavd
  toolchain: gcc-11
  build_name: gcc-11-lkftconfig


Test job running with qemu 5.2
https://lkft.validation.linaro.org/scheduler/job/5978795#L548

Test job running with qemu 7.2
https://lkft.validation.linaro.org/scheduler/job/5979229#L422

>
> Thanks!
>
> --
> MST

- Naresh
