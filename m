Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A463221C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiKUMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiKUMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:30:35 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72FBB1B92;
        Mon, 21 Nov 2022 04:30:10 -0800 (PST)
X-UUID: c413e1fb5ad2495b99658ea4f03bad2a-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ew6+L9aqHqlZQywPj238kgI7CvZBeJY2YyKt211tEzo=;
        b=pbWWk8BJEmmvmxYf0EUa302PrvYbWCSFeM8EIiWfkTbABGJfh8Wj9IRs6Q8YYbL94dTXfGNSdOnUCsR6DGRT57uZiJQzulNeqM6z3JKxb73vUi7as5GuYrXNi+O2iWCMlWobF7YwIKxP28uleM2tKW5CdZyUzQnU6lSFD9Bt7kI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:cf547c95-dc8e-4c6b-91ae-d2389b81678a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.13,REQID:cf547c95-dc8e-4c6b-91ae-d2389b81678a,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:d12e911,CLOUDID:c31f622f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221121203003JXTROOFK,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c413e1fb5ad2495b99658ea4f03bad2a-20221121
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1443858228; Mon, 21 Nov 2022 20:30:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 20:29:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 20:29:58 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Subject: [PATCH v5 1/4] clk: mediatek: Export PLL operations symbols
Date:   Mon, 21 Nov 2022 20:29:54 +0800
Message-ID: <20221121122957.21611-2-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221121122957.21611-1-johnson.wang@mediatek.com>
References: <20221121122957.21611-1-johnson.wang@mediatek.com>
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

Export PLL operations and register functions for different type
of clock driver used.

Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 84 ++++++++++++++--------------------
 drivers/clk/mediatek/clk-pll.h | 55 ++++++++++++++++++++++
 2 files changed, 89 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 54e6cfd29dfc..a4eca5fd539c 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -27,37 +27,10 @@
 
 #define AUDPLL_TUNER_EN		BIT(31)
 
-#define POSTDIV_MASK		0x7
-
 /* default 7 bits integer, can be overridden with pcwibits. */
 #define INTEGER_BITS		7
 
-/*
- * MediaTek PLLs are configured through their pcw value. The pcw value describes
- * a divider in the PLL feedback loop which consists of 7 bits for the integer
- * part and the remaining bits (if present) for the fractional part. Also they
- * have a 3 bit power-of-two post divider.
- */
-
-struct mtk_clk_pll {
-	struct clk_hw	hw;
-	void __iomem	*base_addr;
-	void __iomem	*pd_addr;
-	void __iomem	*pwr_addr;
-	void __iomem	*tuner_addr;
-	void __iomem	*tuner_en_addr;
-	void __iomem	*pcw_addr;
-	void __iomem	*pcw_chg_addr;
-	void __iomem	*en_addr;
-	const struct mtk_pll_data *data;
-};
-
-static inline struct mtk_clk_pll *to_mtk_clk_pll(struct clk_hw *hw)
-{
-	return container_of(hw, struct mtk_clk_pll, hw);
-}
-
-static int mtk_pll_is_prepared(struct clk_hw *hw)
+int mtk_pll_is_prepared(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 
@@ -161,8 +134,8 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
  * @fin:	The input frequency
  *
  */
-static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
-		u32 freq, u32 fin)
+void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
+			 u32 freq, u32 fin)
 {
 	unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
 	const struct mtk_pll_div_table *div_table = pll->data->div_table;
@@ -198,8 +171,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 	*pcw = (u32)_pcw;
 }
 
-static int mtk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long parent_rate)
+int mtk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+		     unsigned long parent_rate)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 pcw = 0;
@@ -211,8 +184,7 @@ static int mtk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static unsigned long mtk_pll_recalc_rate(struct clk_hw *hw,
-		unsigned long parent_rate)
+unsigned long mtk_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 postdiv;
@@ -227,8 +199,8 @@ static unsigned long mtk_pll_recalc_rate(struct clk_hw *hw,
 	return __mtk_pll_recalc_rate(pll, parent_rate, pcw, postdiv);
 }
 
-static long mtk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *prate)
+long mtk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *prate)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 pcw = 0;
@@ -239,7 +211,7 @@ static long mtk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	return __mtk_pll_recalc_rate(pll, *prate, pcw, postdiv);
 }
 
-static int mtk_pll_prepare(struct clk_hw *hw)
+int mtk_pll_prepare(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 r;
@@ -273,7 +245,7 @@ static int mtk_pll_prepare(struct clk_hw *hw)
 	return 0;
 }
 
-static void mtk_pll_unprepare(struct clk_hw *hw)
+void mtk_pll_unprepare(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 r;
@@ -301,7 +273,7 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
 	writel(r, pll->pwr_addr);
 }
 
