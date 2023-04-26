Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C246EF45E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbjDZMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbjDZMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:32:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1445FD7;
        Wed, 26 Apr 2023 05:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCj7J26wkxUpqUpB2I9TsI5GmnI5YXUDvBy84hBT53y/7FkTizd+XkFGYxnqZ1rmuyF+94QGbEyPO+vQwaaT10JaNbJ90jxLtV//3kBLl7TDA9vxA6Sc1nNlvcmBJk6W6WOhwMjq3tPQESrGSwFbR3e8pztsqN/P4hTDEbHiKnv0dXzr0Bn+Qd9UzOmfadYAwMIENdY+41LB5bcrZPj/vTXQncbVDtxbh5G1oV68cQSRLkLTjuDvZ5vB31HpRnBUhRE89qWs9ThQkj5seSGvgzHO2ZP0u4mGN4pgtGzNXSzMmHCCitmzW9LgBVqBk6A5+3QQGrONOUnwyFUvv3B0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqJ//Oo+zLDyplCLQQiefn9lJDoAiKyV4HuW7cJ+/h8=;
 b=FjfXXAWBTDu6ILXBiZZt2IbskeVJdnooTWtynopffGuVjaaCaS5xxGIsEPy63Bqw06ZYKMEz8hrbDxx/XE64wfBEm0bQBn/PH2UHtat3sSq5i6EstutOdv3L8VhtvAdRd5eYeswx2ywG76FAYau8OFCKFiHxqML6SKbYK8cvldHZUHgfEPvU/fO3mZihvx2fYmYqTtpqPiRrJXmpt+3PaTwF3orbMuq/5FNMGw3nNN6um1+WzNpPXHVcSuJD8O6V4R4mgg2Pttzu/jP+QavS9Ib2SDSxvDunaltWaVIt5pR7IEH6X0JloqcPcOwRHCziYcmrI3yxe6poTzAqn2hpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqJ//Oo+zLDyplCLQQiefn9lJDoAiKyV4HuW7cJ+/h8=;
 b=gTnaRxGKHoyv1qD4gYilQIo6/x/BaGIRJMQnJVNWrb2imaka/NfgXgl8ZBAovnw9GDKXZeRLE2yCwdow9RE6JAQ2qx8wCZ6nnZr48AZhwus3aG8X3g9OGbTgTEupQcCWaLO/G3YFBdDChtgBnrCJmClv6TUDJJISsgAKpVWZ1Q4=
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by CH0PR02MB7914.namprd02.prod.outlook.com (2603:10b6:610:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 12:31:34 +0000
Received: from DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::3c) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 12:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT054.mail.protection.outlook.com (10.13.5.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 12:31:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 05:31:10 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 05:31:10 -0700
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
Received: from [172.23.64.1] (port=50334 helo=xhdvnc101.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manikanta.guntupalli@xilinx.com>)
        id 1preHc-0004Gj-FL; Wed, 26 Apr 2023 05:30:04 -0700
Received: by xhdvnc101.xilinx.com (Postfix, from userid 90444)
        id 614E021314; Wed, 26 Apr 2023 17:59:51 +0530 (IST)
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
Subject: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps node to support rs485
Date:   Wed, 26 Apr 2023 17:59:46 +0530
Message-ID: <1682512187-8828-2-git-send-email-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT054:EE_|CH0PR02MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 705aef79-bc08-495d-2596-08db46522bc2
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pFc56hf4D8GhtgxyJq9+RYGfcCzTLl91Vt/zkH+3kmN5+Qv8sfIhdU0ifyx6g24MH4IFxY3No5epyhU6Un0ppYjAUaznTHnf+u1qo7jtM9s3HZbSltt0WDcTl8yaSD0zzTeqi6TqqpwmVfJX6jY0mSvQTm+lfffxnK0wX2IbleJX5GPijY15J6uAJ2bFBG8Sjy446kgQNie2lCcsiD2qYtovJlyuty3oJ4zJuCsj40fWIoSN3gYhNN68YKwj1FLiBRg+8asN/hIBLsOFcM8e26FCUv7H0RiIOzfw8C6kpl/CIOGeCMWNjoIWp9TtcDcRa7oPfwlI8+suLF4U2TZ63j8me9/C4k984gd6maGNGeQN910EIoiiy125HKeInSTfOghKBvag2GTi6T2NtKLmNoyNMaafwFJ2JPd0m4rJrxPm2Cg2/RxmS/Z6CoQiuBG1Tpc+ww/QsCTQsJaDVbH00XAV2eO6lBGkdHSiNyexN1DH3uN+AcCELVjEqizDeXVaJb9ju+wgORx9hVPaCVCrraY93qvEtAWf/4zkP/B86rI/BkFHy40jFQ2heVNHyD+0IctCx/9GdRZSTbTMoInE/sfbla7ca6DY/lM531TOAtFHBjgi2DEuCfthm+Z0BDYhTc+rw8giVGpqmtFkMbhtfGwVmmJHwKuSi6IZBEJ89RPOAyiajwIYoXvsI3dsLX5uwZU/8H2nVhXcr3ukt+pnx3H0iv81/n4k3kGqkGAA0Ctgpv+6yUdWIIDi707bT5f
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(6266002)(186003)(26005)(42882007)(921005)(82740400003)(356005)(4326008)(40480700001)(5660300002)(316002)(70206006)(70586007)(6666004)(336012)(47076005)(2616005)(36860700001)(41300700001)(82310400005)(36756003)(110136005)(42186006)(6636002)(83170400001)(40460700003)(54906003)(8676002)(8936002)(2906002)(4744005)(7416002)(44832011)(7636003)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:31:33.7526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705aef79-bc08-495d-2596-08db46522bc2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7914
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional gpio property to uartps node and add reference to rs485.yaml

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index a8b323d7bf94..34ed0d80b923 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -46,6 +46,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  txrx-gpios:
+    description: Optional GPIO to switch transmit and receive modes via pmod.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -55,6 +59,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
   - if:
       properties:
         compatible:
-- 
2.25.1

