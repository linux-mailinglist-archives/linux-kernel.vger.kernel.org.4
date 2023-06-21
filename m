Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95A737915
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjFUCYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFUCY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:24:28 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DA18C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:24:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L2OFle064468;
        Tue, 20 Jun 2023 21:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687314255;
        bh=ZYlHeY71zSSaGopLelEmHiU5I25wRJG/rx/hcBG+cyk=;
        h=From:To:CC:Subject:Date;
        b=NJyl3i87wYr1AakSFiJ2hPnFs0d59inI7vLAqa+aDwDdjbfZvgOd4L2XTI/+uEq+r
         beZHXwfMXNc3blC5DVvxhUo8jnuWU5y3FkIkjPprbkndhTlYKA4VPHJ3t2yazl/qf/
         OMc6ogykZwCumpUYIukEe1CLPsZGUPg/l8nzjLBM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L2OFVi075009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 21:24:15 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Jun 2023 21:24:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Jun 2023 21:24:15 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L2OFHc001655;
        Tue, 20 Jun 2023 21:24:15 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: [PATCH] soc: ti: k3-ringacc: Fixup documentation errors
Date:   Tue, 20 Jun 2023 21:24:07 -0500
Message-ID: <20230621022407.270842-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 8f131368a758..548b9f605d86 100644
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
@@ -229,7 +230,7 @@ struct k3_ringacc {
 };
 
 /**
- * struct k3_ringacc - Rings accelerator SoC data
+ * struct k3_ringacc_soc_data - Rings accelerator SoC data
  *
  * @dma_ring_reset_quirk:  DMA reset w/a enable
  */
-- 
2.40.0

