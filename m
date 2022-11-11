Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB86251E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKKDtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiKKDtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:49:03 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E142B623;
        Thu, 10 Nov 2022 19:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0dDPjlKZNJ3R3x6Cxbm4VW95izeyEqkHJrJHTgRA87Ks5Au1yAfKpPYUyZotgt0MqJQxNih0N3oxf+FxnleMv2HVj+VRRnPEBiWIOYSEfnLlZ4oBVqMLyaQgaH6jDBca4MJ48JBnyKv9Ej5e1JV27WNJOPqywAvwGl/Xqp5SMLYV+epzdNxOxpbNf1eX5qHN/KYqUkvcBOagT43rGEd7S3iLzTqE7aQEBAMHOPvaWWIPDENY1Ask8a97+eJuBBmoly5R5XhzxEEuilJdvSjS4CdI389AT4yOQMF/eDfAi50rNBJiE6Tvp5m/0I8QQX2UChcqAosRaDjHkoIOw4HLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEvt+xL+IkiHDhbbgRnLZPKRpIjG6/Tbr1Of0fMZCb0=;
 b=BsQJ6Ntx8LqVz7MVlVX2xCQGk3UaHYi/ga+UcCSiyT16HAEal9IlG8+euE9P2cwgkD6w/0ULbZZsWnquuXbIpV8VTYbG/ctJoPU4VHQKxZcWkn2Yn6Z1krOpmy0kgU5tFMgfH2IsZEt7mKh+ZyvFQ/uIs/Z7g2eXgjUOybqnGFnsYL5nUftYq9ehwykiYX9TM3A6MiMAXBF6t8ovrga7Ouu+x5dB+Ll7f4E6lnoXLZEdvlb7VcYZ7C6KCfP76aeVnZ3YR1EtFqvnRQgeVjnbfGqb4a6wKA3ksU3rshBlXoJpHKcTHuvCA+psKSv6RHAhEoRN0Qf9sbq99dJfDQ9XMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEvt+xL+IkiHDhbbgRnLZPKRpIjG6/Tbr1Of0fMZCb0=;
 b=xtKq7iDU8h3k7nyw93b4JD3nv3V/llCfqjEYruj/KMOVytFYP26opEfifNpomc8updcaGjYXx9IS1LzDCA/8F0utwox6jGIQ2zmOSzT9wGxwcW0HKFaLv5XL4EObDKRpM2rwN4eFjnadeBk8TxY1cBM8wHf4Iy3CuUL9PjAwUqpzssMm9R0jcGjIam2sJkhMFCUi079JHTgdsoKjO3XG+OqqM6YWgNH7M9qsG5FaSE4WNNKe/aRs6HC3hSfPWieDgDhtOW0I/RGcZHMXEDxxWmeFKPJIWCKCEmSqnyOYBsXjqPPBV/Zyxp+uu8BU+6UcAtpJ3EjONGcuZhKnSEAo+A==
Received: from TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b5::15)
 by PSBPR04MB4104.apcprd04.prod.outlook.com (2603:1096:301:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 03:48:56 +0000
Received: from TYZAPC01FT041.eop-APC01.prod.protection.outlook.com
 (2603:1096:400:2b5:cafe::8f) by TYCP286CA0060.outlook.office365.com
 (2603:1096:400:2b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Fri, 11 Nov 2022 03:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 TYZAPC01FT041.mail.protection.outlook.com (10.118.152.116) with Microsoft
 SMTP Server id 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022
 03:48:55 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     garnermic@fb.com, Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Facebook Greatlakes board
Date:   Fri, 11 Nov 2022 11:48:25 +0800
Message-Id: <20221111034828.2377-2-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT041:EE_|PSBPR04MB4104:EE_
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e2008e9-1a59-48b0-8b55-08dac397a87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1Y6ExpK1EYY0VhwBMvOXaaBjbj31u8UVGc4esLOPD9aJQL5mXq9OWSIYe9xpIozMFQ/G50WmdrSWeZ41qODp/xEUtRZgG09ZqBytdum9ZSRWgrdjvmTqRUX2XzrbNw4PW2ijrOCcKsNGyRg5wISL4W+S5mTqV7t2ugR8sU3Sfer1RkQgb9sTooYpkaDsU4VBeKYvsmzocHrOOAfEliOJM+SltF8zpd5pidZFbI/gTONtgrYpFUbkIStLgOKrqTmHtGiN/9ymR/1lnxMDkSpZ1Zbwafgrccd8BcADKkck/NU6GEYVLhylDJyd1gaOPkQTr8lsEbP7KE4T/hS8uG/AfG9BePrifiqT/pMbCa1wvgnpSQUOz6Hlz+lUzYmfChZzhrQEs6ymtfOUa6YfYnHmnbQ18B5eeisP8R0X+NY5cHlI8OY4vFOWo8LdVKTCNpJxHx4NXJWZl6NScTIDx8b9wTpszssW6emGzEMuqTVepBs2Yh/rujC9duRYB7oNHnkn8qrUcr4WH0Z4wr7vVfXO/1M8hWTlwuYioEIRA1eqeXLOtAcbLPAAo+YOdK493p0ExxgT0/2YvqJKs68Phog+51fmMfvU0B7qTB7ZDvyJtgH4o89kitsbw1xfsvs7eenfmrJZx/ebuofQipBH0LlQEz5thTj0ejceqR4QqY5KT55um3XZGcL/JexrkRj6Icvg6AAh/upw32KSq+/QN6x0SN0jG6H8qXXs1oEf/Ol7creKqSf16tBmoCmBx6U2kqx
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(376002)(396003)(39860400002)(136003)(346002)(47680400002)(451199015)(46966006)(36840700001)(8936002)(54906003)(478600001)(81166007)(2616005)(5660300002)(7416002)(40480700001)(956004)(86362001)(26005)(8676002)(36756003)(4326008)(6512007)(70206006)(70586007)(36860700001)(356005)(36736006)(36906005)(41300700001)(110136005)(6486002)(316002)(6666004)(82740400003)(336012)(82310400005)(47076005)(2906002)(4744005)(9316004)(1076003)(6506007)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:48:55.5287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2008e9-1a59-48b0-8b55-08dac397a87f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT041.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB4104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Facebook Greatlakes

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 217a1d674863..3e6373aa3841 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -77,6 +77,7 @@ properties:
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
+              - facebook,greatlakes-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.17.1

