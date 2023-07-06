Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29670749C18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjGFMnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjGFMm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:42:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED35125;
        Thu,  6 Jul 2023 05:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgQuVwxp50OOpfw3TjR0RYeF5iSjC0xqn2H2vb1+Xes95OlyApTNhSTRNz/mrCYR0KnOzPYXDvYPzrwT+QdG/l2mZ8MXRqEN0SKFP2NFpQ+qM1uiQx64v7Qc3BYH7KxO119XLxmljXH60H7hR9hj04vbetg+EcEXppK2DJn4OvXZUtALufJs/JROHC3+ZzNLkLDJD6Hjmz5AxhxxbTp4TdbzNKpsacitatRw5hjJBTnvCK4q6vKxeGM72sU3T/UliqqNfkTHJNeAiUrUbauUaWwmSPJxxrmG3mG9C6ms+8dy6FBYZffdMJb7f2dfrmJwvLXUs3IQHnng6eUS8Z6AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clT28NDDnXG0lYtow9Jcn0FNxd+1sybluxxuiLZdlc4=;
 b=cPkvjG9mhlEAzKoB2G5G8S2d2ydJnxvqS2R+yFJR+3Pp8FkumY9Qg9HBLe8hUlfCQFCLsZ2t1KJ3gJNa3A8mIOSXCOmVqS2YM5xO7Miukg9vNBYqE1qrgnDdCdrbRTVch65LY+9diSz7KnHv3LVktw2KWKN4g9HKb+GgzezNHpGOGCuOiacMQKqbzS0Sp8yd9aMZErMchekXWWFMNQCdSR/uxJnL5MQa/SWiMywGHSzt5un6qBttiDBdzuQLHX/oJnpus0kRhpz+feV5y2m1j6k1t8B1qN6FTfjO+FurBTD+oJPBtjz1TyQRCSu2JBLfCzcRmKUG+CJ4FZhg7+7iZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clT28NDDnXG0lYtow9Jcn0FNxd+1sybluxxuiLZdlc4=;
 b=BN69uy08Gm2rVL9AZoz4IXa1YSI64dzvzT7vw+zA69zeGetTy3YJ9MtlM6FWIBlF+rBNODoRVeJw6JQMA/mNmihezS6cUlijdl6NMD1/y9JnWk1OTXA/2D2CmWBuw2WkoT6/VkCxBtJM8eF5+ZSivYq/fy23f19SMa6CC/IzCcyyNuQxKmdxPhETvpiMQU8TWRc77GujJrotDl0NRHroUbo3XWi5mLJ3Ib426RystphYkdxRzG5D20U33e0JE+OM7F++Bdf3n/4MHwbc0p64lkB+MSCM2Z2aIRUPdRR5PspRlWSuZjRQtG/CRW8skdIwVPPpO+m+QnoDSWRN3jfAjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:42:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:42:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] ata: ahci_octeon: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:42:31 +0800
