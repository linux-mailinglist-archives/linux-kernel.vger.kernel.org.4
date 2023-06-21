Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB345737930
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFUCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFUCez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:34:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD90B12E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:34:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L2Yh0j070029;
        Tue, 20 Jun 2023 21:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687314883;
        bh=q0hvlpgx9vGyvHElW9ks+VEoe38LpUfFmwWhcP8F0H8=;
        h=From:To:CC:Subject:Date;
        b=zFR+Z9C/3CGTRUuNAsVeaRlV77dVnhPEEJO9Td2OPxrWxyxVE10fSah03LHjSnr/R
         Psjl6MXTuUFq+gECcPD64QqrQUftEKrIkd6KPg4bD1xWEiOB/loqHaO1yKuWHRQREF
         KVrSk0fuc9zdZv1t4cDGXhYsPglXyH2am7X52BK4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L2Yh65007937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 21:34:43 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Jun 2023 21:34:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Jun 2023 21:34:43 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L2Yhdf010455;
        Tue, 20 Jun 2023 21:34:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: [PATCH V2] soc: ti: k3-ringacc: Fixup documentation errors
Date:   Tue, 20 Jun 2023 21:34:42 -0500
Message-ID: <20230621023442.275128-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup couple of misses in documentation. This squashes the following
warnings:
drivers/soc/ti/k3-ringacc.c:135: warning: Function parameter or member 'tdown_complete' not described in 'k3_ring_state'
drivers/soc/ti/k3-ringacc.c:238: warning: expecting prototype for struct k3_ringacc. Prototype was for struct k3_ringacc_soc_data instead

While at this, replace "w/a" to indicate workaround to help clarify.

Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
* Fixedup a couple of places where "w/a" is used - replaced with
  "workaround" to indicate quirk workaround
* Picked up Randy's Reviewed-by.

V1: https://lore.kernel.org/all/20230621022407.270842-1-nm@ti.com/

 drivers/soc/ti/k3-ringacc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 8f131368a758..999403e1b9e0 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -125,6 +125,7 @@ struct k3_ring_ops {
  * @occ: Occupancy
  * @windex: Write index
  * @rindex: Read index
+ * @tdown_complete: Tear down complete state
  */
 struct k3_ring_state {
 	u32 free;
@@ -192,7 +193,7 @@ struct k3_ringacc_ops {
  * @num_rings: number of ring in RA
  * @rings_inuse: bitfield for ring usage tracking
  * @rm_gp_range: general purpose rings range from tisci
- * @dma_ring_reset_quirk: DMA reset w/a enable
+ * @dma_ring_reset_quirk: DMA reset workaround enable
  * @num_proxies: number of RA proxies
  * @proxy_inuse: bitfield for proxy usage tracking
  * @rings: array of rings descriptors (struct @k3_ring)
@@ -229,9 +230,9 @@ struct k3_ringacc {
 };
 
 /**
- * struct k3_ringacc - Rings accelerator SoC data
+ * struct k3_ringacc_soc_data - Rings accelerator SoC data
  *
- * @dma_ring_reset_quirk:  DMA reset w/a enable
+ * @dma_ring_reset_quirk:  DMA reset workaround enable
  */
 struct k3_ringacc_soc_data {
 	unsigned dma_ring_reset_quirk:1;
-- 
2.40.0

