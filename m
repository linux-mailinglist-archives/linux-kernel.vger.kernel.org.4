Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88C374D266
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGJJ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjGJJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:57:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6E935AF;
        Mon, 10 Jul 2023 02:54:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36A9s10l127588;
        Mon, 10 Jul 2023 04:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688982841;
        bh=/VmYmage+nLZ/JQhB/pLs1QvyKdPSAEAJ4/xwBJarVk=;
        h=From:To:CC:Subject:Date;
        b=eFt7iic4LkwfTx3UGXcESKIil0r+QWOMCgRHuHqxolGSM655ixmDBF98XDgwdzOEZ
         hKlbcGp9pdAI2+fUiNZEaWm6+pBJEUY3A0rYjpZirFviEEh6HGJD7OGjPZ2sPknOgh
         SelXdIIfgUhonj6muEWVkkoUDQ0q0rBgLaDqrpJE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36A9s1ev106735
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jul 2023 04:54:01 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jul 2023 04:54:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jul 2023 04:54:01 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36A9rwcG014254;
        Mon, 10 Jul 2023 04:53:59 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [RESEND PATCH] scsi: ufs: TI UFS host controller expose device tree aliases
Date:   Mon, 10 Jul 2023 15:22:45 +0530
Message-ID: <20230710095245.183195-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When TI UFS host controller driver is built as kernel module,
It was not getting auto loaded due to missing aliases in modules.

This patch adds device tree related aliases.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Resending with correct email id of Martin Petersen

 drivers/ufs/host/ti-j721e-ufs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/host/ti-j721e-ufs.c b/drivers/ufs/host/ti-j721e-ufs.c
index 122d650d0810..117eb7da92ac 100644
--- a/drivers/ufs/host/ti-j721e-ufs.c
+++ b/drivers/ufs/host/ti-j721e-ufs.c
@@ -81,6 +81,8 @@ static const struct of_device_id ti_j721e_ufs_of_match[] = {
 	{ },
 };
 
+MODULE_DEVICE_TABLE(of, ti_j721e_ufs_of_match);
+
 static struct platform_driver ti_j721e_ufs_driver = {
 	.probe	= ti_j721e_ufs_probe,
 	.remove	= ti_j721e_ufs_remove,
-- 
2.34.1

