Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F762BD75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiKPMTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiKPMS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:18:58 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4822619;
        Wed, 16 Nov 2022 04:16:53 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AGCGiWr058265;
        Wed, 16 Nov 2022 06:16:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668601004;
        bh=PQTThAj8zPs2mcU3AIS2tvhUu1yshE7axp8XheUsR54=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xj7VN4FnspqJ4vJ6MffMy+F5Gt2fYX4InmVY3vxWCgXbl9UE7OYFQT80dQn37Ne5Q
         oifEov7lwwl6EjtkTMtJxkxIQO4K/9SSupGpMaM7QepSA5fX+bjZkTc0I4IM7WnFrj
         zXq7ty/+dEhnbdig1wgru9dj5Vj75IrwSy4u+eAY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AGCGihw066432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 06:16:44 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 16
 Nov 2022 06:16:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 16 Nov 2022 06:16:43 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AGCGhsl114384;
        Wed, 16 Nov 2022 06:16:43 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 2AGCGgiX013729;
        Wed, 16 Nov 2022 06:16:43 -0600
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v8 3/6] remoteproc: pru: Add enum for PRU Core Indentifiers.
Date:   Wed, 16 Nov 2022 17:46:31 +0530
Message-ID: <20221116121634.2901265-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116121634.2901265-1-danishanwar@ti.com>
References: <20221116121634.2901265-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing enum pruss_pru_id for PRU Core Identifiers.
PRUSS_PRU0 indicates PRU Core 0.
PRUSS_PRU1 indicates PRU Core 1.
PRUSS_NUM_PRUS indicates the total number of PRU Cores.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 6 +++---
 include/linux/pruss.h          | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 4769ade9c316..7d4ed39b3772 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -564,7 +564,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
 	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
 	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
 	/* PRU1 has its local RAM addresses reversed */
-	if (pru->id == 1)
+	if (pru->id == PRUSS_PRU1)
 		swap(dram0, dram1);
 	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
 
@@ -873,14 +873,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
 	case RTU0_IRAM_ADDR_MASK:
 		fallthrough;
 	case PRU0_IRAM_ADDR_MASK:
-		pru->id = 0;
+		pru->id = PRUSS_PRU0;
 		break;
 	case TX_PRU1_IRAM_ADDR_MASK:
 		fallthrough;
 	case RTU1_IRAM_ADDR_MASK:
 		fallthrough;
 	case PRU1_IRAM_ADDR_MASK:
-		pru->id = 1;
+		pru->id = PRUSS_PRU1;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 4909226f14a9..fdc719b43db0 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -14,6 +14,15 @@
 
 #define PRU_RPROC_DRVNAME "pru-rproc"
 
+/*
+ * enum pruss_pru_id - PRU core identifiers
+ */
+enum pruss_pru_id {
+	PRUSS_PRU0 = 0,
+	PRUSS_PRU1,
+	PRUSS_NUM_PRUS,
+};
+
 struct device_node;
 
 #if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
-- 
2.25.1

