Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246AE654B11
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiLWCR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiLWCQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:16:55 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A405B289
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHNZ+DVhYypd7zkXO5GwuupZU/1DJONom1Ldfe0h2TulfdG5gfE6Hbg/to0jjP3csKmYN30bGPgAetlIQPq0OLOnwHEfHD3hWQqFnob7IqxPQqJgWKkNhM3sqkdunCjPrFR3lJLT/YbeV86pUJdlsiJ8fd8gGZdF4tG0K/URMwSKdkcWm+z5tId2ld9HxV5PqFbW3Q1MllXJibPTDRXQSHIbooqnOiyBhV5Wt3pRjpzyNDVXc+rdR7K1b5rEe36NK5cCbSMnSPOq2g+vfENVne4xSjmQOY//VhFhySusI74jwdi133r/7T+mskYF3b1NB7TnHhfZdezLJovhm8t3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UylZe2wKSbV2ElsZRncVu1XKhDaWECsUbmhKz3pMyCc=;
 b=jIk+LOqvlXkmA/KhBACPiGqGY/IrTNiyXeGcUyZE9/g/8kUTBt8c37KSXumGRqio/XRU2Mem10oZeO3W+YXO0eBeV03sGswXnt71lKE8qwAug45bUnRYZ7UcG/fzNRo+0uKf+491DnzIkAPmM4y+noUSOG1fPl7EmemyuycT3Plv2wAWqipT6KcGry6gi0cIaZL6PX6B2VTyTYh/pXWyFgtRJzcW8JOn+Dxs8BgcPRZGS40haDV/bwQUSGUA7UqQvhHPUJ7bn+L0Pp+mfYQGemkOwENsVmNZvarKLF51Zui7qmFNa9tQGI5BGACURD8t8losmSpoZzAQNS9TPtClHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UylZe2wKSbV2ElsZRncVu1XKhDaWECsUbmhKz3pMyCc=;
 b=pOIcEcUkL8YlbbBpTavfug1afbKbLO4UEt/WAzMsWJqRB2pVjhr1wZ4FyVzcgx7RHf9T+hkd8eQOj9Te/hQIv74bI+yK0wVjrfgEtcRWUwx0w4l6fulICj1pEnNk+BD+Yxv0+pFdIWAKvtz+tchwAzZ1WUt27Z3gcwwGFvn7zGM=
Received: from BN0PR04CA0174.namprd04.prod.outlook.com (2603:10b6:408:eb::29)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 02:15:36 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::62) by BN0PR04CA0174.outlook.office365.com
 (2603:10b6:408:eb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 02:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.13 via Frontend Transport; Fri, 23 Dec 2022 02:15:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 20:15:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 20:15:26 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 22 Dec 2022 20:15:25 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <yangyingliang@huawei.com>
CC:     <jassisinghbrar@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>
Subject: 
Date:   Thu, 22 Dec 2022 18:14:58 -0800
Message-ID: <20221223021458.2099974-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110150822.392385-1-yangyingliang@huawei.com>
References: <20221110150822.392385-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ddc89c-f081-4c7c-2f73-08dae48b93c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9w7jnvNt4APTylDVMXFI0aar7/8LhS+cewfIcXI+WRxqyYlc9ZqqPS2lbjC9vMl9Q2rupgpUNI3aWtvCWWWB9Lw1OKSZPtXpLjSNpkxAWPkRjZkUN3eWaFLAclibBC+9E+PuD3QpZWYp0macM//NJlHfKQUQa+s0THDkvrjbG93qC8JXvLI6qg4HstIpK/A2Y5AryLrUNOrtZrrxnLOWcoACBSLMS2MX5jVBnR0mW0icH5Wkgy5wVstgLBQq38lFWZw+OoJxUOAXZgMmglnBxyj+e8qfPkhFN9Cr3xqhaiinaEAbJxHpRlw1mX8gYnLU/rXJINxkFQgpKTafzs1wgaQgftF97ZTc2Dy6t/wF/TmfzDG0D2wozJKFCd5iJE5x+9ReZx/wlWh3FKBNvm68q8Dyt5uwRHRawZ9mqxxbvV9n41j7IRX//5NQYDZqcALMdt5C+7h/2RTtec+JbChgbuBrh+kGve1owBuBmPJbmhoocM02nwr/u/w/LpPNHgRk7GeVHPrlHKcJbCmkZNx2/cF6/wnJCefZUTdRIwkWg1dTHUmgz+VwOemmWuCihuUb7QOpIdS9vXh9sEfnS0szvUqMszmc5d9LwUM7En+Ee/4Ts5snlm6dHBPcXpNBYnJnlPQT1y4TnxDo2D8Vl1zKrNtv6NPU2+WxJVlWpRWuNLdgdCtAfETbU0hbM1/hJ3HdwgvqFz5lATQm6eC16aK7zCl2mTVeqRsm1tZopLfgh7I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(2906002)(41300700001)(4326008)(336012)(1076003)(36756003)(83380400001)(36860700001)(426003)(5660300002)(40460700003)(8936002)(47076005)(82740400003)(81166007)(44832011)(356005)(53546011)(6666004)(40480700001)(478600001)(107886003)(26005)(54906003)(6916009)(186003)(70586007)(2616005)(86362001)(316002)(70206006)(5406001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:15:35.6834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ddc89c-f081-4c7c-2f73-08dae48b93c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your patch! This looks good to me.

From 1860546acd4d860f8e00e469a3e5e3617017a8c2 Mon Sep 17 00:00:00 2001
From: Yang Yingliang <yangyingliang@huawei.com>
Date: Thu, 10 Nov 2022 23:08:22 +0800
Subject: [PATCH] mailbox: zynq-ipi: fix error handling while device_register()
 fails
>
>If device_register() fails, it has two issues:
>1. The name allocated by dev_set_name() is leaked.
>2. The parent of device is not NULL, device_unregister() is called
>   in zynqmp_ipi_free_mboxes(), it will lead a kernel crash because
>   of removing not added device.
>
>Call put_device() to give up the reference, so the name is freed in
>kobject_cleanup(). Add device registered check in zynqmp_ipi_free_mboxes()
>to avoid null-ptr-deref.
>
>Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>---
> drivers/mailbox/zynqmp-ipi-mailbox.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>index 31a0fa914274..12e004ff1a14 100644
>--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>@@ -493,6 +493,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
> 	ret = device_register(&ipi_mbox->dev);
> 	if (ret) {
> 		dev_err(dev, "Failed to register ipi mbox dev.\n");
>+		put_device(&ipi_mbox->dev);
> 		return ret;
> 	}
> 	mdev = &ipi_mbox->dev;
>@@ -619,7 +620,8 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
> 		ipi_mbox = &pdata->ipi_mboxes[i];
> 		if (ipi_mbox->dev.parent) {
> 			mbox_controller_unregister(&ipi_mbox->mbox);
>-			device_unregister(&ipi_mbox->dev);
>+			if (device_is_registered(&ipi_mbox->dev))
>+				device_unregister(&ipi_mbox->dev);
> 		}
> 	}
> }
>
-- 
2.25.1

