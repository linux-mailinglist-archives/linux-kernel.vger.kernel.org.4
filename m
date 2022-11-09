Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF66228B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKIKlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKIKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938AE209BC;
        Wed,  9 Nov 2022 02:41:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOR8b15qD7tdeCGe9HJwEgm3VsdWS4hdX+vnEPvyN9mya2ip39o4oCbCrgUXmriyWGWnh5Z0+0l9x8kEjxQ7ODm1ApDxZ/I8I14c46fzINqWh4ix3KmGHNl0uqx1sJbKIJo/QVJSZ1mHPLTdJYZ/kPDp16Z0ijBzpGu2ybx3SCThrJsixZwm7HKtzwt0hj9SJ5/kIV5VVCmQBs3cTNyAk9FFE3+Xh8jg0J7RQpD3KUwmXnxTzY/v29kWNDUcXqZxuUS1xCmUWNt4i/DPxHznpmW0VSdv+/RaYvnZSZ6gFPeiUsD8sqrbRWOMT+smVKXZXi57BWFus8OB3r8ZRW1Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY6nb0G97usEt0cDMnExs1IMZ62wo437PxZzDGThDaM=;
 b=URmszr6qmkhORvZ/YuoFLIa42biAvgOO6nF7ZOJ43tdDBABJ28bAtsT2mVfNVRHOf6BEYSflTTi8S7+nRYsxD9NNNwG3lnCEyYDmmEqkiU/GR6R5nsigrLBB0L4J/ipigQkHW7mV4TUkCSSoteSGLwvNq7m7hRgWNrmAts9o66Mfaddsy0rpHUm59wCwAMnQZt9J43zVwpxV+gP11BpMCij8Pf22CFt0xIDalpwwyjNLouJbkk5DmRqRYOb5N9eqgKMLJEw/0Pt86jz85bcOBgBtBZn7dEd5X/A0ceqeRn9VxJU/k2gZBZwdu8J8XrPmh9bOHOyxR1hThMSVWEI/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY6nb0G97usEt0cDMnExs1IMZ62wo437PxZzDGThDaM=;
 b=C8/eUbzWZAfZoxqIAYiFm+qM6iEeB8Jj698TvLdVI8J8Fwpo4cWsPMWjL++bWo8app4JgqQqqIwt8iYCAQE9AR1FnhNJjN6AaskdM9QtY3b982hIjv5DvrTYDcMgjU4ksDt/Luy0Sr3/8VYUuc+vC11MOw7SVM0JeCdb3ocmk84=
