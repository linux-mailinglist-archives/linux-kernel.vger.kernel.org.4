Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6A85BAD91
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIPMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIPMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:42:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503BFA6C00;
        Fri, 16 Sep 2022 05:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09271B815C6;
        Fri, 16 Sep 2022 12:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F17C433D6;
        Fri, 16 Sep 2022 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663332145;
        bh=kV7HFk4TO924Bo/xQRpbgAArFEG65LVWJgBRYxJCc5E=;
        h=From:To:Cc:Subject:Date:From;
        b=Uy9N41Wt68k+Kk0T6wi3qmF6CRknyIj54dXpQeCJD4iU2jc2zT7ioOEWJRQFimuDl
         shghRuyLTULxCkWO3thB1DXmOeEFCRBlQiNeE8K2wAU3DnwDGx/m0Ymcl7A7a0Vuw3
         96ozCIYeUpdLnXdNq5MlFhDCokWndt5ztG2SPzZcYdQJEzl3p1/yxcJ7YEOQ2NTIhN
         /qKix8E4lQG5u1LFz7ikc6k0AsnMzdjo31ekjlnUAmcldLLMq2o2GsaRhI9y9/zpsh
         +MZg8EyA46iWwysLGOCISqZ04bueCqmuK372w503M/Lyi8tN2QjwhRFTYFY6qKIwUr
         V52ckB019QF8Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enabled SC8180x configs
Date:   Fri, 16 Sep 2022 18:12:14 +0530
Message-Id: <20220916124214.3881948-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sc8180x global clock controller, tlmm, interconnect and edp phy
drivers which are required for sc8180x like Lenovo Flex 5G laptop to
boot.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0816b7f6926e..e772d01536cf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -534,6 +534,7 @@ CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
+CONFIG_PINCTRL_SC8180X=y
 CONFIG_PINCTRL_SC8280XP=y
 CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM8150=y
@@ -1060,6 +1061,7 @@ CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
+CONFIG_SC_GCC_8180X=y
 CONFIG_SC_GCC_8280XP=y
 CONFIG_SDM_CAMCC_845=m
 CONFIG_SDM_GPUCC_845=y
@@ -1213,6 +1215,7 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_MTK_TPHY=y
+CONFIG_PHY_QCOM_EDP=m
 CONFIG_PHY_QCOM_PCIE2=m
 CONFIG_PHY_QCOM_QMP=m
 CONFIG_PHY_QCOM_QUSB2=m
@@ -1275,6 +1278,7 @@ CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_QCS404=m
 CONFIG_INTERCONNECT_QCOM_SC7180=m
 CONFIG_INTERCONNECT_QCOM_SC7280=y
+CONFIG_INTERCONNECT_QCOM_SC8180X=y
 CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
-- 
2.37.3

