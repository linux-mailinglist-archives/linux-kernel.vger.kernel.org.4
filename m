Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB06D41EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjDCK0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjDCK0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:26:16 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C13A9B;
        Mon,  3 Apr 2023 03:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF/EdSnv3ol4bHb5mQITHPA5h8Lsq2msd+5s+jrEwgNZLx5ZiG/pCPkU/D7dA1JbtFaFEtcVO39uvNDVcUReqRtw9S+3NmWlfh4trFj7oi95xhm6h1UMWl4wirxnt9nh4esg16EyrQhtkO7gA8PvBJJkLz+qpwgSYOcjwvp0XcSmW7qcEjf1VcBduJKJlJp+sOJKK8O910Q7L5qfH+iGjaCnm/RFze2rx1ePIayvwg9/Xcufwf7z41379y+tJNN3MAUianP9EpthvsoUnqY+FGq7GGibaL4bu1kOcsRCgUySdkPrAvLOErUYet4T83MFCfFMzdufxKhwmDiIqsXtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvOXNWN7AAAJOOgeO+vNMaPNg7eFCr1Y16DGsXzCR0c=;
 b=c2tF2OaYGL8/H0G9KFaFYn6g07qYdgWCk3U32SkP6lwpOZQZG7pS+nEIRsH0Vc+zK6L03O2LnAN/dm+HxAIcRBgQwX8N3uWRl1W1lAW/O5b5lK1Je1nxGKQ3w6R6QDPJaY+FjeAp/J1iA7ZFemYY/lHl2iUk9wVMsJs2slby4GF+A7eK5CLrpMVpQzCU7jAbC+mSK9kJbLRPgFeJJJ5RrN9AEbfx06P/fWcZJlSiTmIZyrz9EK0VfoARKfk2ZmDh1KlRVQvfA1lwU0UZobtCfMxMQFihfHj3wUAPH/WL7uF59bWV+qZ7+bP59hqJsYYSOXiQ1r4eqL8l4IoTjG4OZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvOXNWN7AAAJOOgeO+vNMaPNg7eFCr1Y16DGsXzCR0c=;
 b=AQweKgB4ZTb35Uoi2BAzqxLWdC+vUh1kOy10G5NY2jwq+9wNDSkaRREfX3UDguaxN/YXCjm7UH4pLEe4Z5FMYr3TJcvUjTqiibKx6Q3wrzW4vWe0HoyMvOrKqumVp/HGH/XMrJmi4PyZwAK7zoRg8xIoPW+fe2iyIETTU3SR5Bk=
Received: from BN9PR03CA0197.namprd03.prod.outlook.com (2603:10b6:408:f9::22)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 10:26:09 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::21) by BN9PR03CA0197.outlook.office365.com
 (2603:10b6:408:f9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 10:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.17 via Frontend Transport; Mon, 3 Apr 2023 10:26:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 05:26:08 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 3 Apr 2023 05:26:05 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v3 0/3] mmc: sdhci-of-arasan: Add eMMC5.1 support for Xilinx Versal Net
Date:   Mon, 3 Apr 2023 15:55:48 +0530
Message-ID: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 664bef3e-e380-49db-0d82-08db342dd765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDlCgGdkkDpTGjIZ2VDUdmubg8Ij5HBDl8JFuSlMWJGDWpC12lV5e6rYNdNOgujqE8Y54h0RoSmdNI6z4COQTJ+Lkd+RPvczADyJ6FOQAKaom9WaumuuUEkDLVc38S7LRqasYpGz4ql8Gs/FjA+DSXS5jR8u0qwo6y7ZVvR8rkCyZfspXEb0hCEobmrMxW94ISR6JuVafy4Rm6MToEJpJXM6pfCJUdi4EZDh86tv9iL8yDN2TiKho7OEBNvoYnTswKV5BBOfBYIY8eafEJR4CvWDTtLA148C88nomLWnAZVshoO4Fdjf8g+NASKPFX9yCt1/R+HVoS2qvXh3wF55MdPMJwFxloPFToEhQ66wumkCxj714I3/UNmsItJQ0GWZWe8MkVLgPlxWMnIa6Jstdfzf9zEbWrMNpAZJzkDgCm1YH9jolpOVkhvm4PDpMq+SCxWwbVDr64WZJmyhLs7XtjPQ374ZHRJshtqJInw68gUwaqQcY2LagNkoAWLem+iu4InKiW4Wr9ve86UZeUe6CyFcZoswKjJlNAqzLbl9a2eZvX64Qoc8d7XESHKBc/W5jJJxLnWCrznh09o41LsPrF8ioUVHR5h+CAqRTqrynuyCO3RO8YCH4m8H4q5KZ6PLPoA89dx6SB8cAH7cdH37KRje2piV3VmKSUZiDMz90Ag5KLNRQ4UhPuTUHdyyC3N1/ne4S/Kwp0sR714PpiQzNwt+4T5YFGfaSs0nd/jdcgw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(86362001)(103116003)(82740400003)(356005)(81166007)(40460700003)(478600001)(7416002)(54906003)(316002)(6666004)(110136005)(70206006)(70586007)(4326008)(4744005)(41300700001)(2906002)(40480700001)(36756003)(186003)(1076003)(26005)(47076005)(8676002)(8936002)(426003)(2616005)(5660300002)(336012)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 10:26:09.4485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664bef3e-e380-49db-0d82-08db342dd765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
X-Spam-Status: No, score=3.8 required=5.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eMMC5.1 support for Xilinx Versal Net platform which has PHY within
the Host Controller space.
Also, add Xilinx Versal Net compatible for eMMC5.1 in DT binding.

changes in v3:
-> Split the 2/2 patch into two, created separate patch(3/3) to skip the
clock delay setting for 400KHz as suggested by Adrian Hunter.

changes in v2:
-> 1/2 - Removed v5.1 from compatible string as suggested by Krzysztof.

Sai Krishna Potthuri (2):
  dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible
  mmc: sdhci-of-arasan: Skip setting clock delay for 400KHz

Swati Agarwal (1):
  mmc: sdhci-of-arasan: Add support for eMMC5.1 on Xilinx Versal Net
    platform

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |   5 +
 drivers/mmc/host/sdhci-of-arasan.c            | 237 +++++++++++++++++-
 2 files changed, 241 insertions(+), 1 deletion(-)

-- 
2.25.1

