Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880CA6228B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiKIKl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiKIKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEB024F23;
        Wed,  9 Nov 2022 02:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0EF3RDR/MQ69mFnypHmA0Sb9xc7Y+HnnGljlXBEm4heeaA2PvZ58c4uf7crcXEgnbrnhZxVYla/kU8WIrptu8Jkv7NVUtU0/7l/z0WSFxCFxk1H3thkOny+vQeNaqz/DvwvSjlBV6xqRvzwj7/cNwh+Kly64hl6JjJ0NO1iXd0IpaOAaPnlQShn9geFhfEGOukO+8bRsxOq/OsnmYTXVTjaN2j6tgkhmDi41lPCKShCy5Y3F06oBOEyH/Zk9uU5ipMq64hl1wQiXjKRa6fuYARiXW+e38cXpc1SYXtr/mMqxmbIXueY52Qftx0jKBOpyM9WNTtcLPaC8Xmuil0c2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=165J/0jl3YniOXsSGugeLHpDY9z5jKXw9zLnBFsDvys=;
 b=DaoiE1VN4PiEX2xN7ZrRibee/OY8ng7ZOsi5fTBbLyx4Y5M0KPru8K+2IhtVgg3i9S1HXjTAuSOumkxrGUeN1yffnK+1WxvbasSo14mw4/jRveSGnuFUiO4PGE8NyIVnLFfvK1f/7ga0UP7MPo+FI1G5gQvvI39T/9UVbslzUsaWa4GqEsmNWQkLUCuJBrUnvcNJkipWFHgx6q8Wu6EbPakqdA8q4xESmxcyrzzpmCKbGYaLU6LGRewnDZ5nvecM+n5K8bjuA/h+ezD9Ua6l0+M7ejTdTGpQPjY9gcZ9XrJ0NVUMENYRF1rMYQcQy1bPSCucLh9llhMviz0ffP8DUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=165J/0jl3YniOXsSGugeLHpDY9z5jKXw9zLnBFsDvys=;
 b=l5DsRSvOWaCoBky6agsyALWXlOZOn4A9+U7QflZNlhABpUguSjJDjnkW0bEksK3wVBvigoBw7h2I0RY5MeQnEYoa2gT68xSV/49NmzEN4kePBcA+m9e8vAimQS0KwSJvcmt2GUTSYCLOmUNNruLKZxsqr6D9HJSPoXaZOYy91S0=
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 10:41:43 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::98) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:35 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 6/9] cxl/pci: Do not ignore PCI config read errors in match_add_dports()
Date:   Wed, 9 Nov 2022 11:40:56 +0100
Message-ID: <20221109104059.766720-7-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109104059.766720-1-rrichter@amd.com>
References: <20221109104059.766720-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 41817502-b894-4b91-6bfd-08dac23efdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSBKg9rAB7T2XDBxfRmsslVdR47pvkd9pKrQL3qCRyUF/1LVyVlPiv822U9V+L3Vy6SqyhZaG0C6Fe/PalewkI+/Uu04irRHLyQHPjOFhqmGptYldBkRpSCZNkvt9SATlxzO0tcAVNh2Z7WfsMN1DJRz5aVndRW5pqamJgMl2x5urWhkDtCrb8142zNWtjsy+FbZ/AWjrK9qOl2upRDOaXtYbYDpOQ14IhTFXoe1WLNuCmMiFHZ7RWikpYNFEJPhWmXpXLfOcFZY4mEWD+IIbxHKbDZ/tECr2MAB687WIJZkmZx+7nO/uqR5PRmCcwhxLkcf/5FfIxINUx0MFZmapRJMVYTpMgLitCCfUyc+ycUZlbD9PWIhHvNa8JLQwcWu65sz/cOKsqbmRmTUgAvbmPz3Z5FjdO75m3bdUw9qCK+3G/HP6S1c1ZRQjeWDfKXGR2UpYUroqgYZvUBsD6Wub4ZRBdJcCwK0ZRdyPJj9qbztd3dz4lGnIUHxhd7o/YODujqcL5qHphOrY5FSCAAb43lrYHuY61LJEL47C/Hqj3VtBHF6OtSDrgLoO9VZ2dBvpLJgZQDSeRCYGFbke4SoeC22/gKcKqdLXnQfggxrZFpRF3tVOUxII5C+LcbAQ20NZMHa2CH9TSqJ41pDEYOSHdEkV89aZecZZUHQGrLDOTbdqRMmZfPO2NXX8ykw9f013H83yGuiKAJdZtGJygak69xEM4LMTJxP9TXXOOWH/Oo58Wa+DKT9qJAsmICOUciaXX7NQ6UF1U12kG7rShcd6sVNRUR4pCl/f950bcJJRK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(316002)(82740400003)(110136005)(36756003)(4744005)(6666004)(8936002)(356005)(40460700003)(1076003)(81166007)(54906003)(186003)(83380400001)(16526019)(336012)(70206006)(4326008)(8676002)(41300700001)(70586007)(2616005)(82310400005)(2906002)(7416002)(478600001)(36860700001)(26005)(5660300002)(40480700001)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:42.7802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41817502-b894-4b91-6bfd-08dac23efdce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link capabilities of a PCI device are read when enumerating its
dports. This is done by reading the PCI config space. If that fails
port enumeration ignores that error. However, reading the PCI config
space should reliably work.

To reduce some complexity to the code flow when factoring out parts of
the code in match_add_dports() for later reuse, change this to throw
an error.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0dbbe8d39b07..8271b8abde7a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -47,7 +47,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		return 0;
 	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
 				  &lnkcap))
-		return 0;
+		return -ENXIO;
 
 	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
-- 
2.30.2

