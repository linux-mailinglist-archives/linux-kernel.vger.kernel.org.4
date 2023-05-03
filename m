Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752426F5773
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjECLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:53:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn20827.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::827])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65847E43;
        Wed,  3 May 2023 04:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPNDPNhIPxqKZbCmHFZwVH81mY2wxeWFRrhuvbP1iKVnBDkik4wyD1i5nk5T4t2HEAfpJkmMC+IGs7mFLjT0JPrGc5Oe+LWQO3IEuXd/BB/h7PSAFCBxAtBQO7fvP/R9Sb96iGrfqIJCCqPP1TSstIjpxhkE2Uu03MXZIYf8jm3GZTGaGhvkEGXgeEh1ko/KcFwpkoO6T9ZF4PImnjJ8mdd9bWLLfzrjA61sI5+F4opZa7WERHz/jQui9Cj9AG2RXX5yQaiGbSjnCGN9h0SKeOv1DNFtLb/NF3YlD7rJvO3rwO/Ru5F9ce3OAbw21acj3gLU93wx1JueZ34XbshvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOvpr+1MpxPxFyKIz+JTki5jX8+5i03AiBmPpzL2P28=;
 b=fHc321u6DaNPkQVTzOy693YEyoTQFLJhljlWbCuz4UnHhxSwp63ztIjmyar9ycSMAS3Qm/Y3wOITJzaYX6e2XX4nDcpezae0QpkkptnT6PugQYUyI6mESCMiHl+jMKuYhxzIiSv8ZeqwCVPLePrnsMwudvO2QscNhndZTbAwGp9UN2PWm3RdJiqZfXIcXh6lXk+8ok4mgWrjKWp+WNaYSGisK0+XoEp66ODDEF3i5Ab+ZZ2JQ4hPaVo8uMeflTO3FERnCw22EQzOb/yHxhgxYXy3fBNRliAQmP19emYcS9QO6TlU5i4RTzaITtYAncaMDyeJVTtm4+qFB+ci6SipqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOvpr+1MpxPxFyKIz+JTki5jX8+5i03AiBmPpzL2P28=;
 b=EihBZSsRkhG5YCrgzWzTMJtnEI8n8Ds7G8LB5l4/JhGwijdbJ7Lp9+CbvcsAPAGt/m/+xyVy3KYJRN7Ilyp1mJ+Rv1irNdjtZ1u0DHV6RxWW+CbCW1UTxJn3PatGX2XDP1QkaEjOu+0o4eZbH4dygEdGSzaHyV8LOTRsz3go7/75X28Gjn77goag7uEvloG8v4gEX90maz2XyrIjW9KLta1jU6jdTmbzYAKJsApGTmrDfOQPL3AkjJVMC2qA0KPEUeR3oepxhIiZfzt7kTIhmXgGtKOGVEJCkwyaX7ORDctT2oWT6h9sdXEJcsi9E786CnrDCf78sIAoK52fFCkTMg==
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com (2603:1096:400:28a::14)
 by SEYPR04MB6896.apcprd04.prod.outlook.com (2603:1096:101:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 11:53:51 +0000
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4]) by TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4%3]) with mapi id 15.20.6363.021; Wed, 3 May 2023
 11:53:51 +0000
Message-ID: <TYZPR04MB6321AECE88794F8585182977966C9@TYZPR04MB6321.apcprd04.prod.outlook.com>
Date:   Wed, 3 May 2023 19:53:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 2/2] clk: tests: Add missing test cases for mux
 determine_rate
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com>
 <20230421-clk-v3-2-9ff79e7e7fed@outlook.com>
 <954b051546fe936db16353fc58a68438.sboyd@kernel.org>
Content-Language: en-US
From:   Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <954b051546fe936db16353fc58a68438.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [NdkBGoqjQGa+OnwgkFSVdPqiDtiVpmCJaitOVcGSpK7+lZtaoDb0N53SeXnRPg/Mb7rN74gmDyQ=]
X-ClientProxiedBy: TYCP286CA0199.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::17) To TYZPR04MB6321.apcprd04.prod.outlook.com
 (2603:1096:400:28a::14)
