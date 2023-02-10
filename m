Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B806691D20
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjBJKqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjBJKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:46:50 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2114.outbound.protection.outlook.com [40.107.8.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE38527A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R97e+6mwUNz8JCl6xkXxsr1amAUFLASydGQDakL4Gd8RnHTo8/rMawHXvUqSlwoY7freCFo9IA3R246BooCSyCQoaRLc2cISJ9O6DYhJm5mmPsoutyIoIYOg9oIZD004a6V1LDOAA8Yrq/slgOtfV4fvKBqlCqd2SrB+GdujdGqRRb9NGW0QE+h7FXIqk1YhrtKC+Ko/m/6bKS7XrsCdACU6ZEqDeDS1eXAD4Sa0r2AVbvKJRoKeZbTMzsCVVB42dJr5hTsobIMnmhsnfZxYF20u5sdGDptOUlN9MqLYxP4xnO1ZI7grc6Lw89lFff2YJfSSMaBmvcIyjMIjstlh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu4ZoDuRvMDJppfx05VORo3xHkwOMYuKg9t4dmjuj7o=;
 b=h6JNBsV8YMQ7T04icglPF4GCLiXjiBQuB4glsC7UpszA72jeuSHFHU4ZZeiAVbzvNvhNmncReEhIPj1XSLbTBomREjeucxN/ldYubUm+CWuoS+ZQHu24JgJakWs4Fu3hhS2acEB8H5xCFsiczB0Rs0JuuWZlZxzpbachifXbxUkiW9YNbJwAs6U5wuh55LxT2YDE6QvIl8HLOr4HdYegRyGfAYKpSp/Pxzcqk9znJQ6M1j7RVHyxE5SP5IGCoXy8KVjDyydmBnZVDjjRbwP/BzBH9au9qaiA9bYNHxsQDd2ftHMZ8LpbZKlwRBiNabsqf+Wz1iwMs2dOvBP6VxWFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu4ZoDuRvMDJppfx05VORo3xHkwOMYuKg9t4dmjuj7o=;
 b=Js/KWCWb/epRCid8fu3PZ2DkOiq9nRhe+Uz/m0kYxQwSpyQtPshXnLSgovlaxZx5+SSYDEMDeu0HSDlhRQ66wkGV3ej7GLEsu+ItuKEZ/AITmybU+gajZI1lNUNNgcKMTRXyT5jZzzNbNPp00JjOph+JuLFct+J4MhEzJZyinbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS8PR02MB8544.eurprd02.prod.outlook.com (2603:10a6:20b:549::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 10 Feb
 2023 10:46:44 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::6729:6fa3:a04a:5afd]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::6729:6fa3:a04a:5afd%7]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 10:46:44 +0000
Message-ID: <89199aca-5b57-e8df-03ca-b2658ee9d8b3@axentia.se>
Date:   Fri, 10 Feb 2023 11:46:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH] mux: mmio: select REGMAP as the code has that dependency
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
 <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
