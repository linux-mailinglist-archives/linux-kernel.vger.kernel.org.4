Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA66CD4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjC2IdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjC2IdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:33:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2A3172B;
        Wed, 29 Mar 2023 01:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqkQHNxijfyrL5qgBOUM89NheDNa6u0U8k+kvubSsyjWPzb43Cgnn9ZlNMRF09TEr/hHfAE8Jd0JhQQQ4bAzm43yzyo6ho7mh6AH0aUJlZ7nqMJS9m8ACsKbTvmyNLnZBZqf0z3xW3ldB1oRojka79zBi9V+9YHX9bjj46Aqbfvj3VpjPfQ1tSBYayP9sVhNgfFrP/q9zUs08dwoVCFa/ZBYrY1cxOkENCN7MyOILUx1CLOlwKeDjyV+RJ/TQGmboiR2A4LgDjof4yalKuJD7H98YuOzxTEIAiOtHEFPdudr3iUKcseSTG/46XQ0bt+SY7fklUz8k1nTmfktfgWlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sascvLo2rdBCIEtoEy2cWF0vHOGysjj0sN9RW5zPPvs=;
 b=TXUMuw30/U91hSp7TlvMmuMTJ+u9NDQr+JSoZL9FVEWtCsdRV4G2DDwxBcIkSJ4+GW1UJEwQXDX2GUbgwpqtXE7q30I3UDjsSjpUpYJpHzPua/mNuuZuuyRxKwdDFD7enILC8+L+zgJEUU2KUDSFe0GYWkFsuK0scKpOvWmazrgkxV/T06pIMkYr3xofjvYaPLa2I6YqRpnRIBzRqfS36xMbXOaCNXZl1Y2/xKmUpR1fi4fUn2BZ6HT9hd6MDnpoSumv1V1bP4cHTK0mr0qC+023CBatR+s8fGgAMwqo1DhvLx27SMehiC+Hfyz70yz0ICGUbEZL9rpfMKO0TAeyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sascvLo2rdBCIEtoEy2cWF0vHOGysjj0sN9RW5zPPvs=;
 b=kB7M/rY7akZnPD8OOJ0n8ruI7z7HIP5S/ajDayxrcCDYfvEywghcE9nz/VLRFHeyvpzYdd9ICOwOmarW4BdYZJrH7BpXNlwP2xFkdP4xHTrqKA2Tc8zc1HIEEGqqalrXCtc7grwPyPIpk2HDsWm/GcEEFks9KMxQPI2gaMS6rhrrO4heCUWlTlJVf5uny9/Zh4WAUMNoGLqW1Jaq4d29UTF37Gu5aLQhfSjuhSF+q10RqcXu9WZOaM77Pk6bGdRd8IgP9LwGgUVYUbeWYnQusb4BqXdLiYrtmMCipyz5dzeIjoURn2ZAGIGVBgVOAmur+0lLZp9fVo0lwdvx7g8VKQ==
Received: from TYCPR01CA0090.jpnprd01.prod.outlook.com (2603:1096:405:3::30)
 by SEZPR04MB5674.apcprd04.prod.outlook.com (2603:1096:101:46::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Wed, 29 Mar
 2023 08:33:00 +0000
Received: from TYZAPC01FT042.eop-APC01.prod.protection.outlook.com
 (2603:1096:405:3:cafe::62) by TYCPR01CA0090.outlook.office365.com
 (2603:1096:405:3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.19 via Frontend
 Transport; Wed, 29 Mar 2023 08:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 TYZAPC01FT042.mail.protection.outlook.com (10.118.152.183) with Microsoft
 SMTP Server id 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023
 08:33:00 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: aspeed: greatlakes: add mctp device
Date:   Wed, 29 Mar 2023 16:32:35 +0800
Message-Id: <20230329083235.24123-3-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT042:EE_|SEZPR04MB5674:EE_
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2cd55cb-ced9-49e6-5fdb-08db303034ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrvpB73rmAlgb/DWLHYzmRnM+9U/fUgIy1Mlj/e1A95wlABYZ7aPuyhXDMhdWgLz1JwQzfdho/PbSS9xVsE8Nj7Eb+ZBpWfrCIY6PW3ovjIApGBPzdyKjiy3B7ya/YHG37Wi/HEjXs8V0GqrAT2PRAhkn3DRltkiJhubmSohJVMIZvECFgnZbKLbnvCGbfdIIEq+HqW82NyJ1eJjH1fTh+OFpdMCrHv0Vw7yyKIMz/e0iOGBFeN31gu9TqH2Ubs+GADz99qouBwEEDMCW4oPErrAEF5pnm22qWEST1+gR1Fo0zH8ADe+QAU+QjumpBFntk64oEXaNRs26QYM9uQBIo9PATHzccI3Qv4L5hxzfDpk15ZnqHC1dF5G/AqP5MS/asmpCmd1gf3UA6GzuAChazCLPE/RDxt9T4aX/J4vyzvfTdr2tbKAG8DPz/942xwLXtg3qgS5IP96dVOfITOYT9KYs+71WQFqJT/50Cq/eXm47XSc6Hnr3edMPvR7ekIIMIgcCcdIZwnq218Ah8lhFhOnUI6GA1QDxaFIYq/+Pr5k89WgCz3H06tUekzwt21vb23YhfZam2hJhoaAlarEc5RkBflExM704s6IbrTP1ktBzAdUeuriEahbArCBJvWWtp1WW89q8PpuqTjHrfTs22DTaqAQI7F3hIFNUyTkOok=
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(956004)(2616005)(47076005)(186003)(336012)(26005)(1076003)(6512007)(6506007)(6486002)(82740400003)(6666004)(70206006)(36736006)(110136005)(36860700001)(478600001)(70586007)(41300700001)(4326008)(8676002)(81166007)(356005)(82310400005)(36756003)(9316004)(5660300002)(2906002)(4744005)(8936002)(86362001)(316002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 08:33:00.3333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cd55cb-ced9-49e6-5fdb-08db303034ea
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT042.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5674
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mctp node on I2C bus

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
index 59819115c39d..2f83693e4f85 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
@@ -156,6 +156,7 @@
 
 &i2c8 {
 	status = "okay";
+	mctp-controller;
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
 		reg = <0x1f>;
@@ -165,6 +166,10 @@
 		compatible = "st,24c32";
 		reg = <0x50>;
 	};
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 };
 
 &i2c9 {
-- 
2.17.1

