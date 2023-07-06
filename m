Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC5749C13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGFMnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGFMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:42:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F220171A;
        Thu,  6 Jul 2023 05:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNhQfbZ90K9gaNnB44lCVEWysEe6bgKKoRvCzTGKFu76PpWFNBFdFCypgFEiTH/A7P6vJOSjlvuyVtXl/zSidb3aROpteoi01qkn9j9IeRasTTfQwzLuXBz31Pk/C+EOdaUk7xbCMmki2H0OH+xvU2TPM5Htd0FoVBea0zh2I/fj85z1SofQYaB+U/KF00cU0meDn2Tl34IN5J5pv9c7IrkTIIVJxe2GxDS9aAnwn1NvBjqbh+V2aOzgUHDRgpZtGxTM4c0pJz6RgmoDjeRL3rYPGiEB32/qUEzqt2HiwVeG6KtObS+sdPGvGn3fRR4j+Ec3ijaS4wlMcJlVkR6vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTBEk3ERPwGYe9e803WybvcvhM/4AUThNLDY/pAo4aw=;
 b=UzyrQ4HaDuQvhyGH3FDV8D/DaAl08yt3clXK7UFURaZyBsuepIOdq8i6KxKbN7Ye9StMy8QFHv3WY7rZpqGGAeIa9A2AFda4bZZvKdsDv9DQ414SAAVo5FXlrcHbFEQsFu7QI1iAhkrEwosEJctQv4f/lHOl8y0UuTWUv5bccRiM7YxldU4klDtZ9ppeTJ9HGZmkyRYCKkIokAayGTlS6U8I7x652x/FpiVRDxUHx3x0MtP/gXZSOwK+nXXQyGT/s8tvgFwQMKcmwIM27C+HpFLOC2l7cbfKKdQvya8zld8oE6RFjZy39ya+DXkBkILusNGWXR6SnAI/zNzUd3TOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTBEk3ERPwGYe9e803WybvcvhM/4AUThNLDY/pAo4aw=;
 b=qUyU7EH5UZWY1lvzpyb4usZDS6bGmrfXtMrJJrXlYZNo+klCumFv/kpiUiGgDKVhiTXE3IDEdvmMDGXBe0S7kMH1n8QtixYnjpOmJ3KOSPlLUKiAbQBbZyeSvVL1zjBFlWfGahqLrFK7XC3hnrnkdQcpITM443QDX9urb3b9pAZ0xKq15xUEEHQX6defDNUIuVeXc8ED1CzRtnz+J0mkAeJPhlHO1qyh05mdDWF0g/4folpLOfF21g5muVX8CS6bWKvSTf4RhhR7WFVa+10bH3V+BkTLPIBUrDNnf6V/8h+4l0Wkvn8jvCAixjhq1ZZwLjSIKAtt/IA79hiNmu8CiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:42:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:42:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] ata: ahci_seattle: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:42:32 +0800
