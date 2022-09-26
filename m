Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB4A5EAF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiIZSWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiIZSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:22:16 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83E2126F;
        Mon, 26 Sep 2022 11:18:47 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.195])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id AFC048000E8;
        Tue, 27 Sep 2022 02:01:25 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     linux.amoon@gmail.com
Cc:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        michael.riesch@wolfvision.net, robh+dt@kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 2/3] arm64: dts: rockchip: Rename pinctrl label of pcie2x1 on rock-3a
Date:   Tue, 27 Sep 2022 02:01:01 +0800
Message-Id: <20220926180102.37614-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926180102.37614-1-amadeus@jmu.edu.cn>
References: <20220926061420.1248-1-linux.amoon@gmail.com>
 <20220926180102.37614-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUxLVhodSRoZTkhJQ01ISFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJOWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDY6Ojo4KD0eUQhDHCohSS4X
        PBdPCg1VSlVKTU1PSUpOSUNNSENKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJOWVdZCAFZQUlOSEg3Bg++
X-HM-Tid: 0a837af600bdb03akuuuafc048000e8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distinguish it from the pinctrl label of pcie3x2 added later.
Also added comments to the pcie2x1 node.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 8adf672709e8..1b195355da2a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -539,8 +539,9 @@ rgmii_phy1: ethernet-phy@0 {
 };
 
 &pcie2x1 {
+	/* M.2 slot */
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_reset_h>;
+	pinctrl-0 = <&ngffpcie_reset_h>;
 	reset-gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";
@@ -582,7 +583,7 @@ pcie_enable_h: pcie-enable-h {
 			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		pcie_reset_h: pcie-reset-h {
+		ngffpcie_reset_h: ngffpcie-reset-h {
 			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-- 
2.25.1

