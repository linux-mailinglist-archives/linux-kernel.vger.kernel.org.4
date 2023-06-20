Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA8736061
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFTAEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjFTAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:04:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DEF10FF;
        Mon, 19 Jun 2023 17:04:18 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F20856606EEE;
        Tue, 20 Jun 2023 01:04:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687219457;
        bh=6ATRDxpWwig7hs2izlUcfXHh022ClevxNi5+pW49c5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdkTnWe7EPdZV3Ex0X/89hfVYFf8wjg/7j2bhi/M2/cPEe1uFSdURA4G/FwGQq4sK
         0GvzNCTtduir6CK40KruY72Fk9Ky9ugf09L/Hkd4XICtpcq+uqg60bnRyWelCwp9dY
         ZxOqHkAV6cccHLjBb5Ufeh0KjIaAtHh2rZZbNcXGswnPS5ujhxOTC8NY+4hhtgj4iY
         aZpoMfLyjkebPwYSrIRT4ekFKpb72JV6E60ypFT19Gbm1vRhwVXUvKCdQxwGHBkZ2U
         GmkgFkUkQP+0VaITJcRHr3r1aI1JX2jSt3gDBvzXyJaYNmdu2K32/gzpK6VKfyQcsS
         m9dErKbBTlC7A==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 6/6] arm64: dts: mediatek: mt8183: Add decoder
Date:   Mon, 19 Jun 2023 20:03:39 -0400
Message-ID: <20230620000349.2122191-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620000349.2122191-1-nfraprado@collabora.com>
References: <20230620000349.2122191-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

Add node for the hardware decoder present on the MT8183 SoC.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Qianqian Yan <qianqian.yan@mediatek.com>
Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v3:
- Dropped 'active' clock and added the 'mediatek,vdecsys' syscon phandle
  property instead

Changes in v2:
- Reformatted reg-names to fit in fewer lines

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5169779d01df..4144f1ed3ff0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -2019,6 +2019,36 @@ vdecsys: syscon@16000000 {
 			#clock-cells = <1>;
 		};
 
+		vcodec_dec: video-codec@16020000 {
+			compatible = "mediatek,mt8183-vcodec-dec";
+			reg = <0 0x16020000 0 0x1000>,		/* VDEC_MISC */
+			      <0 0x16021000 0 0x800>,		/* VDEC_VLD */
+			      <0 0x16021800 0 0x800>,		/* VDEC_TOP */
+			      <0 0x16022000 0 0x1000>,		/* VDEC_MC */
+			      <0 0x16023000 0 0x1000>,		/* VDEC_AVCVLD */
+			      <0 0x16024000 0 0x1000>,		/* VDEC_AVCMV */
+			      <0 0x16025000 0 0x1000>,		/* VDEC_PP */
+			      <0 0x16026800 0 0x800>,		/* VP8_VD */
+			      <0 0x16027000 0 0x800>,		/* VP6_VD */
+			      <0 0x16027800 0 0x800>,		/* VP8_VL */
+			      <0 0x16028400 0 0x400>;		/* VP9_VD */
+			reg-names = "misc", "ld", "top", "cm", "ad", "av", "pp",
+				    "hwd", "hwq", "hwb", "hwg";
+			interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_VLD_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_AVC_MV_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_PRED_RD_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_PRED_WR_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_PPWRAP_EXT>;
+			mediatek,scp = <&scp>;
+			mediatek,vdecsys = <&vdecsys>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_VDEC>;
+			clocks = <&vdecsys CLK_VDEC_VDEC>;
+			clock-names = "vdec";
+		};
+
 		larb1: larb@16010000 {
 			compatible = "mediatek,mt8183-smi-larb";
 			reg = <0 0x16010000 0 0x1000>;
-- 
2.41.0