-static const struct clk_ops mtk_pll_ops = {
+const struct clk_ops mtk_pll_ops = {
 	.is_prepared	= mtk_pll_is_prepared,
 	.prepare	= mtk_pll_prepare,
 	.unprepare	= mtk_pll_unprepare,
@@ -310,18 +282,15 @@ static const struct clk_ops mtk_pll_ops = {
 	.set_rate	= mtk_pll_set_rate,
 };
 
-static struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
-		void __iomem *base)
+struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
+					const struct mtk_pll_data *data,
+					void __iomem *base,
+					const struct clk_ops *pll_ops)
 {
-	struct mtk_clk_pll *pll;
 	struct clk_init_data init = {};
 	int ret;
 	const char *parent_name = "clk26m";
 
-	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
-	if (!pll)
-		return ERR_PTR(-ENOMEM);
-
 	pll->base_addr = base + data->reg;
 	pll->pwr_addr = base + data->pwr_reg;
 	pll->pd_addr = base + data->pd_reg;
@@ -343,7 +312,7 @@ static struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
 
 	init.name = data->name;
 	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
-	init.ops = &mtk_pll_ops;
+	init.ops = pll_ops;
 	if (data->parent_name)
 		init.parent_names = &data->parent_name;
 	else
@@ -360,7 +329,22 @@ static struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
 	return &pll->hw;
 }
 
-static void mtk_clk_unregister_pll(struct clk_hw *hw)
+struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
+				    void __iomem *base)
+{
+	struct mtk_clk_pll *pll;
+	struct clk_hw *hw;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	hw = mtk_clk_register_pll_ops(pll, data, base, &mtk_pll_ops);
+
+	return hw;
+}
+
+void mtk_clk_unregister_pll(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll;
 
@@ -423,8 +407,8 @@ int mtk_clk_register_plls(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
 
-static __iomem void *mtk_clk_pll_get_base(struct clk_hw *hw,
-					  const struct mtk_pll_data *data)
+__iomem void *mtk_clk_pll_get_base(struct clk_hw *hw,
+				   const struct mtk_pll_data *data)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index fe3199715688..f17278ff15d7 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -7,6 +7,7 @@
 #ifndef __DRV_CLK_MTK_PLL_H
 #define __DRV_CLK_MTK_PLL_H
 
+#include <linux/clk-provider.h>
 #include <linux/types.h>
 
 struct clk_ops;
@@ -20,6 +21,7 @@ struct mtk_pll_div_table {
 
 #define HAVE_RST_BAR	BIT(0)
 #define PLL_AO		BIT(1)
+#define POSTDIV_MASK	GENMASK(2, 0)
 
 struct mtk_pll_data {
 	int id;
@@ -48,10 +50,63 @@ struct mtk_pll_data {
 	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
 };
 
+/*
+ * MediaTek PLLs are configured through their pcw value. The pcw value describes
+ * a divider in the PLL feedback loop which consists of 7 bits for the integer
+ * part and the remaining bits (if present) for the fractional part. Also they
+ * have a 3 bit power-of-two post divider.
+ */
+
+struct mtk_clk_pll {
+	struct clk_hw	hw;
+	void __iomem	*base_addr;
+	void __iomem	*pd_addr;
+	void __iomem	*pwr_addr;
+	void __iomem	*tuner_addr;
+	void __iomem	*tuner_en_addr;
+	void __iomem	*pcw_addr;
+	void __iomem	*pcw_chg_addr;
+	void __iomem	*en_addr;
+	const struct mtk_pll_data *data;
+};
+
 int mtk_clk_register_plls(struct device_node *node,
 			  const struct mtk_pll_data *plls, int num_plls,
 			  struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 			     struct clk_hw_onecell_data *clk_data);
 
+extern const struct clk_ops mtk_pll_ops;
+
+static inline struct mtk_clk_pll *to_mtk_clk_pll(struct clk_hw *hw)
+{
+	return container_of(hw, struct mtk_clk_pll, hw);
+}
+
+int mtk_pll_is_prepared(struct clk_hw *hw);
+
+int mtk_pll_prepare(struct clk_hw *hw);
+
+void mtk_pll_unprepare(struct clk_hw *hw);
+
+unsigned long mtk_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate);
+
+void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
+			 u32 freq, u32 fin);
+int mtk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+		     unsigned long parent_rate);
+long mtk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *prate);
+
+struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
+					const struct mtk_pll_data *data,
+					void __iomem *base,
+					const struct clk_ops *pll_ops);
+struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
+				    void __iomem *base);
+void mtk_clk_unregister_pll(struct clk_hw *hw);
+
+__iomem void *mtk_clk_pll_get_base(struct clk_hw *hw,
+				   const struct mtk_pll_data *data);
+
 #endif /* __DRV_CLK_MTK_PLL_H */
-- 
2.18.0

