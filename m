Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012BF626A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiKLPlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:09 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70113.outbound.protection.outlook.com [40.107.7.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562271ADB1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:41:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwqaHWe8eAlKYWcOSryYES4aAJ7jTCTpTvgglVXhmazhEUb88UGuVRHWX2H8JbWI/KVYc1sjW1URE/kC9SFPKEclcqb2bfezkWZofyuytZXE+TsztfuLYS67G3pNs3m3JOA/x4w52t5B/Th7SFQqIyridDW/F83JMhs3tZuI274Afv5NxfVGweKUWZRbOMbWIZ5OCoQJD70WoJFGsrRNa8M8O+8apEy92Hvy09D/uYNXG8IpMACur1ssnbOmJPmGRUB7Tvu0bSoy0kt2EFaKkshOOBIoBFRMsQ9LhAyYycdrxmlfvzyym1pgTxz/B1ixv4ics3cW20Uogii5oL227Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqhKasZBlkgm5NROFm5coMmTKsICdPOLkS2XWzt0JW8=;
 b=L2r5TXNhpLcLJtFaxjNxK7PUqMgCHyWm+iPADCyUPohuDmUsGHRcoBQPq+YNBSNSDaV/LAEygbRZpmQ6lRutuzxZQN4LFkn0O2IEi0wTdI7nUfI/qT4zHZumy9+KiCjFftKNz2rge1nUkOr6KGe9JTOAoVUFRtwK4+StdCvWuAs7R9aUjRcdXUUQm3Rnn72Sec0laj5ZtsEBjoA5lKtgwvwE9Z0V2omTpTg/tQN1yrtFk+P4aM4FG15HcY5mcSvf7ae8jrd73X8stLaMm712TyqFW7gNiPqHfaGLadMnyEGBatIxnQicJ521nm9ZDdsjTbKig5A/QLDzw+cYLdq16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqhKasZBlkgm5NROFm5coMmTKsICdPOLkS2XWzt0JW8=;
 b=E38VY+BNQmANMsb/cYpVaUs1aGx31KDYKHhEcMM2eF5YdPBUwQZ6lwks6trCqYMjaBrpjH0rkEjkd7J5UVVWbLK2Ft1M3D8/d6rrU9CgB40PaN23Xzyqh7hXU1g81lo/u+scoTg33tCYzS7EeQtCQgh7djK6qGzx48L8O09BzLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by AS4PR02MB8384.eurprd02.prod.outlook.com (2603:10a6:20b:51b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Sat, 12 Nov
 2022 15:41:01 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::ad1e:9bed:b822:8d08]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::ad1e:9bed:b822:8d08%7]) with mapi id 15.20.5813.013; Sat, 12 Nov 2022
 15:41:01 +0000
