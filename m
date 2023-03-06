Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF926AB54A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCFEI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCFEIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:08:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F6A5EF;
        Sun,  5 Mar 2023 20:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKMaxsf8Q59UUUtl9rBTbpF5FgGmdo66RG2s2SKQsoyQuF7wRffBzJYHJh82yWC1Hby0mx+ZwO6xNk/daBSDPMCWYTQzUuaV3qIW8z8Oddm7hkBGQFAEkOV9Q3E0OfnX2n5RGz3OmFlFSe5My5ykrLMilH8XyOx/ql3VRQNThcmv7k+uG/ywXoRdTib1JMto1pGGEBwSvdaX+MlPNli0r/HWoqvs/PjSKIq48Mw5wZPFJUaSPPA1STa0Jden/XX/P2FncL4QGFJn7/4fhhHiIC4AyZIv+QQHm9r9TefWi9t8PYlRqfJrObPCEu4H92yVVd9Q9TZhV/mtTHqiZnCiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl+NRk1lPPWu1qLYsSSP0N9uQlgD1WldvUdBw1ctCec=;
 b=SZSspLUSGk0CByg0n5qjRV4cZsTw4CN+HsWEzJ9cS9/2K/yvbi+AIjIZvyhPOV4/yAeDU3xBLnN+biHuDSxs3ErznJYN78dphlqdDoDpjm5+nCFOuRynbPnOqUuHXtPSG+PKAnXzbrUDJXBthplxXchloDEw4nlcctZOsaHvI88CtATUmiToG6ncQvpLEPSQRHbrI/H1o6squrUxcF6DcGG8vce26DLY7GGbhC7HXO+c00QB21bXAYc3w3nzhw34HhLw0Fqz2Sq6GQfHurWH2keUC7OaU6b7iuXbZ7uBWcCoOulkMMaWS2mEmipIXfxRAroBtFV7F+9Oht4FXIKDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl+NRk1lPPWu1qLYsSSP0N9uQlgD1WldvUdBw1ctCec=;
 b=BjSzIeBAgX03hPpp1CP73q2X7fcpZN6LKqPn0hBcg7Xc7MQX4SPZXUjlv0KijRfyNH0f/ie+40BumW1KFkuK2k/yAJf2i5w2qPNhh0JAU7SNX4DvNgeRMNx0YUcIiUaPxaB3FKqxR2Uj0SL3F2FeRJYLDUfBBn/hawzlpS788QI=
Received: from DS7PR03CA0206.namprd03.prod.outlook.com (2603:10b6:5:3b6::31)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 04:08:12 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::2) by DS7PR03CA0206.outlook.office365.com
 (2603:10b6:5:3b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 04:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Mon, 6 Mar 2023 04:08:12 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:08:06 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 01/15] dt-bindings: arm: add AMD Pensando boards
Date:   Sun, 5 Mar 2023 20:07:25 -0800
Message-ID: <20230306040739.51488-2-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 857c8a72-4a66-479e-4bd3-08db1df86733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnhBXRSGMXvTXFO0Or2AwJGOgvckqSScoalpaYZe6O5KE4o0VWiGPuhT5/tlnf5I+CAYHXH/lveiVAdCBYsBdZPSACirjzoC5zrGdGUrGyi8DtjIBkWSCE4WKkSWwwMgHObQgOL6yjglgjdekYD9ZBEJU2Unk3jiUey8kXVsXbxlvLMr2dgGJCcBudsmonGJbPk4eJCD2OSWGZEvYVLF94Pf8yEpsn7JyZqleA+pcK5XRFNwlq8HME/RatvsHo61uDO/TpqI8ORrxjV7bhBw7ktakdEJSWVRTnW6bJkSIzK+MXazRCcAWxDJqU7pxic44XXUXje6Hbmmda400iKYKAJwOdgGLqNGP2wNPQlhGt9If6rDu3GlUN+/HPkrhvVmUUNxmscHFwWM4nc0oKDl3xD9CtjTO/IvY9B87yH7/ECbbJuE2YJnZTR8+JakN+YpYuHHUfJe8GTacIKhiRik2+lBGyG+vI3GFcx5pA3Q7n5RFExSeDp2GdG0ele93z3pril67ocwlqSz4ilSz84aBhGkHX4Pj6MWEOmwa6ewI7tiNoEim1gkyKGUO3Sy4RQSA6WEdQL8VNCD9qqkjCr408zMtbJZL8ZEJZRjiTSNJuEBpTWe7ztLz6kcccZiWubVVcN7rHR3NgWGlePqDkTQ0tL9nNbfFoNwZW5XvR4COHyVgAjuMHpLCLgAwTNNzNxfrf57+6mEqN410cbHXxj9zTgJQimPbqVR5qI1c+emOcP04Erm0xudqo0GS8bVKadwiqvEV0Svgb3BR9Dv+L+Tgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(16526019)(186003)(81166007)(356005)(8936002)(36860700001)(4326008)(6916009)(8676002)(41300700001)(82740400003)(2906002)(70586007)(5660300002)(70206006)(7406005)(7416002)(426003)(47076005)(478600001)(6666004)(2616005)(1076003)(26005)(336012)(966005)(316002)(54906003)(36756003)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:08:12.2785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857c8a72-4a66-479e-4bd3-08db1df86733
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for AMD Pensando Elba SoC boards.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,pensando.yaml b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
new file mode 100644
index 000000000000..e5c2591834a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,pensando.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Platforms
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Pensando Elba SoC
+        items:
+          - enum:
+              - amd,pensando-elba-ortano
+          - const: amd,pensando-elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

