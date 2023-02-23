Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0C6A0AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjBWNoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjBWNn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:43:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41354E5C4;
        Thu, 23 Feb 2023 05:43:58 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 58449660220A;
        Thu, 23 Feb 2023 13:43:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159837;
        bh=O+KDnSI3KszDtxSXA0fyQMxxMHho/MGieF2kZyp8r7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AP3bxT479EcxEZGP2VzwVZJBT0ZPQ39hal42JpJafcKPtXdX+WGz+JaibwRIiKu+D
         O5akJ3a08NT4gqhpiLtg2O/8N64h+30NOpNpsemItFnlIwxGbj/Tk4sZrfZyWqe5C+
         7SVaoERKNpvUrrbiwre5FxSgc7eWnacYwoCoKq5O21cUlKleWag1ZqtoeqFsurd2d0
         +bFb+ZGSmx1QXcMl/F1t6sQoaCCPQ14CBCfKDWS9UHM//f8sm69s5eFfuWaNEPG4jF
         gniLh0o5jr6kS1mbCY+ql46i/PFFg8SBmp+d+k8iB04H7Eyxtl8tNLYE3SnHXuc5qm
         iaPL61eHbLceg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 03/16] arm64: dts: mediatek: mt8183: Remove second opp-microvolt entries from gpu table
Date:   Thu, 23 Feb 2023 14:43:32 +0100
Message-Id: <20230223134345.82625-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
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

This was done to keep a strict relation between VSRAM and VGPU, but
it never worked: now we're doing it transparently with the new
mediatek-regulator-coupler driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 3d1d7870a5f1..e01b96adef02 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -563,82 +563,82 @@ gpu_opp_table: opp-table-0 {
 
 		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-			opp-microvolt = <625000>, <850000>;
+			opp-microvolt = <625000>;
 		};
 
 		opp-320000000 {
 			opp-hz = /bits/ 64 <320000000>;
-			opp-microvolt = <631250>, <850000>;
+			opp-microvolt = <631250>;
 		};
 
 		opp-340000000 {
 			opp-hz = /bits/ 64 <340000000>;
-			opp-microvolt = <637500>, <850000>;
+			opp-microvolt = <637500>;
 		};
 
 		opp-360000000 {
 			opp-hz = /bits/ 64 <360000000>;
-			opp-microvolt = <643750>, <850000>;
+			opp-microvolt = <643750>;
 		};
 
 		opp-380000000 {
 			opp-hz = /bits/ 64 <380000000>;
-			opp-microvolt = <650000>, <850000>;
+			opp-microvolt = <650000>;
 		};
 
 		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <656250>, <850000>;
+			opp-microvolt = <656250>;
 		};
 
 		opp-420000000 {
 			opp-hz = /bits/ 64 <420000000>;
-			opp-microvolt = <662500>, <850000>;
+			opp-microvolt = <662500>;
 		};
 
 		opp-460000000 {
 			opp-hz = /bits/ 64 <460000000>;
-			opp-microvolt = <675000>, <850000>;
+			opp-microvolt = <675000>;
 		};
 
 		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <687500>, <850000>;
+			opp-microvolt = <687500>;
 		};
 
 		opp-540000000 {
 			opp-hz = /bits/ 64 <540000000>;
-			opp-microvolt = <700000>, <850000>;
+			opp-microvolt = <700000>;
 		};
 
 		opp-580000000 {
 			opp-hz = /bits/ 64 <580000000>;
-			opp-microvolt = <712500>, <850000>;
+			opp-microvolt = <712500>;
 		};
 
 		opp-620000000 {
 			opp-hz = /bits/ 64 <620000000>;
-			opp-microvolt = <725000>, <850000>;
+			opp-microvolt = <725000>;
 		};
 
 		opp-653000000 {
 			opp-hz = /bits/ 64 <653000000>;
-			opp-microvolt = <743750>, <850000>;
+			opp-microvolt = <743750>;
 		};
 
 		opp-698000000 {
 			opp-hz = /bits/ 64 <698000000>;
-			opp-microvolt = <768750>, <868750>;
+			opp-microvolt = <768750>;
 		};
 
 		opp-743000000 {
 			opp-hz = /bits/ 64 <743000000>;
-			opp-microvolt = <793750>, <893750>;
+			opp-microvolt = <793750>;
 		};
 
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <825000>, <925000>;
+			opp-microvolt = <825000>;
 		};
 	};
 
-- 
2.39.2

