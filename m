Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D64654B37
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiLWCoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbiLWCoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:44:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CCE1FFA9;
        Thu, 22 Dec 2022 18:44:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj5YoqQkDFFUtTKw99lGJWRlXbXTf87dBpwW5z2X+3T3tGyeE7y0vIndEaNCATzeNS6IH9m838+3tgDxjtVHyffm5dKOw7g61JUPp+JSXtmsW1VN8ZEhIPQXHigo8jPAJ+zY6rT+OMrdbYS0KwAlIbFYGcMlnbK6tjsqVDagt450dDXzf8AT5ABBY3pG0soQRRTE7LtM3FLrpofXE1WQ/9bJVLj8NBu33vGnTqx3H1KGZLm1zA3PuqB3Y0zwufiG5QM8eZQtkFu7f6F/TtJJ7/R/+ktoifchMyYijcpdz/NQRVj+0hQo2l4NCR/DrMPtFnMVZ2uRmhrNEPzvNCwv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKY0Jog6FsmJWOcR28u+v/m7x9elI57yLRVt1phUJEY=;
 b=TyhUtW0cAF7ndzox2nW1UxmRFU53nvkdu8GlXIgxHunqocTLi2dKoCuZ30VdNbiR1VgZ6TppUdkhJE67DbxX4/i8mfqdBgc7HPuPgxIA8c4IEdWVT8qHvf17WHAbyyLyQ95GgGvrzSgkKjKjaP9nyyuneHXbNJWdSSOZL/gAzXg9TcfTokHKgUa1OEZ8+7dOQTuy5NO1Xwz1IXg9vXCW3MsNOO0qOmyVwGGzBcsGGptVNQhLJn0MlJfsPlodEj021N1Xrz+DFc1jzw55L0Hs+L5w72UdnMlrAZqw+xtWmO0+IH8N6UMmBB+j6aVfy+7wkwuI+PjoQS+2IYFD2OuHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKY0Jog6FsmJWOcR28u+v/m7x9elI57yLRVt1phUJEY=;
 b=0Iu84WEHeoWGGpBYTcj9h7IIY0DIgw9ZbxF5dWp2Te2UNbRj15yasDWwJMk7IlIqT6xcJuGjyIo61pgmpTI1zE/kU9P1N4ur/6BOWVYVLjJ1wlsrUq8HhlkiMkAOCQcuONIiGrTAAnlQ8+IqlF9jdb9UpJnoQpBsLG7aw9tEFL0=
Received: from DM6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:5:1f4::22)
 by DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 02:44:28 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::75) by DM6PR02CA0081.outlook.office365.com
 (2603:10b6:5:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 02:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.13 via Frontend Transport; Fri, 23 Dec 2022 02:44:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 20:44:27 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 22 Dec 2022 20:44:27 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <christophe.jaillet@wanadoo.fr>
CC:     <jassisinghbrar@gmail.com>, <kernel-janitors@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <tanmay.shah@amd.com>
Subject: RE: [PATCH] mailbox: zynq: Switch to flexible array to simplify code
Date:   Thu, 22 Dec 2022 18:44:07 -0800
Message-ID: <20221223024407.2107699-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3c21e60417a0b57e7a80976b786726048119b5cf.1668932733.git.christophe.jaillet@wanadoo.fr>
References: <3c21e60417a0b57e7a80976b786726048119b5cf.1668932733.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|DM4PR12MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: 67027b59-c9c7-4b86-46bb-08dae48f9c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0J1mdQ5eQPrmk5eK4Qf8RD1wA+RTYux3WupacEerEM3lPR9zsW6LIBbNMwfawZcddHrZvWU01Tu7MmvA0CkviIzjt1GgAJbG8HLXXAArSPdXSTj8UpgilHVG1WeblsyeZs8whFIq3DBaf9SYSdow79WHonU73T/Wn3ZbDLba5z2dK2axAHZOq5OqUESAnaiQEGA0EawxdwIsh9vxw/oYASv7KCqwkWAvtL/Xe1YybS2EJq9ushha1pV47uwJJR9bcyLBzPewwX/tBjMMy/U0+01Bfqp0Htw/rIUwGORSHyU5VVH9is4TM+TrYrDj+KSKoEwP3m2SytRuj8g2RJPLjS/6H3eM3Nx/C7rgA3Si/Nrz3t3Vja6zBbaFm4NtlmWlWbm7eLPY+vOrD5uIBHjDe/1TbKRaG0J3cBNxhSxF57zrA5kf6eg9mr2/5hUQ90Ph0vO9danz4zBwhEPyHXkIeyqXMY6bX/3rMSHQ9Eyr9w2xNTm6pU6RLtr3JIB3dV435AO7oeynK0MoBimcgbuXbzAbnXTirXzcgVYFBi60Qk/D2nV31DiaG59Z44+PMLbGxgLmXRdy7FO6M8DMpXhlmEkczLw3yVBYbF9D2eIcTtGL9CvATBUAw84AgdakItNEus/ce6I5lx+n53EPJyAjoM0PwO1UZQGuCwwstnvCls3hdv5oijS0SS77WRsspOLzHPLVsfwzpISfnxMR8nf7yCrW5jADndf/tt3fuq/NPIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(70206006)(478600001)(316002)(2906002)(15650500001)(54906003)(6916009)(36756003)(82740400003)(83380400001)(81166007)(356005)(82310400005)(36860700001)(1076003)(86362001)(26005)(6666004)(186003)(47076005)(40480700001)(2616005)(426003)(336012)(70586007)(8936002)(41300700001)(8676002)(5660300002)(4326008)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:44:28.1953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67027b59-c9c7-4b86-46bb-08dae48f9c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5152
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>

Thanks for your patch. The patch looks good to me.

(Update: Fixed subject of email)

From 48e51754dd7cd49abdf3adc7a01e6863bf5e3764 Mon Sep 17 00:00:00 2001
>From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>Date: Sun, 20 Nov 2022 09:25:54 +0100
>Subject: [PATCH] mailbox: zynq: Switch to flexible array to simplify code
>
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

