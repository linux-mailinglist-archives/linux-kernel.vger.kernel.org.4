Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B0663E85F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLADi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLADiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:38:23 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65115CD1D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:38:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnpBrtFQ7Pg9WyLC4fbQfZbY6sGfJtvFHGQQ8y/kV1k6Eoc6gd9EcHDyQACHSDB/24Al/Tfq/adHoZW2unGgOUk/o1BxzBh3nx8SB8WXSaifTC55BB31TZQlT4w46DRg2O59XuHT/ZN04gPTSEsczyxBa14dkHKUMZeuESUCXOOW+SZypH+AaFaceuQzA/xl805Z48ugmaPVjR5s2RKI/psR4dtMgYtbfVjVo3EF4gjSJRhkwg6Ad/nUmvWnmuWp4B1KFyR+dNBnVRtGzQO4eUR/KzUZbEevtsYxIN/b/pucErU+fyWeHpDAt6+O7PFkCfDSQlw0YpkoE7YdVUOXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2gE6Q9kr26tzDPE6GvfG3QhAq6L5ICaMMZ/eFCIAtI=;
 b=TB+C/7zV0YfyWk8FwbSiqJGEeYkLb8Zq2dYBwM2PnXtc1SJ/77wjjcbFSwNCwpB7PUmixXpgSZabxQ7wC762DfFK9gUCncQ5s8Exd3hwoHAkYMB/PHaYv4ILspmwKuTPMjeDZe7odTBkB/zT6upbsfpB2gSRU9XzYtlf4pWqOR6mWHGQwo87idNHSxajcgng1nhnpPZcjldOJyeBJ/ZGvinGEyCYG9AuXstY3TV3yFbYkfJ4eAKd/A7g+E8iYQ5/ZbQMLKTJUep5mFVuFadj38x28gxPz64GVdkvD1K5EluRjX/RB8aWFI7cty1ffXiVrRMI11IKRnFygQGVmFoHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2gE6Q9kr26tzDPE6GvfG3QhAq6L5ICaMMZ/eFCIAtI=;
 b=pUMpObPSmmoMei/T56gaCXSMz/IeCCUkYi4gWH16u7pOUkXsVwPQD1cJCTFcaUS2DvSndacv/ggGbJW9SZxszU7HRkU0Qnqp7m5npj5WnUBr5dX62iSb40Reua5o6BVotQn3hVWua8YwhAczMiYPNxEz5Rb6QUBnvs9QW01hGkAtNz3oSeTirRcDU0EImKWDnXD1tW5hrE/9CG646Zb7K1sH+3yUExZ9SZ54dwyXdbckl0riJlBiNnIBoIzCfLsj71ecmxe3RcriMc2OTaroBkrE8Dl5pguKXigJJvzhfRtRGEQNPgHuvS3y7p6amwtLIZO0DqyagoTJG2UnO3Nb2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB5940.apcprd06.prod.outlook.com (2603:1096:101:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 03:38:20 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::1a6b:94bb:3e8a:bdcc]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::1a6b:94bb:3e8a:bdcc%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 03:38:20 +0000
