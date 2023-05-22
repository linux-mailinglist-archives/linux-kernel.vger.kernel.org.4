Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4916170B9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjEVKVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjEVKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:21:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2105.outbound.protection.outlook.com [40.107.21.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A3189;
        Mon, 22 May 2023 03:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI2Imfq0tCughWoyLqrf/gI6odVCQPCLaQA2j7LxJSJsO+J3ZccCa0PjVec4UBxOKIfjFl0lOUJ6JGYc3UHUdX41sunAXldxUBZt6z2tkvTIuOfqUEzCLVXLxh/tblPhLQckDeE5QYcTvyURqjb14g1+EZO523ZiuYy5Ls8W+CLf+CF63hYDptxWh3OTsuwo1W8/QWsBH4A2ePH7jVF+nYflPB7leRNsHWbgtgdoBxxr4x3g5nK4GDnJluoCZuLxDW2zoL7qlIpTcJ/9aA8CvCxnvH16rZA1UZ3dsokuq73y22IYHm2WJWocZO60LAWOZHD021NWwcU0QPMZh3Sb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20P/cHf7YMywPgQddW9XvewQxf5mE9SbkRCEk351/Sk=;
 b=HCePRkk0CLW5HXLKU8yyDua0Q5kfxNovAZN0EwsYm0Tm3nKHyDF9oIKCEXOhHsKsRD3YvNDOwCN//TF0bWpIjSgR99ggnU3o0t3fV8D13beCYeHQ6B5rN6u7IPcdlQHrR55l8zYDtm81G2xK6cci8B2TyWS1/8J2Pky0IFaspGDk0zUr3v2gP6dnoEPXcWPqOD6fiu9Ir/6QdBYGejqBcEWvqgzfPDKu9afF0tHicLz7Zqn/35uVOI21ZAMUiAt9KqWs3/HF9IfohV5zLQB+qARWFmzF3RVINpCngfvcFTrwDKg2ojjGErOwFt7KItz+3QFLevzctU5BiZsVlG6Eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20P/cHf7YMywPgQddW9XvewQxf5mE9SbkRCEk351/Sk=;
 b=St0q4kzWcB8K3BaaYLUg8+LMf+nxXs9yc4Nlz/fTKTEGLEnlTaP42Fyqd90y86PLPo0RqTF6yk2OPv+/+VbvTAgszX0WHuwQ+H0zT7CCEAqe2fxPxeWUlmLWKR4zNnrCL1pxOdp3+Wx+el+yuo727aT8cU1LnAYtpx+aLW51XKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by GV1PR02MB8906.eurprd02.prod.outlook.com (2603:10a6:150:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 10:21:04 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 10:21:04 +0000
Message-ID: <38cea762-12be-ae24-841a-f0977e5181a8@axentia.se>
Date:   Mon, 22 May 2023 12:21:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ARM: dts: at91: tse850: add properties for
 gpio-line-names
Content-Language: sv-SE, en-US
To:     Claudiu.Beznea@microchip.com, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <32995b53-7f73-936f-a81d-5f1969f64910@axentia.se>
 <49665b08-91f7-e449-cc9a-1fd042a0f422@microchip.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <49665b08-91f7-e449-cc9a-1fd042a0f422@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::34) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|GV1PR02MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: cf953807-1dcd-449d-1348-08db5aae3f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHy+BrI34MCc0Q7NAMGAM8DiacwwPeVJCHL9x04U802X+Tdq7nKuoUw0YKfVUaokRyBHaGKh2YnCO/vz7WQDdQuYalDzb3p/nhiJBXkb7ad6OKN3qki+O+ckPkpSha8X6SoqnNCTi8+TFcsc9uXUALCdVw+C+h7s3ty6WdghaoaOfVL6RsivDRUV82XQBpf+q0vwcqJwa63e3ZO5Z4UwkSCWEiWTm/yu9fswZQqmOGAeT9is60nMdbTdXSne0A2ZAUyYLt+5diuTD0csh8PTBBV0Z/acNOyKey9qMMdZLs6nbOX+kcs6rwblmsGGyHhV2KbvKazP6/PmqJMrVa1EXIJfuNYByWVtZx7oLyy2ZHLh3Y7qIiIoxyY+Do0Q7fjSEIBoTk9Y9ywGK8O/l2jhjZGzVH7xE1BKMpdHRGavSpCwlfa+5Y0+mmr3ByC0gQ1W7dyHf59T9DsKN9wwSzYIzLiAteN8NzTUga/EhdWF9OdeykvLL2KdZMWFnBJgaOb6BS0W1R7Ox74cVfO6XdUs3m1loe7M4pBVY2Sm7buQ2qUXZyavoAw7QuWCL8jnuXKHD0nXIydezYEget0tK9yjpH5eoz5pkJUf2wYpQYfSGaFj9YUmBYYdyIXmRpp58H8019WZ30uWeBNNJn0Ko/KuTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(39840400004)(136003)(451199021)(8936002)(8676002)(5660300002)(53546011)(186003)(6506007)(26005)(6512007)(2616005)(31696002)(86362001)(38100700002)(66946007)(41300700001)(6486002)(6666004)(478600001)(966005)(66476007)(66556008)(4326008)(36756003)(316002)(4744005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJCN2hMeEd3MFUyWWZGS21pN20zS3Ywc3FvOWZPSlUyZ2lpOUxTNGJlOHJC?=
 =?utf-8?B?S1dMemUvV1JrNUp5TXpsa1JqNkhjc1BsbEcvWDVlV2FFZE5zYW1xT1VZWTNW?=
 =?utf-8?B?OVlqenZwdnNoMVpQS1lVaGROd1IvRXZ1dnhiWDd5UW8yaE9NN3Yva3pERUlR?=
 =?utf-8?B?NE54S2JVLzJuT0tEMkxBV0pKbENDM0ttaVVOdmFWMENCWEtmUjFEL0pGbHBM?=
 =?utf-8?B?akhLS1JRRFJ1Sy9mNi9BOG0wUWQrTEptNGgvZXEwWFNiNGp2bkZKRGNxNHI3?=
 =?utf-8?B?NzdIODg1ckRYZ2ZYRENFV1FidWcxdHI4aWhrNTV6amljRmMyS0hNOEw4UGwr?=
 =?utf-8?B?MUdqbnpWbXAzRnV5UU4yRGEyWmlwS0RUUTFRSG1kZHNzRlQ1cDE2MDhLSzF3?=
 =?utf-8?B?L3BZTFB0TzdjS3gvVWpxRFVJQ1RmSWtMb1pLZ0Z4d2s2VnE4aDRGYXloUUVN?=
 =?utf-8?B?TDNDUHR0U2RhcHY3OS9SdExHa0crazAwZFpxQ3d6MTFaOG15WUVnWXBDR212?=
 =?utf-8?B?aVFwUzZVSDhDbnFXbU1vVGZ0Nk1zODdwUGRJVGFZMndxZWtrUnpVYUVudG5C?=
 =?utf-8?B?cXRtaUN2L3E1cDhuc1krNWE5NWppcjFERE9yYWVBSHN3YzJQNnYvc3ZMZmRC?=
 =?utf-8?B?UUpYeS9oVE1wZmNEWVQxVjBNUG1tRlpMeER0QlpZVWswalZFazROUTN5SUJs?=
 =?utf-8?B?ZEpndlpra245UGRQK2kxUjFTcWpKRG5TOFpHR2VIc0pSWi81U01KQW0vcW9I?=
 =?utf-8?B?c3Q0OW1BNEhSc3dWa3VVYjF0SDhxcGR5ZzZiNWxqNzY2OUZ5dVJmN0tQYnE2?=
 =?utf-8?B?TGJqdnZqS1ozVEVwdlNLYzMwSFhXZHJveUNad0FUc1BocDhXcmsxUFJjNzcx?=
 =?utf-8?B?RXNqRUNwOFhOalQ3b0J6VUpDSFdJTWhoYTYvQUltRkJQMzE1Y3pqSlFlK1Zk?=
 =?utf-8?B?a1VwbzJCRHZ5NmxiZWJFOCtZd1RWS0NQWTdSQkVldDZJUWNDRFhYWkxweG1Z?=
 =?utf-8?B?THhJdTQ1YTVWV2NSOHpIa0Z0ZGJFUHRNWjZRdDNCMGk4MmRMSVBYNEp4K3pR?=
 =?utf-8?B?aXYyZ0dUcENKclJoN2pBQkpwMEZqRHJqTHhjTHI2YVZsRWh2aXNUNVU3ckZ6?=
 =?utf-8?B?VG1nZ3RuMzI0OFpySnJwMnd3WVF0bVNaZFovdEFmRkNzMFg3UWcydFVQbGRR?=
 =?utf-8?B?OEg1dHJRanJ5b0g2dE9JOE1FZUw1ZU9oNUs2RDNKaHhsOXNGSmZmVGlmUlJp?=
 =?utf-8?B?OWRjMmo1UG41VEw0VldUQVp3NnVuZURSRkNuL09WbzArcjFiRGVYREZicm1P?=
 =?utf-8?B?OHdYYjluenlnZCtSUmI5c1FrNjVXTUpLMVVqNGdGZWJxRDl0djFMT1JYR3hN?=
 =?utf-8?B?QlZwbEVEcmhvQXlFTzIva2cvUm5xMmMxeHBuUXYzQml5VEd5ZXBsbVhyR2xp?=
 =?utf-8?B?MUJnc3ZjVVV3RkUrMFdnelFDVjJZN2xseTRGTGxGOUp6T1RVTzdsWWYzVWdK?=
 =?utf-8?B?eHN0M1ptNElSUHorMkNGcjlLQkFvRWI1UFJUSTZYMHRKaWdHSUZGYnBxM0xB?=
 =?utf-8?B?T3daWVViV0ZWSTdvUE5uUlFjaWxSTzhXUkxGMEtxOS9qRkZ5cXpQMFV3SlJF?=
 =?utf-8?B?NXVrb1RaQUw0OU02YWJzTWZ0cnVMKzU5SXF0WE4wZDVJc1Z4VkVMODF1b2FD?=
 =?utf-8?B?QTlFUnFtVExab2lxeFZMUVAzK0hZaFA4TUg1N2k2akJ6NWhuQmU5LzY0ellt?=
 =?utf-8?B?ZGpTcEVQQW5EK25QaE1naktWTzlMUi91NkVKMmtCSHNnRWZOUnBjL291Q3dn?=
 =?utf-8?B?aEh4LytSUmFIcDZHMVlJaDhycktkSkRaaDlBdnNTK2FvT3NFcFBKaVYrTG9E?=
 =?utf-8?B?dlE5QmFZeVNCT0pFbjNDbTBJM0tiWjZvT3NpSGlLNWhTL2daUU9hY1ZxMEpQ?=
 =?utf-8?B?TThXdnNETmJXRnhnZ01xd1lxYjYxRFBFdWlUZ3RXaUpobXBtYU1meDRVRHl3?=
 =?utf-8?B?dUp4cFJueVNYcE1HYUFXTXAycnRkVmRFenh6ZEFwVWRsQ1hnZWg5dXNoQlFX?=
 =?utf-8?B?dlRVaXd5R05qZFFrWjNIT1B3T3M1SVhmdC8vT1RjMC9jRHh4N0FkbjQrUCtj?=
 =?utf-8?Q?Rsiyo5QV9oZaRlO6O8GkbcXfa?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cf953807-1dcd-449d-1348-08db5aae3f81
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 10:21:04.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G74d8WemVp9bYdoG+wc8rnvOhzktRF/wm1BoTuD6O11ok3FeFfiEAiMqo2ceuGZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8906
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-05-22 at 11:46, Claudiu.Beznea@microchip.com wrote:
> On 28.04.2023 11:06, Peter Rosin wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Signal names are one-to-one copies from the schematics, except VBUS
>> which is an unnamed signal there.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Applied to at91-dt, thanks!
> 
> Please note that I've added 1 tab in front of index based comment. It looks
> more readable this way and this is how other DTSes I've inspect are doing.
> Please have a look [1] and let me know if there are any issues.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/commit/?h=at91-dt&id=08e4dd1d12acc02244b119790c8e50bbf3618a89

Looks mighty fine to me, please go ahead.

Cheers,
Peter
