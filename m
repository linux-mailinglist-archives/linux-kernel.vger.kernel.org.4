Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C2D62ED9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiKRGaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiKRGa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:30:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB3697A94
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:30:25 -0800 (PST)
X-UUID: b58a818645d144ad9fcade17229798dc-20221118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=t0/kcTXw6jGVvgjMHZqdojaidDYLv7u6AgMEPfrEt7Y=;
        b=TgrtK+zHQSeV11CMOq80D4ZO/inklulGUmy2rNfpEXtSwlcbXOJ9WoRQlFM6wSnNJBhpzxlhHTV3Eh69VyHMHXz/t4GohFgufTCqU7OqZsEMWG8kH4bZ/HnHcGVx7rBqgrcob0SMSFM8xvafL4miGL83bSv5bkN4zWoONzKe6yc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:a9d58ffe-8e08-488b-8322-b266cca03412,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.13,REQID:a9d58ffe-8e08-488b-8322-b266cca03412,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:d12e911,CLOUDID:9639242f-2938-482e-aafd-98d66723b8a9,B
        ulkID:2211181430214OB7Q0K4,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b58a818645d144ad9fcade17229798dc-20221118
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1823122021; Fri, 18 Nov 2022 14:30:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 18 Nov 2022 14:30:20 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 18 Nov 2022 14:30:19 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1] mtk-mmsys: Change mtk-mmsys & mtk-mutex to modules
Date:   Fri, 18 Nov 2022 14:30:18 +0800
Message-ID: <20221118063018.13520-1-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change mtk-mmsys & mtk-mutex to modules for gki

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/soc/mediatek/Kconfig     |  2 +-
 drivers/soc/mediatek/mtk-mmsys.c | 18 +++++++++++++++++-
 drivers/soc/mediatek/mtk-mutex.c | 17 ++++++++++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 40d0cc600cae..20c77152c282 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -68,7 +68,7 @@ config MTK_SCPSYS_PM_DOMAINS
 	  tasks in the system.
 
 config MTK_MMSYS
-	bool "MediaTek MMSYS Support"
+	tristate "MediaTek MMSYS Support"
 	default ARCH_MEDIATEK
 	depends on HAS_IOMEM
 	help
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index f3431448e843..82443a91d7d9 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
@@ -326,4 +327,19 @@ static struct platform_driver mtk_mmsys_drv = {
 	.probe = mtk_mmsys_probe,
 };
 
-builtin_platform_driver(mtk_mmsys_drv);
+static int __init mtk_mmsys_init(void)
+{
+	return platform_driver_register(&mtk_mmsys_drv);
+}
+
+static void __exit mtk_mmsys_exit(void)
+{
+	platform_driver_unregister(&mtk_mmsys_drv);
+}
+
+module_init(mtk_mmsys_init);
+module_exit(mtk_mmsys_exit);
+
+MODULE_AUTHOR("Yongqiang Niu <yongqiang.niu@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek SoC MMSYS driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index c1a33d52038e..84cd1a858f06 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -874,4 +874,19 @@ static struct platform_driver mtk_mutex_driver = {
 	},
 };
 
-builtin_platform_driver(mtk_mutex_driver);
+static int __init mtk_mutex_init(void)
+{
+	return platform_driver_register(&mtk_mutex_driver);
+}
+
+static void __exit mtk_mutex_exit(void)
+{
+	platform_driver_unregister(&mtk_mutex_driver);
+}
+
+module_init(mtk_mutex_init);
+module_exit(mtk_mutex_exit);
+
+MODULE_AUTHOR("Yongqiang Niu <yongqiang.niu@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek SoC MUTEX driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

