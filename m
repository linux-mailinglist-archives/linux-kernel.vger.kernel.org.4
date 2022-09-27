Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3A5EB823
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiI0C7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiI0C7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:59:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C11A6AF2;
        Mon, 26 Sep 2022 19:56:35 -0700 (PDT)
X-UUID: f5614a9d1a2f476caedacbfdd7b2ca91-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MGo95QrOIOS0N5UamZ0ehMKwsLyrHKoHLoOELavqTTw=;
        b=TbY4t/xabIzBMj4XH3Gvx8rtusD+6LosPrIDpfbVTF31A2FmqHLvTDsGjjnYlNwqfnL5uSxGSw7K/07TCmU3pzJ9JYYVmMVRQASKwkz/w0BOAy/xAUNH/o+Htj/pAJarc0BJimpRKr0ZxEhnHqL09i2snyFqEJpULVokn3UxFOg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:1efa0a24-8173-4787-bc3e-da7ae5768999,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:1efa0a24-8173-4787-bc3e-da7ae5768999,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:bcbe1c07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220927105630K59ZMH15,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: f5614a9d1a2f476caedacbfdd7b2ca91-20220927
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 17438933; Tue, 27 Sep 2022 10:56:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 27 Sep 2022 10:56:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Sep 2022 10:56:26 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: [PATCH v3 04/11] remoteproc: mediatek: Remove redundant rproc_boot
Date:   Tue, 27 Sep 2022 10:55:59 +0800
Message-ID: <20220927025606.26673-5-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220927025606.26673-1-tinghan.shen@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The video codec doesn't need to explicitly boot SCP in its flow
because the SCP remote processor enables auto boot.

The redundant usage of rproc_boot increases the number of rproc.power
over 1 and prevents successfully shutting down SCP by rproc_shutdown.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../mediatek/vcodec/mtk_vcodec_fw_scp.c         |  2 +-
 drivers/remoteproc/mtk_scp.c                    | 17 +++++++++++++++++
 include/linux/remoteproc/mtk_scp.h              |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
index d8e66b645bd8..c3194f88ff31 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
@@ -6,7 +6,7 @@
 
 static int mtk_vcodec_scp_load_firmware(struct mtk_vcodec_fw *fw)
 {
-	return rproc_boot(scp_get_rproc(fw->scp));
+	return scp_boot(fw->scp);
 }
 
 static unsigned int mtk_vcodec_scp_get_vdec_capa(struct mtk_vcodec_fw *fw)
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index d421a2ccaa1e..bf68bccab78b 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -673,6 +673,23 @@ struct rproc *scp_get_rproc(struct mtk_scp *scp)
 }
 EXPORT_SYMBOL_GPL(scp_get_rproc);
 
+/**
+ * scp_boot() - Boot SCP
+ *
+ * @scp:	mtk_scp structure
+ **/
+int scp_boot(struct mtk_scp *scp)
+{
+	struct rproc *rproc = scp->rproc;
+
+	/* scp already booted when power > 0 */
+	if (atomic_read(&rproc->power) > 0)
+		return 0;
+	else
+		return rproc_boot(scp->rproc);
+}
+EXPORT_SYMBOL_GPL(scp_boot);
+
 /**
  * scp_get_vdec_hw_capa() - get video decoder hardware capability
  *
diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
index 7c2b7cc9fe6c..e463105b351c 100644
--- a/include/linux/remoteproc/mtk_scp.h
+++ b/include/linux/remoteproc/mtk_scp.h
@@ -52,6 +52,7 @@ void scp_put(struct mtk_scp *scp);
 
 struct device *scp_get_device(struct mtk_scp *scp);
 struct rproc *scp_get_rproc(struct mtk_scp *scp);
+int scp_boot(struct mtk_scp *scp);
 
 int scp_ipi_register(struct mtk_scp *scp, u32 id, scp_ipi_handler_t handler,
 		     void *priv);
-- 
2.18.0