In-Reply-To: <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0106.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::21) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AS8PR02MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c17955-654c-4d3e-34ca-08db0b541a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+jIxBmEZDi2/A9U0/U4U4dqhVSi7GsLMzYAQ6ani9dCUt7smYFydGFeMZbjPEPSSQv949SxvzebBdkXY3JofXeMhxLWCCDT8QdxzcLusbfg6ABAc8ayXZB4zlx6aarBcMi11vIxnSoI4U/xVzOEqC2+jCrBQZ0hn+j8WtQDTiw7OVhpTYQTpDQ0PkwEaOIzVEidqRcfBcMl5AOd5xrRHlLiVCpUKb+pZ8UtvdZN6yxDf1fxIPofohmG/pDxsRXPEYLGqtp9d7XNI3k1KSfTdRSmDSLKxz7ZerQzE2ytPmda6Y7vpXz8pjFSiNd4ThedlqLyy9MaBwOUqy9lxStvJsDfP8Cw5Xy9qzdhK5f9P+GHoHke/9IhWbOQ33IdKyIjiXcdc3MU66wcHAoV+e6GmslywRsCW413mkdSEvkEOEbPz2LE8eLADO3ojJRKNwAKUGEoyaC3dwi1JDm2XPYRBjqakxgjWmWA9JpjJHRIhAyDksYF+g98cDa27rvYOPI8FF9G0lHiDw7OysS/abvp8rYRjhWGzIivy5Bk9DAkVNN4z+YQWG1sckfz0/dXYGM+tSvfnbz0L9zU8Zf2QACQ6ZB8HeXYbqQK/9JGTcOuAEbKkt+rePszC7w/CFjBGJjgxXRyB6buXBP2aAJ4jqlwtMaTfTNpuUEQbJR51gDPdWhy0OKHpLpiC6uXHXpa0C0VRnu5kBZhrFX6WvYffE2+zu45WoHRSlpV30neulA4q7++mpY1+0q04W62BUk4hQQvXIK0x6Nkeweu76dcQ2UN+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39840400004)(136003)(451199018)(6506007)(110136005)(966005)(316002)(6486002)(36756003)(8936002)(186003)(6512007)(26005)(83380400001)(66556008)(66476007)(38100700002)(2616005)(66946007)(31686004)(41300700001)(5660300002)(86362001)(8676002)(31696002)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWg3dWJPbU5PM2NqVmhnUGVRMDRQbjB2akc5UnQzZGtuSnQ2bldvMy91Mmh1?=
 =?utf-8?B?SUpRQU5hbHd6UCs0OUJPeFAyNUQ5WW9SVXdHaEY5RUlVZHU0TFpwcjdlTFJI?=
 =?utf-8?B?MFZwOXpKWUZLREVjbzdvR3EwYnIrSHpIWHhrYXJLM0VrKzhmZ0k5cWUxUlhI?=
 =?utf-8?B?aVl4Zkd2TzNFZExvb3QyTThFZnM1QVVPUnhLcVRRaFZGakxUQmdvMklyN3JN?=
 =?utf-8?B?Y0t4WTRkcmdDcTNrTVNVUEYwVDVVMkp2Y1BDL2FnNnVRWGlGSFRIWGpCc0NE?=
 =?utf-8?B?UXBJVDB0V3pETW15VWtUVmRhOWtVOGtYamRUWVdrYmtndi80dWFUWDhxREpm?=
 =?utf-8?B?cXRsWFJZbkd4cHRWN1dNRkFMejU4eDVTc2lxVW82WG1sWGVqbkpiajZLZ2hm?=
 =?utf-8?B?OW1FNy91SUxpSm9WMXBYa3F2Vm04dGc3T2todEtaamlNaXJxU0pRMzd1S1VB?=
 =?utf-8?B?eVNlVlN3em5hUEVqbXVYYmRoOGRFZTdxbDVSc2RwclM1RTNWYiszYll4OG42?=
 =?utf-8?B?WUttSjhiQXd3djhHY21FSHJua3F3R1hQRGdBQTdRRU9JYTMzZE0vWDRkR2ZR?=
 =?utf-8?B?YWFzdjVvWHUzaUowVW1kNU9Ub2JQSnFGNUw3YkhsMmZFUlo2bmt0UjBvSThM?=
 =?utf-8?B?QSszNWVibDVHRm10OFJUWHMvbm1xVjZmc1RHWkp6UjUySW9ibFpwZk5JQmdx?=
 =?utf-8?B?eXZDY3hWY1ZMWm5MeTVHWFc5eVVjOWRncWQySXJWRHRwdmRMSXpuMER2VjQy?=
 =?utf-8?B?MEdpdDFBamdOb3l2YzdDb2JLaUViYjhUalh4Y1NCdTRMNkFEWWl3dnFoYkts?=
 =?utf-8?B?ZGE1VUdhbXJyTUkyZU5QR3hSM2ZRVlFPU1ROZmhxUXpZd3BFRk5veTk0NXd4?=
 =?utf-8?B?T3JFcXdJVCtnNklLWEhDV0tGYWtlR2hQQ2EyT0R1cTlQekt1NnNaQzRpaGVX?=
 =?utf-8?B?WU5NSkdQclNxSkpVSE9yQ2l1cnU2Yyt0ZW9iejZFcnR1bGNTL1pzV0I1WEY4?=
 =?utf-8?B?R1pPM2RmNVIzQnk4TmF5VCtCU0M2S3lTUG5HQjBlQ09tbHZTak8wZHVxNjNH?=
 =?utf-8?B?NTdzcWpydHRtbkhxQnhlQnU4cUNEd0VLSTZKZDk5cHpPUHFwN0RkaG1SYzd3?=
 =?utf-8?B?NTdKRHpMOU45L0V2bHBLb2RxZjdJdmFHV21JV1pESHFUaGJmYkwwVk5yTzNP?=
 =?utf-8?B?bG9yQXlRcmYweXFWVzVmR0FXenBHYjB4b0JGTWJUSGNqK05RejRVY1lrTG1Z?=
 =?utf-8?B?L0t4b21nVUFNV3dNbE1MbU4rV3VaVnpKTE5IR2lEUHZQd2pZY1BCMG1mNm5v?=
 =?utf-8?B?ekhwZW5IcUE5cFBvdmh3Q0V4aW1KdmJCQ3VUZDJhdWU5RXhxQ3VzMmtnaEl2?=
 =?utf-8?B?UE5DR2lqSmJpTlVxWXVhT2Nkd0dNOWZraVZ5TjI1M1lzK3ROYWY3eGlQZE90?=
 =?utf-8?B?cGtDa2ZNTjg2VkJXRTJ0OUxmeEtsaVIzSXpsRWlqU3pBbFZsbVF0OG9GUy9v?=
 =?utf-8?B?UXZKTUwxRWFOd0tjdExsZDNmMGNvVUhyVDZsOHpZeFNpY3hCUjY4eEk5M0ti?=
 =?utf-8?B?eDdndHhWWFBuUHdnTmpjQlBXdDRsL1M4dGtDSGlSamtIOEtycWc2QXpubkh3?=
 =?utf-8?B?UERrNHdXNFZXazlTVGpOZFVOMTJGL09mbUpHeVRLZkptdHFEQmRsK1JRa0tm?=
 =?utf-8?B?ZzN0TzJob1pFQjdLQnlJVC9Hcy9TQ0E2a2RoS2h3YWhpUDF5d0doUXlYd00y?=
 =?utf-8?B?ai8vY0R6b1B2R2tOU1VpMzBpTUhVNE96ODZYeUpHVkF2SEM5TVJjRUxxUXVt?=
 =?utf-8?B?TlNtOHBNM3lWSmh2cVdtQjZSNjBvUlB6UUZ4M3BHakpkaWIwRjNuWS8rOHhS?=
 =?utf-8?B?MTAvdkV3dDNPQXpXTWt3bXdwWDcvM2lPNXVUVCt4THRRaVNHVDBxdXNRV2Ex?=
 =?utf-8?B?RmN4NUIwMHpZN293cGtVV3BkMVpsUGRXeTh6RFB5SXZwU0ZQelRWYTY2cDBI?=
 =?utf-8?B?dW9HUFhmMU54dUcwOVhDRXNwTDY2eFFLdDU1eFdJVUh5VDNWUTZ5Y0grMGoy?=
 =?utf-8?B?dlBTWThKbGF0dzI1S05ZaVp3aCt2V21WZHpOd3FHMHZPb3R0VzNabWFVMDdv?=
 =?utf-8?Q?KxdZFxejkKvd0wgJiVBVkmEXs?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c17955-654c-4d3e-34ca-08db0b541a1c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 10:46:44.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyQWi7pJJkQzLAVk4/g7ARl0jCn4vH6U7Bh79Mrb7Lg9e2w6i86hAcuScDF2jaGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8544
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_REGMAP is not active, the build errors out like this:

