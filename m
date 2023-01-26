Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875DC67C8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbjAZKfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbjAZKfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:35:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF1C5619C;
        Thu, 26 Jan 2023 02:35:37 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A5856602E6B;
        Thu, 26 Jan 2023 10:35:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674729335;
        bh=EMl5yatPQKhtWM2fU3fhn8R0Jnt0BN2gaE4N11T994Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6f19OUrNeNzCjr6L+ZBaC4DyPgc+JYOsCxmwcQOLpd9vW6TCon7lYhjV6Zw/dHvA
         NXl/DKKPev3eeQaRUrLg4e3pKPqnIPiLkaihZhPi4YCeXB5vFzCOlbirFICVQkLFvH
         AUfnFIaWTar0j0B8ZShrBx2k3RrMOoQmtmtfuAstwkSyTeUGamZjdsXfPx74vUDpuz
         ebk56daRyTxwQGtR73T07iQageU+SxG3GZpuRHfOIFWXvua4dnkrcgdQC8yeK54dGY
         vYk8pgVJ5NSLlpwPOfts1xAnmHNAO5A3Jxy5QnudA19ZDNLf8C1L6OQfMWEqiFNNh9
         UjJfElFU7zuSw==
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
Subject: [PATCH 3/6] arm64: dts: mt8186: Fix CPU map for single-cluster SoC
Date:   Thu, 26 Jan 2023 11:35:23 +0100
Message-Id: <20230126103526.417039-4-angelogioacchino.delregno@collabora.com>
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

MT8186 features the ARM DynamIQ technology and combines both two
Cortex-A76 (big) and six Cortex-A55 (LITTLE) CPUs in one cluster:
fix the CPU map to reflect that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: 2e78620b1350 ("arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makefile")
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index c9124bb0c960..9e8daaa044dc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -48,14 +48,12 @@ core4 {
 				core5 {
 					cpu = <&cpu5>;
 				};
-			};
 
-			cluster1 {
-				core0 {
+				core6 {
 					cpu = <&cpu6>;
 				};
 
-				core1 {
+				core7 {
 					cpu = <&cpu7>;
 				};
 			};
-- 
2.39.0

