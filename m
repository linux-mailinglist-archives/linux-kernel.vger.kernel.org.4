Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52DD6C7DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCXMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCXMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:24:58 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021022116
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIW2NyLUGjIQMhVe/jlHjrax1frP9fwhSFHmvjX56TfJNCVJim2/p3Kcbk86H6m/sCvtrrm3aZ0w+meEWas3EQGDl1qUWO6eNCf8pjRtaIOu/e7H/JaZ18F0ptODIr/hV8c8nzRaiwirYUEn5ZA4xuW//uzmEz9Mhdiw7x343U/Yy2Wa1cbG0wFusM61aezUoL6YO8S5BKqGs8BKkJcbHOc4HIWPgVVhC6gzfjQLd38cLYWmE4QK/qALuT/ctJ/PW1dvGZSPVZfcBzGelt+ZcdMTDzUuAUk0qaEWvpm2s2F4BD7Q7uBmM2oJh1gsyCM7ri+Hdlxb94LxTRwOPyPyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrklw00+Zs69l5D6Gy/mRxDKEUobNt1PSN+cbHQIb68=;
 b=N0U6ExXETOwGEJ7pR450KxDR1Lq4+SBEnPweXFK/y35hQuDHA5HkBTwtFCsHACoEGCjSNuz69MP3qUqCJyI2apyDdf5y6kgQ0KzsVpRrvzqv0WLmNB3wjTBfa9iVq30ukpMYwu9iIIs55NJCLVEGvRUUiXa0uPFGGRUK9BB18GunceruwO2h74WonwcEPkZt8mARtKfaYqyrqH2r1ArcRNTjhhxffLJAOAAVai6QbozA/vVAPQ6pmKZDe8Fa1fLlQGrTp7NZVhk2JDA+FB56DaaudaLxdrzlXKEnegjI8veobMn9l9F4SMzSi9BW2An0aywJHwsVS8n3sdYiX0nR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrklw00+Zs69l5D6Gy/mRxDKEUobNt1PSN+cbHQIb68=;
 b=Ka0+UUreaojAbM8xdyPpR5Wj5wWMMYp8bhmgKFZ27BO/PLYUngPzPMXshXYBJCytYbwXdF6yvcbGkoDUSLmuneUnJ8Q04qyhdSjW9u9HU4NMoJXt1tansU7j8+lSsG63fTzvLEr7iEarBIdIewLOiZmA+3b1yAJtKcFGohp+PnE=
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by MW6PR02MB9814.namprd02.prod.outlook.com (2603:10b6:303:240::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 12:24:46 +0000
Received: from BN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::a1) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 12:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT036.mail.protection.outlook.com (10.13.2.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 12:24:46 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Mar 2023 05:24:44 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 24 Mar 2023 05:24:44 -0700
Envelope-to: git@amd.com,
 radhey.shyam.pandey@amd.com,
 laurent.pinchart@ideasonboard.com,
 kishon@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.2] (port=36899 helo=xhdvnc102.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1pfgTL-000FmK-VF; Fri, 24 Mar 2023 05:24:44 -0700
Received: by xhdvnc102.xilinx.com (Postfix, from userid 13245)
        id 2928F1045C1; Fri, 24 Mar 2023 17:54:43 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] phy: xilinx: phy-zynqmp: mention SGMII as supported protocol
Date:   Fri, 24 Mar 2023 17:54:39 +0530
Message-ID: <1679660679-10409-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1NAM02FT036:EE_|MW6PR02MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe6467e-6632-4f58-6212-08db2c62c13a
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eF8RqhONaUZEf2h2PbvjRO6NQib0nuk/7JzWyFbWSlCYmOZs62IaqQi+JL5XAdsTRc/+LNByh6cxtIIEfO47aWsH6TTJeODTMd2Fg1ow/p0NRu4i/SJMtQe73HXN+tcf0020RqF+m7O4o30XD3kLikrJu0m8JHUqx5vC2N6QQitvFxHlhm3nNdZnDNbA/zNBuNb5pAb+HJPt4ZT0s1qDExIktbODuOgoFa5BB8FeRIBcKdHMH1SlWnolCZH4cBRH/e85T57jBXLLVu/w+Ar2jw+meM3qT/WLZEDfTDTQlS6McnN5zI369LyrBWI4JNtd3pLtzvUkPGsuaFQyvuqMwsN194sITKOqoraM7qK+eicXn6VINq0Gx/yZPlCaftfzyBx67LPu2TYafhZGUrmhJszVdnlu9WOW2PQuilYQ5vlBtVeE/uKk+aF09sb/qI9hx6cBpnmvmKWpgzNVWVyJkIRQ0AOhOLt2DO1bVeMdiuz1e9zx1N3MsW1piYquEyK6d/EyFkjYs3pilL63r1rwuv0hdkkFJma8hTysXvdYWq8wQwwKSStxh/JIHERyk2RDPlXAYeBljkGhjdkxtVCoyIRZ86jFTRUqnNZhdYX16XyCypQCknxtk1C5mZI1+ngvA95T212pelr8nPcUqZweTUBv785nYXglc8ukqWiOWsnunV5KPG2x4PX1GMSJuLl4dREG6tIvimDyYMXmQC1XeWqJU8EaDjse8tU0gwpKjYw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(39860400002)(396003)(451199018)(46966006)(36840700001)(40470700004)(83170400001)(40480700001)(356005)(2906002)(40460700003)(36756003)(83380400001)(2616005)(336012)(186003)(42882007)(6266002)(478600001)(82310400005)(110136005)(36860700001)(70586007)(8676002)(4326008)(4744005)(70206006)(54906003)(47076005)(8936002)(42186006)(6666004)(26005)(316002)(41300700001)(5660300002)(82740400003)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 12:24:46.1897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe6467e-6632-4f58-6212-08db2c62c13a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9814
X-Spam-Status: No, score=1.8 required=5.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGMII is validated on kria KR260 robotics starter kit. So modify the
comment description to include it in supported controllers list.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 9be9535ad7ab..ebe5ba730234 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -8,9 +8,9 @@
  * Author: Subbaraya Sundeep <sundeep.lkml@gmail.com>
  * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
  *
- * This driver is tested for USB, SATA and Display Port currently.
- * Other controllers PCIe and SGMII should also work but that is
- * experimental as of now.
+ * This driver is tested for USB, SGMII, SATA and Display Port currently.
+ * Other controller i.e PCIe should also work but that is experimental
+ * as of now.
  */
 
 #include <linux/clk.h>
-- 
2.25.1

