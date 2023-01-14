Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4566AC99
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjANQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjANQW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:22:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8893C5;
        Sat, 14 Jan 2023 08:22:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A352C60BDC;
        Sat, 14 Jan 2023 16:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC96C433D2;
        Sat, 14 Jan 2023 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673713377;
        bh=D+CAM3wftbuFaEJFjxP2gUnsEFVwOYnHKPf2scr7lgw=;
        h=From:To:Cc:Subject:Date:From;
        b=m3xWBgLe/f0oz4PDmgkDZAHBCvog+YbRybak5fOIh/i7EXb12K3CXqO8vPbAJNsXB
         l0hcgbLBIMuEU7BHG8CKduswuzYXAl/luQ/s9EkmzprC7f1G6f5gVXhSNyuTODMSeB
         vtx+GyqF7hq7GypfPMJ7uXR6Ukbst5eQ9PyO65isGdx9WF6o0JDNuU5sJJqpliRwuE
         bL5iVS0xlvOg4wroTdTFY6C34pMG0siGpU8jfZCfxQfJDa/hxclpWE1fxKrVYk1YjE
         y31HvdvhXjmzwfa2DOIlnsrxSirNjlZ8jwdj0AK/cz3JDRFYTT95NGDHJA+oqV91vd
         nFSbYiz620J0w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pGjJA-0005tR-Nd; Sat, 14 Jan 2023 17:23:05 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: defconfig: enable Qualcomm PCIe modem drivers
Date:   Sat, 14 Jan 2023 17:22:36 +0100
Message-Id: <20230114162236.22615-1-johan+linaro@kernel.org>
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

Enable the MHI PCI controller driver and MHI WWAN drivers for Qualcomm
based PCIe modems such as the ones found on the SC8280XP Compute
Reference Design (CRD) and Lenovo Thinkpad X13s.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Bjorn,

Perhaps you can take this through your tree?

Johan


 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86aa3730a8b6..117b49f3f1c1 100644
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
@@ -405,6 +406,9 @@ CONFIG_MWIFIEX_SDIO=m
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

