Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA05F61C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJFHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJFHiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:38:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EA67CA9E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb5lnHi4EGBYTigEB0EfI44gsKG51DAvowNsSx35PL+IRgw1ZaAgzLcTvOW7PN7AuPYlVnPrMjVR1NFTX3tH90Kbs0hb1cevqasnX8S+4ivLaDXmn8BcW0Ziat2kkHIeTjqU934vxtKE7oU6uHgDrJMCivWlEJS3PntFglGHrzH0KoUAorZtgu5kMSgO1lmlpZKcOwncs/WlwlMidm8zIA1HnRmn4roqN2x3r7HhGx1uI+fBP+Z/OyU8z9WO2mBTSqJ5eTrsRLx+ljmDeAvPpEE5X59Q1XevGZ7jVqP6rPRkcx2QjiP/Fqo4pKBL8vQrpXukuS3px6vEa2bYwl6zVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEhfys8WyLik2IG5wuweP4+UICMjWC7PBzvNuxx5xsU=;
 b=U4WRYITH/FRrLNY9xr7lt2BkzkvxVCcuMMEPnUitIBDfO+b/HPuTqsNGtazGlctuSLNgKPzmOoCh1uSZi8owFub3Rq0Bf9bUPeEF+gjNd7D+OwE1jHRBQNL0v5bdbyMuf63o+PEr1cax6ErLNpGomehRNCFu16sPV+8M5rhNnmwoAyi+8CmKa62UXGRgfCyS1O4S5/UCJVDstW+TQMtZ/UG8lIdDK9qwc2JQlIRcLMrAAhlx/vev1TkipgQlIMZmm04kmUZUM+28iLoxhqNe7oYqDyp+/GWtv+JEcc0ciaSL81dXnNl88kE6OTMZd626GKPg/kZvXMlusqNIZi5f8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=lists.sr.ht smtp.mailfrom=wiwynn.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEhfys8WyLik2IG5wuweP4+UICMjWC7PBzvNuxx5xsU=;
 b=K7LwXamvNTeknu4y7AINa7u3qDqecLW2aQIZ0gDegS0mOa2vzRV2xdM5j0hE1iQe6Y/OxhURJXOkUFLLaVdyMxxz73YOtMb9IvOVV5Fy9dTqswOEOk/dylimPGvXi9kFMGL5m3z3fHvufZzQsf8VhFw0ZwJt3qt7eRnlzfCPd+HgBJV0vPh1u0ij6mD/39pP4XJcmymX+e1k0eIEN6PDSi7BcXq4ZGnArzrspafs4bSRKNFifLjOTzCaH0QqAZf4mlkkDctw7IzLpaFBZn4vb5WT/Jqlq5pGtbhXmOWfhOEcIiay87OmUGcAmhPExiteYJ1aCkJ3fXWhSwkFJmnv7A==
Received: from PS2PR03CA0007.apcprd03.prod.outlook.com (2603:1096:300:5b::19)
 by PUZPR04MB6245.apcprd04.prod.outlook.com (2603:1096:301:ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 07:38:05 +0000
Received: from PSAAPC01FT016.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:5b:cafe::43) by PS2PR03CA0007.outlook.office365.com
 (2603:1096:300:5b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.10 via Frontend
 Transport; Thu, 6 Oct 2022 07:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 PSAAPC01FT016.mail.protection.outlook.com (10.13.38.116) with Microsoft SMTP
 Server id 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 07:38:03
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     ~sircmpwn/email-test-drive@lists.sr.ht
Cc:     patrick@stwcx.xyz, garnermic@fb.com,
        Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: winbond: add support for w25q01jv-im
Date:   Thu,  6 Oct 2022 15:38:01 +0800
Message-Id: <20221006073801.2220201-1-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT016:EE_|PUZPR04MB6245:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 90ad5a1b-6812-4b07-3463-08daa76db3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lplQG4wJEA6qnXxglY2Z24dgReM2ORFDLC3uCmkE2gjKCf+eISoNj7WBtBEYQg3yJ4m7fogvJwGaCBng6ZMvRrqdINzzq7ui89iw9xFYdGXj56CXqcNFUwC7LkS2SoH/GQItXno/hiVzoOW6yXNs3Ow1mvDy6kpEzXiy7Wtfxx7dfMP4IN9fhFpF3AMjPbAHBCJtDmN8BIzdqQYBeHvB8gm2sfJi5Cdi2OUCV00E2vOoCyhMDIDU04zKwH1dF4/chzJ1/2G9s/mrFBupjTeabClEO2s/YRz4DbnKMaBgJe9myscpPHHiV9D1XMVTS0LdTx9Xqk3OLMcTkSeHqfwYO4KzatratoNNBJHO8EKPu+OmuxZyB5g79fDxJyNHxwfJ5PcxOG1zHwQo0pX06RgJajrsBH7LZuRFv+MOStODhSkwJYsFZtNNiJC3cJy/B0ERHzV8SC1ZCOdoN0e1S3gchnsSH2NKhnDMaCP3xC4uy+2mqIEck0ooL7jZYPAGSpbp0flaCk6EuqcAxVDNFfkJWq+gRWMY63kSznmJH8mrqTcnI+0cbxDtuy8WpaXZCcWBC5ND0q9yKhTEvPZjrjh7HQ4n2GLuGPeHurfQ9mUBar4Bo32kGRFNwv8YEntFgdgIFPInojPftmBSx72/MoV5a90V2E9607LA1EJxfuqnbnPJ0L84dlCfMuhj2zkChlM2NGV7XWktx1IzUgDMtnu8JOdszzKxsxOKFvulGETwbQaP8qZeoCPRLbS5v2/EhR9wipOqmyKsDJLrTegY08XTbR1Acu742+X09leqEnGa8VE=
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(7416002)(54906003)(4326008)(316002)(36906005)(36736006)(6486002)(5660300002)(6506007)(41300700001)(8936002)(26005)(6512007)(4744005)(47076005)(9316004)(82310400005)(82740400003)(81166007)(356005)(2906002)(2616005)(956004)(336012)(1076003)(8676002)(478600001)(36860700001)(70586007)(70206006)(86362001)(40480700001)(36756003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 07:38:03.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ad5a1b-6812-4b07-3463-08daa76db3f3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT016.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond w25q01jv-im chip.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
---
 drivers/mtd/spi-nor/winbond.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index ffaa24055259..2b02b05ceb0a 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -139,6 +139,9 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "w25q01jv-im", INFO(0xef7021, 0, 64 * 1024, 2048)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 };
 
 /**
-- 
2.25.1

