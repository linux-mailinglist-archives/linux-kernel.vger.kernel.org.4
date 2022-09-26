Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD39E5E9980
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiIZGdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiIZGdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:33:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969982DA85;
        Sun, 25 Sep 2022 23:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/rFnyyNJdM3r1k7tvunSSBl5Nc5tiBuv8Hnd8STq0jnxpAG43z3kkKTsL/UtcsC5YxBZrRBMtxJBD+jFpFXCw5RdD5XoN+yaq04cd5rNbHU/FBh38i6pLdxXfo9iK6P7AlGSakzgm+IJ36ldkAVWi7rWX8ofP4GIQzAYRr4RrsmbZbl5DuHApSb24wMib8yrLy99wJC6jvc6YUcDgcbur1NRYugo+Ayt17ow5IPokHvyiRV9WlZWV9KFpXgum+0HZ+ejOzB2e3+1N08+t7Nqpdl9IcOdCKb+9d0uE57kY8HEt1Hu37eCk2GgeDG1uCe7croq+sO4JWp5xG58oI0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHeXuBdX55L21DquBd5Ez8HX19IrR2W9feaA4h/75Fg=;
 b=Wg39Iw72AvUyTdudn2vUe5rx/kiAVuKbcufqu7HkliumWSwSuY0Chs3dEs8YT+vn68geNLfwOPbLnaJiEAFQ/JQP0DJOdvvUDB5DeOtrlhiyL8GlPnRNPXauWiTPBbFKCV6RqNVmsuxd74PKnJWrIkBVYPTCA2yPpxksjFAu7BjPv6vQ+SHAQ/0oUYdLIhSybIZTQVZeBRGYKq8NCkoA4CxQ5uhc9MBjl9RuU85YMDtYTQ7iMVP8FPXKcqpC4pFYY6h6b7GM8FMu/4xMpHWfbKcBsKF9Zy/roWtZGs3HMBmrcC/mLt7dVCHadO5eY4cDr3qE7DPhu1bH7jAz47TRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHeXuBdX55L21DquBd5Ez8HX19IrR2W9feaA4h/75Fg=;
 b=U+wb0wGpENpQTpGcAn0pg0/sT6lKP2bVRIGLnsLY6FqrmyERYshAwgMHQ8KMGtOBVIHrHS+kSJQZ1hMgvyRspNfcCvIjcBzF6znSS6KtFjJox9RDUDUFnMVt3qh0AvBCmADhO6DDIcGJGzKnKwD/6OZDWcyoyzK9v75NXBfS0lI=
Received: from SA0PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:d3::13)
 by MN2PR02MB7104.namprd02.prod.outlook.com (2603:10b6:208:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:33:34 +0000
Received: from SN1NAM02FT0026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::d) by SA0PR11CA0008.outlook.office365.com
 (2603:10b6:806:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 06:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0026.mail.protection.outlook.com (10.97.5.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 06:33:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 25 Sep 2022 23:33:33 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 23:33:33 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com
Received: from [10.140.6.18] (port=46254 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ochgK-000GAg-K2; Sun, 25 Sep 2022 23:33:33 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH v3 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
Date:   Mon, 26 Sep 2022 12:03:20 +0530
Message-ID: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0026:EE_|MN2PR02MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 281ecca7-59e2-475a-ecc2-08da9f89090a
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSXL3vCWg2LdrEBU2zlLjgBJ+R8Mb11oMQgxE8F/Q6yo3JS1dStYWMXEDAW7n+ktQQ6IJJ3pzMn8TSGT0WtYl59JSbz3Q6iHAcaYk9VK4AHsRrpVXRXHVn+rX/RINxnoU77M3Dq0tzTlb4Dr5KdtXeLuSddLz24FawimaX2dWOBy+KytMH7DoJ4ar0WraGVogrVN5s7Z8edTRSSzcF011xdBed/cNg/GUR/32lbNHMxwBHMJiGcutaefDwvgfjvwwOUF/s70csazUW5Q1XhfQK1P8A9TB1TQZPl2F7qm1VdVaWYAl2jcWyCw/Vh60r6QVnsai7bIahkU+kB14lynkXHjVQskRU6voAdskyTXAJzpVMyPzPlDx+Vmb0u63040Cy7eEeweFYLvEK7BqjDuYXjZ3fUSUdiknXOW+N1CMy6ZMnrBgZw09xlgI/CS6hTRuYkSLVICqkiobMx8o+H0fXXOvcBkvuV7oJDU+VG1E/aqi/ssWRH/hGycVcp1SO8peb0rntf34sUnEQqNC9tyZ2XyFFo3jGFmNNsD42ZjqXQeb0N3UyiGqBnhJjvIjV9QzBJwYVs1RdO9N9+ptPEekz2qS7L/N9ruLgtxXulql9dFqZKYH8dJmYwNHNAWhcf8VMPSjtMEUbI6Pw700cO6fWyNAGZBRSw7fZLtbfXKIdITINZUfAeM5T0i/vYQFjijUg3VYKRKBxDqVO4V+rboF9YzFDr2mlfqAnTKelA9jOSiZJBbCO8OHXKqTQ04Ww1yBIfo6kS9rwrC64U0SCXpHeDf9z33mw1H7BBpW6+KdbQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(2906002)(82740400003)(6666004)(107886003)(54906003)(7696005)(110136005)(9786002)(316002)(41300700001)(8936002)(7416002)(8676002)(40460700003)(4326008)(40480700001)(70206006)(70586007)(7636003)(356005)(36756003)(82310400005)(478600001)(26005)(5660300002)(83380400001)(336012)(426003)(1076003)(2616005)(47076005)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:33:33.6455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281ecca7-59e2-475a-ecc2-08da9f89090a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7104
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix kernel-doc warnings in GQSPI driver.
- Avoid setting CPOL, CPHA & baud rate multiple times.
- Add Versal platform support in GQSPI driver.
- Add tap delay support in GQSPI driver.
---
BRANCH: mtd/next

changes in v2:
 - Used of_device_get_match_data( ) API to retrive match->data.
 - Removed oneOf and used only enum.

changes in v3:
 - Arrange compatible string in alphabetical order.
--
Amit Kumar Mahapatra (5):
  spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
  spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
  spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same
    SPI frequency
  dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
  spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on
    Versal platform

Naga Sureshkumar Relli (1):
  spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI
    Controller

Rajan Vaja (1):
  firmware: xilinx: Add qspi firmware interface

 .../bindings/spi/spi-zynqmp-qspi.yaml         |   4 +-
 drivers/firmware/xilinx/zynqmp.c              |   7 +
 drivers/spi/spi-zynqmp-gqspi.c                | 191 ++++++++++++++----
 include/linux/firmware/xlnx-zynqmp.h          |  19 ++
 4 files changed, 184 insertions(+), 37 deletions(-)

-- 
2.17.1

