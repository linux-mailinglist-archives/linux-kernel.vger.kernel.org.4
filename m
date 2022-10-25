Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4C60D490
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiJYTQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJYTQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:16:31 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CBDDED35;
        Tue, 25 Oct 2022 12:15:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJuI074676;
        Tue, 25 Oct 2022 14:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666725319;
        bh=3eIMtKaot4dMOLF8vrcRprS13eBVxZaNUsR4vZmwHYg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gJ8CiB/9R6L5iypIFmL/LAeeXo6JakUCnO5BOBPVtysvQ81jLjZhe4c3ZDqyPvGKm
         KXvR2Do5Wil9HtPC1c6DOKp4eUv65g1AtK0JNlssd05KrpKq/35Q4iVtNeA0bhxD3b
         dBBzTQP1HZ8ufp1fD/LRfJy4BPYscN6u9ZDIUlJI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJFJWr065987
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:15:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:15:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:15:19 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJEv007000;
        Tue, 25 Oct 2022 14:15:19 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 03/11] thermal: k3_j72xx_bandgap: remove fuse_base from structure
Date:   Tue, 25 Oct 2022 14:15:07 -0500
Message-ID: <20221025191515.9151-4-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025191515.9151-1-bb@ti.com>
References: <20221025191515.9151-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4006; h=from:subject; bh=BJVvhDze1728PDHb2aAD1qwDBK4lUra5IUOJll7k50E=; b=owNCWmg5MUFZJlNZP6G8OQAAa3///7ftru1pfpff411f39q31n2m/v9kbX5/6mh5vr9xn98wARsz WQ9QeoaeUPUA0aA0AAaeoA9QNAZNAGgAxAAADQAAGh6h6mQyaPU0NPTU09TeqeoZQMTRpoNNNANAGQ MjQbUNDQxABhDQGIGajQabU9CGjJk0aYmQDIGTQNBhA7SbSDQ0MgGgyaAeoMjJiGhhGQGg0AMjTR6j TINNAAGI00A00eoBp+qAyYQ0Bh75JMRxigZOJ2HkcpEqJqH6vnJ0pYnIlBxnsHL7RAQYaHgMZQHzcE AQtMvGZAr/17QVmNOHNAsGDZtJHrWp2uu8fYQDk87UxYZNZPC8yuEUXvUEAEfiA7+rEqUM+L05CNIv LVUFzRn83VbQdf5LfYSTKm+LYdiPoa8BjDQfMrynqNl6qFN5ZSoBc1QjYHN/FOV2tBCkkoh4jKqB89 q5ZohFxKYVYrJuPAkPfSjPcMy5ATiBO8pSHC9aOxUrZj1NUqgFXfY28lhaG9wms79Itj5dWgYnAYQO kjy9VWQEWz/VGCJXALg9398z9SzmCoEgD1MXRjYFDAcjwAIMypeGzi39fix8oF13ooRWciINgLZ4k2 Y7Mgmq83nAa2PTDHHMf5c3BaDT6oMG8oHQOK6gCPmgI6Q+EPSv+ynYjEt8s/xdyRThQkD+hvDk
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'fuse_base' is only needed during the initial probe function to provide
a software trimming method for some devices effected by TI's i2128
erratum. Not all devices that use this hardware device will need to map
this eFuse region.

Remove fuse_base from the main k3_j72xx_bandgap structure

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index b9d20026771a5..71bf65e6afaed 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -177,7 +177,6 @@ struct k3_j72xx_bandgap {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *cfg2_base;
-	void __iomem *fuse_base;
 	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
 };
 
@@ -276,7 +275,7 @@ static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
 }
 
 static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
-			     struct k3_j72xx_bandgap *bgp)
+			     void __iomem *fuse_base)
 {
 	int i, tmp, pow;
 	int ct_offsets[5][K3_VTM_CORRECTION_TEMP_CNT] = {
@@ -298,16 +297,16 @@ static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
 		/* Extract the offset value using bit-mask */
 		if (ct_offsets[id][i] == -1 && i == 1) {
 			/* 25C offset Case of Sensor 2 split between 2 regs */
-			tmp = (readl(bgp->fuse_base + 0x8) & 0xE0000000) >> (29);
-			tmp |= ((readl(bgp->fuse_base + 0xC) & 0x1F) << 3);
+			tmp = (readl(fuse_base + 0x8) & 0xE0000000) >> (29);
+			tmp |= ((readl(fuse_base + 0xC) & 0x1F) << 3);
 			pow = tmp & 0x80;
 		} else if (ct_offsets[id][i] == -1 && i == 2) {
 			/* 125C Case of Sensor 3 split between 2 regs */
-			tmp = (readl(bgp->fuse_base + 0x4) & 0xF8000000) >> (27);
-			tmp |= ((readl(bgp->fuse_base + 0x8) & 0xF) << 5);
+			tmp = (readl(fuse_base + 0x4) & 0xF8000000) >> (27);
+			tmp |= ((readl(fuse_base + 0x8) & 0xF) << 5);
 			pow = tmp & 0x100;
 		} else {
-			tmp = readl(bgp->fuse_base + ct_offsets[id][i]);
+			tmp = readl(fuse_base + ct_offsets[id][i]);
 			tmp &= ct_bm[id][i];
 			tmp = tmp >> __ffs(ct_bm[id][i]);
 
@@ -356,6 +355,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	struct thermal_zone_device *ti_thermal;
 	int *ref_table;
 	struct err_values err_vals;
+	void __iomem *fuse_base;
 
 	const s64 golden_factors[] = {
 		-490019999999999936,
@@ -387,9 +387,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		return PTR_ERR(bgp->cfg2_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	bgp->fuse_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(bgp->fuse_base))
-		return PTR_ERR(bgp->fuse_base);
+	fuse_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(fuse_base))
+		return PTR_ERR(fuse_base);
 
 	driver_data = of_device_get_match_data(dev);
 	if (driver_data)
@@ -428,7 +428,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	}
 
 	/* Workaround not needed if bit30/bit31 is set even for J721e */
-	if (workaround_needed && (readl(bgp->fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
+	if (workaround_needed && (readl(fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
 		workaround_needed = false;
 
 	dev_dbg(bgp->dev, "Work around %sneeded\n",
@@ -452,7 +452,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 			err_vals.refs[1] = PLUS30CREF;
 			err_vals.refs[2] = PLUS125CREF;
 			err_vals.refs[3] = PLUS150CREF;
-			get_efuse_values(id, &data[id], err_vals.errs, bgp);
+			get_efuse_values(id, &data[id], err_vals.errs, fuse_base);
 		}
 
 		if (id == 0 && workaround_needed)
@@ -501,6 +501,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	 */
 	kfree(ref_table);
 
+	if (workaround_needed)
+		devm_iounmap(dev, fuse_base);
+
 	return 0;
 
 err_free_ref_table:
-- 
2.38.1

