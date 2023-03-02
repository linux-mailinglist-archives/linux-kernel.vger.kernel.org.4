Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5EA6A8225
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCBM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCBM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:27:43 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FE4BEBD;
        Thu,  2 Mar 2023 04:27:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x3so3896397edb.10;
        Thu, 02 Mar 2023 04:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677760053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0YVPdDle1NaFco5UbTAMJ63K0C79g/uIPg380c+Gdo=;
        b=Qv7Kkabrm00rp8Xs8/p7jI7WFOj8UQYMkRElDC6cttipvBQcAsk0jriUZDSifA3I5/
         9gJ676FyGVUj9OMKRMa3/Ce3PLlrkDZ0vpXoTEzAxOaQvwsUv7LIIoG74TrW+8E6rud3
         GNI4n7PwM4bGew1wk7gXmgEq4fBUKbDKf24ERmgiMwIt3KJ0zSsmNhAtW6qspAvHCmsP
         llpM5srqIGWxgvMuwqevfGS+/L/6eBbID8zlJ2M+Df5MAZHKayZS/jkIubqAwn+k0rsE
         YMz6mJ+MtXmPmj2dVTITi5bz1+kawST2e+MxhXSErWMv41WP4FG9nt+e0Fxax46RL8m5
         8GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0YVPdDle1NaFco5UbTAMJ63K0C79g/uIPg380c+Gdo=;
        b=3xZ9DeSoFTyXYaBw8KxXhyiNsKVVGL1YmTRV2UEPz2jrBVhBnOc1D6f3U19ZMk2fpd
         fJKu5l+QjbHrgMNEYDnitsIBwA10zkTjERMuNEP90G7vf9Wvq1yOQjadfD/49pQlHNkp
         FIp26ZbxS2Jvj+F/lg8Jmf/ViIGGPhmgvh8uDj/dq0z1/Vg6Q4RSE9KQSNOGsqSlkNcd
         i8dkq6+tUUoDopZDa4oCYTU0WGh0ZVhGL7+zErsMQQ70q0G+fptU4EE8WPCq8eQa1/W4
         vuKFDCfiy2tS6cjDiAuzBLEDwdwpQI1ikh+MrlxIfh/nAD/IOP5h7FMb7slOODCejLzI
         gC3A==
X-Gm-Message-State: AO0yUKX8k0McsNREa+KQ3HDLI+MrkVAtxxZbiYNVV/QOb7ZnJgvhuHyb
        uYZ+XQsRuVWFCijm2uVgsIs=
X-Google-Smtp-Source: AK7set8LKXktfUXsHTwFvibDbL5TSOXHnbTis5kPWESFbKm0pRN/tNN8dxkVullwlTC8i4Gv7zU8kQ==
X-Received: by 2002:aa7:d7cc:0:b0:4be:7311:1135 with SMTP id e12-20020aa7d7cc000000b004be73111135mr4026476eds.31.1677760053077;
        Thu, 02 Mar 2023 04:27:33 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id qc17-20020a170906d8b100b008ca37f3eae9sm7038375ejb.131.2023.03.02.04.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:27:32 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for MT6735
Date:   Thu,  2 Mar 2023 15:27:08 +0300
Message-Id: <20230302122708.73848-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302122708.73848-1-y.oudjana@protonmail.com>
References: <20230302122708.73848-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add support for SCPSYS power domains of MT6735. All non-CPU power domains
are added except for MD2 (C2K modem), which is left out due to issues
with powering it on.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/soc/mediatek/mt6735-pm-domains.h | 96 ++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c    |  5 ++
 drivers/soc/mediatek/mtk-pm-domains.h    |  2 +
 include/linux/soc/mediatek/infracfg.h    |  5 ++
 4 files changed, 108 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt6735-pm-domains.h

diff --git a/drivers/soc/mediatek/mt6735-pm-domains.h b/drivers/soc/mediatek/mt6735-pm-domains.h
new file mode 100644
index 000000000000..59e830fc354b
--- /dev/null
+++ b/drivers/soc/mediatek/mt6735-pm-domains.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT6735_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT6735_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mt6735-power.h>
+
+/*
+ * MT6735 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt6735[] = {
+	[MT6735_POWER_DOMAIN_MD1] = {
+		.name = "md1",
+		.sta_mask = PWR_STATUS_MD1,
+		.ctl_offs = SPM_MD1_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = 0,
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT6735_TOP_AXI_PROT_EN_MD1),
+		},
+	},
+	[MT6735_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = SPM_CONN_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = 0,
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT6735_TOP_AXI_PROT_EN_CONN),
+		},
+	},
+	[MT6735_POWER_DOMAIN_DIS] = {
+		.name = "dis",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0),
+		},
+	},
+	[MT6735_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S),
+		},
+	},
+	[MT6735_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT6735_POWER_DOMAIN_VDE] = {
+		.name = "vde",
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT6735_POWER_DOMAIN_VEN] = {
+		.name = "ven",
+		.sta_mask = BIT(8),
+		.ctl_offs = SPM_VEN_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+};
+
+static const struct scpsys_soc_data mt6735_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt6735,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt6735),
+};
+
+#endif /* __SOC_MEDIATEK_MT6735_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 354249cc1b12..0ade6b8cafff 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/soc/mediatek/infracfg.h>
 
+#include "mt6735-pm-domains.h"
 #include "mt6795-pm-domains.h"
 #include "mt8167-pm-domains.h"
 #include "mt8173-pm-domains.h"
@@ -568,6 +569,10 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
 }
 
 static const struct of_device_id scpsys_of_match[] = {
+	{
+		.compatible = "mediatek,mt6735-power-controller",
+		.data = &mt6735_scpsys_data,
+	},
 	{
 		.compatible = "mediatek,mt6795-power-controller",
 		.data = &mt6795_scpsys_data,
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 5ec53ee073c4..4aa37dc57ac7 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -19,6 +19,7 @@
 #define SPM_ISP_PWR_CON			0x0238
 #define SPM_DIS_PWR_CON			0x023c
 #define SPM_CONN_PWR_CON		0x0280
+#define SPM_MD1_PWR_CON			0x0284
 #define SPM_VEN2_PWR_CON		0x0298
 #define SPM_AUDIO_PWR_CON		0x029c
 #define SPM_MFG_2D_PWR_CON		0x02c0
@@ -28,6 +29,7 @@
 #define SPM_PWR_STATUS			0x060c
 #define SPM_PWR_STATUS_2ND		0x0610
 
+#define PWR_STATUS_MD1			BIT(0)
 #define PWR_STATUS_CONN			BIT(1)
 #define PWR_STATUS_DISP			BIT(3)
 #define PWR_STATUS_MFG			BIT(4)
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index 07f67b3d8e97..c60f8e7e976e 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -393,6 +393,11 @@
 #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
 						 BIT(7) | BIT(8))
 
+#define MT6735_TOP_AXI_PROT_EN_CONN		(BIT(2) | BIT(8))
+#define MT6735_TOP_AXI_PROT_EN_MD1		(BIT(24) | BIT(25) | \
+						 BIT(26) | BIT(27) | \
+						 BIT(28))
+
 #define INFRA_TOPAXI_PROTECTEN			0x0220
 #define INFRA_TOPAXI_PROTECTSTA1		0x0228
 #define INFRA_TOPAXI_PROTECTEN_SET		0x0260
-- 
2.39.2

