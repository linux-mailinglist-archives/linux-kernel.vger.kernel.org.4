Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384E772F95A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244006AbjFNJiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjFNJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719F0DF;
        Wed, 14 Jun 2023 02:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 064AE63342;
        Wed, 14 Jun 2023 09:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0471EC433C8;
        Wed, 14 Jun 2023 09:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735485;
        bh=tpW4YlEHIcX307ck/O7pP4loAlJ+EP93YGZ2HAyn1jc=;
        h=From:To:Cc:Subject:Date:From;
        b=OZSmYVcDZoB4BQCAicu9RPN6uTBp8pWCinFjqcLbIeYvHXdpBUZDWiDYt3Hkqj0ak
         l0mQxu3eP7tP4bhBy816fdsTKt1X6KCdd3vNZeiRReflFbxTKwTG+DYOpkAO1PGfrs
         0A5607s85LYzGgEH3BU1EBVD+zqpluH5pyGopT58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.318
Date:   Wed, 14 Jun 2023 11:38:00 +0200
Message-ID: <2023061401-retiring-volatile-d131@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.14.318 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                     |    2 -
 drivers/gpu/drm/amd/amdgpu/vi.c              |   11 ++++++--
 drivers/i2c/busses/i2c-sprd.c                |    6 ++--
 drivers/infiniband/hw/i40iw/i40iw.h          |    5 +--
 drivers/input/joystick/xpad.c                |    1 
 drivers/input/mouse/elantech.c               |    9 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |    3 ++
 drivers/net/ethernet/intel/i40e/i40e_alloc.h |   17 ++++--------
 drivers/spi/spi-qup.c                        |   37 +++++++++++++--------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |    6 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |    5 +++
 fs/btrfs/relocation.c                        |   14 +++++++---
 fs/ceph/caps.c                               |    6 ++++
 fs/ceph/snap.c                               |    4 ++
 fs/ext4/xattr.c                              |    6 ++--
 include/linux/netdevice.h                    |    7 +++--
 include/net/pkt_sched.h                      |    2 +
 include/net/sock.h                           |   18 +++++++++----
 lib/cpu_rmap.c                               |    2 -
 net/batman-adv/distributed-arp-table.c       |    2 -
 net/bluetooth/hci_core.c                     |    8 ++---
 net/bluetooth/l2cap_core.c                   |   13 +++++++++
 net/core/dev.c                               |    6 ++--
 net/sched/cls_api.c                          |    2 -
 24 files changed, 122 insertions(+), 70 deletions(-)

Ben Hutchings (1):
      lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Chia-I Wu (1):
      drm/amdgpu: fix xclk freq on CHIP_STONEY

Dmitry Torokhov (1):
      Input: psmouse - fix OOB access in Elantech protocol

Eric Dumazet (3):
      rfs: annotate lockless accesses to sk->sk_rxhash
      rfs: annotate lockless accesses to RFS sock flow table
      net: sched: move rtm_tca_policy declaration to include file

Greg Kroah-Hartman (4):
      i40iw: fix build warning in i40iw_manage_apbvt()
      i40e: fix build warnings in i40e_alloc.h
      Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"
      Linux 4.14.318

Ismael Ferreras Morezuelas (1):
      Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Josef Bacik (1):
      btrfs: check return value of btrfs_commit_transaction in relocation

Luiz Augusto von Dentz (1):
      Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Somnath Kotur (1):
      bnxt_en: Query default VLAN before VNIC setup on a VF

Stephan Gerhold (1):
      spi: qup: Request DMA before enabling clocks

Sungwoo Kim (1):
      Bluetooth: L2CAP: Add missing checks for invalid DCID

Theodore Ts'o (1):
      ext4: only check dquot_initialize_needed() when debugging

Uwe Kleine-König (1):
      i2c: sprd: Delete i2c adapter in .remove's error path

Vladislav Efanov (1):
      batman-adv: Broken sync while rescheduling delayed work

Xiubo Li (1):
      ceph: fix use-after-free bug for inodes when flushing capsnaps

Ying Hsu (1):
      Bluetooth: Fix l2cap_disconnect_req deadlock

Zixuan Fu (1):
      btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()