From:   Rui Zhang <zr.zhang@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Rui Zhang <zr.zhang@vivo.com>
Subject: [PATCH v2 RESEND] regulator: core: fix use_count leakage when handling boot-on
Date:   Thu,  1 Dec 2022 11:38:06 +0800
Message-Id: <20221201033806.2567812-1-zr.zhang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEYPR06MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfa3538-d9b7-447f-cdfe-08dad34d7d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9sSduLujrXynXKc3dknYddgYLk3FP9oGXlEl6hX7zPkftNcgNrT6ovBZfEHqJ8FddxjRZkrY/RkUKLHC1H+SE7Yu5GUDr6pxR5LAkJxKc1Fkgy61BDfIKLfs1GZzRnRGppHiwz5HqkexwAIwbirWrrcxbgI/EZdGXcVTQJm3iJ97jZ3i+7aJkLEmfRg/U0yiLPWCD3Jvt4sfSNe9XlscAVmHr3GSStVgW7RcGqa7Nx5qpoKhHzczsxgCUlrQgx5hu3cbPFejL4yXcVq4pNo9TmFSMggUnvtIZOcyKVlVKQWNEX0YaCWyNCfzS1y7BOJ0tHv4mRGo1Auv2OgCQ51j/qwjVchOdUpuKWO0OjDxA812l+sLv7WxL8W2RTEpFH/ERae2gHAVsuKVb+nJTjuxC5QVjF9rKhIKrZbAoao1IAmFE9cSoCNM/dx7q0PMYpIpdgUQ9VXdehmqlNsUHxpNdMxdhdv1BOxckuhKQQQkELsK2YvNcAi8cC69Zyz2uUxtI8ktKkLdCfKj9Mi2aIZewzbal9H3AvMBiRAMbZuVswrBuKcLIgtQu04yaRr26g0ScpiTkWtThnxbp/GRANNycDyty4UvPva6KcLs33N6HLe1ZajvBZI3gqNEQm6mskBDnk+eIuTnYJut9d7tEuNTGICvtD8bP7xwU4ws3PEKloXZEPlJwZ8TiLyWyYmhigVvn9AiMhad0INGcjVfFG/rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(41300700001)(66556008)(86362001)(83380400001)(110136005)(316002)(36756003)(6486002)(38350700002)(2616005)(66476007)(38100700002)(2906002)(66946007)(4326008)(107886003)(8936002)(5660300002)(1076003)(478600001)(26005)(186003)(8676002)(6506007)(6512007)(52116002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lGbjJsc25yNS9IOW1lUENzcExTdkt3blprRTdWUXA4OUhsSk1FRTFXRUly?=
 =?utf-8?B?OW5vZmhURDREZ0JlWDNVQ0h0OE9veWJ3ZS9ZZFg5QVdYbU5NelBndHVIWEJR?=
 =?utf-8?B?dy9ydmxRUEFua0UvT3BUR1ZtVHlsVDZRUFZ6enphTEtRa1lsaWZZS1ZKbklW?=
 =?utf-8?B?a2loZmJra0JJeWhndE9OdVRRVXJtZTJkbG4xdkZkYXYzc1lpL2lVV3YxaVg5?=
 =?utf-8?B?d211WG45M3RYK1hRZnNFODB1TlBGYk1PdlJISEYzVUQzbzdhR1c2S0hkMUhL?=
 =?utf-8?B?Qm9aL2dHWkthT28rTE9EYWVzUkZSYVhLMm9menRydStGdVJNQXVKV0hRRStE?=
 =?utf-8?B?ZmMxV3BXWEN2NThZK0Q4VW5oWTdpckJ4dFJKeko0MytjZ1RoZC9vZFFqVE5m?=
 =?utf-8?B?WFc2V2pteGFkUFJhcldnNTFFalRtNzd2T1pDeHZaaGZ4anFnK3BaSEE3b0lx?=
 =?utf-8?B?QWdyQ0FPeGZqWDVLQ2kreTlBaU50bE42Rk9kUkNyRW1RVFluZnlLaWtwVUpq?=
 =?utf-8?B?d0hqSjVYUkVQZFo0VHpDTmt6UDB4Y0syWVY1QkxxWHU2c1BDVHNGM0JIMDlB?=
 =?utf-8?B?WkpidStvZTlGcUpLcXFCcUtTayt1RWdER0gxaVI1UDZXcWg3L0R1MGRybzUw?=
 =?utf-8?B?NW9nVHFIN2xpRVZXZ2Jraml4T213R052WUY3OEN3RCsva2JKSnJwWDQ1dWhB?=
 =?utf-8?B?QmFCYXYwU2Q1QkNiWHBjdXZpZTFtd291UUhMeVRwVHA0VkhFT3Zkd2dhZ2Fp?=
 =?utf-8?B?eCtWQjdVdWQrYWEwaTcxTUNPY1k0TmcvOEE2cTJtSEY0TG1rWVhhMWVJQ2kv?=
 =?utf-8?B?ZXFvSFFPUmg2NFpZOG5kNGdWTmRTTlVHWTlmRnVxaElIdFVHNU02NzNianZH?=
 =?utf-8?B?N0QwTzJDcUFNS3Y1bFZDQkx2eUQzRWUzZDJaQm8yTlZ2QTdhVWo0RVl6SVJa?=
 =?utf-8?B?Q3Z5QUpBYi9IVzBzM3NKYjNYQnVzaEhiTXMrQ2h1VFdjbUxNVzgzUWYwTVlR?=
 =?utf-8?B?WTd3QUwxL1BvL2ppWUp5Yk9HOFN4QkMvSmF0M1ljTGJyb0FudjBWL3JiZ0lK?=
 =?utf-8?B?SlUxRDN6K3RSTXM3WDRqdmpHeFJUKzZTMXcvV3l1QjdJUlJpcng0dGZ5Tlpa?=
 =?utf-8?B?VGJrNGJYRm9lOW42emtJZTRTdDdKMWFNc1NBQS9iTFJod3lYSGFjL1dWY29D?=
 =?utf-8?B?ZXFBMzV0b1dsS1FwQ3JWNU41UnFGcWxoWi96NmJzelVtMHpodW9SVW4wTDBo?=
 =?utf-8?B?d0xMbzc2c2xGMEJuaCtDRFE0SHhFbU5rNlV4b0R3eUo1cndibTFmaVRVWlBp?=
 =?utf-8?B?Z2ZocnNRTGYvSVB6WnFVcG1DQ0lsS0FkeGlybDlFTjBNeUUwZlAwa1JWYUxD?=
 =?utf-8?B?VVdsU0tOUzFMVlkzeG9vVXk5U3M5S2w5SGNpdFlzWW1admtUaDF6U3pFeXoy?=
 =?utf-8?B?MzAyTmQxVzZ6UHNoR2JuYmdDMmpvQ1ZFUXk2VXhWSFFpbGthdEI0alN1bU9S?=
 =?utf-8?B?MHJHY3lsSEN4WnZyczByNjZwTEJoNVFCK2piRFZ1YnZqeWZRM3BwME9uTWgz?=
 =?utf-8?B?bStiWW5iNmdsbHpVVmVuN3JOU0FCN1BWVnk4TDB2K3ZFL0plNWVWQzh4WTFJ?=
 =?utf-8?B?K2RnNnZuMjFOUWVGUWFzN2wxTS9tSGNYSm00b20xMGxPMVlsclArVmJoK1lH?=
 =?utf-8?B?L0V2b2hBdnNWc3NqbzJ6K0JiZENZcW9nQTFwTFJydURsTXNHbWJUTktkV1Y5?=
 =?utf-8?B?ZlUrTjZoSHhEa1FQWUd4a1JCOUFkYW5pc2syRnl0NEZoQ3U0dUYvbHBGNHRt?=
 =?utf-8?B?YXJHWDNHc0VpVlpjY0NyWjFrYzE3bEpYTTBZTklKZGJUZjBDSnJ4eTRlRzB2?=
 =?utf-8?B?M0lGVm41VHlQNy9EcklhOHBKbVJqL1lKbFp1cDE4Z2duWXZGQzFBNWZBNTJP?=
 =?utf-8?B?Qk42QXRGamdZdy9YSmxiZnBjT0hxNW5ienk5czVsQm5DdmZKcUFvVlJKYnZJ?=
 =?utf-8?B?Z3hnemxpMDd3OUFCSGpJcCtlaTdyQ0t6eXRYS0dnU3lmVDBTdXh1MDNJVEFl?=
 =?utf-8?B?M0pIbHFQQlNZYlZsSUoreVRqZlRRTW96NEdsWGdZbnNydWxzcUdVUU5MQmd6?=
 =?utf-8?Q?PPTeZfIobByso4gc7VF+XTxeL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfa3538-d9b7-447f-cdfe-08dad34d7d78
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 03:38:19.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWtZ92L+PBPAUIPT7Bst03SSqpuKIQVOXBphbJCj2O7JpLMHm6L7cL6IT8nP0qSoCIQIS9JJuyYnV/4J0QZBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5940
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found a use_count leakage towards supply regulator of rdev with
boot-on option.

┌───────────────────┐           ┌───────────────────┐
│  regulator_dev A  │           │  regulator_dev B  │
│     (boot-on)     │           │     (boot-on)     │
│    use_count=0    │◀──supply──│    use_count=1    │
│                   │           │                   │
└───────────────────┘           └───────────────────┘

In case of rdev(A) configured with `regulator-boot-on', the use_count
of supplying regulator(B) will increment inside
regulator_enable(rdev->supply).

Thus, B will acts like always-on, and further balanced
regulator_enable/disable cannot actually disable it anymore.

However, B was also configured with `regulator-boot-on', we wish it
could be disabled afterwards.

Signed-off-by: Rui Zhang <zr.zhang@vivo.com>
---
 drivers/regulator/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e8c00a884f1f..1cfac32121c0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1596,7 +1596,13 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 		if (rdev->supply_name && !rdev->supply)
 			return -EPROBE_DEFER;
 
-		if (rdev->supply) {
+		/* If supplying regulator has already been enabled,
+		 * it's not intended to have use_count increment
+		 * when rdev is only boot-on.
+		 */
+		if (rdev->supply &&
+		    (rdev->constraints->always_on ||
+		     !regulator_is_enabled(rdev->supply))) {
 			ret = regulator_enable(rdev->supply);
 			if (ret < 0) {
 				_regulator_put(rdev->supply);

base-commit: 01f856ae6d0ca5ad0505b79bf2d22d7ca439b2a1
-- 
2.34.1

