Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056BD6DF6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDLNM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDLNMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:12:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7308F7D93;
        Wed, 12 Apr 2023 06:12:25 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 70EDC6603208;
        Wed, 12 Apr 2023 14:12:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681305144;
        bh=W84iqCod7r2TCo/WEoCtavk3ERz0ZI5/UapmrYR06xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqY7t6+oJxfkhAVqa3XkwqMUNf0cylg2BwhkbtIHM+2MAYLX2nVP4j3BVT8Y2Qkhc
         ezvk2vVzWaRanUlqWZ8qakLr5SooJILlELkPGVeq8Fx7p7+38Jwryz8rKjJpDaiGRm
         isR9A9IAZd/rGR+e1gZIF0ovRfNjR5RDMmQLYxC/K8GNA0NAA+cnukEEwycU/KdD9d
         7lvxNnHN7KuiTZzLndZjmcjGxslKweXiXJZ4VCP2vJtrIq757ExA4/kLByXheN5oAU
         9HD3m66KmFw0ZeaKlwm6HxHcx5WvL/aHlVaPmc0e1IpuEh9wx3RqDSeLVTtRLB26hv
         euRXWnfDzw5ow==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        amergnat@baylibre.com, flora.fu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 3/6] soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
Date:   Wed, 12 Apr 2023 15:12:13 +0200
Message-Id: <20230412131216.198313-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412131216.198313-1-angelogioacchino.delregno@collabora.com>
References: <20230412131216.198313-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding new members with name abbreviations describe
the struct pwrap_slv_type with kerneldoc to enhance human readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 5c500be48f7c..a33a1b1820cb 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1218,11 +1218,17 @@ struct pwrap_slv_regops {
 	int (*pwrap_write)(struct pmic_wrapper *wrp, u32 adr, u32 wdata);
 };
 
+/**
+ * struct pwrap_slv_type - PMIC device wrapper definitions
+ * @dew_regs:      Device Wrapper (DeW) register offsets
+ * @type:          PMIC Type (model)
+ * @regops:        Register R/W ops
+ * @caps:          Capability flags for the target device
+ */
 struct pwrap_slv_type {
 	const u32 *dew_regs;
 	enum pmic_type type;
 	const struct pwrap_slv_regops *regops;
-	/* Flags indicating the capability for the target slave */
 	u32 caps;
 };
 
-- 
2.40.0

