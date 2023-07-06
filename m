Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB6749AE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjGFLkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGFLkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:40:01 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69753DB;
        Thu,  6 Jul 2023 04:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imWndILWou4U1SuuooIH9K6JiovRv0a7zANoTPB+Kg66ewMClS1BQyRZl7A1v2u+x56kldEoQ5fGeDXzTm+tV+hs0npRU+NGAfgAR2QiZDV54J/vumjfpo2pz0gBKDHSZDuDIM5FxB0Z7RCtkQoyCO2d5bQp/wikC3b55yHaUGBwvWBP8y3Chdz/odZ9jzllX8Gy37nP9VxR0rsX+V8D1m3hvRaPrKcoaa6K2P4F+gPnnjv3p73H9AZsJkScoSYojT2LjfMN5MhvPtBULfkHifRTJdPjPrZrKu2Pv5n+nyPqLxUjaDVBgJtTNNNH5de4zwxtMsWUDfK7sqk+Cd+tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMp8IXemTEd7C932HIINWu+QIi0l6BOly5jVd490whg=;
 b=GsOV9IiQMt4Ziw8s5RzCPFmP4rFmj/ptSPVUIRvVfilxWIGkFo3DK5SGCL3lUCWbaIBzlPrulThtKmvs6R3E57J/dF+RSyxga6y6kD497HatBrJZsaBEfh+xic/liRHwk7Z0xF8u1vaPOq1BT8OyDPbK9LlYrwFRsvVumqTz3U/LBf05ucS9jLxkEgLRHsYLzotR9QHJ1O0pr0MwC6oHxEKw0tHgTN1oFUZxLzTg4QRX27062+L3ctEoMHZa7VJHm4OxL7QYf0FqZyhG9S3Um0OezP4ECHFta7orcd2bztiAecjBU5WOH6+q4DxdpShyVxLowkdtbrLo/SVZV5TW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMp8IXemTEd7C932HIINWu+QIi0l6BOly5jVd490whg=;
 b=Ru2UavtzGi35GR4n2sVx8tUB+j0Q9+0Mp/dGE60WgGiawzI0AzRPOMvvQ6QbFjoLS8KuvH8CBz7vsKJZm9bCqoaf1YsfpIG8c4DSItgxwd5xv6YyVk0oEMqcr+E2UKKAunahmwEVC1lFpyJpzaqZAPitYyopBMl5+W0ul9NIvcQEdvDEa8Y6HAT3+ooLnYxMcT+c1Uf3gRSinZVSa81hN8pc0vJ7D4u6TFn21Gjr9QqHa5rFHkpPbVh6IR0qtIKHVkX+wLFRF/f9C6xvc8pwasQ5Zb6ZARz8uHh5JnICln6NQIBzLA7ykGNZ+bgRO0b6i4imPGSLGnPCGOpL9JQI5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5889.apcprd06.prod.outlook.com (2603:1096:101:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:39:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:39:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mfd: exynos-lpass: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 19:39:36 +0800
Message-Id: <20230706113939.1178-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706113939.1178-1-frank.li@vivo.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cffa873-6943-496f-b97a-08db7e15b7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ul7YJJzYfX28CCVyI4M/UFp4u5TOJZ3njU2tDAszHvhpfFApsHe19JtAuZAU9dIKuE5Z+ID1vV7H83qhbdO9nSU8WZAbFTXYDO/y32LdqghNIytehRhPpPTYO6as0P3d5ne66nBobsZCaX4X/zXeYhdpS4sbZLvnkmuEZQorUUPl7WUZ/L05J6Yr1QEP3L0dTGIiCeIX5n23ICG03vMcKmSq0pkD/KDttmOR+Qb5N5fnS5hw7NCKMESAqDn9lzqFt9wUPB5exQSQRe+jilWQk5Eo0eMx5YFoDlHSTI0D7OZ7B/DoiJawkTzNS+cOu9LuHuyF4RG2ZEF0uFzr6fB0LYrqZEIZvJTbwvIpHwjCfbDf6tH/R0RzQ0kLFSaNZqwGP5s/siSTHqwoqng3QGifq4Es5+mSgxvdyhB5i9cn9g+7NIJrqREGK3LbCldSeXlzb7slRd7qXiEk9oYCIVKCLOYVEfQ6QNBv8sQm5PGixLteFuhITGv6/PnEkpIVXuZl0xGcnvJPjMnlZa3RiNm7pmtO3m+rGB3lkJIgghZzbWGTRu8gbWJf890lRSmhKJOScjfTCKmlTpje6uVtaB+HpsqR+ZzZbKeBG3xRyzLeiFc5CNoyYFqm4G/fz4ZmvBFG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(36756003)(86362001)(2616005)(4744005)(6512007)(6666004)(52116002)(478600001)(110136005)(2906002)(38100700002)(38350700002)(26005)(186003)(1076003)(6506007)(41300700001)(8676002)(5660300002)(6486002)(66556008)(66476007)(66946007)(8936002)(4326008)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tnmPv56IOs1FIZC7IFaKSlA1bseWCPgVrW8VYr4tc0A2MCgPwbMvwmQsZ7rC?=
 =?us-ascii?Q?SL8XG4l0aNw9eG/ZEFtiZCTwgeI/0hw7CU0OkFKal2SwPjMJrR3HawygDxbA?=
 =?us-ascii?Q?16HO1v/ozxMIBeUVvNwwll4R/ojkr70mMw0AaEGUaPB4j+Aw5Wxf3PJax19a?=
 =?us-ascii?Q?mK9q7Em75Zjuvn48ZLu2vZW4QEXMEIknljt012DxzMD8CDhhuZuIyJgiLIRg?=
 =?us-ascii?Q?aps6HjV4+yTMh8a921n5Lb44fRLBpabuXi4jdEjUGNGvAZkyYmeVJ9F1tB9M?=
 =?us-ascii?Q?A23N8Sc3OPNj6luNoOux0M4b7kQ+lGIo8WIi5SMWY3g8V7N4PI1J4d+rK0Sh?=
 =?us-ascii?Q?8TuDSrjRbX/WlPkGYq/DUkWbMbNnJG9m4WIUne4ef+adkXT7DqpWx128Q/XT?=
 =?us-ascii?Q?2tFTmeMFZl9dem5VDBg1HQJw5gh/UQWlqzxf4AKQAUjZvhg4IEYBkGV1PsXE?=
 =?us-ascii?Q?oUAO6wInoSjihpJL2zrSv8s4mKiOdtkZziKAY+uWWxOUVI1Tx13eb2KT9R+V?=
 =?us-ascii?Q?MFvmnoBI4qFnnSrNOH3HKJrq9L8hfRZAgcJIhX6pJQTsNjV50W5LKTW/qdhg?=
 =?us-ascii?Q?3ZRLRPuVv///WqyIbitUpWea3TTZ19dD7zaEWVyMPye5FfPKDB+TWS8PYdFa?=
 =?us-ascii?Q?ZUfPnhIJT53Nb4Jnp6r+9/rZdWA1u7tZxm5gecCPVvY+cMiwo/ZdMJCLeLo3?=
 =?us-ascii?Q?dAC4HqEWTQFjmOiij3OhZU+oBsbMigzTLOFM5efrdWntSCgq74F9TmlJ34Sk?=
 =?us-ascii?Q?88Sz0lUNy3AWYtTasXvfvydp34HLkmtJAzjnETZSCWWAIVxY9xEy0+ZCuOJE?=
 =?us-ascii?Q?wh4Kxq97eF+twixjIyDHAD5TUWPDQ725Z8LFSGO7kM9zzxTDL0AlJmg3b0Dn?=
 =?us-ascii?Q?DZrovaxfrZ/KGOHifc+/wyAf4O8LrPrfiEq1FYPd6DobwFttT99aph2vnuwY?=
 =?us-ascii?Q?1v2mZK3AczGA9VCyWbHIog/D/SX/jM6txjrCQYAF1eAfUkQZ32hiVPpVPVzl?=
 =?us-ascii?Q?8+5uqqu0cApnT0Ykzi55I/lxM/NDb93PGHeV1+CeAqpgqaTGhCx1H5PTUkzX?=
 =?us-ascii?Q?A2r1/qFICwnU8jEzfJYx254PC4M1MzuuJKX8IRTT2XxeXn2amMa2DuvJxhKT?=
 =?us-ascii?Q?3uUoP9jP+9Fd12EfpmKlQjCQjDRQ5fisFPt8fHkDp/hrfrU7Fague8Db/vTU?=
 =?us-ascii?Q?uOF+XgoiAsl0qMX146aURCrsT1no1lilOZTCXFMBC7uiD/6UEMLR3A27Kx4p?=
 =?us-ascii?Q?yfagaW1Zs1H9Kod0O2vWb5jmuG7NlqBn8dVmYMjEstjKucJsPQcqUMWtmRfT?=
 =?us-ascii?Q?iIT5XUFfqXDnbrwccohpUaN9t05L0qAlhxF6g4wwSLssphMHVRQoUDvSdxAb?=
 =?us-ascii?Q?SgFbuFvBCU9lsta/Ksi7+ReugIfKuPsCJxHcV9/okJ1Qs0Q6rqCh7XrwSrJj?=
 =?us-ascii?Q?DGVIgOf4Lvkp2mp+MUWRvqQUk73kwigy2tTqxQlKNYtgpMPcvpPfs25kpulH?=
 =?us-ascii?Q?hzSJYAC8AhxotzNEUwroHSVV6qgkyC+FkJQdt76u7lMOO+y+J59y302SdjD1?=
 =?us-ascii?Q?4UztjNmisFFhU5I9aWIHumTnPzhD8Q8ObCrn7UW3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cffa873-6943-496f-b97a-08db7e15b7d3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:39:54.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGU5gyeLnIqyzaQjRzSijphl3waVtbJF8OGsDHfMZrH3pNgvZsAhFLNyUkvFyEY78bsTz6VRZ23+Ah7SvIPDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5889
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
 drivers/mfd/exynos-lpass.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 166cd21088cd..1506d8d352b1 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -109,14 +109,12 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct exynos_lpass *lpass;
 	void __iomem *base_top;
-	struct resource *res;
 
 	lpass = devm_kzalloc(dev, sizeof(*lpass), GFP_KERNEL);
 	if (!lpass)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base_top = devm_ioremap_resource(dev, res);
+	base_top = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base_top))
 		return PTR_ERR(base_top);
 
-- 
2.39.0