Message-Id: <20230706124239.23366-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706124239.23366-1-frank.li@vivo.com>
References: <20230706124239.23366-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2fa995-15b7-49ef-0a89-08db7e1e8269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlH1uPr0RlEXzB+T7hcphtmRLrwuqOlEDuX4Eb6j66sgcw/bYP+gwvzZnjVBq6uFB6S7Mjm0cQEmtHKK6kwUwLVHE+HwsWkmQS3bLD4Q9XIqKnSoTxYRda8uFajP0I/r7BVCKyn7sJpntwihz0RRm96ZqSuM0GXTd8oaWh/mFcKDNHVHfOPeTqbbNPvNia2SaDptfgR+A00q/tOq7AuWW9hb1bHSdFQnV5F1Ra2OEL3iPjoO0BccEre9bVdNr5KCcvdZfXyzHgwlscdc/DH2E0AqoZ2ol1SS4o3cjCoa9Ou00FCN9BsxwrKBG5HKt/evge0jYCw/NjgQS92yEwYmOcRjGuaE/I9WdmbAma/qWdPKGMEZK12bHX3q436EDdrdcdTXsFdy6VbVwn4qtOnRJHSbVn6T6tsGXrwUCdg/aeXjY8xqeQsQqjZA859zy0TR7mSIyWpBrZHE9OHsukQT5otWxyxHjTvdvy57rGum3FqXJOzzaIKXdKl4lA6T7QqyKfca4q150PpoUTHcEfV9oH01o2oW27LghJLD8OH8KhmJZJqz41VmWxnZNDVG3UQ5Tbs28OTn86/DIq4mNMwlZnH5fLtBeOBEd7Lb9v+2MITd8ov8iX6GlY+rQWz/vYK8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(4744005)(5660300002)(41300700001)(8936002)(8676002)(2906002)(316002)(83380400001)(2616005)(66476007)(38100700002)(66556008)(66946007)(6916009)(4326008)(38350700002)(6506007)(86362001)(186003)(1076003)(478600001)(26005)(52116002)(6486002)(6512007)(6666004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlsSH25QuOpf6NLJE8S6KC4AkaBO0Z2FpuqgQkA0YT6QguEAerasXOzY7e+k?=
 =?us-ascii?Q?cp5VpLhWpd5dbXNZlUqtOOih+oLfheYTinLj1jRMT/1XqnAh/VAsHr0aLvuR?=
 =?us-ascii?Q?zIrJ2kk6/C+no0ulDt7w8zahTb6BOFOxrhlp16qbUhexE4h9sTuHrAS3whNl?=
 =?us-ascii?Q?AMigs0oWCXYvCdxf22gr+aY6xDuwap8ZiCevKgnga0+cCX2axzbnAxsWG676?=
 =?us-ascii?Q?gMUmF5jWgWbxxsOjPkMqTwarEkhuk5kwf+WFoJI1mXZ42HJticFgLiufEG64?=
 =?us-ascii?Q?aq0xFMujldDHnG7LPDNbRzhpTpCiQBS9NvI/MNA2wP3TuWY3ccVWbnTqxhGj?=
 =?us-ascii?Q?blmZQlOUuvXyIrRuxPNJ6+JAC/Zu5KB3DvAfglsQo2tbYDt+/MHw4fYprM8+?=
 =?us-ascii?Q?MC/XeAjOauqXJ88vPziioSlOcaBithig3yRMRwlY53SRrHPz65sNpzpQHXwk?=
 =?us-ascii?Q?XnyvhtPAht5So1h2qnVOyJIcHio3LACbU+TLKIe0OjquDaqf9NW422Zer2A8?=
 =?us-ascii?Q?LXKWzn5Tm9prp8AEmxhgFRMRk39yfz+WBlSmoIgTLB75CTKyUok4XZ1wPJEY?=
 =?us-ascii?Q?18P6EmuSBrlyBOpyJaPN959ESi4YQK+e3mR8hK/BmApkHljo3SEzUHwx+r0+?=
 =?us-ascii?Q?4sg8gbZPHZNanGW70saFWQUVKELm/GEqBgqjhWco3N196DBMaKUx9jmtV9+Z?=
 =?us-ascii?Q?gpIIQk/9D+cR4HGjOqedsyl2YxPu62WkZfTdCaQihr9T/0ok5hNPPzjZ67eS?=
 =?us-ascii?Q?PE3uqKovgjN0ci60clJMLq4P1pmwUoFW8mLQdrOgco9Pp+E+fqdThNk/Eu5b?=
 =?us-ascii?Q?PCg97nzjYgfkHGwG0lXkk66L0QG4bGWxSyKFIw83Ai9r48B/yJIOWHG2QViw?=
 =?us-ascii?Q?mNI5zrUYRiCxTofXS4Ys/fa86OYwxD9FGOoeA25tfk/nRKVBSZN5/tq/q2xx?=
 =?us-ascii?Q?HHOd2hlQlWHqJt3oZgauZjrqd3iB3OOLYG4674T+GRv1hA7H2SDup8MAPuqS?=
 =?us-ascii?Q?rgH1GZ3biHxa202x+5iJTfyAQohQM8ETmwOI36gmlomiE9g1mkXE6a38pT/Q?=
 =?us-ascii?Q?zn0ZEOTFuClwUvznKkjUxdkuBmdB65ix345FX0KL9syl7vfCSwnBGlXEfbkD?=
 =?us-ascii?Q?kgUqWS+g6CorBEtPArImrMdhB6ox7GJoibTyWR1KxzSdSaPBXXQyubHT3Mi4?=
 =?us-ascii?Q?8CqARgBKAlI+nqeOx0Xp4aDwzIa1Kj+TN0o9Jdm1v43U7j3LCXUqXJdJsYR6?=
 =?us-ascii?Q?jBbWrCxkI0ipxFI93xPB80iJR7CVdhw99C4TOWIuKu7n+uc8WmMSxbPrhgCb?=
 =?us-ascii?Q?cUXyz+wSnISX/Y3cdpql/XVG/lVoYvH64s5zDJDP7TMnY4axirNOO83LVjFL?=
 =?us-ascii?Q?qao4v5s7YrqA6W0l80Ltcj+QvbrlfJnCEaQh/Sd205DyQb6oWcTM/F0M5Ycf?=
 =?us-ascii?Q?LY2lKC+xueuk+A7nIYyGOyjYmr5pH7fPTLO/gjtrCLbnAe/EubN6BqcxwI5U?=
 =?us-ascii?Q?QdoRoabBnrfaKIbc51E/LKj1k7CpPAK8n35DWXeNqJOxD5rnX7QzAV8AVxeF?=
 =?us-ascii?Q?23umWK7Y6aLBqrIW8PebDMnUsVB3CnJSaiW7cj8D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2fa995-15b7-49ef-0a89-08db7e1e8269
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:42:50.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQHun7nelhsn+opAEsXFAaz791R5srfcRBX46jVEgbt09F5cveiwSirNg/WD1nDUTek0f0Ux6j/vx2x75AlhtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/ahci_seattle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 2c32d58c6ae7..a64c9c4704cd 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -132,8 +132,7 @@ static const struct ata_port_info *ahci_seattle_get_port_info(
 	if (!plat_data)
 		return &ahci_port_info;
 
-	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 1));
+	plat_data->sgpio_ctrl = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(plat_data->sgpio_ctrl))
 		return &ahci_port_info;
 
-- 
2.39.0

