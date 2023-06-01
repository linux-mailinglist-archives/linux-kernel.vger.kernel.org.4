Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51270719DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjFAN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjFAN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F9195;
        Thu,  1 Jun 2023 06:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E582964499;
        Thu,  1 Jun 2023 13:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB704C433D2;
        Thu,  1 Jun 2023 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625975;
        bh=60T0ZlGej2u8siVphMwkViSZOgb2k12GET+sEZNIZM0=;
        h=From:To:Cc:Subject:Date:From;
        b=CebgAzMVdCXKp5GQLAWjxEwph388HoRieuhoBfVhJUOyfREYWUaLaPGgYu+jYRy0x
         itEwHHTfQRJDWmS39NKvOc+L5GuUr1QGQMX/e10WCx55ypHrUsj6VlAhdM/aG4P28G
         soqiCNimJQnUdGbMpGrmroG+NUpZx5vH44//3ZXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.3 00/45] 6.3.6-rc1 review
Date:   Thu,  1 Jun 2023 14:20:56 +0100
Message-Id: <20230601131938.702671708@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.6-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.3.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.3.6-rc1
X-KernelTest-Deadline: 2023-06-03T13:19+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.3.6 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.3.6-rc1

Paul Blakey <paulb@nvidia.com>
    netfilter: ctnetlink: Support offloaded conntrack entry deletion

Gautham R. Shenoy <gautham.shenoy@amd.com>
    cpufreq: amd-pstate: Add ->fast_switch() callback

Wyes Karny <wyes.karny@amd.com>
    cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

David Epping <david.epping@missinglinkelectronics.com>
    net: phy: mscc: enable VSC8501/2 RGMII RX clock

Wyes Karny <wyes.karny@amd.com>
    cpufreq: amd-pstate: Remove fast_switch_possible flag from active driver

Yan Zhao <yan.y.zhao@intel.com>
    vfio/type1: check pfn valid before converting to struct page

Tian Lan <tian.lan@twosigma.com>
    blk-mq: fix race condition in active queue accounting

Yu Kuai <yukuai3@huawei.com>
    blk-wbt: fix that wbt can't be disabled by default

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Incorrectly handling copied_seq

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Wake up polling after data copy

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: TCP data stall on recv before accept

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Handle fin correctly

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Improved check for empty queue

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Reschedule is now done through backlog

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Convert schedule_work into delayed_work

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Pass skb ownership through read_skb

Henning Schild <henning.schild@siemens.com>
    gpio-f7188x: fix chip name and pin count on Nuvoton chip

Shay Drory <shayd@nvidia.com>
    net/mlx5: E-switch, Devcom, sync devcom events and devcom comp register

Maher Sanalla <msanalla@nvidia.com>
    Revert "net/mlx5: Expose vnic diagnostic counters for eswitch managed vports"

Maher Sanalla <msanalla@nvidia.com>
    Revert "net/mlx5: Expose steering dropped packets counter"

Paul Blakey <paulb@nvidia.com>
    net/mlx5e: TC, Fix using eswitch mapping in nic mode

Imre Deak <imre.deak@intel.com>
    drm/i915: Fix PIPEDMC disabling for a bigjoiner configuration

Imre Deak <imre.deak@intel.com>
    drm/i915: Disable DPLLs before disconnecting the TC PHY

Imre Deak <imre.deak@intel.com>
    drm/i915: Move shared DPLL disabling into CRTC disable hook

Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
    ASoC: Intel: avs: Fix module lookup

Robert Richter <rrichter@amd.com>
    cxl/port: Fix NULL pointer access in devm_cxl_add_port()

Shenwei Wang <shenwei.wang@nxp.com>
    net: fec: add dma_wmb to ensure correct descriptor values

Jakub Kicinski <kuba@kernel.org>
    tls: rx: strp: don't use GFP_KERNEL in softirq context

Jakub Kicinski <kuba@kernel.org>
    tls: rx: strp: preserve decryption status of skbs when needed

Jakub Kicinski <kuba@kernel.org>
    tls: rx: strp: factor out copying skb data

