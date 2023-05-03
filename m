Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB56F5E75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjECSq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjECSqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:46:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2109.outbound.protection.outlook.com [40.92.53.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55283FF;
        Wed,  3 May 2023 11:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hym8/LZwz3eTvtgNzCcL1gHJEx14c+wFqPq7Su2y3O1K7l6JfXdKjnggJcFGU2q4D6ciSOIwxYpOxHPoFsaml0RzYiIzY6M13ueUWRX1jaNKxsWAcfi6LQT3RTo3HwHc86djM2mRmEATcTx6RR5pG+watVKSbukEStP8EawsbeJs3bcTDzMUb1PiTNR/yJ3JLQkzE/FkhOA+6tPokuBA5atfXQ9d0dMwe8uVxMBf75xdVJeo3xHN0YBcIFDuzN6rPDGeLQTGRg3Vz10kDR0sy0ES1uKSIjb9Nt9okWyBha9m56HbPbTVr56eucvYqlESeyr4Z9h3cXu2LXI7zd5wfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O14VJZFlQ5t0A1qQlwIVLm83v0zZyAq7zvpEeC8zmA=;
 b=inFN2i1Ex/I0TeVHADEiEZC2qwChbaoXm42mJLtl/xeTV+SaMpRyHpaytMAhOjFoOCsz0Ss4GJ2cEoYeDK+7sGp/N7ieBydfysR1MMVMQOGPwmHOxWaPsutk1uU8cmP1KlYt8uq2Tb6kB0raQbfL3ejaOX+4iV/HzqdTKBdu+OdCtGirIxLkihaFL0/t7t+/CEr0xI49S7hV79TzC7OJmIfL+5HPHNcBCmdRg+3e2XRPeN/qLW7dVCAEJW4n3EBsC1/cjgupWX1bFQDWclsw4eUbMYGpdHUwjhxHBV1A5yarTE58QS+wZLKAwHhPVB11ehq1cmJBsF3NDUiPCdFaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O14VJZFlQ5t0A1qQlwIVLm83v0zZyAq7zvpEeC8zmA=;
 b=lYbqpuWdE+ntWisozZjHAEUI+mm/3JG1PX/jgyGW9blOXPc5zHi4FIUptOKCwJJ/lJ1bDpIs94iG25WuN4bMMcaaV3ETNms/VbWNUQSsOvFZ9oyoUKyW+SOF8cXTQlJ5dh1H3dtqJLSC6gJjmIojm3Dy2+r1a93a2AxFfQXJ3MNUK4AGvF6l5Nf9JJw19pcxsKdDdZjr4CRcXLH3N1NXzuhmPHUcllDy6XcwOEgn5vWYl0ipSYUua1zfFnyFdwuekQSD8BY6581336bSbAGGAVpUsn7y+kWMQ3l2ntdEdHUmPOVGX85u4rsJ3qYNBEUPjKBjPAN0QaiDJNBq82fN9Q==
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com (2603:1096:400:28a::14)
 by PUZPR04MB6649.apcprd04.prod.outlook.com (2603:1096:301:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:44:51 +0000
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4]) by TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4%3]) with mapi id 15.20.6363.021; Wed, 3 May 2023
 18:44:51 +0000
Message-ID: <TYZPR04MB632148D739338EC2ABB1C035966C9@TYZPR04MB6321.apcprd04.prod.outlook.com>
Date:   Thu, 4 May 2023 02:44:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 2/2] clk: tests: Add missing test cases for mux
 determine_rate
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com>
 <20230421-clk-v3-2-9ff79e7e7fed@outlook.com>
 <954b051546fe936db16353fc58a68438.sboyd@kernel.org>
From:   Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <954b051546fe936db16353fc58a68438.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [szDkfI5QwqTAjlA6zyrOHZzJyvG4etK0jQ9BZakuN0biw+TFAiGm4geSV0Fm72hlDtg41lOfs0s=]
X-ClientProxiedBy: TYCPR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:405:3::30) To TYZPR04MB6321.apcprd04.prod.outlook.com
 (2603:1096:400:28a::14)