Message-Id: <20230706124239.23366-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: cced8004-5131-4146-f100-08db7e1e8118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9DFGqDYnPUFtwI28WJ2yLRqSi049hQdwsBvHb5i0aX5v9Ro3E/UjNPZU87pRyntJnH1iepuablt7ziKZJJM5hfTxeP3bQdYuc+cn22JLHPFsXic/nXFsigUkvukh1NsGxj2XOAbBOcOdhHsxhel4vwsk+XcmD2e810mD85uLtsac61oT1xhrLr+PLTEn3VWc26pW8vNK+IAP62o7OT7k3RjboOJejxJUmFQ5lPjKnAUPZiO8zxSJDRwhysQzSTtoWuZ8ZbFx8xXpk8vOR7XnfuMHmKy05SniwrGl3wKhuyrJC9lNHcHgS5AmDSU/vckGLpHQ9/TEQQrxOf9c4BJAO/UAsmWWFz3hV8+0lCh+PO4s1rX2bpQZccW4dL72mQGP7IdWBiLQcc7spiWlO4a4iMXvxcZv0pIITeJuDz7rogxpnSZ5Kazq57fwvAwqtDqsloZc9CxuvH29gj6zksKal6mhayG2Lgl8yaOAFXZrRY+nfTKOrwJOv53E5azTUVBdckHhBWpQP7tW5E1sW1fsVLzK3i7lXrWupuZOhRM35Jn8WhMN2aTvqDHoLuCbqPKp7a7TZ4dTj9RTYxr0FuVirOkMn6P2hRiOvsCwcaHq14TvePT1yVp39yccZXxu+J5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(4744005)(5660300002)(41300700001)(8936002)(8676002)(2906002)(316002)(83380400001)(2616005)(66476007)(38100700002)(66556008)(66946007)(6916009)(4326008)(38350700002)(6506007)(86362001)(186003)(1076003)(478600001)(26005)(52116002)(6486002)(6512007)(6666004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?evq/hAgWZcNwc/hgeP+P0PlPK4G//1Uw2DDfMMyPS9ajn8XUoByXx49wUntE?=
 =?us-ascii?Q?CJ8nczhL4nabLZb8Ld1tYeYaupolSHdNvUlQkctJRnyaquFkr6IQ8kMuiw84?=
 =?us-ascii?Q?r7I8dLHWinhwwUT+Jg2Dclk5+CkmUgiKfxZPwSwYjtg7Awa/CRZfmpQ4FrRx?=
 =?us-ascii?Q?Wh5mmj0BL1xjK8J3y626YJbXN6GUoFmdQLuxR11h7z1wsKbtukJJJpEKz41C?=
 =?us-ascii?Q?jpPFKVVBiqeeELadUdp8mbV354f7vb0wRQEhribTTdjYuuX+w3U2DAYmIr6T?=
 =?us-ascii?Q?bXt/aINfgg2mSfsqt+FggzJU9oXveUupkRpDzZ7VJj5Xj5lb4NqMjCreWy05?=
 =?us-ascii?Q?aEruxDvT7FtzZbEeuu8bqbdolVYTOuLKGb5UnnyUYZ/lSE1o5heGD/6vk96w?=
 =?us-ascii?Q?Dyzb9iewq65ps+G1ownoh04QZ524FUubCEMNxnZXm5q6nvOnmxr1g53xkpdI?=
 =?us-ascii?Q?bMiUR78VKtTqYPI5mFjT/UarEoW5ULSjmqvmjtt+AG2wyJbN/QNrcCKNUNkF?=
 =?us-ascii?Q?yLqnG97DaYqE7mPvUSBTPRLqVS00sz5Ivlq4ft++jHua+zUxuIfzrpMmpsYI?=
 =?us-ascii?Q?TV3moSJqUa5kAEwNGjvS1gf6WPg6wZqHZ6hgEjVVFkURwDmbIaBipfZX+YKz?=
 =?us-ascii?Q?sIYWfWj7raMpX0dSfyxpsju7GHcms09842zTBvyfCZ6+DoDbW+NAeIqHfVyQ?=
 =?us-ascii?Q?Mk9UcUktPTsq1ksJOOf93rTWARrEXzjCUIHpMB70rEo5g7m5R5EQQzLY1pyl?=
 =?us-ascii?Q?4Nj4zuU7NiyeW+RjVns+WuC3Osy86juTpkVUAsZ8ep71inY+cjDFEQUQqW5g?=
 =?us-ascii?Q?fC8u2jFJKYC38bfkjbF4V9rEou85ggrrAr69u5TsMgx8rkpay8qPu3rjnP4y?=
 =?us-ascii?Q?U1wPhp9jC4tdn7Gm5nS8czpXCJri2AXlZ9B3UKxnvT4imVYDgs3icsMxjkCs?=
 =?us-ascii?Q?0YfJuyrIRoyjbdgXqjdEclQaFYFl8fJ7iciQPETgtiIEqq7Ot94zAWzNoqTI?=
 =?us-ascii?Q?rExjuuq7pytTegj4YtynNpTj/K/OHN3moMdttxwfW7GEdI0g03/U+b9A3vkK?=
 =?us-ascii?Q?N7haP76GGM44ElnHF1G14L40ZsxlL/aTaF4PXvYs9TfG+iHf1jjZWo5b6E5p?=
 =?us-ascii?Q?KPPtaoNOhAaOHakOQnsy+FaBgRMg2+dcpAb6BY3rbgNzs6vp72rsA4NtRVxj?=
 =?us-ascii?Q?iHtf4x7PUUIE8QPXuU7gl3f8SDdRWXrPQ3FQKY1nJexP8uHkaSZbx/XB+kar?=
 =?us-ascii?Q?EhI6jCmoLNvvJjQrnU5j8tV2nuFWjyRMZyUQRKy2Cp3LmoiRbiAtl6N+cZ7F?=
 =?us-ascii?Q?r9hKqbIEyyVT2Jc0tzN8JsqAlRMFPzFFydanJsxEfsGmVDoA4SeeG/DiiOmf?=
 =?us-ascii?Q?j9FrRi9O9IUyqEQqlmuVJg4DDI3hBu95xUEWbve1PiGoe3AWCmpv8Rw300Rk?=
 =?us-ascii?Q?0j3tq+qRFCWI8467EqrevnXbeFt3SSXM7kianPX5+rGpVZ4/qgKhC28i5ZZE?=
 =?us-ascii?Q?iqHGvthhcIdN4KZ7X6XLMctcZVm5Hh2yr/2bXnTUFpyGtHKwE/PBt0ZG0km7?=
 =?us-ascii?Q?8+aUlceh94Ngrpdoj06fe/3UPZMgFFs5evaeUs1p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cced8004-5131-4146-f100-08db7e1e8118
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:42:49.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjzEPlQMHcsrepM19uRIlmXEAyPH97qy4ACiLtKhdEW4keIICRKrde23oenndcEfbMsur6VCbSaJc98gI/ztOg==
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
 drivers/ata/ahci_octeon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
index e89807fa928e..9accf8923891 100644
--- a/drivers/ata/ahci_octeon.c
+++ b/drivers/ata/ahci_octeon.c
@@ -31,13 +31,11 @@ static int ahci_octeon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct resource *res;
 	void __iomem *base;
 	u64 cfg;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

