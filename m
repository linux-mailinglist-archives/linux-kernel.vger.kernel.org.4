Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D71719E01
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjFAN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjFAN2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE4199;
        Thu,  1 Jun 2023 06:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BAEC64473;
        Thu,  1 Jun 2023 13:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63907C4339C;
        Thu,  1 Jun 2023 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626070;
        bh=lYvcMNrBCOjDHywtvbagoDsSmsFgmvin0K6p9+lv3jg=;
        h=From:To:Cc:Subject:Date:From;
        b=PV4b5T3BBN9kjHKxjAiPXIkYli+CfyTJJkA+5Q1VJLuaXQhewc76YYH3zimdbNPmO
         hIopYe9UjqsLfREZPQEMeA6I4RovknSDZriHPfNk+0DrWXHAYnKSpu+8hnDZPHzKRa
         k7LwgpIUv23M0YdiPuQB1Xpzm66xQXnBPWuGK8RY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.1 00/42] 6.1.32-rc1 review
Date:   Thu,  1 Jun 2023 14:21:09 +0100
Message-Id: <20230601131939.051934720@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.32-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.32-rc1
X-KernelTest-Deadline: 2023-06-03T13:19+00:00
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

This is the start of the stable review cycle for the 6.1.32 release.
There are 42 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.32-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.32-rc1

Yanteng Si <siyanteng@loongson.cn>
    tools headers UAPI: Sync the linux/in.h with the kernel sources

Paul Blakey <paulb@nvidia.com>
    netfilter: ctnetlink: Support offloaded conntrack entry deletion

Gautham R. Shenoy <gautham.shenoy@amd.com>
    cpufreq: amd-pstate: Add ->fast_switch() callback

Wyes Karny <wyes.karny@amd.com>
    cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()

Anuj Gupta <anuj20.g@samsung.com>
    block: fix bio-cache for passthru IO

Ido Schimmel <idosch@nvidia.com>
    Revert "thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function"

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Don't allow s0ix on APUs older than Raven

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Add validation for lmac type

Claudiu Beznea <claudiu.beznea@microchip.com>
    dmaengine: at_xdmac: restore the content of grws register

Claudiu Beznea <claudiu.beznea@microchip.com>
    dmaengine: at_xdmac: do not resume channels paused by consumers

Claudiu Beznea <claudiu.beznea@microchip.com>
    dmaengine: at_xdmac: disable/enable clock directly on suspend/resume

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: fix potential memory leak

Haim Dreyfuss <haim.dreyfuss@intel.com>
    wifi: iwlwifi: mvm: support wowlan info notification version 2

Eric Huang <echuang@realtek.com>
    wifi: rtw89: correct 5 MHz mask setting

David Epping <david.epping@missinglinkelectronics.com>
    net: phy: mscc: enable VSC8501/2 RGMII RX clock

Yunsheng Lin <linyunsheng@huawei.com>
    page_pool: fix inconsistency for page_pool_ring_[un]lock()

Qingfang DENG <qingfang.deng@siflower.com.cn>
    net: page_pool: use in_softirq() instead

Yan Zhao <yan.y.zhao@intel.com>
    vfio/type1: check pfn valid before converting to struct page

Tian Lan <tian.lan@twosigma.com>
    blk-mq: fix race condition in active queue accounting

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

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmf: Fix CnQF and auto-mode after resume

Jeremy Sowden <jeremy@azazel.net>
    selftests/bpf: Fix pkg-config call building sign-file

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Fix usage of partition info get count flag

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Jakub Sitnicki <jakub@cloudflare.com>
    inet: Add IP_LOCAL_PORT_RANGE socket option


-------------

Diffstat:

 Makefile                                           |   4 +-
 block/blk-map.c                                    |   2 +-
 block/blk-mq-tag.c                                 |  12 +-
 drivers/cpufreq/amd-pstate.c                       |  45 ++++-
 drivers/dma/at_xdmac.c                             |  60 +++++-
 drivers/firmware/arm_ffa/driver.c                  |   3 +-
 drivers/gpio/Kconfig                               |   2 +-
 drivers/gpio/gpio-f7188x.c                         |  28 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   7 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   7 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   8 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   1 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   9 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 209 ++++++++++++++++-----
 drivers/net/phy/mscc/mscc.h                        |   1 +
 drivers/net/phy/mscc/mscc_main.c                   |  54 +++---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |  37 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  35 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   9 +-
 drivers/platform/x86/amd/pmf/core.c                |  32 +++-
 drivers/vfio/vfio_iommu_type1.c                    |   5 +
 include/linux/skbuff.h                             |  10 +
 include/linux/skmsg.h                              |   3 +-
 include/net/inet_sock.h                            |   4 +
 include/net/ip.h                                   |   5 +-
 include/net/page_pool.h                            |  18 --
 include/net/tcp.h                                  |  10 +
 include/net/tls.h                                  |   1 +
 include/uapi/linux/in.h                            |   2 +
 net/bluetooth/hci_sock.c                           |  28 +++
 net/core/page_pool.c                               |  34 +++-
 net/core/skmsg.c                                   |  81 ++++----
 net/core/sock_map.c                                |   3 +-
 net/ipv4/inet_connection_sock.c                    |  25 ++-
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/ipv4/ip_sockglue.c                             |  30 ++-
 net/ipv4/raw.c                                     |   5 +-
 net/ipv4/tcp.c                                     |  11 +-
 net/ipv4/tcp_bpf.c                                 |  79 +++++++-
 net/ipv4/udp.c                                     |   9 +-
 net/ipv6/raw.c                                     |   3 +-
 net/netfilter/nf_conntrack_netlink.c               |   8 -
 net/sctp/socket.c                                  |   2 +-
 net/tls/tls.h                                      |   5 +
 net/tls/tls_device.c                               |  22 +--
 net/tls/tls_strp.c                                 | 185 ++++++++++++++----
 net/unix/af_unix.c                                 |   7 +-
 tools/include/uapi/linux/in.h                      |   1 +
 tools/testing/selftests/bpf/Makefile               |   2 +-
 50 files changed, 881 insertions(+), 287 deletions(-)