../drivers/mux/mmio.c: In function ‘mux_mmio_probe’:
../drivers/mux/mmio.c:76:34: error: storage size of ‘field’ isn’t known
   76 |                 struct reg_field field;
      |                                  ^~~~~
In file included from ../include/linux/bits.h:21,
                 from ../include/linux/bitops.h:6,
                 from ../drivers/mux/mmio.c:8:
../include/linux/bits.h:23:28: error: first argument to ‘__builtin_choose_expr’ not a constant
   23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
      |                            ^~~~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:16:62: note: in definition of macro ‘BUILD_BUG_ON_ZERO’
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
   96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
      |                             ^~~~~~~
../include/linux/build_bug.h:16:51: error: bit-field ‘<anonymous>’ width not an integer constant
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                   ^
../include/linux/bits.h:23:10: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
   23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
      |          ^~~~~~~~~~~~~~~~~
../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
   96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
      |                             ^~~~~~~
../drivers/mux/mmio.c:102:29: error: implicit declaration of function ‘devm_regmap_field_alloc’ [-Werror=implicit-function-declaration]
  102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:76:34: warning: unused variable ‘field’ [-Wunused-variable]
   76 |                 struct reg_field field;
      |                                  ^~~~~

Reported by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/lkml/64cf625b-2495-2382-0331-519d1cab0adf@infradead.org/
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Note, there is a patch in linux-next that removes "|| COMPILE_TEST" from depends.

Cheers,
Peter

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 80f015cf6e54..9234f8c400ca 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -48,6 +48,7 @@ config MUX_GPIO
 config MUX_MMIO
 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
 	depends on OF
+	select REGMAP
 	help
 	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
 
-- 
2.20.1