X-Microsoft-Original-Message-ID: <aeb793d4-59ef-2875-454d-f2b0a259f73f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB6321:EE_|SEYPR04MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 48919622-f248-4a6c-d273-08db4bcd0f6b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+hfVTL7lrdtKiUw7fqXkVF2G/P8nV1aVH7CctEHAg6vM9qSg9f2wRx5RvtpMzYttc/JtCnafQVRJpyTFCGdZycK3BkTtOxlJQNWz0l43IJGLpISYwkWJ7gKn0YM5wmJ3M3CBdTtrqoXa5Tvj8Jt9h4oXGRwzFGKbZ307INhMXJbQJ85GNkjq8DztXMj8wvFpMY8+ufAeP4hMpSC5QqU5+r0B8bBMbF6933BCYSlJiuTh9YLowp0FiVThrmr818A/Fz3B+MRXJ6u1TJko0VjUpzNbtyrq05cAb/wZjQU97xnFt1ERg4mFtICVeGvYvVkqx/dLdCCK5wcGyyihiGsKuXprVC6HpLNM/7HZHkfiB47ZMbd3a97LOh3bkrjxQ3pFlQQlgk7Rvyfq3dEO9IFardhbbnoPeZULP7DCZpQo+e5aEYir+ARUM9R0n0l0kIPkKXD3hgXr1b4IXeRLB17WtFVkw0iVHaxJmc/8FOgi1iiGT7+v72sXSSSwh3zTO97HAFP0ivKvaawNzLfiDBdabR8GvkJpWzZR0vV8AG7hx1EJjHYh/jMySNVGtBXzOMzWM0emPmpSMnD4bAAtGSDnLI/Ps3hPdrcaxlZu6QaGwIYjsXg9FAmOvcy9bTnHYis
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBOVWtQRzZaSWF0bnQvZUxlb3pqVmtqWVg3VGs4TkExcVU5TFV0RHNyVlV5?=
 =?utf-8?B?VG5KbFFtUFNCNlpBN0UyeFV3SllHMXZFSGFMSUVQWERuSnpYdXllNDY5eS9M?=
 =?utf-8?B?OG1jYTRUNVNNTUZ0Q0FhVXVaNjY2UktTNDR6YzVOUi8ydEQwTThVVlpRNjhH?=
 =?utf-8?B?OXo3RVJsZWtheXhvdXk2MVFYSE9teEl4ZlA5Z04xTEtqQjdadWNOZXVUQkVE?=
 =?utf-8?B?WkNKOTNiZkVvV1p6TzNZTHpjY0ZWYjZtZHErREdtNmhQSlNGV25UZVVoYUNq?=
 =?utf-8?B?SFI4R0tpRW5FN2M2eWZqTFdLYjd4c1AvSDlCN2Y1bXFneGVCd3NvOTJvNXVz?=
 =?utf-8?B?a3pRL0R0SEZGV282T1I4aXVyM0RERCtYZTVCc0xoZTczQVRBSC9nam80ZGZD?=
 =?utf-8?B?LzZ3RjFDdWM5Q3ErOG9ad3UwalM2NzBoL01LdlFjVjVqZHpBUElQOThCZkNr?=
 =?utf-8?B?SHYrbDFMOVNsV2F5QmFYbGRERm4zbTJKRDc0ZHl3M3BUeWptTlEyV1lLbW9l?=
 =?utf-8?B?cE5kSld3Mk9US0RtUjdzZWY5d3hhU0kyTUtCcTVoR0tVME1PVm5qc3Q4TEg3?=
 =?utf-8?B?MndPa1AzTVQ1TDZIb3RsQnFUK2tjMkpkU2xRdUN6NEV2OVJ4N3FvYXZkclpX?=
 =?utf-8?B?NkZUM2hVL3Zhbi83VW84Vi9vMXRrdDJFS2dmVXBRRE5EbmpYclhyR2Y2MHJJ?=
 =?utf-8?B?V2YyWFV1RHptNmROU0IwNzA5U3BWMU03dnVXTlVRTEhUaVh3TWIxWU9ZQndG?=
 =?utf-8?B?ZGlVS3ptYmVZUmlsbFNiL3Jlb0s1LzlrbkZFU3NhcFZJS3A3NThabWxYSUls?=
 =?utf-8?B?Q2JNSXgwQTM3dnVSQk11d2lIeUtJMTZXZW5SVTh6eWdzdWZnc1huTlRYR0lK?=
 =?utf-8?B?aXlTOXZ1ZEo5OWh6MU10S3pFRlZPVDhuR0RTZktzdCtLaWwrNi9uQ1hXUldH?=
 =?utf-8?B?R3RVSHYwVlhncHA5S3NtL2dxN3JWZ2prckFtY1duNUZnSnl1NmVYSTQ0cVFi?=
 =?utf-8?B?ZXFqSHg3MnpVaTVSK0pLZjBSbjlyZ0cyNjdVL3BFK2RoNTBweW83cEZJaE92?=
 =?utf-8?B?WlAvc3k1Z2kwaHpLMEZ0NVQ0elBjY3VNZ3FhNUt3VkZIN2wyQUdraVhveVEv?=
 =?utf-8?B?OWNZVFlWdWoxZDBGaEpwVFlPeU5makNCQWE3QVg0R1JMWE5na290RzVtV2Qz?=
 =?utf-8?B?RWtQMDAyQzZuTXIrWkd4dVpMS3NlbjlSSHVkQzI1VjVTa2Y5MUx6bWlCSkxa?=
 =?utf-8?B?TmNnZW5zVmR2bmdmaTlyMWhpQ05Ca3FOazZaZnNqR093RXNLWHJSWmJtSG5H?=
 =?utf-8?B?bDhpMWc0bUlsaTIxTHF6OHROeFNnWWFjVStBcXU2ZG0wSDcvQnU0U2xoS2tk?=
 =?utf-8?B?VHkvZFFsdEpoRUIvbW85K1kzV1pOV292eDFZazFoWEVxVTI2M2tiTnlmSGxS?=
 =?utf-8?B?Mjdtb2N1RU1xYnlENGpNdHR1YjNJZHJkaHREOS9UbFoxSHNJTzlSM3MrZElN?=
 =?utf-8?B?VHFUVTM5T1A0RlFzQXN3T1lkd0JJQjVsUndyUGZ0SU9udzZwUjFKSTNiRFAv?=
 =?utf-8?B?SFVkTERoZTV0UTRBYmVCczB2NElySHFXcnRKZUkvUVphRkRNTUJnSUhoZmtD?=
 =?utf-8?B?cUhmMHhxenpVV0p0SmRoYTNGZTdDdFlUcU14TTRSYnRxeVdxMWcvNEFSS0ps?=
 =?utf-8?B?ei9RYTJhbzdIWTN6Zk90L3NwVm9MeER3N04zRllzVlhrbDIyeStBQURvSDRy?=
 =?utf-8?Q?LF/oOLBvAJrGhX5Ovs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48919622-f248-4a6c-d273-08db4bcd0f6b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6321.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 11:53:51.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6896
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2023 11:08 AM, Stephen Boyd wrote:
> Quoting Yang Xiwen via B4 Relay (2023-04-26 12:34:17)
>> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
>> index f9a5c2964c65d..4f7f9a964637a 100644
>> --- a/drivers/clk/clk_test.c
>> +++ b/drivers/clk/clk_test.c
>> @@ -2194,7 +2194,47 @@ static void clk_leaf_mux_set_rate_parent_test_exit(struct kunit *test)
>>   * parent, the rate request structure returned by __clk_determine_rate
>>   * is sane and will be what we expect.
>>   */
>> -static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
> 
> Just leave this one alone and put the other test cases right after it.
> Don't rename it and also move it lower down. It makes the diff hard to
> read.
> 
>> +static void clk_leaf_mux_set_rate_parent_determine_rate_case1(struct kunit *test)
> 
> Please add a comment above each test case like there is for
> clk_leaf_mux_set_rate_parent_determine_rate() that describes what is
> being tested.
> 
>> +{
>> +       struct clk_leaf_mux_ctx *ctx = test->priv;
>> +       struct clk_hw *hw = &ctx->hw;
>> +       struct clk *clk = clk_hw_get_clk(hw, NULL);
>> +       struct clk_rate_request req;
>> +       unsigned long rate;
>> +       int ret;
>> +
>> +       rate = clk_get_rate(clk);
>> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
>> +
>> +       clk_hw_init_rate_request(hw, &req, 0);
>> +
>> +       ret = __clk_determine_rate(hw, &req);
>> +       KUNIT_ASSERT_EQ(test, ret, -EINVAL);
>> +
>> +       clk_put(clk);
>> +}
>> +
>> +static void clk_leaf_mux_set_rate_parent_determine_rate_case2(struct kunit *test)
>> +{
>> +       struct clk_leaf_mux_ctx *ctx = test->priv;
>> +       struct clk_hw *hw = &ctx->hw;
>> +       struct clk *clk = clk_hw_get_clk(hw, NULL);
>> +       struct clk_rate_request req;
>> +       unsigned long rate;
>> +       int ret;
>> +
>> +       rate = clk_get_rate(clk);
>> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
>> +
>> +       clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_INIT_RATE);
>> +
>> +       ret = __clk_determine_rate(hw, &req);
>> +       KUNIT_ASSERT_EQ(test, ret, -EINVAL);
> 
> There should be some KUNIT_EXPECT statement in each test.>
>> +
>> +       clk_put(clk);
>> +}
>> +
>> +static void clk_leaf_mux_set_rate_parent_determine_rate_case3(struct kunit *test)
>>  {
>>         struct clk_leaf_mux_ctx *ctx = test->priv;
>>         struct clk_hw *hw = &ctx->hw;
>> @@ -2218,8 +2258,95 @@ static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
>>         clk_put(clk);
>>  }
>>  
>> +static void clk_leaf_mux_set_rate_parent_determine_rate_case4(struct kunit *test)
>> +{
>> +       struct clk_leaf_mux_ctx *ctx = test->priv;
>> +       struct clk_hw *hw = &ctx->hw;
>> +       struct clk *clk = clk_hw_get_clk(hw, NULL);
>> +       struct clk_rate_request req;
>> +       unsigned long rate;
>> +       int ret;
>> +
>> +       rate = clk_get_rate(clk);
>> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
>> +
>> +       clk_hw_init_rate_request(hw, &req, (DUMMY_CLOCK_RATE_1 + DUMMY_CLOCK_RATE_2) / 2);
>> +
>> +       ret = __clk_determine_rate(hw, &req);
>> +       KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +       KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_1);
>> +       KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_1);
>> +       KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
>> +
>> +       clk_put(clk);
>> +}
>> +
>> +static void clk_leaf_mux_set_rate_parent_determine_rate_case5(struct kunit *test)
>> +{
>> +       struct clk_leaf_mux_ctx *ctx = test->priv;
>> +       struct clk_hw *hw = &ctx->hw;
>> +       struct clk *clk = clk_hw_get_clk(hw, NULL);
>> +       struct clk_rate_request req;
>> +       unsigned long rate;
>> +       int ret;
>> +
>> +       rate = clk_get_rate(clk);
>> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
>> +
>> +       clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2 + 100000);
>> +
>> +       ret = __clk_determine_rate(hw, &req);
>> +       KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +       KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
>> +       KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
>> +       KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
>> +
>> +       clk_put(clk);
>> +}
>> +
>> +static void clk_leaf_mux_set_rate_parent_determine_rate_case6(struct kunit *test)
>> +{
>> +       struct clk_leaf_mux_ctx *ctx = test->priv;
>> +       struct clk_hw *hw = &ctx->hw;
>> +       struct clk *clk = clk_hw_get_clk(hw, NULL);
>> +       struct clk_rate_request req;
>> +       unsigned long rate;
>> +       int ret;
>> +
>> +       rate = clk_get_rate(clk);
>> +       KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
>> +
>> +       clk_hw_init_rate_request(hw, &req, ULONG_MAX);
>> +
>> +       ret = __clk_determine_rate(hw, &req);
>> +       KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +       KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
>> +       KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
>> +       KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
>> +
>> +       clk_put(clk);
>> +}
>> +
>> +/* We test 6 cases here:
>> + * 1. The requested rate is 0;
>> + * 2. The requested rate is not 0 but lower than any rate that parents could offer;
>> + * 3. The requested rate is exactly one of the parents' clock rate;
>> + * 4. The requested rate is between the lowest clock rate and the highest clock rate that the parents could offer;
>> + * 5. The requested rate is larger than all rates that parents could offer;
>> + * 6. The requested rate is ULONG_MAX.
>> + *
>> + * Hopefully they covered all cases.
>> + */
> 
> Please remove this comment and name the cases better.
Thanks, I will follow your suggestions and rename them in next version.
> 
>>  static struct kunit_case clk_leaf_mux_set_rate_parent_test_cases[] = {
>> -       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate),
>> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case1),
> 
> Maybe call it clk_leaf_mux_determine_rate_request_zero?
> 
>> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case2),
> 
> clk_leaf_mux_determine_rate_lower_than_parents_fails
> 
>> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case3),
> 
> clk_leaf_mux_determine_rate_exactly_parent1
> 
>> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case4),
> 
> I'm not sure I understand what is being tested in this case. Are we
> testing that __clk_determine_rate() with a rate between parent0 and
> parent1 picks parent1?Yes, that's it. For example, 2 parents offer 100MHz and 200MHz, we
request 150MHz, and 100MHz should be determined(the highest possible
rate lower than or equal to the requested rate). Actually the flag
CLK_MUX_ROUND_CLOSEST is still missing in the test cases. I suppose it
should be in another patchset.
> 
>> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case5),
> 
> clk_leaf_mux_determine_rate_larger_than_parents
> 
>> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case6),
> 
> clk_leaf_mux_determine_rate_ULONG_MAX_picks_parent1
-- 
Best regards,
Yang Xiwen

