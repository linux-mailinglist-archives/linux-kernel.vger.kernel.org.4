Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52B26CD8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC2Lqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjC2Lqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:46:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1514C9E;
        Wed, 29 Mar 2023 04:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN/0AZWk2bosdGtYIw8hTMVJZxdwQ0RMjR5slMdqewJ8wJdqt/9tgi6WIL8Vjafv4wTKikhTCyt83x8toCD3JE+5aW+6D3KSCjGBAmXID5IP4xdNWS3kftJTpoC2EOtvoaiIWa4Zy9u9+evjknK7oEDnCu+lZsaMK6oT+sKh7196BJ/PZCrKHg9h1oADytu7y8eMHAci1SGrI0y+umqnEUeAB40slLoJ+l48TtJBqcSF7sEn4b+FTOP0cNoBk1719JMWqEOt/AXm5M9UIKuEhRE0Ov3Ytyt6Lir3shwWOjyBWgXkYGccGrpo8Rqup9b65QPEsFq5zPZrVK5VTamA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFAPRwD99yZ3ccP8nd3AzywhPzCtYl9dDkV/ELgX688=;
 b=a8eHbU6b67TBU2qM7n6Zwh+hx1TBfHWMD09YH16r2hJYK8iiGhsvK9VdNT6s0asljSy/uqDcKvBEkPZj7p9JWVMtwz+qdq19UZl3fGPPm1/Fwh8DMowLSbG+OcVJvv82u9vXoV3fXimWE5HxlgkURURW6xQIf+hhZZJfklJrY3Z5eZmynqZ/wbmH1zuRdgS1VKDsgPbgf6Jso4AYcvh7EuS6rpbNON4MD8xi+p3sKAHJRoaG0QfVrh0yGKVlUmf8koiOXWTbMtcePRREYD7HK8v4+U7ugiAEZB2qwB8XOLgrXVSIcn5y3joD1aReyqyDFlmy3r26nvA8Fh89znmPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFAPRwD99yZ3ccP8nd3AzywhPzCtYl9dDkV/ELgX688=;
 b=iKTIs3NPSeiqcaLNRIXfKahjiynAVdwGQQqVSvV2y9g+BvMvJ9LklXTRoU1+cxPlMOPSjC1NtXNCcX19oZwCew8fk5y4W4M61TSoreei6YK5gq02z9FWBiAyWRUMBaN6t64tSAdyanmj/eKDZhelxzs0BmTeB9TmiA1TIjLDq9Q=
Received: from BN9PR03CA0743.namprd03.prod.outlook.com (2603:10b6:408:110::28)
 by BY5PR02MB6517.namprd02.prod.outlook.com (2603:10b6:a03:1dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 11:46:35 +0000
Received: from BN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::a3) by BN9PR03CA0743.outlook.office365.com
 (2603:10b6:408:110::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40 via Frontend
 Transport; Wed, 29 Mar 2023 11:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT017.mail.protection.outlook.com (10.13.2.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 11:46:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 29 Mar 2023 04:46:32 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 29 Mar 2023 04:46:32 -0700
Envelope-to: git@amd.com,
 srinivas.goud@amd.com,
 gcnu.goud@gmail.com,
 broonie@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.64.2] (port=58552 helo=xhdvnc102.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.goud@xilinx.com>)
        id 1phUG8-000CA1-5X; Wed, 29 Mar 2023 04:46:32 -0700
Received: by xhdvnc102.xilinx.com (Postfix, from userid 10378)
        id 4A755104552; Wed, 29 Mar 2023 17:16:31 +0530 (IST)
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH 0/2] spi: spi-cadence: Add Slave mode support
Date:   Wed, 29 Mar 2023 17:16:22 +0530
Message-ID: <1680090384-25769-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1NAM02FT017:EE_|BY5PR02MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 84826c95-a09b-4f99-11cd-08db304b3f7d
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hf7TgzEf1yBEhJMN2yzrpWfQNb26ZOWks6iDErLqGpH9g13U3/bGZoCGRp5arZuG9jLb+lmuEwjsi/mXocvoa1EPICJFMdpxdWchEJMv92GjO/PkgQj38VbeF158znXXiK34yGOUouqEI1rkQXDAqw2Q5te4xjEQA4YoR1wbz3M4h3dfOnDPpxX+Vnn9CsF1DP48cMzvcxfliuYdLumnKx4ZrdjBm4QHZCh9453eiyxMghda+GSm3OT1p2XMmnlol90hiV7dH79l6WOe8gFrbxFr0gppbqp+BNGiTN7V3oYTE2cUNhlwIj2UvaNxURxhRIu2WzlUia9TKyVu8Ei4pm60iVcKNMNxgCRShvan6avDq9j+c91IUEni79Y6Kfy5KtxpbJFo7sYJcl7J6jnYx0VsPQWvQ4avOQvGuWOo0zR06MAfrkJKwulZFomFHEFZZE29vB3ME+/yOxVjIW7j7KlZ9MZUoxM+eIg/CP2QRdrHAQAZX+3qoLEqt0XLmW3Ceqb1LTj3WZcTAVALrfnJpZn9B7p4isi78PnGzuqdxpbJTaAGYCXA9WkvwIfYqesiLv6RxReOkWkNXPbhrhCNps+osO419od4GMVelh1pSRCvfH871DB0feRkaintuTCwbyhuaMC0sb1C0CnqA8WD3JQ6NHuTBfZZHLjPsJDF41qNdjbpjjSV+GsY7X5jdexp+89NIUQKdo72T7WwJIQHbcYo9T+YUjyMNUPW9Kxnso=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(356005)(82740400003)(6666004)(7636003)(26005)(336012)(2616005)(47076005)(36860700001)(42882007)(186003)(6266002)(4744005)(5660300002)(8936002)(2906002)(44832011)(40460700003)(36756003)(54906003)(478600001)(82310400005)(42186006)(316002)(83170400001)(41300700001)(4326008)(70206006)(70586007)(8676002)(6916009)(83380400001)(40480700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 11:46:34.7336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84826c95-a09b-4f99-11cd-08db304b3f7d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6517
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spi_master structure with spi_controller structure.

Currently SPI Cadence controller works in Master mode only.
Update driver to support Slave mode and also Full duplex transfer 
support in Slave mode.



Srinivas Goud (2):
  spi: spi-cadence: Switch to spi_controller structure
  spi: spi-cadence: Add support for Slave mode

 drivers/spi/spi-cadence.c | 324 +++++++++++++++++++++++++++++-----------------
 1 file changed, 203 insertions(+), 121 deletions(-)

-- 
2.1.1

