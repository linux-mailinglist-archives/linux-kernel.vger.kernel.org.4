Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19F75002A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGLHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLHiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:38:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2057.outbound.protection.outlook.com [40.107.215.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF680B8;
        Wed, 12 Jul 2023 00:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+24UoDG888S6sV3AFHQY4i6IU5RLtdey+376FW0XqGsbN8oX5wDXFlgWsYtNiA7PSJhh8hAQN6AwiY4IbUrib2WorN7GbVkbDAz0//Xf84gA982ae6EDfdDuaoXTaaz+4jdF/JUnXpzkTAv/y9z9t+23BuGdOc6JTk+TTkdtJcNxsytfA6T/67l0iU+JntDzl6OvHC5A0IFIj1bruJJ67YEJkkHxqWk+V1VV1bZzU3mCwyG0GHKPueu4+dfCjoJxKOpoto2F9U+cJhcvx3H/weR/RwrudQnjrdjjKwxRgm14AcKfuepTylBWY3T6kotpbpFCpt7AkiBgui53HksRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/h4VecOtrX80GUo5VeK3hXPo189rFbY324b/DYS9V4=;
 b=EjRBqjNtC+zihzAYMuGhIg2GxGBXDEde1Ce/0SVmsJfWLUwX/R/NZhHC1DP1Jbpmk5F1NWpjpHoXywZQzwhoYfYpfn/iGHxMyOLUAfpQOon28SHZUY/qgEf9VIhX+L9m+Ud8LwnBv8JJPzaNCBdCvwkHKtobXiI8ZbwJLCG4eAqVldYKM2FTvRK5zXYWHXm5Bzqtj3YVhlQwtkkig33iwxDLC5AtZfgZdYmBUaWafhl5Nyi0KaDPFUO1eADXfWi7Tda89ZidPd6xfBFACuBI0Y9S7LZRZrqnoRVRisZsPZV92yfK1D5gAKCJnWWBpQRhidJEdrEL3i/GP4gbFudFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/h4VecOtrX80GUo5VeK3hXPo189rFbY324b/DYS9V4=;
 b=tHnsmtfRK2V12QS0Ury0BkOpjLWU69/uJnQ3JEl/zzgJs7orq+eCmhSkCeOk11gKBjBSKK3zaLtivnGHt3TtTdbi60gQf29n3v1SWGOTh5V3RKVK+OncdHtRKimGemTOMgjcQuSmLj7JgKutAd9/arOB+nvkSr60YrqCjAVTxMCXHfIniRKIHkw5S/dhSbWgTUo+F8kGtpr/cwiGW8pPPSgn/+u/rAsst89JJMiYfKhX/TneSkYaheG8CSmgtL6kJJF/4R0uLr1KELJdzrhkJh9iA616x2v4yTzYCVCv4OETe53DKhn1u/WDYXDXCj0yDIek3mwkhfRIXuePyn1UfQ==
Received: from SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14) by
 SI2PR04MB4361.apcprd04.prod.outlook.com (2603:1096:4:fd::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 07:37:57 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:4:be:cafe::c4) by SG3P274CA0002.outlook.office365.com
 (2603:1096:4:be::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Wed, 12 Jul 2023 07:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 07:37:56
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add Facebook Yosemite V4 (AST2600) BMC
Date:   Wed, 12 Jul 2023 15:37:48 +0800
Message-Id: <20230712073752.54624-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SI2PR04MB4361:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 180164b9-7601-463b-3721-08db82aae8e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcfe0E/ytnrx1tmOke7lyFj4ttEFElAge6z2wFQq2qOHYp+veSBAQEtBNZ4+f0jtmsuAFgoUi9BKYEZIav9D5jqJS1ornltTUPVBwK0w1xQ8xJI76lisC9OAr3ZxrD3rFuEB46q+02AEphYw5sU8cQ3b1amsLfBDEFF9psqASA75QEtsyBULb9/TfiUj829ucigHMQ5KM0Xv/AoJNATempKbPQOeFS8mYLmIMPx6ERcvfJ137EAV9gqCUFqvH7cIUATpBNrpKcJkzBSyq1h2LymvfusJG2dnoTsnDnI30kdy+jPS/NciG0I2esBggTKf6XfBTc1G+bzS2oY6W2nL/YJPF0wvtf6xvoqCXpuPPqzyXQUCvajBc52wFbgeoP0RU/JGKD+3xtqtqW8Ny0ABqfVlAc7w9o63ZKGPHjwhqxXV7bFLHpS68D8Te9BEcEpFQB4S1eCJKRHw0KOoe3Vk50GJUieNFMYr7WQ6s7yo61Mx7wIrNmMe8VL9rXq8FvjVakEF99yHRvWt1OBFGW9Moc0E+YuKFr8xxvGqwgWfTVKn6WHTZVXIx6Pzt5FRYWzD9XGKyfIW7xdpawSaL8BniDUs/lqeb00Yzu69PUkfF/6WVY+OvqKDPH9WVLflflncHysp0/jc7pwK9NA5V5qALb15RabR9N5rieRpLVfYHa1ooi8n8NrvGfXV5MptNETT+z4HDJKsfrtwVv/ALEe4qg==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(346002)(136003)(39860400002)(376002)(396003)(47680400002)(451199021)(46966006)(36840700001)(2906002)(82310400005)(81166007)(356005)(6512007)(82740400003)(336012)(47076005)(2616005)(956004)(186003)(26005)(1076003)(40480700001)(36860700001)(86362001)(6506007)(5660300002)(8936002)(8676002)(4744005)(36756003)(7416002)(54906003)(6666004)(6486002)(478600001)(41300700001)(9316004)(70206006)(316002)(70586007)(4326008)(36736006)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:37:56.3631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180164b9-7601-463b-3721-08db82aae8e5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 - Add Facebook Yosemite V4 (AST2600) BMC

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite V4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 570 ++++++++++++++++++
 3 files changed, 572 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts

-- 
2.25.1

