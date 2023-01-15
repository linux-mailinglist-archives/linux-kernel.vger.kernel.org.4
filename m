Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45166B346
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 18:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjAORos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 12:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjAORoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:44:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159EEC17E;
        Sun, 15 Jan 2023 09:44:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A69D260DB9;
        Sun, 15 Jan 2023 17:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D5DC433D2;
        Sun, 15 Jan 2023 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673804685;
        bh=LbELnULzQeXF80ZCI8QXN68KTsD4HRTs1fqbFs/eXKg=;
        h=From:To:Cc:Subject:Date:From;
        b=OoakFsmF8FSTBEOE9VR9K16omo2UEg44ZXGRteW/jjJZPcieKieAwVFaTrLA5GKdz
         FGwEOj2IChOZ5jOS0rfRX0so5l+Vi7LVm/AsJNx9wxPQAwzQkpLzxCMpuebitsZdMb
         vucHkk/Ru7Y8uCT3XAYKDaY6Ax6xaNjzgd8d+HMWVWw87iMWCGKV51u1/lgcW2a/Sy
         bo0Cfrb8eA9MB65P/oW2psZTv40oPCWwPXouc+nqTk0hDMMmucq6CQ/zk8h0BVHfsm
         7vwaSMlwV29BjPAsuZmXxtA+PTO/srAvnByKvoqM9yy97tIdmNj7+cUCurtm7iRxZ2
         wjIiPY3VxUj8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pH741-0002tA-D1; Sun, 15 Jan 2023 18:45:01 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Daniele Palmas <dnlplm@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2] arm64: defconfig: enable Qualcomm PCIe modem drivers
Date:   Sun, 15 Jan 2023 18:44:50 +0100
Message-Id: <20230115174450.11041-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
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

Enable the MHI PCI controller driver and the MHI NET and WWAN drivers
for Qualcomm based PCIe modems such as the ones found on the SC8280XP
Compute Reference Design (CRD) and Lenovo Thinkpad X13s.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v2
 - enable also the MHI NET driver which is needed for some modems
   (Daniele)


 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a862f3658a7..02cd913008ec 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -250,6 +250,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
 CONFIG_HISILICON_LPC=y
 CONFIG_TEGRA_ACONNECT=m
+CONFIG_MHI_BUS_PCI_GENERIC=m
 CONFIG_ARM_SCMI_PROTOCOL=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
@@ -319,6 +320,7 @@ CONFIG_MACVTAP=m
 CONFIG_TUN=y
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=y
+CONFIG_MHI_NET=m
 CONFIG_NET_DSA_BCM_SF2=m
 CONFIG_NET_DSA_MSCC_FELIX=m
 CONFIG_AMD_XGBE=y
@@ -405,6 +407,9 @@ CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
+CONFIG_WWAN=m
+CONFIG_MHI_WWAN_CTRL=m
+CONFIG_MHI_WWAN_MBIM=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_ADC=m
 CONFIG_KEYBOARD_GPIO=y
-- 
2.38.2

