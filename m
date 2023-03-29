Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59FC6CD4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjC2IdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjC2IdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:33:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2089.outbound.protection.outlook.com [40.107.117.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C20A49D7;
        Wed, 29 Mar 2023 01:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I49OsG1MMpGGvmglFm9TLE9W0OEypRc9mjXzGZMmfvaEtRQ4AOjU1TqAhih/KqN8iSTaMLIHbpEBDZq4Y0b2u/F2g575+tYaVsI2w6TphO5u6Amg40hH2aapMqePs+M9B0cJj7riJGDDVimbP73fK5UlSxHcaW3HRS1jtGEjenDaOQbG254BLGt2fWSzLGa3raSczQnCJMg0G5W/eR/oG2K9zL700h4DOdhJGgUEuLi1pTREG9a5YBC0rd8ls9yK6ofQqdvb+J7WrFVrSPIOKQjz1E9jHoh/zi3loaI2JpW8965ny+Shu3KCKKDgN3EDx9/MJuFD6ubwN/OlT6QQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsPEQSyrn2byAuiypyjtnD7TvWKRF0djVli5CpfHsl4=;
 b=a6FMuhWi/olubJnYFBCJxy7GWH3XhGSKK+QadyjZE+at3CDpjjxHgslnhhloAV/kvqZ1J1oNArL3KUCRdfOZw3UduLOPwV0fberb5+uEwshCx1np9UTwdvUyrO70cNkF3pnxE8oXL2Wn5s2bmUr3BiMoVAroYoIaESkDI47YFvDjx2V33Ic+6La+vao2K5LLOq0/y7fXUPX5406vv9oUY43/sqdVQxELAutTk6aZde8Gzv542JWvpGnRopHAWx8J6j0BUhOu8e+ZWhQPrn8kt+JjTk1rqwsg4kBANY3ge2tkX0ASPoGLwdkFXKxhgkm6W8Azq0XdGIUafnq6poJCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsPEQSyrn2byAuiypyjtnD7TvWKRF0djVli5CpfHsl4=;
 b=ruGpHr5KYRJLHaZRPUP6m35a7x15iPke3Lak7hDO5jH/ucSK2o8GzvpzAjUKnmUZJGXgfG0jAXuGVz7lmanv24jJJXJBruQ1bYBM8tgDYwHg8/npN9/Rr2YUlSbSKiKGZlltZ5s+lAmgyNlAmSUdJjo3mX8qe/6hqOO+mG5nFOvaasEyL0NMAJqvWUCkHUFzhrwsP3utFoA40x0LvmSFr1jKca37YnWcR8L565Zwyke6+oRlfEEM4oi3NWm9ilbAILqywgOayle+DZT1lP5duA6FnnRL+WjNeeyTfNoNt1SoA70Rm8aFVh3oyM2hWQUJJbjtrk+uf8IpShdzY6DT5Q==
Received: from TYCPR01CA0089.jpnprd01.prod.outlook.com (2603:1096:405:3::29)
 by SG2PR04MB5746.apcprd04.prod.outlook.com (2603:1096:4:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 08:32:56 +0000
Received: from TYZAPC01FT042.eop-APC01.prod.protection.outlook.com
 (2603:1096:405:3:cafe::d7) by TYCPR01CA0089.outlook.office365.com
 (2603:1096:405:3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.19 via Frontend
 Transport; Wed, 29 Mar 2023 08:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 TYZAPC01FT042.mail.protection.outlook.com (10.118.152.183) with Microsoft
 SMTP Server id 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023
 08:32:55 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
Date:   Wed, 29 Mar 2023 16:32:34 +0800
Message-Id: <20230329083235.24123-2-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT042:EE_|SG2PR04MB5746:EE_
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fca7c4e1-8092-49b8-a18f-08db30303234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jp3C0WFcnETiA5nzNz8My3ch1nkY/NZ8chIwlIjYY0FQ+/Ier51lopBLsdJ4GMXvKJZdv1RRdP0IgtaZux7ibNmOcgv3jOmLq2TXHGlTg83N/VzM+cKk/yR7G7z5qAUi+mjS/ftVkTdVa/MBLRiB4yWRw1mtmv7D49HLZbQHjqLbUyB8aWaOWaKaa/eCenoplMXU7u5CVwviZlTRRBSPw4jfmsHxFQIFIIEtVIJnFplggePj9+4zJV4lH8byz028VTzp5UvbFtWLG8F4hRkal6LI70LN2Gp4FoA7lhOpHaKrMxqLjfqtiBgrCT/hGXEKdMo+AoRQpC6CIiTch69CzhEyt52Po1emPFPwxatH2JKdTugmbMxW/n5PMmapSLdT+MyIui8LYlANTMvKe9e5bvZGJFwvt38PFZFk1hIt4P5jhyyVC5ZB2Hx4AbCl9KzS0hqU77NG5TH0bgeBETagM2qTuVYsRFNFn5u4/0jMyp3Dwe/NmWYqGeOgqC/M+kX3RyXwSxT+gcG9faFOmiBvLnUK2664odDad+vkMh4Wz5PCVrJXBBZ3bKBA8GpvLxY6B8obiZdFGVzC/85nMP+Jdq/+28xT/IDrdByvRmNU9q3d5Zg7wLBDXOMcrOGQrkzmfsAu750A53g462dBSzzx9FIshJpTpdfovJNuFsfApfo=
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(9316004)(36756003)(82310400005)(40480700001)(478600001)(70206006)(70586007)(4326008)(8676002)(36736006)(110136005)(316002)(36860700001)(6506007)(26005)(1076003)(186003)(6512007)(336012)(2616005)(956004)(47076005)(6486002)(6666004)(86362001)(82740400003)(81166007)(356005)(5660300002)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 08:32:55.7868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca7c4e1-8092-49b8-a18f-08db30303234
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT042.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5746
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,WEIRD_QUOTING autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Add GPIO names for SOC lines.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed-bmc-facebook-greatlakes.dts    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
index 8c05bd56ce1e..59819115c39d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
@@ -238,4 +238,53 @@
 &gpio0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/ "","","","","","","","",
+	/*B0-B7*/ "power-bmc-nic","presence-ocp-debug",
+		  "power-bmc-slot1","power-bmc-slot2",
+		  "power-bmc-slot3","power-bmc-slot4","","",
+	/*C0-C7*/ "presence-ocp-nic","","","reset-cause-nic-primary",
+		  "reset-cause-nic-secondary","","","",
+	/*D0-D7*/ "","","","","","","","",
+	/*E0-E7*/ "","","","","","","","",
+	/*F0-F7*/ "slot1-bmc-reset-button","slot2-bmc-reset-button",
+		  "slot3-bmc-reset-button","slot4-bmc-reset-button",
+		  "","","","presence-emmc",
+	/*G0-G7*/ "","","","","","","","",
+	/*H0-H7*/ "","","","",
+		  "presence-mb-slot1","presence-mb-slot2",
+		  "presence-mb-slot3","presence-mb-slot4",
+	/*I0-I7*/ "","","","","","","bb-bmc-button","",
+	/*J0-J7*/ "","","","","","","","",
+	/*K0-K7*/ "","","","","","","","",
+	/*L0-L7*/ "","","","","","","","",
+	/*M0-M7*/ "","power-nic-bmc-enable","","usb-bmc-enable","","reset-cause-usb-hub","","",
+	/*N0-N7*/ "","","","","bmc-ready","","","",
+	/*O0-O7*/ "","","","","","","fan0-bmc-cpld-enable","fan1-bmc-cpld-enable",
+	/*P0-P7*/ "fan2-bmc-cpld-enable","fan3-bmc-cpld-enable",
+		  "reset-cause-pcie-slot1","reset-cause-pcie-slot2",
+		  "reset-cause-pcie-slot3","reset-cause-pcie-slot4","","",
+	/*Q0-Q7*/ "","","","","","","","",
+	/*R0-R7*/ "","","","","","","","",
+	/*S0-S7*/ "","","power-p5v-usb","presence-bmc-tpm","","","","",
+	/*T0-T7*/ "","","","","","","","",
+	/*U0-U7*/ "","","","","","","","GND",
+	/*V0-V7*/ "bmc-slot1-ac-button","bmc-slot2-ac-button",
+		  "bmc-slot3-ac-button","bmc-slot4-ac-button",
+		  "","","","",
+	/*W0-W7*/ "","","","","","","","",
+	/*X0-X7*/ "","","","","","","","",
+	/*Y0-Y7*/ "","","","reset-cause-emmc","","","","",
+	/*Z0-Z7*/ "","","","","","","","";
+};
+
+&gpio1 {
+	status = "okay";
+	gpio-line-names =
+	/*18A0-18A7*/ "","","","","","","","",
+	/*18B0-18B7*/ "","","","","","","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","","","","","","";
 };
-- 
2.17.1

