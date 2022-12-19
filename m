Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA56509CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiLSKLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiLSKLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:11:10 -0500
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15022DCE;
        Mon, 19 Dec 2022 02:11:06 -0800 (PST)
Received: from amadeus-VLT-WX0.lan (unknown [120.42.184.107])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id F03458001AF;
        Mon, 19 Dec 2022 18:10:58 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH] arm64: dts: rockchip: remove unsupported property from sdmmc2 for rock-3a
Date:   Mon, 19 Dec 2022 18:10:52 +0800
Message-Id: <20221219101052.7899-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGU1IVkIdSBofSklOGUhNQ1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJS1VPSVVKQ09VSktMWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6TRw5KD0vDTMROBQZSAE*
        FBMaFElVSlVKTUxKT09PTU5CTUtDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpJ
        S1VPSVVKQ09VSktMWVdZCAFZQUpDTk43Bg++
X-HM-Tid: 0a8529dd7c02b03akuuuf03458001af
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'supports-sdio' is not part of the DT binding
and not supported by the Linux driver.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index a1c5fdf7d68f..5af11acb5c16 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -737,7 +737,6 @@ &sdmmc0 {
 };
 
 &sdmmc2 {
-	supports-sdio;
 	bus-width = <4>;
 	disable-wp;
 	cap-sd-highspeed;
-- 
2.25.1