Received: from BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::16)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:41:29 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::f8) by BN9P220CA0011.outlook.office365.com
 (2603:10b6:408:13e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:29 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:26 -0600
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
Subject: [PATCH v3 3/9] cxl/mem: Adjust cxl_mem_find_port() to find an RCH's port
Date:   Wed, 9 Nov 2022 11:40:53 +0100
Message-ID: <20221109104059.766720-4-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109104059.766720-1-rrichter@amd.com>
References: <20221109104059.766720-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|BN9PR12MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ed6df7-a314-4116-779b-08dac23ef5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REEzWynFfBy8dikKxSV+hXuZAuNdeB94+/WFPs6o7b0bLcDOxbTYJwDN6PCpst381Wm1CvkJVlvICJI4pb1jj2Iz9YC4QmnfxG4TxcebwNltjzr8u/ZouuXGnQVlHgUbVc9D3eKXhXC7WC7Gd5YCnVRd4EUrms4JIxzyx+NTzYn8s23ngye64x42oUbwrDsUhQZsjWniU3anIp2/pb0lW3a1WWzLAUV/PhjljaPD8zSJfRjyvzYMUX77VSy8gAaMHFhtTT1r0WpNko+pC3gdlnLZRqEpwrXwVwC9SQI/1L87m3Jjn/obqxIPzQ8ZC4sZ3y2E7s/PIdhJGugN/FZ5E+WNqUw7PXUlTt2HoOp6S4rWW1zJSfQHC92XgbWC0OB4FN9z9Lr8FH9JFWI/cn0Da5EZ/Q+tCCly+Tm0eiZii1bmH6wZeITk5QsL2Iy8Q/V+LnMIexI+B6GkYSoJX8/iMTqofcELru1MW+85JJ8v9qrOySln8NqJLM3sXKvfX3fFgdhgljTJhLMqnMJZ+7n4HShdRSXpkPY4ceoaivXZO5HhiWe892rH5Fx3DGmA/bQ+ZFWpF3iZLcmtDqcuNtMGbxgHtBgflDo2XS5E03U8hK4c43anhORO7e4rJ3S2wQ2swxQf6bruoW0DQCQssNzUE0WnHVDGJAQvAQYvdoyjqCRmSeKWGZxbEodyoy2ZwmPCT8nQDExpGVN8uHACIjFd0i8fc/1tVDlS+m/yiRCDD5PCXn4mzuOB2Z0Fpg8l5NuAETkVEYd/YkU8JwKePhpG9tAqkjzb/8P4v7cUayzfJp0xqmv7RVCMa3uxDY/M5v00QSBzW0G1qBArFwgJRzEcjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(47076005)(186003)(426003)(336012)(16526019)(1076003)(70586007)(36860700001)(26005)(2906002)(7416002)(40460700003)(40480700001)(2616005)(110136005)(316002)(4326008)(478600001)(82310400005)(6666004)(5660300002)(8936002)(41300700001)(70206006)(54906003)(8676002)(36756003)(81166007)(82740400003)(356005)(37363002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:29.6602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ed6df7-a314-4116-779b-08dac23ef5fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe software view of an RCH and RCD is different to VH mode. An
RCD is paired with an RCH and shows up as RCiEP with a parent already
pointing to a PCI bridge (struct pci_host_bridge). In contrast, in VH
mode an PCI Express Endpoint is a PCI type 0 device with a PCI type 1
device as parent (struct pci_dev, most of the time a downstream switch
port, but could also be a root port). The following hierarchy applies
in VH mode:

 CXL memory device, cxl_memdev                               endpoint
 └──PCIe Endpoint (type 0), pci_dev                           |
    └──Downstream Port (type 1), pci_dev (Nth switch)        portN
       └──Upstream Port (type 1), pci_dev (Nth switch)        |
          :                                                   :
          └──Downstream Port (type 1), pci_dev (1st switch)  port1
             └──Upstream Port (type 1), pci_dev (1st switch)  |
                └──Root Port (type 1), pci_dev                |
                   └──PCI host bridge, pci_host_bridge       port0
                      :                                       |
                      :..ACPI0017, acpi_dev                  root

 (There can be zero or any other number of switches in between.)

An iterator through the grandparents takes us to the root port which
is registered as dport to the bridge. The next port an endpoint is
connected to can be determined by using the grandparent of the memory
device as a dport_dev in cxl_mem_find_port().

The same does not work in RCD mode where only an RCiEP is connected to
the host bridge:

 CXL memory device, cxl_memdev                               endpoint
 └──PCIe Endpoint (type 0), pci_dev                           |
    └──PCI host bridge, pci_host_bridge                      port0
       :                                                      |
       :..ACPI0017, acpi_dev                                 root

Here, an endpoint is directly connected to the host bridge without a
type 1 PCI device (root or downstream port) in between. To link the
endpoint to the correct port, the endpoint's PCI device (parent of the
memory device) must be taken as dport_dev arg in cxl_mem_find_port().

Change cxl_mem_find_port() to find an RCH's port.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0431ed860d8e..d10c3580719b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1354,6 +1354,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	return rc;
 }
 
+static inline bool is_cxl_restricted(struct cxl_memdev *cxlmd)
+{
+	struct device *parent = cxlmd->dev.parent;
+	if (!dev_is_pci(parent))
+		return false;
+	return pci_pcie_type(to_pci_dev(parent)) == PCI_EXP_TYPE_RC_END;
+}
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
@@ -1433,9 +1441,39 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
 
+/*
+ * CXL memory device and port hierarchy:
+ *
+ * VH mode:
+ *
+ * CXL memory device, cxl_memdev                               endpoint
+ * └──PCIe Endpoint (type 0), pci_dev                           |
+ *    └──Downstream Port (type 1), pci_dev (Nth switch)        portN
+ *       └──Upstream Port (type 1), pci_dev (Nth switch)        |
+ *          :                                                   :
+ *          └──Downstream Port (type 1), pci_dev (1st switch)  port1
+ *             └──Upstream Port (type 1), pci_dev (1st switch)  |
+ *                └──Root Port (type 1), pci_dev                |
+ *                   └──PCI host bridge, pci_host_bridge       port0
+ *                      :                                       |
+ *                      :..ACPI0017, acpi_dev                  root
+ *
+ * (There can be zero or any other number of switches in between.)
+ *
+ * RCD mode:
+ *
+ * CXL memory device, cxl_memdev                               endpoint
+ * └──PCIe Endpoint (type 0), pci_dev                           |
+ *    └──PCI host bridge, pci_host_bridge                      port0
+ *       :                                                      |
+ *       :..ACPI0017, acpi_dev                                 root
+ */
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport)
 {
+	if (is_cxl_restricted(cxlmd))
+		return find_cxl_port(cxlmd->dev.parent, dport);
+
 	return find_cxl_port(grandparent(&cxlmd->dev), dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
-- 
2.30.2

