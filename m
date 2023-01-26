Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A08467C8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbjAZKfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbjAZKfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:35:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA153B38;
        Thu, 26 Jan 2023 02:35:35 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE3086602E69;
        Thu, 26 Jan 2023 10:35:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674729334;
        bh=iKRWu1G6lRj82iCKcuPFgVRRJGOdOZ+wFl7EKyG3ooo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBmewUkJe5wonIHRiTpTwd4y9LJFeNiqAIRlyHP0ntZd3YdC9VuAR4IWXrnCi5j6O
         bVj76/T7a4Mvh4jI3IHgOXufyAPmv1JhOd1wOXW46ObYVRwnp5ULe49E51NDG2vAXs
         RoI4Do0lmXPc5o7ngrW1HkNemIZzSBhStzqhh5U8w/ti2mscnMobiokVo+yQBe4UB1
         kgdoW1GG5Gq39tRfG3/3T57TtAmr3f4Y/66k025ngMKJS+HDXPBQVoBp1qUq8hXiOk
         dANmYtFKfSL3Upae90DEf0qATiImCLsraUIEv4/y87LfFMI2wikuI2CRB/zHF5RKES
         dgJQtDozy246A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        seiya.wang@mediatek.com, tinghan.shen@mediatek.com,
        allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/6] arm64: dts: mt8195: Fix CPU map for single-cluster SoC
Date:   Thu, 26 Jan 2023 11:35:21 +0100
Message-Id: <20230126103526.417039-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126103526.417039-1-angelogioacchino.delregno@collabora.com>
References: <20230126103526.417039-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 features the ARM DynamIQ technology and combines both four
Cortex-A78 (big) and four Cortex-A55 (LITTLE) CPUs in one cluster:
fix the CPU map to reflect that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 926325935777..f04f836d9a72 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -199,22 +199,20 @@ core2 {
 				core3 {
 					cpu = <&cpu3>;
 				};
-			};
 
-			cluster1 {
-				core0 {
+				core4 {
 					cpu = <&cpu4>;
 				};
 
-				core1 {
+				core5 {
 					cpu = <&cpu5>;
 				};
 
-				core2 {
+				core6 {
 					cpu = <&cpu6>;
 				};
 
-				core3 {
+				core7 {
 					cpu = <&cpu7>;
 				};
 			};
-- 
2.39.0

