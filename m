Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055986EF45A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbjDZMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbjDZMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:31:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180685BB5;
        Wed, 26 Apr 2023 05:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeDM2t4r+T8+jPj4ekBDy/IIYzAGugVBy6mj7EC/T+LgNiZYdO45KKKwUXHZ4Rmajk47/NtlCu8OZ6RR42+SAm1Csja2b6VM7boNwo8JFoLoHQ2dvesukchyI6PW3msvGtdPonYQkFLnUozvIlpkDd+ekr8Lu5u1UJn5uip4o4r8y2FF02YAvLxBQu5Ox5/TBQQZ277wI8x8cVyJA+uRQYIYc8I5DltM1up3p0fsBnR+vNvHmgFrjI+JWGW/38SUWfjWdmtJp5PSuxuiHNSd0ThdZNsHIFfimkzQIhaa6+tcboNOlVtgBPMXmKYm3m0JbIZ2oUqu9IlDutGx1o4HQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0aJPY2JvI6LZfG3pQ7pHhB/iR3/5XgZI9O/Rn3tVS0=;
 b=Eln0mnXAox4bg3tP/KCqUzDjA+qRQrc+DbJ/yKtTnp7HHwO0b9jnc67druDGOrTJ2o8cTktcNqNnGGzx/H4jtE874UasL+UnYXbl6RSfL+PItE5tNWKpY9IW9HJgxmwfuNZ5pARnBiWKai4AxwNIIEOYO6yER5HwoLr+GG+ZJIjLtclm9k0MonlsnPc7Xsml563i0w4AAvLpMptTIyKFMXzznqZFDzm4APE9KVNzvNHPbVsM+gDa7jWJKAq4kxP+Q94chSp5v8jMMeo2QQBFgnXnAYPd291nImo/qUDSmPSDiJhmPWo2UQOLBTorqtggL/gBcZk369WDtu0jBaARXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0aJPY2JvI6LZfG3pQ7pHhB/iR3/5XgZI9O/Rn3tVS0=;
 b=Qf5reyJeui/KXGRQUQu1V8VcOY2mWo/uchT8OZ96ReIFOuVDPQrM+05AgWNyJTr1A8Az+JUHFzDVKXR10/ZfS44eLuyehPt0/mgpP3vm1rIjt+tcsWtrvEns4NYV0ngVaG1buRLTI4FwJ5a4x/ijDNVRG3/wf7L4EuRh548aOeY=
Received: from BN0PR04CA0208.namprd04.prod.outlook.com (2603:10b6:408:e9::33)
 by SJ0PR02MB7325.namprd02.prod.outlook.com (2603:10b6:a03:294::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Wed, 26 Apr
 2023 12:31:26 +0000
Received: from BN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::2a) by BN0PR04CA0208.outlook.office365.com
 (2603:10b6:408:e9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 12:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT062.mail.protection.outlook.com (10.13.2.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 12:31:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 05:31:22 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 05:31:22 -0700
Envelope-to: git@amd.com,
 manikanta.guntupalli@amd.com,
 michal.simek@amd.com,
 radhey.shyam.pandey@amd.com,
 shubhrajyoti.datta@amd.com,
 srinivas.goud@amd.com,
 manion05gk@gmail.com,
 jirislaby@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Received: from [172.23.64.1] (port=50332 helo=xhdvnc101.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manikanta.guntupalli@xilinx.com>)
        id 1preHO-00048P-Q7; Wed, 26 Apr 2023 05:29:51 -0700
Received: by xhdvnc101.xilinx.com (Postfix, from userid 90444)
        id F02F721314; Wed, 26 Apr 2023 17:59:49 +0530 (IST)
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>
CC:     <git@amd.com>, <radhey.shyam.pandey@amd.com>,
        <shubhrajyoti.datta@amd.com>, <srinivas.goud@amd.com>,
        <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH 0/2] Add rs485 support to uartps driver
Date:   Wed, 26 Apr 2023 17:59:45 +0530
Message-ID: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1NAM02FT062:EE_|SJ0PR02MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a00efd-b192-4b3e-8fab-08db46522745
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXNNtqEbBYoFhGrixd09nl3CH1Q9G+23z8Dz/ZEBHfgmj3v/F0HOgwgcptLRpJbbs6qRs17DoitjaLcSX7hDJENBpJyYD/j0C7lJmWWiczQxZFxi68qGAiKauUq/zAzgq+3FDDil6mkS0wrABjBOs9SzhPuBpZAPI3BOsfknrg1Eg/Z9C8Fv6GEch1q/qXgnYYld408Ix2IkGYaX+mgwuo2HBkHwfR9ympIAk0n/NJgXyjy0wSqfLatE700r0NUJwUeG4Iwxu9pPS9MxFry9oYr471LXkdpP1DJlIQmBjC0gc6f43KaTgscA/tBJ0IC4nSSTy3Fwe2zUBRMcSTOqWXTJvsi0cnPqQMMYUwAOP8Nio+EAlsygwEkvt6w1BwtHNfCLhiWH3TxfkMyj1m/6KZvsDhfKClxH6alqsGK438aYUrjlyGzv2Q/FNaLEiJmomtEi/jrbPZpZpNgKegbST/mIsG5XdVHEfTMYlM/8N/7N644bu1Zu8flm07mN9Uwybiwf8pskS4k70vtIwW/kg/U9N3aTYLodTBkQIeoJ/XlrfmzcMBsvXBbmQlP2U4k9BaD4F/GoBXKRFqLHgx1Fw4PO0ADYU92JlI7vYe6pB5o1cVGBw76SOe/h3AGdUpA033yXje7JzDtQI0ZLzBrqZDMw+C9ZP1j6/jMxfisM7eZv9NqTtHa6XKnsRO+SUdVlWyeg/hAd5EEFy0lu+qEYcv39/NIZnzS4My8WWRilKCAQLkFV1jJDl4zT3NTMevaB
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(83170400001)(42186006)(54906003)(110136005)(6636002)(36756003)(6266002)(186003)(26005)(82310400005)(40480700001)(6666004)(316002)(82740400003)(83380400001)(4326008)(44832011)(70586007)(70206006)(36860700001)(2906002)(4744005)(7636003)(356005)(41300700001)(8676002)(336012)(42882007)(921005)(5660300002)(8936002)(47076005)(7416002)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:31:26.1783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a00efd-b192-4b3e-8fab-08db46522745
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7325
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional gpio property to uartps node to support rs485
Add rs485 support to uartps driver

Manikanta Guntupalli (2):
  dt-bindings: Add optional gpio property to uartps node to support
    rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |  5 +
 drivers/tty/serial/xilinx_uartps.c            | 96 ++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

-- 
2.25.1

