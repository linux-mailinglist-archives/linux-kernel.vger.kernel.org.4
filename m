Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0346C691A96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBJJAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjBJI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:59:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D755E64;
        Fri, 10 Feb 2023 00:59:39 -0800 (PST)
X-UUID: 3dbab8e0a92111eda06fc9ecc4dadd91-20230210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6HhKK4J2H3bm5JiXJDgPozBzQTQbRGkWm2dygfVNSZ0=;
        b=tytu3w6v3mv/Ojr7fO2DnKtdAys/JYCQ7905FDYsVkOIc8wl0+qKqiwFo+dMWqWTuun4ydYQw0EIGCiXv9r2bvLgvW8l59JZm8hH4ATWaeq16hDM5JRN0h9mexdt2JM11QQgVegh+EQxvVLNVQLV614IlERdfgLllhI0G1gvmYM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:3489b9f0-ce9a-42ee-bfe0-081fdd7f0fc5,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.19,REQID:3489b9f0-ce9a-42ee-bfe0-081fdd7f0fc5,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:885ddb2,CLOUDID:0ff8e556-dd49-462e-a4be-2143a3ddc739,B
        ulkID:2302091540508PDLCMUG,BulkQuantity:8,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 3dbab8e0a92111eda06fc9ecc4dadd91-20230210
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1879244574; Fri, 10 Feb 2023 16:59:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 10 Feb 2023 16:59:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 10 Feb 2023 16:59:34 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 04/12] remoteproc: mediatek: Add SCP core 1 register definitions
Date:   Fri, 10 Feb 2023 16:59:23 +0800
Message-ID: <20230210085931.8941-5-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230210085931.8941-1-tinghan.shen@mediatek.com>
References: <20230210085931.8941-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 SCP core 1 related register definitions.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_common.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index ea6fa1100a00..3778894c96f3 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -47,6 +47,7 @@
 #define MT8192_SCP2SPM_IPC_CLR		0x4094
 #define MT8192_GIPC_IN_SET		0x4098
 #define MT8192_HOST_IPC_INT_BIT		BIT(0)
+#define MT8195_CORE1_HOST_IPC_INT_BIT	BIT(4)
 
 #define MT8192_CORE0_SW_RSTN_CLR	0x10000
 #define MT8192_CORE0_SW_RSTN_SET	0x10004
@@ -56,6 +57,26 @@
 
 #define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
 
+#define MT8195_CPU1_SRAM_PD			0x1084
+#define MT8195_SSHUB2APMCU_IPC_SET		0x4088
+#define MT8195_SSHUB2APMCU_IPC_CLR		0x408C
+#define MT8195_CORE1_SW_RSTN_CLR		0x20000
+#define MT8195_CORE1_SW_RSTN_SET		0x20004
+#define MT8195_CORE1_MEM_ATT_PREDEF		0x20008
+#define MT8195_CORE1_WDT_IRQ			0x20030
+#define MT8195_CORE1_WDT_CFG			0x20034
+
+#define MT8195_SEC_CTRL				0x85000
+#define MT8195_CORE_OFFSET_ENABLE_D		BIT(13)
+#define MT8195_CORE_OFFSET_ENABLE_I		BIT(12)
+#define MT8195_L2TCM_OFFSET_RANGE_0_LOW		0x850b0
+#define MT8195_L2TCM_OFFSET_RANGE_0_HIGH	0x850b4
+#define MT8195_L2TCM_OFFSET			0x850d0
+#define SCP_SRAM_REMAP_LOW			0
+#define SCP_SRAM_REMAP_HIGH			1
+#define SCP_SRAM_REMAP_OFFSET			2
+#define SCP_SRAM_REMAP_SIZE			3
+
 #define SCP_FW_VER_LEN			32
 #define SCP_SHARE_BUFFER_SIZE		288
 
-- 
2.18.0

