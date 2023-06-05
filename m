Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1472202C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjFEHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjFEHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266ECA1;
        Mon,  5 Jun 2023 00:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC72761CFE;
        Mon,  5 Jun 2023 07:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCD3C4339B;
        Mon,  5 Jun 2023 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685951559;
        bh=7964Pi7oyMf3L1OrGUoQ2Wu4a2LP+jbGylsF1fgtGV8=;
        h=From:To:Cc:Subject:Date:From;
        b=PX0PqkjrRpkFnyPgwOKiEr/TdrS49ph46sbw0vGPO6KIbtVWSPt+jYdYnxbHAg/+O
         wPAY7aEBZbFr3Vgpmeu75aDtxjOFfGCkj8velF3ZkOXq4e/HfvgKYN64eGTUtjihea
         JA4LkVq+hOe76ez0AP3bZrYubzD1VywDiYDvZK+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.3.6
Date:   Mon,  5 Jun 2023 09:52:31 +0200
Message-ID: <2023060527-flammable-refresh-8d53@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

I'm announcing the release of the 6.3.6 kernel.

All users of the 6.3 kernel series must upgrade.

The updated 6.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/boot/dts/imx6ull-dhcor-som.dtsi                   |    7 
 block/blk-mq-tag.c                                         |   12 
 block/blk-wbt.c                                            |   12 
 drivers/cpufreq/amd-pstate.c                               |   47 ++-
 drivers/cxl/core/port.c                                    |    7 
 drivers/firmware/arm_ffa/driver.c                          |    3 
 drivers/firmware/arm_scmi/raw_mode.c                       |    2 
 drivers/gpio/Kconfig                                       |    2 
 drivers/gpio/gpio-f7188x.c                                 |   28 -
 drivers/gpio/gpiolib.c                                     |    2 
 drivers/gpu/drm/i915/display/intel_ddi.c                   |   15 
 drivers/gpu/drm/i915/display/intel_display.c               |   17 -
 drivers/gpu/drm/i915/display/intel_dp_mst.c                |   15 
 drivers/gpu/drm/i915/display/intel_modeset_setup.c         |    1 
 drivers/hwtracing/coresight/coresight-etm-perf.c           |    1 
 drivers/net/ethernet/freescale/fec_main.c                  |   17 -
 drivers/net/ethernet/mellanox/mlx5/core/Makefile           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c            |   34 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/debugfs.c      |  198 -------------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |   12 
 drivers/net/phy/mscc/mscc.h                                |    1 
 drivers/net/phy/mscc/mscc_main.c                           |   54 +--
 drivers/platform/x86/amd/pmf/core.c                        |   32 +-
 drivers/power/supply/rt9467-charger.c                      |    2 
 drivers/spi/spi-geni-qcom.c                                |    2 
 drivers/vfio/vfio_iommu_type1.c                            |    5 
 include/linux/skbuff.h                                     |   10 
 include/linux/skmsg.h                                      |    3 
 include/net/tcp.h                                          |   10 
 include/net/tls.h                                          |    1 
 kernel/bpf/offload.c                                       |    2 
 net/bluetooth/hci_sock.c                                   |   28 +
 net/core/skmsg.c                                           |   81 ++---
 net/core/sock_map.c                                        |    3 
 net/ipv4/tcp.c                                             |   11 
 net/ipv4/tcp_bpf.c                                         |   79 +++++
 net/ipv4/udp.c                                             |    7 
 net/netfilter/nf_conntrack_netlink.c                       |    8 
 net/tls/tls.h                                              |    5 
 net/tls/tls_device.c                                       |   22 -
 net/tls/tls_strp.c                                         |  185 +++++++++---
 net/tls/tls_sw.c                                           |    4 
 net/unix/af_unix.c                                         |    7 
 sound/soc/intel/avs/control.c                              |   22 -
 tools/testing/selftests/bpf/Makefile                       |    2 
 48 files changed, 592 insertions(+), 442 deletions(-)

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix module lookup

Andreas Kemnade (1):
      gpiolib: fix allocation of mixed dynamic/static GPIOs

ChiaEn Wu (1):
      power: supply: rt9467: Fix passing zero to 'dev_err_probe'

Christoph Niedermaier (1):
      ARM: dts: imx6ull-dhcor: Set and limit the mode for PMIC buck 1, 2 and 3

David Epping (1):
      net: phy: mscc: enable VSC8501/2 RGMII RX clock

Gautham R. Shenoy (1):
      cpufreq: amd-pstate: Add ->fast_switch() callback

Greg Kroah-Hartman (1):
      Linux 6.3.6

Henning Schild (1):
      gpio-f7188x: fix chip name and pin count on Nuvoton chip

Imre Deak (3):
      drm/i915: Move shared DPLL disabling into CRTC disable hook
      drm/i915: Disable DPLLs before disconnecting the TC PHY
      drm/i915: Fix PIPEDMC disabling for a bigjoiner configuration

Jakub Kicinski (8):
      bpf: netdev: init the offload table earlier
      tls: rx: device: fix checking decryption status
      tls: rx: strp: set the skb->len of detached / CoW'ed skbs
      tls: rx: strp: fix determining record length in copy mode
      tls: rx: strp: force mixed decrypted records into copy mode
      tls: rx: strp: factor out copying skb data
      tls: rx: strp: preserve decryption status of skbs when needed
      tls: rx: strp: don't use GFP_KERNEL in softirq context

Jeremy Sowden (1):
      selftests/bpf: Fix pkg-config call building sign-file

John Fastabend (8):
      bpf, sockmap: Pass skb ownership through read_skb
      bpf, sockmap: Convert schedule_work into delayed_work
      bpf, sockmap: Reschedule is now done through backlog
      bpf, sockmap: Improved check for empty queue
      bpf, sockmap: Handle fin correctly
      bpf, sockmap: TCP data stall on recv before accept
      bpf, sockmap: Wake up polling after data copy
      bpf, sockmap: Incorrectly handling copied_seq

Maher Sanalla (2):
      Revert "net/mlx5: Expose steering dropped packets counter"
      Revert "net/mlx5: Expose vnic diagnostic counters for eswitch managed vports"

Mario Limonciello (1):
      platform/x86/amd/pmf: Fix CnQF and auto-mode after resume

Paul Blakey (2):
      net/mlx5e: TC, Fix using eswitch mapping in nic mode
      netfilter: ctnetlink: Support offloaded conntrack entry deletion

Robert Richter (1):
      cxl/port: Fix NULL pointer access in devm_cxl_add_port()

Ruidong Tian (1):
      coresight: perf: Release Coresight path when alloc trace id failed

Ruihan Li (1):
      bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Shay Drory (1):
      net/mlx5: E-switch, Devcom, sync devcom events and devcom comp register

Shenwei Wang (1):
      net: fec: add dma_wmb to ensure correct descriptor values

Sudeep Holla (1):
      firmware: arm_ffa: Fix usage of partition info get count flag

Tejun Heo (1):
      firmware: arm_scmi: Fix incorrect alloc_workqueue() invocation

Tian Lan (1):
      blk-mq: fix race condition in active queue accounting

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Select FIFO mode for chip select

Wyes Karny (2):
      cpufreq: amd-pstate: Remove fast_switch_possible flag from active driver
      cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()

Yan Zhao (1):
      vfio/type1: check pfn valid before converting to struct page

Yu Kuai (1):
      blk-wbt: fix that wbt can't be disabled by default