Jakub Kicinski <kuba@kernel.org>
    tls: rx: strp: force mixed decrypted records into copy mode

Jakub Kicinski <kuba@kernel.org>
    tls: rx: strp: fix determining record length in copy mode

Jakub Kicinski <kuba@kernel.org>
    tls: rx: strp: set the skb->len of detached / CoW'ed skbs

Jakub Kicinski <kuba@kernel.org>
    tls: rx: device: fix checking decryption status

Andreas Kemnade <andreas@kemnade.info>
    gpiolib: fix allocation of mixed dynamic/static GPIOs

Jakub Kicinski <kuba@kernel.org>
    bpf: netdev: init the offload table earlier

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmf: Fix CnQF and auto-mode after resume

ChiaEn Wu <chiaen_wu@richtek.com>
    power: supply: rt9467: Fix passing zero to 'dev_err_probe'

Jeremy Sowden <jeremy@azazel.net>
    selftests/bpf: Fix pkg-config call building sign-file

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    ARM: dts: imx6ull-dhcor: Set and limit the mode for PMIC buck 1, 2 and 3

Ruidong Tian <tianruidong@linux.alibaba.com>
    coresight: perf: Release Coresight path when alloc trace id failed

Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
    spi: spi-geni-qcom: Select FIFO mode for chip select

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Fix usage of partition info get count flag

Tejun Heo <tj@kernel.org>
    firmware: arm_scmi: Fix incorrect alloc_workqueue() invocation


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx6ull-dhcor-som.dtsi           |   7 +
 block/blk-mq-tag.c                                 |  12 +-
 block/blk-wbt.c                                    |  12 +-
 drivers/cpufreq/amd-pstate.c                       |  47 +++--
 drivers/cxl/core/port.c                            |   7 +-
 drivers/firmware/arm_ffa/driver.c                  |   3 +-
 drivers/firmware/arm_scmi/raw_mode.c               |   2 +-
 drivers/gpio/Kconfig                               |   2 +-
 drivers/gpio/gpio-f7188x.c                         |  28 +--
 drivers/gpio/gpiolib.c                             |   2 +
 drivers/gpu/drm/i915/display/intel_ddi.c           |  15 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  17 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  15 ++
 drivers/gpu/drm/i915/display/intel_modeset_setup.c |   1 -
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   1 +
 drivers/net/ethernet/freescale/fec_main.c          |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  34 +++-
 .../net/ethernet/mellanox/mlx5/core/esw/debugfs.c  | 198 ---------------------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   6 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  12 +-
 drivers/net/phy/mscc/mscc.h                        |   1 +
 drivers/net/phy/mscc/mscc_main.c                   |  54 +++---
 drivers/platform/x86/amd/pmf/core.c                |  32 +++-
 drivers/power/supply/rt9467-charger.c              |   2 +-
 drivers/spi/spi-geni-qcom.c                        |   2 +
 drivers/vfio/vfio_iommu_type1.c                    |   5 +
 include/linux/skbuff.h                             |  10 ++
 include/linux/skmsg.h                              |   3 +-
 include/net/tcp.h                                  |  10 ++
 include/net/tls.h                                  |   1 +
 kernel/bpf/offload.c                               |   2 +-
 net/bluetooth/hci_sock.c                           |  28 +++
 net/core/skmsg.c                                   |  81 ++++-----
 net/core/sock_map.c                                |   3 +-
 net/ipv4/tcp.c                                     |  11 +-
 net/ipv4/tcp_bpf.c                                 |  79 +++++++-
 net/ipv4/udp.c                                     |   7 +-
 net/netfilter/nf_conntrack_netlink.c               |   8 -
 net/tls/tls.h                                      |   5 +
 net/tls/tls_device.c                               |  22 +--
 net/tls/tls_strp.c                                 | 185 +++++++++++++++----
 net/tls/tls_sw.c                                   |   4 +
 net/unix/af_unix.c                                 |   7 +-
 sound/soc/intel/avs/control.c                      |  22 ++-
 tools/testing/selftests/bpf/Makefile               |   2 +-
 48 files changed, 593 insertions(+), 443 deletions(-)


