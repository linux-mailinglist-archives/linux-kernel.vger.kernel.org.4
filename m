Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274E16A6A39
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCAJz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCAJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602B23C60;
        Wed,  1 Mar 2023 01:55:36 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5AE7A6602136;
        Wed,  1 Mar 2023 09:55:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664533;
        bh=WS/5GDWx9zfOrHB3JiHOO+tDSOb8JiL3fs15woWgU4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QylmoMJ1GQotalrfRakBbOuQdDCgme16Wj0YeUN7rCOpBwlAE/GkXCy6rhJ95vxxJ
         K9Y+A2HujYoMjArvR2Y9f87xlbyEFKDHprhYMdgUuGcRZPUi3cHyHq2pdBXnJGkVOD
         Bp9rPdvtxaHj5WHlUkVQNGyOfBq/sbVDBpTkflqErAO6Qq9AO80+fnBH7JlVH3OLs5
         49xU0pI90eVAWOT10lOQxM4H24YaPYwQdjP8LSy1B5B46nGoXqa+zx2OoXugewsJWz
         eW20diFbmoyh/+T4pQbQGA7Cr8U1up2M5w3G/OxbxUQm/cYkngQFBGoYwALVJkRXLx
         +Xf3JklBNNoHA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH v4 07/19] arm64: dts: mediatek: mt8192: Add GPU nodes
Date:   Wed,  1 Mar 2023 10:55:11 +0100
Message-Id: <20230301095523.428461-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

The MediaTek MT8192 includes a Mali-G57 GPU supported in Panfrost. Add
the GPU node to the device tree to enable 3D acceleration.

The GPU node is disabled by default. It should be enabled by board with
its power supplies correctly assigned.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
[nfraprado: removed sram supply, tweaked opp node name, adjusted commit message]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[wenst@: disable GPU by default; adjusted prefix; split out board change]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[Angelo: cosmetic fixes]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 107 +++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 87b91c8feaf9..34631adc52c6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -312,6 +312,91 @@ timer: timer {
 		clock-frequency = <13000000>;
 	};
 
+	gpu_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-358000000 {
+			opp-hz = /bits/ 64 <358000000>;
+			opp-microvolt = <606250>;
+		};
+
+		opp-399000000 {
+			opp-hz = /bits/ 64 <399000000>;
+			opp-microvolt = <618750>;
+		};
+
+		opp-440000000 {
+			opp-hz = /bits/ 64 <440000000>;
+			opp-microvolt = <631250>;
+		};
+
+		opp-482000000 {
+			opp-hz = /bits/ 64 <482000000>;
+			opp-microvolt = <643750>;
+		};
+
+		opp-523000000 {
+			opp-hz = /bits/ 64 <523000000>;
+			opp-microvolt = <656250>;
+		};
+
+		opp-564000000 {
+			opp-hz = /bits/ 64 <564000000>;
+			opp-microvolt = <668750>;
+		};
+
+		opp-605000000 {
+			opp-hz = /bits/ 64 <605000000>;
+			opp-microvolt = <681250>;
+		};
+
+		opp-647000000 {
+			opp-hz = /bits/ 64 <647000000>;
+			opp-microvolt = <693750>;
+		};
+
+		opp-688000000 {
+			opp-hz = /bits/ 64 <688000000>;
+			opp-microvolt = <706250>;
+		};
+
+		opp-724000000 {
+			opp-hz = /bits/ 64 <724000000>;
+			opp-microvolt = <725000>;
+		};
+
+		opp-748000000 {
+			opp-hz = /bits/ 64 <748000000>;
+			opp-microvolt = <737500>;
+		};
+
+		opp-772000000 {
+			opp-hz = /bits/ 64 <772000000>;
+			opp-microvolt = <750000>;
+		};
+
+		opp-795000000 {
+			opp-hz = /bits/ 64 <795000000>;
+			opp-microvolt = <762500>;
+		};
+
+		opp-819000000 {
+			opp-hz = /bits/ 64 <819000000>;
+			opp-microvolt = <775000>;
+		};
+
+		opp-843000000 {
+			opp-hz = /bits/ 64 <843000000>;
+			opp-microvolt = <787500>;
+		};
+
+		opp-866000000 {
+			opp-hz = /bits/ 64 <866000000>;
+			opp-microvolt = <800000>;
+		};
+	};
+
 	soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -1266,6 +1351,28 @@ mmc1: mmc@11f70000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@13000000 {
+			compatible = "mediatek,mt8192-mali", "arm,mali-valhall-jm";
+			reg = <0 0x13000000 0 0x4000>;
+			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "job", "mmu", "gpu";
+
+			clocks = <&apmixedsys CLK_APMIXED_MFGPLL>;
+
+			power-domains = <&spm MT8192_POWER_DOMAIN_MFG2>,
+					<&spm MT8192_POWER_DOMAIN_MFG3>,
+					<&spm MT8192_POWER_DOMAIN_MFG4>,
+					<&spm MT8192_POWER_DOMAIN_MFG5>,
+					<&spm MT8192_POWER_DOMAIN_MFG6>;
+			power-domain-names = "core0", "core1", "core2", "core3", "core4";
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			status = "disabled";
+		};
+
 		mfgcfg: clock-controller@13fbf000 {
 			compatible = "mediatek,mt8192-mfgcfg";
 			reg = <0 0x13fbf000 0 0x1000>;
-- 
2.39.2