X-Microsoft-Original-Message-ID: <c1e4a80b-1635-e6e3-4745-7369650e2d01@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB6321:EE_|PUZPR04MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: e290769c-fb5f-4976-073b-08db4c067ab1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a68TSertaFiZjGZbhyG9wonu2wV+31QkDv4qpySJ9gPpPEXl+/OI7qA9vUMyqe+SfsOQ0lJu5SDggL4l/8HmnWSqBd4B15gW4WiT2XyWewXFgliCtRultBB58v+yckAj2aQYUz/XBryUn8vRWV299MgUg+Ygbd5PYA0U6/jmtCsUORo1nOVjwhX4hnRryxwVlgQqXa7+aNaWBs7g11r3R8sfrKszOFFeHNt0j26nTzwSSpGOYa8fO7Aiy+sDDwGzpO8p47orwj95wX4y+k8f6eBNxITlVQK1uUG6na2/eP2Wa+k/V+lIiEsZSlJ2OZpxW94C8hhHh5OMQxLnMBJFZHTLt19IvmCWeX9F8RiP8+GEcrg2dacv1nOSHsYLjUBZkOj0pA+Knli0sHJlztcdmjNTtpHilf618CPowtACoBmQUQIMqQJk/VRhqyb36S2nCthqeWrGvD/TvwP+9jecm6J1srTDjU+OiViYRArwd/9ZK+3GBSRntH9QKP3shi+ojRvhkSuZ5zRcrcOKt30G1ZvabCNIeKFeAQuz280Mu1wDETCSzulsOCv7P2esqlYqHQwp9NlBrCSCKOeT6+3Pm2T+pU2LtfAWzGEqC17zj/XrGT36yW/5akTmIOFW178Q
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHljTit4Myt0Vm1UMGFLVnFWQnk5U2xDK2FIVTNBdm9qR2wyZVVUQmJRN2tu?=
 =?utf-8?B?bXdIalZ6NlhtaGgrN3ZucTU4Wm1IVy8xOXhVYmVRRWU5c1FBa2l4ekhZWkNK?=
 =?utf-8?B?MmVBNWZKSWduVTVKZ2RlaGhTNW5qblhlbDRqMTkvRGJDRG1MT3BNSmtYRHFD?=
 =?utf-8?B?ajF6aG9XTHlQUVpLMUVJL2xqUGovYzIrbkpMTzJTaEZKZk1IMXhVU0lMQ3RU?=
 =?utf-8?B?aDlZSmVIU0ZvNGVBbjVLMlRQTlVCMDM0R2I4WXM2M0hjb3VRNmVEVGVtbGpJ?=
 =?utf-8?B?N2lZWUt0WTNDZWFiVndCU1BhS1RKMnd2cDdZcS9PdFNJSjZMNk01bVNpbWtH?=
 =?utf-8?B?OVZxL056QVNtZlZtaENxbFNNamprbUVVWDVYQVVwVWh3RFA4ekJZSXhObEw3?=
 =?utf-8?B?Ukw1WVl6ZnRJbkFhVGhGNytWN3Uyd2hkNFgrcXlSNURzcFRuTVlKY0JSM3hP?=
 =?utf-8?B?dmVlY3VsdUpCd0YwYXVadlRxazN4RUpsNk9Fd2JCVCtRTHVvNTdBV3d2S0Ro?=
 =?utf-8?B?UXYvWFYvelUvSTRLa1Y4Nm9IK05haUZpVXk1S2NURmJNTUJhcWtwTWxnZEJU?=
 =?utf-8?B?anVuY0o4eVI2MEdtOWRrNzJVSk9KRUYzUGE4aVN3Qnp4aGxWaUZ4elY1T1dj?=
 =?utf-8?B?eDFxUlN5YmZhUkgrdVFmcXltWi9RY1NLbFoxYkl2ZExkVXp5RGg3SUVlVmRU?=
 =?utf-8?B?QTF3WlUwT0hlay9IVzlCdmxOVHZrZ0wxbVRGVm90VlZhamNsUVpWWHZVRTcy?=
 =?utf-8?B?V2laNUxsUENwZCtCQ0xNYnFTSVhTOXB5WS91VEtTbDd2cWxsMFltZW9xajVV?=
 =?utf-8?B?Q2RIYno1SW9oN01Oc0RyR25zUTdheWsrTDhvb0RVRlh1RzFFQVEvRGtCY0J4?=
 =?utf-8?B?elFiVFZWanliQThZaEs1SnZOdS9CRUt6WW5Bb2JFZ1lENDVVdnQ3eU9Mak1r?=
 =?utf-8?B?OUFCYXFzcGY0d0tpYXpoMG5CT2plcGhLNmlpU1FaT2pSQUdUTVQ4SG5OL2hn?=
 =?utf-8?B?dVg2UHcyQmpUQTJ6TzdIbWRGelh1T0ozUTJ0QjFmYmZBOTcwblNjZW9LeXlN?=
 =?utf-8?B?cjY1TTlhWkU0UHlJSldjU1JRM0h3SUFTenY0Y0Y2aDhUakFCOXF2dTZMVUhk?=
 =?utf-8?B?WHJNc2ptMVI3VHp4VXFJc0NZVkYvYlI0YUFpVDZ2ZS9sTTI4dmh2T3c1L3N6?=
 =?utf-8?B?MWxVVVYxcVorOE9icVJmQWxMYTNrQWlKZUtvT0lWOFZaaExhQ2NJcjdOcFRt?=
 =?utf-8?B?OVVIa0JhZGRXZ3FUdTZVOStDejJKNG4zdElsZHhzVVR5QWxLcWs3VzBRWnpu?=
 =?utf-8?B?cjYzdGI4dUE5eElsZnhnY2dTWFBHREM3SkJzdDJGM1lJTVg4Ymx6VlVZZVRt?=
 =?utf-8?B?clo5N01XUjBpKzE5YjRJZGd6WExNTWZBL2RxSmNmbEZQRHJweFpaeUZGOUdC?=
 =?utf-8?B?Tmg4TUlQUjJ2MDh1MkRsaDdtb3JlcVZGWm12U05DekVDYUN0VzRic1l0S01p?=
 =?utf-8?B?NGRhZko3ZjBPQnRnblZnY0NzUnY0YkdaUkRTMHhNMGVpU0MrTXdXNU1vVzdr?=
 =?utf-8?B?TlRYWDRLYVg5RjVqNnE0a2NVWHVZZ1JrM0N3TjFxT2NDc1ZCYUNYZVAybHF6?=
 =?utf-8?B?N3JXcjZUUDNvcHpsODNKMjQyOTV0Wk80OVhDdElkU3o4S0srSkhhWkptb0pX?=
 =?utf-8?B?MlRNUlBJclh0L2RRbU45OXM1NzFSNnlkaHoxQlVTVmljUlAydG5hbGdsMkRl?=
 =?utf-8?Q?urQo7iFr/nGibE7a20=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e290769c-fb5f-4976-073b-08db4c067ab1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6321.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:44:51.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6649
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
I don't quite understand. In this patch, I renamed it to case3. Here I
think you'd like it to remain as-is. But I think the comments below said
I should rename it to clk_leaf_mux_determine_rate_exactly_parent1()?
Actually what this test has done should be included in this series of
test cases as one of them.
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
> There should be some KUNIT_EXPECT statement in each test.
> 
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
> parent1 picks parent1?
I think I have to speak more about how these tests are arranged. Imagine
that there is a segment starting at 0, ending at ULONG_MAX. Now add two
points on it, assuming DUMMY_CLOCK_RATE_1(142MHz) and
DUMMY_CLOCK_RATE_2(242MHz). We split the segment into 3 segments, and we
have 4 endpoints in total. They are: 0, 0-142MHz, 142MHz, 142MHz-242MHz,
242MHz-ULONG_MAX, ULONG_MAX. Ideally, we need to test all these 7 cases.
For those 4 points, the tests should be straightforward. But for the 3
segments, we can only extract a random point on it to test. Besides, I
think requesting for 142MHz or 242MHz has no big difference, so I
omitted one of them. The original
clk_leaf_mux_set_rate_parent_determine_rate() is considered to be one of
the cases here, for which I think should be absorbed and renamed.

And as said in the previous email, the situation here would become even
more complicated if CLK_MUX_ROUND_CLOSEST is true. I guess it should be
in another patchset.
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

