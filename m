Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833E372BF7D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjFLKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjFLKoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:44:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133E35757;
        Mon, 12 Jun 2023 03:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C24961372;
        Mon, 12 Jun 2023 10:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283F7C433D2;
        Mon, 12 Jun 2023 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565741;
        bh=XDXcC36LKPzKj9E5jetNkX26wc544KcY+i7kldo4gCw=;
        h=From:To:Cc:Subject:Date:From;
        b=TeW8wHoNFUySXbaa7GTy8ZloIjBjYk/jCZimUOe57+74m75ljLlWI1agqjO8zAruK
         5Ptp4Hx5ou89CB+2VLMpUFFkUIssNUlGGAvJ2OUCxL0qIwH4s9ClfB+Nj3yjM5k4JG
         0CVNbOzOYBo9h6vsaaOX4hcDvxwrhydM2UizokBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 4.14 00/21] 4.14.318-rc1 review
Date:   Mon, 12 Jun 2023 12:25:55 +0200
Message-ID: <20230612101651.048240731@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.318-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.318-rc1
X-KernelTest-Deadline: 2023-06-14T10:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.318 release.
There are 21 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.318-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.318-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"

Zixuan Fu <r33s3n6@gmail.com>
    btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()

Josef Bacik <josef@toxicpanda.com>
    btrfs: check return value of btrfs_commit_transaction in relocation

Theodore Ts'o <tytso@mit.edu>
    ext4: only check dquot_initialize_needed() when debugging

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    i2c: sprd: Delete i2c adapter in .remove's error path

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Xiubo Li <xiubli@redhat.com>
    ceph: fix use-after-free bug for inodes when flushing capsnaps

Chia-I Wu <olvaffe@gmail.com>
    drm/amdgpu: fix xclk freq on CHIP_STONEY

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: psmouse - fix OOB access in Elantech protocol

Ismael Ferreras Morezuelas <swyterzone@gmail.com>
    Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Vladislav Efanov <VEfanov@ispras.ru>
    batman-adv: Broken sync while rescheduling delayed work

Somnath Kotur <somnath.kotur@broadcom.com>
    bnxt_en: Query default VLAN before VNIC setup on a VF

Ben Hutchings <ben@decadent.org.uk>
    lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Eric Dumazet <edumazet@google.com>
    net: sched: move rtm_tca_policy declaration to include file

Eric Dumazet <edumazet@google.com>
    rfs: annotate lockless accesses to RFS sock flow table

Eric Dumazet <edumazet@google.com>
    rfs: annotate lockless accesses to sk->sk_rxhash

Sungwoo Kim <iam@sung-woo.kim>
    Bluetooth: L2CAP: Add missing checks for invalid DCID

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Fix l2cap_disconnect_req deadlock

Stephan Gerhold <stephan@gerhold.net>
    spi: qup: Request DMA before enabling clocks

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    i40e: fix build warnings in i40e_alloc.h

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    i40iw: fix build warning in i40iw_manage_apbvt()


-------------

Diffstat:

 Makefile                                     |  4 +--
 drivers/gpu/drm/amd/amdgpu/vi.c              | 11 +++++++--
 drivers/i2c/busses/i2c-sprd.c                |  6 +++--
 drivers/infiniband/hw/i40iw/i40iw.h          |  5 ++--
 drivers/input/joystick/xpad.c                |  1 -
 drivers/input/mouse/elantech.c               |  9 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |  3 +++
 drivers/net/ethernet/intel/i40e/i40e_alloc.h | 17 +++++--------
 drivers/spi/spi-qup.c                        | 37 ++++++++++++++--------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  6 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  5 ++++
 fs/btrfs/relocation.c                        | 14 ++++++++---
 fs/ceph/caps.c                               |  6 +++++
 fs/ceph/snap.c                               |  4 ++-
 fs/ext4/xattr.c                              |  6 +++--
 include/linux/netdevice.h                    |  7 ++++--
 include/net/pkt_sched.h                      |  2 ++
 include/net/sock.h                           | 18 ++++++++++----
 lib/cpu_rmap.c                               |  2 +-
 net/batman-adv/distributed-arp-table.c       |  2 +-
 net/bluetooth/hci_core.c                     |  8 +++---
 net/bluetooth/l2cap_core.c                   | 13 ++++++++++
 net/core/dev.c                               |  6 +++--
 net/sched/cls_api.c                          |  2 --
 24 files changed, 123 insertions(+), 71 deletions(-)


