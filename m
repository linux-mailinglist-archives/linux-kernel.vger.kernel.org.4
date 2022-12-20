Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E3652603
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiLTSIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLTSIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:08:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3B1030;
        Tue, 20 Dec 2022 10:08:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B316B81730;
        Tue, 20 Dec 2022 18:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC06C433EF;
        Tue, 20 Dec 2022 18:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671559714;
        bh=lB2f0VZzRDnpVDFsJZNCkOFilXouYW8XaLO5xKfkXA4=;
        h=From:To:Cc:Subject:Date:From;
        b=Xw//83I4T5G2s6zbNzvr18lw1tHHR40FeD4UhkSkUEA2LVGVg7/LbJ9cdQNHj0sbA
         9nr5OU9rLt9Kwol0x4qxknbedboIxIl5bbY17dChjDZEMsywibP6trM6j/EcyF8Pxv
         pwyfdOqNyhiYjSbDRrHV8XQ38rEdgxSgcq8nVLRCPG0lT8OCDwZdz4L6+GnWrejWPe
         QxYWtJe3kgf9QowiSdShhwoUYP9gn16Y1rJAWx/TlfZZT2WKssv9vTaf89vkWThnhl
         SADRmdYcg8Dv+s8AmQ+1ifAarXSca55D3Hke/OSOERFCvHyaSWXE2wsv5onet2rtns
         sZ2CTvEx4ZAEQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Yuan Can <yuancan@huawei.com>,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [GIT PULL] remoteproc updates for v6.2
Date:   Tue, 20 Dec 2022 12:08:32 -0600
Message-Id: <20221220180832.93801-1-andersson@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There's a trivial merge conflict between this pull and the SPI tree.
Courtesy of Stephen Rothwell, here's the expected resolution:

> diff --cc include/linux/firmware/xlnx-zynqmp.h
> index fac37680ffe7,cf92e739fa3b..000000000000
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@@ -135,7 -138,10 +138,11 @@@ enum pm_ret_status
>   };
>
>   enum pm_ioctl_id {
> +       IOCTL_GET_RPU_OPER_MODE = 0,
> +       IOCTL_SET_RPU_OPER_MODE = 1,
> +       IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
> +       IOCTL_TCM_COMB_CONFIG = 3,
>  +      IOCTL_SET_TAPDELAY_BYPASS = 4,
>         IOCTL_SD_DLL_RESET = 6,
>         IOCTL_SET_SD_TAPDELAY = 7,
>         IOCTL_SET_PLL_FRAC_MODE = 8,

Regards,
Bjorn

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.2

for you to fetch changes up to 11c7f9e3131ad14b27a957496088fa488b153a48:

  remoteproc: core: Do pm_relax when in RPROC_OFFLINE state (2022-12-07 11:20:55 -0700)

----------------------------------------------------------------
remoteproc updates for v6.2

rproc-virtio device names are now auto generated, to avoid conflicts
between remoteproc instances.

The imx_rproc driver is extended with support for communicating with and
attaching to a running M4 on i.MX8QXP, as well as support for
attaching to the M4 after self-recovering from a crash. Support is
added for i.MX8QM and mailbox channels are reconnected during the
recovery process, in order to avoid data corruption.

The Xilinx Zynqmp firmware interface is extended and support for the
Xilinx R5 RPU is introduced.

Various resources leaks, primarily in error paths, throughout the
Qualcomm drivers are corrected.

Lastly a fix to ensure that pm_relax is invoked even if the remoteproc
instance is stopped between a crash is being reported and the recovery
handler is scheduled.

----------------------------------------------------------------
Ben Levinsky (3):
      firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
      firmware: xilinx: Add shutdown/wakeup APIs
      firmware: xilinx: Add RPU configuration APIs

Gaosheng Cui (1):
      remoteproc: sysmon: fix memory leak in qcom_add_sysmon_subdev()

Jeff Johnson (1):
      remoteproc: sysmon: Make QMI message rules const

Luca Weiss (2):
      remoteproc: qcom_q6v5_pas: disable wakeup on probe fail or remove
      remoteproc: qcom_q6v5_pas: detach power domains on remove

Maria Yu (1):
      remoteproc: core: Do pm_relax when in RPROC_OFFLINE state

Peng Fan (8):
      dt-bindings: remoteproc: imx_rproc: Support i.MX8QXP
      dt-bindings: remoteproc: imx_rproc: Support i.MX8QM
      remoteproc: imx_rproc: Support attaching to i.MX8QXP M4
      remoteproc: imx_rproc: Support kicking Mcore from Linux for i.MX8QXP
      remoteproc: imx_rproc: Support i.MX8QM
      remoteproc: imx_rproc: Request mbox channel later
      remoteproc: imx_rproc: Enable attach recovery for i.MX8QM/QXP
      remoteproc: imx_rproc: Correct i.MX93 DRAM mapping

Shang XiaoJing (2):
      remoteproc: qcom: q6v5: Fix potential null-ptr-deref in q6v5_wcss_init_mmio()
      remoteproc: qcom: q6v5: Fix missing clk_disable_unprepare() in q6v5_wcss_qcs404_power_on()

Shengjiu Wang (2):
      remoteproc: core: Auto select rproc-virtio device id
      remoteproc: imx_dsp_rproc: Add mutex protection for workqueue

Tanmay Shah (3):
      dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
      arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
      drivers: remoteproc: Add Xilinx r5 remoteproc driver

Yuan Can (1):
      remoteproc: qcom_q6v5_pas: Fix missing of_node_put() in adsp_alloc_memory_region()

ye xingchen (1):
      remoteproc: core: Use device_match_of_node()

 .../bindings/remoteproc/fsl,imx-rproc.yaml         |   16 +
 .../bindings/remoteproc/xlnx,zynqmp-r5fss.yaml     |  135 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   33 +
 drivers/firmware/xilinx/zynqmp.c                   |   97 ++
 drivers/remoteproc/Kconfig                         |   13 +
 drivers/remoteproc/Makefile                        |    1 +
 drivers/remoteproc/imx_dsp_rproc.c                 |   12 +-
 drivers/remoteproc/imx_rproc.c                     |  298 +++++-
 drivers/remoteproc/qcom_q6v5_pas.c                 |    4 +
 drivers/remoteproc/qcom_q6v5_wcss.c                |    6 +-
 drivers/remoteproc/qcom_sysmon.c                   |   13 +-
 drivers/remoteproc/remoteproc_core.c               |   19 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c            | 1067 ++++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      |    6 +
 include/linux/firmware/xlnx-zynqmp.h               |   60 ++
 15 files changed, 1760 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