Message-ID: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
Date:   Sat, 12 Nov 2022 16:40:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0032.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::33) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4445:EE_|AS4PR02MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: 52caad54-b4a3-4b2b-6bc0-08dac4c44cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlfOTP3MsrUf9MPbTn9OB3u1ZQvKADC1eXyrLEOC+AHYfPf/kwh447cqJ8lHfOdZFNHQl+cK5HRowDQ+e4AZpH4CW1rWVA2cqRkXHVKy+tQGv5y20RaAUSBqm6H1+jj4A4dIWvesbZqLdotJqPbrxLyGnk3hmj/K4zafWGNYygOi5k+wgqAQDKNbL4Rstx7NcPQANfblM2TyjFY+6U7zCKyA0LOsmtN2UNJAaWHsEIJcMJzCFfe9gP5mnmH0bSR68TvXRzsiKh7RW+Ydb7vDRoqugQD8kWfM6B/ZGLyFTu2WSkAIL8wuQ1D64nekFoUkGu1VJoNn1gdAgGDbeAfViUY8cph7NjRx/wKcqflBFXV8mObxxQz3r+wi+E1oqJRwf8j+VsV6yXF8uEJZ3/pnxDPng70YuqVA0ppV0KWCOf90EH2JsxlxRghYm9q+Sz8aWjtkhPbHuj95Js5q8OILNsg1Dd0n2F/8Xhgt1ZXLfooSS4OiIvW9rEQSsIg7RS1cCpY+eCTsFn4pWSnBNVG4lCoAU30GOHXAFxVJV7LxUTWWMpR3WPY4LosdSmQr76/q8MZW1gGJnol6qMg5yYHBL8sL7I8qHMdqamyDo9rqoBWrjbN5afuR9zsRamkuuU0RcSsdXedHS7BYablFrssof34c2aeUAlbWHEE5frDAhmANx6YIgvb2om7kh7L9nQeGuLevLhvylnqK6lxW3oR56tvkPmMGkRkFt26avW7oF4jUMVLEiRc2RS9dN8+B6Q5KMGXtfJx+tqVmmuC3Vsjo/s/hk6jF7lG6It9r1lcmzxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(39830400003)(346002)(451199015)(186003)(6512007)(38100700002)(4326008)(26005)(83380400001)(6506007)(2906002)(2616005)(478600001)(316002)(5660300002)(6486002)(41300700001)(54906003)(8936002)(6916009)(8676002)(66476007)(66556008)(66946007)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhBeDJjWTgxeDZQa3VxOUV2cUlkM096R1hyRkdOc0JPY2pQQ2tPN1VYN3Uw?=
 =?utf-8?B?SzJjYWFQU2dlZklmWmU0cWlsdzhtMldQOWw0UXgrVkxUWkZjSWx1QlE4cjFC?=
 =?utf-8?B?N2kyTi9GQnBXeTRJOVhtMllHVXo2RVFkckNrZUFXY0xpa0Z5bFNmU0hkWnFl?=
 =?utf-8?B?VEFKVkh6WVYzMjlQOHR4UFFpT0UyYXkwNlV2QlFGbHNpWVVBM3NoOEFQNTVK?=
 =?utf-8?B?QmVsbE9DbVoyM1lGR2d5eXFRdmlEeUN0RHF2QlprVUxhVHBabTV4Z3JmMTl3?=
 =?utf-8?B?d2s3VmZJVTd5MWRHMVNnWEIvaDNjTkxFSFhnU1lxYWVZMHBIZkJUTFVYS2tm?=
 =?utf-8?B?bXYwTmZKSXFaUHA0VjZkZU1zLzNQQ25xNU5TL1NYa1dsU1o1d0NFaXJNSDRs?=
 =?utf-8?B?T2xUcnA3aEtzOXJYRlpRTmNGT01FMCtOa3FEUU85TDhvMU9iaEpQYlFtNjRB?=
 =?utf-8?B?T3JOSVFod0NNRDVVMFJHMjNXNGxwTnkvYnFjMmxvNmJWMXlaZ2N0elFSWWlL?=
 =?utf-8?B?Y0dpbkQ2ZkI5K0NuRVdNNHRSNXVvME92YnpiWVdRWWh1ZlhNR2t6akxIOFI0?=
 =?utf-8?B?MVRZNUllQkZxZGxsN0hSaU5hV0l5RzdzZllCUUhnMUcwZGVtR3pJV3VrK2Zo?=
 =?utf-8?B?QzNDSit3WjBjazFidkhsUFZRSmdDODZxMlVxK01salBiYUxKcVI4RmVzR3hN?=
 =?utf-8?B?cmdWaEd5Zko0Z0hEZElrRERxK2svdjd2c09wU0dWS0dVR0xaSFJpWWJrSmNW?=
 =?utf-8?B?WURUaERLaUd0OUVZd1FrMStmdmhiNUF1NUtkSE5wMEpHbTkwYVJSdzMzWjBU?=
 =?utf-8?B?S2hnbXNoQmkvV3kxK3dsM1BiemthWlF4TWlwdnQrRWUxOE9wbE0yNmFpSVpL?=
 =?utf-8?B?UUs3MGIrNXlUd09SRHhqelZRVy9CcnppeU5FQjFSbEZWMDlVMHJzTENIYm9P?=
 =?utf-8?B?ZC9TY1VhN3AwM0FZZmRwc0dzeVJsWUdJZWVmellNdWF5M3p4VmNSWmlpdlJs?=
 =?utf-8?B?dEVYa0lBVmhiNXpRSjZUdGw2ckxQUWh3RVV4dnE2VHBOQUdoK1BGcW1pY2xU?=
 =?utf-8?B?U0E1YmwwN09QQjA0cmZCLzZ2M0VDdHdnUmdkK0dSdkp1V2VCcTNsN2VxSnpW?=
 =?utf-8?B?YlpyZkw4L3pISEtUeXZ3RENmTDdHNjB6ZDBXUEtyTVVscnJXKzM5TU9aRWFr?=
 =?utf-8?B?Qk1hZXlYTXhlTFFuQVRzK1JLOFpkZGp3ODJiSm1vUEhrNGdOdGZqT2xCVVRZ?=
 =?utf-8?B?Z2ZLenl5UFY1cUNYRXROQkxTelJYREN3L29IdEdydFRiakZaM0M0Zm91UWdr?=
 =?utf-8?B?UmgyZ3A2TXQzZWJyL0ZOdk9iV08rNDNvYXZoNUV0clpTK05HOFZhbHRvSXFT?=
 =?utf-8?B?S1NPNUVtSXl3Ymkvb21NK1VlVG1SWDJHWXZYNDhiekJMMDV4Sm5IQ3V2c2dF?=
 =?utf-8?B?NEpmMXFYdSsvd3c3M28vZVBQUTgzRk5rSGRlNUdBYWR0NHl5MVpBaEhJM0U5?=
 =?utf-8?B?aU1nYUVOMmNxaXYzd3RFTFpEWlc3TVRkNi8rQ2tpTit5MSt3aS82alJDSjVM?=
 =?utf-8?B?OU9Iakh0V1RWeGsyak9VYm4xTjJSbUk3STZOai8vWkFkQUxQRHArcEhiSVh0?=
 =?utf-8?B?L1NrM3hDbXYySUhoTjhndUVuOWxrbUpTYkFFZVEvQzhWWWNob0xacUkzZTB5?=
 =?utf-8?B?TTlQZzdIYjhaNFVJbUpOUDJ1WFRJMHlRWC91UEREQ1NLOTdRSGhyd054em0z?=
 =?utf-8?B?VU1ldjR6bjA0YWlNMmNLZndJQmxrY1Y5TDUyc2dTSXNDNHdOcWdhUDdsbmMr?=
 =?utf-8?B?U0dEL3Vld2RtS3BIdzNMT2k1V001NVJPWGp6MHhQYWhnVkFsOG9HTHM0U29E?=
 =?utf-8?B?d2VMN1ZOdk9ZQ2tUaUtyY0FYc3loRFhTeWc1UWFFRjg2VjZCZDhjbHlocXpD?=
 =?utf-8?B?WTJsT0RWUyttZkRjT0tuaW9PaTlReHkzU2RGTU5IaFdoZU1ZQWM1Vy9PcnZB?=
 =?utf-8?B?R3hhakl0VjY5N29BUFpCZGxyNloyazZwQ0ZuaTR6dC82MmJuYTFlK2VVZzMx?=
 =?utf-8?B?bjJOUUJ3a3VLdTVqKzZHZ3llWTN2QmUvSTNLelJwdmRMWlA5TnV0YkR4b2s5?=
 =?utf-8?Q?TFc6tMXy1waErIpmcW/kVKysh?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 52caad54-b4a3-4b2b-6bc0-08dac4c44cfc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 15:41:01.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmg2Vha/DRPJLPFIU3Q8f5KH5TRU4/i8aEZ8yrgv9QF5q6LlEhj83ak6FW2Gjl7S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The L2 cache is present on the newer SAMA5D2 and SAMA5D4 families, but
apparently not for the older SAMA5D3. At least not always.

Solves a build-time regression with the following symptom:

sama5.c:(.init.text+0x48): undefined reference to `outer_cache'

Fixes: 3b5a7ca7d252 ("ARM: at91: setup outer cache .write_sec() callback if needed")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/mach-at91/sama5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi!

I'm not sure this is the correct solution? Maybe SAMA5D3 should bring
in CONFIG_OUTER_CACHE unconditionally instead? But that seems like a
bigger change, and not just a tweak of the regressing commit...

Cheers,
Peter

diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 67ed68fbe3a5..bf2b5c6a18c6 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -26,7 +26,7 @@ static void sama5_l2c310_write_sec(unsigned long val, unsigned reg)
 static void __init sama5_secure_cache_init(void)
 {
 	sam_secure_init();
-	if (sam_linux_is_optee_available())
+	if (IS_ENABLED(CONFIG_OUTER_CACHE) && sam_linux_is_optee_available())
 		outer_cache.write_sec = sama5_l2c310_write_sec;
 }
 
-- 
2.20.1

