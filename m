Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C3654B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiLWCvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiLWCvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:51:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74A1FCE0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:51:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvYAobqMDBP868Zpt3oJu6QXFsCSMQubSM7y3VDChMEfs6wpHzCqYq5HPDvXRW9ysJEFvzQ9sVtT569642wyCt1sgXBBtt2QchICc3R4eobaymz+8FisivYNirTFbZRr/fdpafzr2+lKZSd4dco1G0pOw+ohMNRnAB3iLTOh84R2eCX6op5sIhMSeBKvgYqj+Yrg5UD0FzIUyucJUiNG7aeARq6M3yebAGCb6TJjJ5LpDVEBLh2jRhQ8YNRcBVgl5loyzd7657nyotdQwQVuLa7vpQv5Kae7H1ednc4x3NdiamdiOOWbfryh2m5RSpdt93YU90mmMP0825sYEPx0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK3GboUkxH4eQzSwOFmgyOAQwmsCxaT1/NVWjeCHW0E=;
 b=nOIesaOpTm3p1rKDtyF0UruUCETMLfJMDhJOpaZYD0HVkrNdNzw8mj4yemENG7bjCp+iQLE0tKB/kr3cxdOipqjQVSQ3Q5vb3sXbKxnFgQa8zNeV3/d0rVnxUPx+gY19NGRAv8ycC8zbr4HQRYJnd3L22j34gsjCgYUe6/O9NaLT4PHdsQUby1ISDLRrB0m0vHwBJ6Kjuz9M7ljLC7elwZ7KHreldXth9U7KpwblWbc8q3yRvYVCTmv4DWdyO6nmA462HhHSAY7tHodlFn/dZ2ZC7DgKGdQRQZlsVKP66AJEfDJTXWo6R4lXvPPSkEo6v3isnmJxh/2ANCmA71OTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK3GboUkxH4eQzSwOFmgyOAQwmsCxaT1/NVWjeCHW0E=;
 b=W3fDI/R/48emfc9DndkDMcj2F4qKfZcpUXT7kkZbnjbNLJ4kUUnvtC4VtBp0RvVr+pBXX4kLbvFYG/S7XNLlCPCWd9gwfAt95IoVhEHIFeCKMapypnQ+BEdexQe+7CaFeuhdnQqDDT2FcYa/FUEwBWmpXD4k2k9lhj79zcl1H+Q=
Received: from DS7PR03CA0165.namprd03.prod.outlook.com (2603:10b6:5:3b2::20)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 23 Dec
 2022 02:51:19 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::95) by DS7PR03CA0165.outlook.office365.com
 (2603:10b6:5:3b2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Fri, 23 Dec 2022 02:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.13 via Frontend Transport; Fri, 23 Dec 2022 02:51:19 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 20:51:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 18:50:51 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 22 Dec 2022 20:50:51 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <yangyingliang@huawei.com>
CC:     <jassisinghbrar@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <tanmay.shah@amd.com>
Subject: Re: [PATCH] mailbox: zynq-ipi: fix error handling while device_register()
Date:   Thu, 22 Dec 2022 18:50:26 -0800
Message-ID: <20221223025025.2107945-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110150822.392385-1-yangyingliang@huawei.com>
References: <20221110150822.392385-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ae75d0-3051-4bba-8de3-08dae4909156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzsgjR7vgN60Mpe6eVx/t9HJufGTBuuyoiWbL2MIwTaMM+UPvqBrwtuwGG3DW2gotLTvUpLpRPLIo66a2dXg87CHx4qcFF9LGvJtDgzTIsUjcoWHkalhrcNOnfcekJuXYvc4FxI//yY6z8rjRDmt/wbs57NgeKX5yu/ubVuDbcW76iq2m2GkTddwaactj6mmg1c8IcebdYEC8ITSL4O6lkW+nPLfUmggjRmEG/Y26+NrNqyiQQmVqJOAH0mbki1Ffb46f2b3q95PEEoL4Z1sr6wticg4cC0ZmxJmk1IZgzaN3qddoMJVOAbFpBykqWtMZ8hSsj5C67FN9AIjtACzGhBOe6qegpwPT0bNOvJ227Emv/aoI0QqCXt00WJTpm7lkdqnQVQ1MclbBof6M5dN/a830V1+Z1jzAFpzhNd85o/A6sOzltZNZpNa3KshsKDKeMzwlRKAImNv6RPqW+o0vv1W5Lo3VbTpyyWSgPPsb3EeNZIljKdqnrjWtQFlV/ROWZRh268OZUkEJ2+kfA8vMaqQCTjg+Tf2maKiaXvi1ZhWKuRzprH0gaUO1dYaRDZXO4oO6wSDnXqBrUv4153l73T/jFLSMiF/YSZ50mkhOZW+GzsUm3zd/zA+JbF/GBHwWzj7jaJGwQba4SS3BZMV1GorXHb5uF5Bm61BTSlu4AlqTl4beme8sPhYW1g+k/8sM29Sn2NOsHA7sx3q7cdS4eI0Fbhkw6/zHMh6kdhcE60=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(54906003)(6916009)(316002)(40480700001)(356005)(8936002)(81166007)(70206006)(70586007)(4326008)(8676002)(36756003)(41300700001)(82740400003)(40460700003)(26005)(186003)(82310400005)(86362001)(83380400001)(1076003)(2616005)(426003)(47076005)(336012)(478600001)(6666004)(36860700001)(2906002)(15650500001)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:51:19.0513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ae75d0-3051-4bba-8de3-08dae4909156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>

Thanks for your patch! This looks good to me.

(Updated: Fixed Subject of the reply)

>From: Yang Yingliang <yangyingliang@huawei.com>
>Date: Thu, 10 Nov 2022 23:08:22 +0800
>Subject: [PATCH] mailbox: zynq-ipi: fix error handling while device_register()
> fails
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
>-- 
>2.25.1

