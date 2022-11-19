Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812A3630F42
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 16:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiKSPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 10:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKSPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 10:25:15 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799C7DEC9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 07:25:13 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AJFOuGK024296;
        Sat, 19 Nov 2022 09:24:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668871496;
        bh=vNwBTL7uiaXFHQ1HqY76JMrEJuOG439YiuYKnkAC5ls=;
        h=From:To:CC:Subject:Date;
        b=Wo4GbgRoLOyaFbkoK6ut/AC4eiDhyJQVA/YPNGKVjH0rQ0vOiwsM5nvaA20ifSYEK
         3MqLrsaZJXIs7yo4EgN94DnlM7pbmqh0tsxL/E5kUGLDL2Bfa/i4V2w0gnVPZE6TTd
         dV8zyWaV/rDFqshvy751x7heG2v4ELdZK1fmulVU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AJFOuFL030674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Nov 2022 09:24:56 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 19
 Nov 2022 09:24:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 19 Nov 2022 09:24:56 -0600
Received: from ula0132425.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AJFOre3086622;
        Sat, 19 Nov 2022 09:24:54 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH] soc: ti: k3-socinfo: Add AM62Ax JTAG ID
Date:   Sat, 19 Nov 2022 20:54:47 +0530
Message-ID: <20221119152447.241166-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
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

Add JTAG ID entry to help identify AM62Ax SoC in kernel.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 91f441ee6175..d15764e19d96 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -43,6 +43,7 @@ static const struct k3_soc_id {
 	{ 0xBB38, "AM64X" },
 	{ 0xBB75, "J721S2"},
 	{ 0xBB7E, "AM62X" },
+	{ 0xBB8D, "AM62AX" },
 };
 
 static int
-- 
2.38.1

