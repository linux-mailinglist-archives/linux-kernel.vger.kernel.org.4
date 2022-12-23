Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB35654B25
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiLWCgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLWCgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:36:22 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EEB1789B;
        Thu, 22 Dec 2022 18:36:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuiB6YPP5RNpWt5AvVISSC2Xv2FbcDUvsGq7jbkLuecggs6QI/0TbJOa6lc97RgTjyPUb6YGA9oHq/DqBJ06SGTC6YFqi+vZIXFvUtJ3Rgz1kDNlZdz714PbvQZbIae3m/dapSnLKh2fit5PwpOomsiyqGhnarYc1ci8T7bg0fiL4thXWFTv2O6MNP6cFUdt2nTLB6Yg8vQpdax3uv7SSfenDFUvd9DCXyuhTSne5lFhB2+a37y9Gy0ympv6w0Dc0IiqXEms5QJdjT8SexBGA8W7yZ8xkscK/ozo5bM/EVICE/L/hsFlbu2DfYZMTzU/VwqEgcsTl/LMDLaMbGBV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAvIigMBSc9SKkK/DvefpoNwcebu5MYKTwqOpHEyw0g=;
 b=KYRlFvLoW41oEzfLMqlq3QJI6s5b2su5rMxTfsT19POAxajaVDqgk9dXg5Q5I72+K4HkEZ2xzLeH1Wj5M4YwZZ/U0vVdCd51D1Hi+DSDnXeTy9Rgj4WO+afx09brmZotuRzxSfSUQJXeZCBAMOW4Nh1oYUw0TOEapFu74I4iQExmrekb8NnsDPgNLA0oHBrFeYCxwtGcAYzm/uHjYPLa5Dj/06FNvQATVxl0GtUkoKUjsnhSnnVjOGPAmvbluu01OWzpAu/32shXLC0lD9JYLDkwlOFzKt82OdOJ97PBDS9FFXZ46+wZVItDbH0MIZNFft4HQFZogA/Yjn/p1+Fofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAvIigMBSc9SKkK/DvefpoNwcebu5MYKTwqOpHEyw0g=;
 b=y9EyEgdLIeejNPWXWewlmBi3RG83x8wwrArIdc0rNRgW8ZkZ8ULnVXP2nzyArHnuaI1WlPOUUeqRrDiV1as3K7z2n9HDgy3Fz/ZmzLJHzFI1dM8VO0OHODA3/HCBju3etPR5rJ75QqsHNxCdNP/IwIwBapYlMvPvVLMnZUa2dTg=
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 02:36:20 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::53) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 02:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.12 via Frontend Transport; Fri, 23 Dec 2022 02:36:19 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 20:35:32 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 18:35:09 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 22 Dec 2022 20:35:08 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <christophe.jaillet@wanadoo.fr>
CC:     <jassisinghbrar@gmail.com>, <kernel-janitors@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <tanmay.shah@amd.com>
Subject: 
Date:   Thu, 22 Dec 2022 18:34:47 -0800
Message-ID: <20221223023446.2107400-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3c21e60417a0b57e7a80976b786726048119b5cf.1668932733.git.christophe.jaillet@wanadoo.fr>
References: <3c21e60417a0b57e7a80976b786726048119b5cf.1668932733.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 7349d48a-334a-4b9a-2be8-08dae48e7917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAQ952Z2mgqME54ZxhlkhutTfRjTdM39pBCLoXdeLCqgrTK9gaXLj3D9VBRWNgyNFIsYYxM5zoez2yFzL/xTyHTSqYV38X/JYk0c8xqU9K1OBoPII5rf4kmYAlZcbQTJIz7Kiktzzb7PMdgU0DDUYM14J9PnsQaP4aBZH//qA8l23T9wFKOdedlku4xl7efcZaiZwqCNiJbhNqGv5EwoNVCIKFdmHSi0WWZ2uyMt9dXsWEptgTUKZHfc/Yv9bowWfJOSswzItLs8IMPi/aGWZjN3qOptD6zufTaYNVnznwFMo72hzn4J10L5DCMEqH05x04CcaY5QGpnXEItd1gXheXk9BDAM+y6zuYTUM8eQN/1ly+5XWuXbVImdME5mlnwcvREZDIrAqGnwpX46axtiAu+b9noSgmLAdzMDi1AR7E+xVv6Vv16i9weAPAk9fb+mIPzI72vWHDS3LzJ7IP7j6B7r7t2vo7REIiIGJtP3QzCCdD/QS8LshIDckVukOrhBtVXH1BZK0G+qJWnvoC+0kY4iaWYpx2yqZYzgrdUUJ/bqgRAM03+EN0/S7KplUoE91Bd7wAtEc/I7s0HMi70ZR/L3Rzbqq3lqL6R8R1vu4UiVbejbeWKYY6xMitSJNTeou+fSaDe56sEQH+Jy5X7H25C6huqNRa+4InGJiOjKHjcMDZwYdkja9eJ/yI0hIpIBGOvYEHnI7lNCM6u06Ovt/hX922bCPFBkeMn07TJkEI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(5660300002)(6666004)(44832011)(54906003)(6916009)(2906002)(70206006)(70586007)(478600001)(186003)(41300700001)(53546011)(26005)(2616005)(47076005)(426003)(40480700001)(86362001)(336012)(36860700001)(82310400005)(5406001)(316002)(1076003)(83380400001)(356005)(82740400003)(36756003)(81166007)(8936002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:36:19.2991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7349d48a-334a-4b9a-2be8-08dae48e7917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your patch. The patch looks good to me.

From 48e51754dd7cd49abdf3adc7a01e6863bf5e3764 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 20 Nov 2022 09:25:54 +0100
Subject: [PATCH] mailbox: zynq: Switch to flexible array to simplify code

>Using flexible array is more straight forward. It
>  - saves 1 pointer in the 'zynqmp_ipi_pdata' structure
>  - saves an indirection when using this array
>  - saves some LoC and avoids some always spurious pointer arithmetic
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---
> drivers/mailbox/zynqmp-ipi-mailbox.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>index 12e004ff1a14..a4c8d23c76e2 100644
>--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>@@ -110,7 +110,7 @@ struct zynqmp_ipi_pdata {
> 	unsigned int method;
> 	u32 local_id;
> 	int num_mboxes;
>-	struct zynqmp_ipi_mbox *ipi_mboxes;
>+	struct zynqmp_ipi_mbox ipi_mboxes[];
> };
> 
> static struct device_driver zynqmp_ipi_mbox_driver = {
>@@ -635,7 +635,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
> 	int num_mboxes, ret = -EINVAL;
> 
> 	num_mboxes = of_get_child_count(np);
>-	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
>+	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
> 			     GFP_KERNEL);
> 	if (!pdata)
> 		return -ENOMEM;
>@@ -649,8 +649,6 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
> 	}
> 
> 	pdata->num_mboxes = num_mboxes;
>-	pdata->ipi_mboxes = (struct zynqmp_ipi_mbox *)
>-			    ((char *)pdata + sizeof(*pdata));
> 
> 	mbox = pdata->ipi_mboxes;
> 	for_each_available_child_of_node(np, nc) {
>
>-- 
>2.25.1

