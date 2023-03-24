Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7766C7BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCXJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjCXJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:42:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5116112852;
        Fri, 24 Mar 2023 02:42:15 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D9EA6603114;
        Fri, 24 Mar 2023 09:42:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679650933;
        bh=jE2h/ittsn0tSizCPWhMSnonPGhnh+XeahgZ0uy3c4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPFV21rwVMMf5SZqpzqd3iSEj9+NI3BmlLTaK4wWg8pCpUS52lpKpbJI7+al8BSXI
         UDTm8uCnjhWaalb0V3XWMmmt49hwiqpMP/w4YzGetYIKrHx3K7Lx5PGM+80Uel9Ly3
         ro4fpUqs4SpTTat0exOqR4fM2iGAj1zpmL9bdEDCITEulwwW4PY94L8xG+Byk/ZHsi
         cq8d1kJ+rOWoMdiz0PyGk25mlf59HKB0KeHKgMHOfntDmb4+Xho85g0R47ZJ7CUM/4
         2kSW+NKXTXbKqPQGRcrS88ppTpW332406XzKlRCZM1vybBXkn7MxfzmUy2D5pUlCGS
         Tt+5hX8bSIl8Q==
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
Subject: [PATCH v2 3/6] soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
Date:   Fri, 24 Mar 2023 10:42:02 +0100
Message-Id: <20230324094205.33266-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com>
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding new members with name abbreviations describe
the struct pwrap_slv_type with kerneldoc to enhance human readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

