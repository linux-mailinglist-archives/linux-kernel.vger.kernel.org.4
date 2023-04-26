Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7C6EF636
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbjDZOTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjDZOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:19:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2115.outbound.protection.outlook.com [40.107.20.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FAD423C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnjLwQytZox/G2Ir5OQXKPG76t9y0RCPyal/ckJykXm/ypoH09FTI+i5ZnwD2s2nxAvqhI2OWCGWmXIKVR0cx8aRoFcX42xunXkE7y5WTNDfUk2YuMB0MEWlTtL3G+ekvDw27d41jVqyqolfU+3SBHCBaLJkgxyJbTQt/3Pu2eiKt7G/6zeN6NADP4Ht/8mT2qpdTZmx8iUmamCIqTohTPZOapF8H4ES6rCt1rL4NxJfR6it9LxQHoukE1BvltKCDm49mJl+UNtDFxk/fS94hwOWp0uJHeQ0/zNls0haD455jiu5LTXwh3ylHCriH9bFlsCjOw/AKgCbQ2W8jf557Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohi58xfsfiUuT71awQPFk4LL/zhVH5ETuAtdMTcWgRw=;
 b=OTe74yYnytFQOAl2QpB2NLpOqTaApNzD9HoQn4OceLpwtk1rVB0+vwVaeu6CwmOPTnC76S/9wax/3IfyGwFfwiWs+hHAxTYF7CbhRrt8G3mWpm9FMYTaHwGMyxlKk8fAldmi4WGnWFB6oH97ovnsSVhko7PAxbmr2+4u20aP9Rqg173gQOuNW6OcQxjZMbZFw4tT02KfsRVBV6zsdlgY2YFS/ue6RcA7ELF9CuJZeqPMObcrsZHRr6Ns3gGdhIeDyETQuJ9wPSfDXAxLqTZrQJTOBsXczvtitxi6l0ZpB9cI0EY0g7PNSCNUbeA5RRD1tg99JTtC6Rld3l+TTn1O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohi58xfsfiUuT71awQPFk4LL/zhVH5ETuAtdMTcWgRw=;
 b=eoyIif8lHu+NzFOE2mHFwzOu6IuryQV7nnDz6ZiQaPQHE8XU1g7ez0JcT890PzVSm0819lQBRD7uBvYbIpS72bBjUW8HKnMFMcedUJGCmAYKa/QISooE3gpQSJOeMwA+uXjiydCdjGoT0lKDbM4D1S3gQMTY9jISoSn2e6So9CctB9rk3wAWoqU8QRMMZ7oDVbMkHT2tpSA2GTBWdKTnRiD1p1U5ILKx9k7Ysi83EhiG07W7dKGasuRYnGCvIqf1VMrQiQS3WLHi1AItcxKNusvEX5+jkampzTH0ZZgbXSdLo7TC1qJg/dFpVHNds5C5xNYxasYfD9Tt989wV1XrMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by DU2PR07MB8150.eurprd07.prod.outlook.com (2603:10a6:10:273::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 14:19:17 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::62ff:e381:3c65:92f0]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::62ff:e381:3c65:92f0%2]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 14:19:17 +0000
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v3] arm: topology: Consider clock-frequency property from parent /cpus node
Date:   Wed, 26 Apr 2023 16:19:01 +0200
Message-Id: <20230426141901.10671-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|DU2PR07MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 7738a223-ad52-46dc-4f6d-08db4661385c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1n6w7LsX46anXcuYu66jyKI1F5v7L3qPlRPPt6RMnXEV6wSGBQkRb+uPx0faGDh4HzEve6BymeFgY2jDif0bPfUaTcBcklBHbRUfpQE7jS2csP6KpFCnuEaKgJMEiEKSdeo6YyMgmXB7XXSGrcCKnGI5M/fTp9nYWXBL04ywKySPMhfCpYJ+2GdXhsbycp9lh9mmmdi3KVx6YfBZs+qP9OPOQ82VdJudJpqeBGsSPEMw5T90hx1snefBtIIA8ow8PmPuKj5NEpj21LuLwPJxMX08JC7qKh7EXpP0jKa37yQZTestU68qVxhjJt2o7DVK1eJ0Qksv7Bff47Z4TpmbkeqwGpoQnxn0o8bfDRIfQzTv/EiEM7NBha0EsPc/UkFkRxBXJ/D02CvAZ59NIjG/If4Tfs0CAs508EGErNaQ+BfpKydOlqMqyJNg738lczdkf3Zm/Ri5LkB+WsD+WstO9xzP+6C1bcglbhXAJQlMRjYlICdod3rsEj3XIT00isAteAQdUn6VS0Q6Z6G9jNS6hcDmgWUXjhejU91cTfFe2hYEeLbb382plvTvhuXOevBB5Naz3XWOh3QZOpJ/JPLN1U2YMG4wHeIJx6zV3J0Yp6zPmyykIUrUZpdDNL/YVxTB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(6486002)(6666004)(52116002)(6512007)(186003)(26005)(6506007)(1076003)(107886003)(83380400001)(2616005)(36756003)(4326008)(82960400001)(6916009)(316002)(478600001)(86362001)(8676002)(8936002)(2906002)(66946007)(38350700002)(66556008)(66476007)(5660300002)(38100700002)(44832011)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hemtgnt4vb2tGqBCZWId8NQAOcBZNgLCUcPgImg6Kx0Jf7q/DhY/U4wHk5Ix?=
 =?us-ascii?Q?RhpawruiaqHAtlw4Ghdg5LzJSOGHRePdy7U1mgFVjox3RXI2q+tuU6/EeXwf?=
 =?us-ascii?Q?2tMvgmBFzSyXH0ZZKuZ2PlgnLQna4k+es5OxYVcxFU1GiHat1X/+uLY+FXLM?=
 =?us-ascii?Q?koKVIiNwTfTAyTgxJbg+fj1jANo1WHCr5Y6Kwd6sIkb5KiTvN6icjyZrClJb?=
 =?us-ascii?Q?0uLpzw3FWuoYNiIvqllxUOzzM23KrIQLGWoZex7hLpfPdap7D5n0u14U+TDS?=
 =?us-ascii?Q?piMvR3wn5EiYVA8xAbVeg2EhWY11NCp/TcPMWAzPP3JPX4/4+6yjyzg682A1?=
 =?us-ascii?Q?7tqPyL46PToU3CpAYb2JwyB2yOaHnWy3Z874YFjQdv11XDkUGpEs0rwRjNls?=
 =?us-ascii?Q?wRmLsAHctBXNClph5hzIeQdH/EMI8Iu04UeWuicaK+TSu6d41Jnj7UnjatNx?=
 =?us-ascii?Q?UEg83UirGJDl7Avq4/V3JZb2Xua4KZbDVF/FIpKwAyNM67+E9a+akpjGGhFs?=
 =?us-ascii?Q?9ve3+dVaQnHpNzhtPenoqLdcip3dpApM9KLW5Cf096iIKyo0EaLwttfbrwaN?=
 =?us-ascii?Q?lWKWO2BrxPepDHV7M9Hr0C1z5izEIkzsmtf712xTQ4cTTBY8gzXiD52fNS0O?=
 =?us-ascii?Q?X+dct8dMB3XAStv60c2UkHy1JcReNjDxMNTowUwR9VZw4aJ52C1kvIECOPaH?=
 =?us-ascii?Q?9vwfCq0OshhkDboCWrLOCbfZWmkN1RlLhPtsL8qxQVKa9aqfjoyGLu8VVgYE?=
 =?us-ascii?Q?yphV5sx0aEwpxEi/OwURhTa3WLNc9GdpUWK+ZEuSmsa+Fun3S9L6YLa5NHkj?=
 =?us-ascii?Q?f/fpYKjEWYU2QZhsa1rj8VtHKnpaGhc9BXE6m0imn70MI1IQORRIvHBKrCj7?=
 =?us-ascii?Q?El9gWJQFblgheswGFibMAf/zh0UQr0e+A+KR1IomC4Vl51gnU4z5NuPU6ZtZ?=
 =?us-ascii?Q?hCIkq3pfuLQ2Ekwr/+o2inHpxDKxLcAWPZyEenKVpUJN7PJlhJ09zcNiXkLH?=
 =?us-ascii?Q?lgHicFDKOrEtCqbSlv3orPDxwxXiUd6fmwKmVJTT+1xFs06mLX4E9RYraDyG?=
 =?us-ascii?Q?1nzgqBzlmW2th74kaRLJoKSf6+AlaEzc+zVUbNXB5pJqr8Q8j//bRxQ0Vn7V?=
 =?us-ascii?Q?usJpSkPFOtjxg23lH9SZt2SEJyT8L8FognpZscUjT9ihg4TYWXgxmDMampUX?=
 =?us-ascii?Q?eWMtgJtlSSusxEtfHK1sZ/93IWs36zl4QIGh+WWosVPY0ERpaCVqCp77/XBV?=
 =?us-ascii?Q?tXEmOmiBDenBb8T13DG9VEhChBX3GBwPSmIRSjxA3UdSi2DGDoBiAalutZCO?=
 =?us-ascii?Q?MF54XddhCkmvZf63Ig1Sp+1z07UB4oqpdeRH967Hcsch+NY591IZykr7VWA2?=
 =?us-ascii?Q?0LXMjwd44LpqA1hovX5xiuSsfWCTr149ZNoRqOvxovcjDiTgGyuHINA5aEAz?=
 =?us-ascii?Q?ou04cwi0cJId01SpG8w7KXea7yqhTDuqNl6BiaCo6V6h3AbPErTVA444kolS?=
 =?us-ascii?Q?GEbLtx0lk0RLQuQirCokJlx97ciIn8xlYf+HPHbvjlWMwqPjiq1IfDtNQ+3V?=
 =?us-ascii?Q?tRqMVWai2qIwRcsaNwbNfPwtuKAUUGzK3Ht8k3h39Ci9ofuK/hWfEVpcFPGn?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7738a223-ad52-46dc-4f6d-08db4661385c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 14:19:17.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BITT8N8zJQXY/XVMFD7wYdwAYVue/AW3TV3SpgppFzqUsei6z8OrsXqH/VADuG4HduL6eL9v2K0/T0Tb+c7KxMTS95Sa8mr4vXAn95Nft4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the clock-frequency property is not set in the cpu node but in the
parent /cpus node, the following warning is emitted:

  /cpus/cpu@X missing clock-frequency property

The devicetree specification in section 3.8 however specifies that
"properties that have identical values across cpu nodes may be placed in
the /cpus node instead.  A client program must first examine a specific cpu
node, but if an expected property is not found then it should look at the
parent /cpus node."

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
- Refactored /cpus node lookup
- Add missing node refcount decrement via of_node_put(); of_get_property() does
not need it
- Track lifetime of /cpus node separately
---
 arch/arm/kernel/topology.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..32fc1c8d9d11 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -85,15 +85,24 @@ static bool cap_from_dt = true;
 static void __init parse_dt_topology(void)
 {
 	const struct cpu_efficiency *cpu_eff;
-	struct device_node *cn = NULL;
+	struct device_node *pcn = NULL, *cn = NULL;
 	unsigned long min_capacity = ULONG_MAX;
 	unsigned long max_capacity = 0;
 	unsigned long capacity = 0;
 	int cpu = 0;
+	const __be32 *common_rate;
+	int common_rate_len;
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	pcn = of_find_node_by_path("/cpus");
+	if (!pcn) {
+		pr_err("missing CPU root device node\n");
+		return;
+	}
+	common_rate = of_get_property(pcn, "clock-frequency", &common_rate_len);
+
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
 		int len;
@@ -121,8 +130,12 @@ static void __init parse_dt_topology(void)
 
 		rate = of_get_property(cn, "clock-frequency", &len);
 		if (!rate || len != 4) {
-			pr_err("%pOF missing clock-frequency property\n", cn);
-			continue;
+			if (common_rate && common_rate_len == 4) {
+				rate = common_rate;
+			} else {
+				pr_err("%pOF missing clock-frequency property\n", cn);
+				continue;
+			}
 		}
 
 		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
@@ -154,6 +167,8 @@ static void __init parse_dt_topology(void)
 
 	if (cap_from_dt)
 		topology_normalize_cpu_scale();
+
+	of_node_put(pcn);
 }
 
 /*
-- 
2.31.0

