Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11951714709
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjE2JZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjE2JZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:25:58 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B09E;
        Mon, 29 May 2023 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685352356;
  x=1716888356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JwKb3x4SOyuQx3MrzdQi05ot7ITRYC7+rn1BTIfxCnw=;
  b=mnrLoyahSJjDXYSN4ib9D2dB6hRfeksrYO2uzZpZOmDanKjkPs5vDZlj
   UG5u4f090hjNnSjto6LI62H0yrwHxlKGSeUFLMptyEZCzieCdBFxkwvE+
   gyL5nSQDSO4GEFgb/kQSeQLKlDO/tmGbIgMAAgCiXle025DVl461FQhS7
   ENp5oVnfU+1M9pJmjATrAJwXBOOokszbTxpBjP7pMFyUOd80Tu9ol5Bdv
   mHw1HzlX4Dc4To0l/WXAeiYjX7Do51d+yeRrw4ZX0Sm4KxTXh9s3Mj9uS
   qpIA97IcvvC7QmsvynFJm1cMzO+m5Q+wJNIXNGFuCFgkOMVxipSdwUjof
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoifpH5x9sC+qLReRHWm+zIfw66gpLsLAoxHflTs1/Gl20RnMawo+ew2ls3uYA4s8DMo5MqZs3JwQLsJU0Z3BTlhbg3intL9aSFXMmgMEdbW2sPplJM8ERN9GVf3CzrhJdbChhj4Lkl8+k8r46iEDlbDCsOKY6V1kldAEqCMo+Q09FJP5Exc5lsQxsuQAeckaNHbXXtyv01qMYYkBUvJ1+Ev8g06zLRLkub64lRjze5Lfx9skHabU9M7aBoDjt52RKPUvh0YZDQNQD7Y9NYziXDSCTHi6qjmRTpO3UZZcRnXoXivM6/FjUaD6MunpO0pOeySGb347THUbRKmifaYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwKb3x4SOyuQx3MrzdQi05ot7ITRYC7+rn1BTIfxCnw=;
 b=DItNTFAyOJX6zLtBNbHy+385UbvylMV96iu8s/OeC6rh0BBw+V7CNcpQ4otYKFlyOVNkf1BvHjDKBLehLS6HuzuYhHjfRPSsg5Nglyp7Dl4qND35IvRNI+/kvqC/Ad0Aeuic8XDxA2l9v/oO6P5mMrfGpe6n64QHgZjLBfO/tbCKle5Q8l72d4uFQ1rSZk6pBZwfULQlhanUxUBjv0SN2tWxhxpW7NKZ30PX4EeV0PsXwJjpDDNYnsNyeNG49I5DSyMgwsTFdEWXbQFp8qkQc/QoU1IBrcxH6CgaTRHPV2tL6aRsQym3jrlvMGAF4kw9KEqFcxqHwAp3Fy/UWBCKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwKb3x4SOyuQx3MrzdQi05ot7ITRYC7+rn1BTIfxCnw=;
 b=pu0BmO321S+LK4rwjbWE/oqMaDTQ62MdrSaVm+vV/Cx9jFhPIwLBQxX4wBoyBxB0ii1RgelqNBh4tbdbA09DEDqsu/YU/yh6L1qdO3E7feKBhuHk1HAdLcnmKNkorMXFEyZQsoRxmvrvZxmWI9ZP5QpMu+bplV4vpZFQZt3edIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <46da8636-0c4f-9602-dcad-6e6dec10a94a@axis.com>
Date:   Mon, 29 May 2023 11:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
Content-Language: en-US
To:     <andy.shevchenko@gmail.com>, Astrid Rost <astrid.rost@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
 <20230522142621.1680563-4-astrid.rost@axis.com>
 <ZHPY32XPGyc96jJS@surfacebook>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <ZHPY32XPGyc96jJS@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|GVXPR02MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fd9ce9-f0bf-4976-2c9c-08db6026b14c
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5c/SuOZm6SNaay7WGszMn8nEqoBVYjB8PZ7nRrDUlUUwBzi0K7h0sAbK7gCqxUnV4DaqSy0ppgDpt+e7Byu8pAkSDxRSbus0HcZST7QrRdpuK9+rwKTvOqD6akxv3gEjiofg9eeT6pqQB4lATSbD+XJTuo9voT139LCoLp/CJqQmF+cRtkhH7JHonGwBuzVFvpTDE+6EB2VibUvIVcBv+As27jJxVtLnTDmr6IirY9x751ugbTljynqm+EHBglf1/+IGT40A1Na26HogIMb3IdhqLBH+IeB2KBPV9/cMvfW/QT+W6ouPHYrJ2eSmZmUSAbgYg5NcIQ5B1+h5fxdwRmHp79DlCfA3/9m85T3x6dmaC6EXEHDk18Vm0qJzEiWjUHxBVhWNvMNgDQhjQ5J82l5vFNOvnhu/0IgNJlk1K06y2KqKtg0ba1OvVftCdvHxTFFFhMJStAPsrFwNZfYxyWaqQQADrkSRZN3vdflmLSS1YxPqVVTlAvswTnSpNBEV/4kermOzjYmRUuNTnGx9mAkcKs9fva3a22Bi7ozCvW2a3khzsVj42sytfClLPEH4ozhV5u2IjZJYWCWXqcUVsqvuHhNBIQn+12waibZ9yfxYdO4OoASLdxqnRpnAP/Rd3LTSGjalKmOhdAO8kYCug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(478600001)(2906002)(186003)(6512007)(26005)(31686004)(53546011)(6506007)(5660300002)(8676002)(8936002)(37006003)(54906003)(38100700002)(6862004)(83380400001)(2616005)(6486002)(31696002)(41300700001)(316002)(4326008)(6666004)(66946007)(36756003)(66556008)(66476007)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak84TUkxY1VKa0Q4d09VTGpGVUlLMFBSbGdoS05nU0pWdU44OFZZM096NlBT?=
 =?utf-8?B?UGQ5YlljYjBkV3BKOW5PUVc2K2NubDk1U1V6TVREWnROc1NBaENpakNOWWcv?=
 =?utf-8?B?ay9YYkhsakNhcXlBVGtmMklOUjU5cHlQVjcwemJUQjVsSW96M1JkV21NRzNn?=
 =?utf-8?B?R3gxeDh2b0c1KzZXbzFXTnJUa2tEajdPZ2w0eWwzWmYxVnE3TkQ4VjFPSTMw?=
 =?utf-8?B?ZXdZVTNUNmhxYWp4c2owRk1MeC9oaVNNWjZ1emNaVHV2RHMvMjBUVlBpYVM4?=
 =?utf-8?B?U2w4QmRqSVl0YnVjcE9vdmV3eEdKbjRUREM4YWVTRE0wU3AydzVUcjJSWXhQ?=
 =?utf-8?B?ai9WNThlc2drU3k0TkN3MXI2QVFkVm93SVk2a0lIbE56OFJlbTB1aWlpVFZt?=
 =?utf-8?B?M0J1Zmsva292NmlCUVB3OGJDb1lvRXFRcmw1WXZnMTFTZTBlV1FmRGJuMVZ1?=
 =?utf-8?B?WFI3NHFKZFFnUUV6MG94WHAxcklxR2FRL0VaSFg3aGFMLzVBMHZoTDluUnB3?=
 =?utf-8?B?bUlhc2R5Y2w2ZWFoMldxQWZZRjFQSVRNMGY0U0IrN3ZQNDVQKzJQSllkOStK?=
 =?utf-8?B?dkxXM2RRSmlHQ01WampzdEcvOGpVZnZaa0V6RFpUZ0pxRXp0Z1R4Nzdmb0ox?=
 =?utf-8?B?dFoxVExPR1BlUVlYMlIvaUZ4MzladjN5VERxdnk2ZHRHdHd0bDYxcXpFSmJF?=
 =?utf-8?B?MExZeXdmUHBxUzBPNzVyK1ZITEdoU3ZkUEdOS2hja09uR1pjeS94Qk12TC9r?=
 =?utf-8?B?UHFreldYMmtXbkZBS3QxKzMrKzdLUThxcEdTbytOQk1IaUU0MU5CbVhmUWZV?=
 =?utf-8?B?NWpzRzJSSDBObXJFTlVPQk9FQzRPNGFQVTZVVGlGQ2sxNXpKZi9PcFJMcGQv?=
 =?utf-8?B?cTExKzBqdWxxbUlxdFdxNVZ4MW9sdWREd09uemZQYmdWUUNiWEhQZDlCQkd0?=
 =?utf-8?B?b1FKQlVxd2RJSXBlVGZsSnBFZHlIV3pxMEVOVUNERTNEamxlOEs5V2lyaU1Y?=
 =?utf-8?B?dDJ5OUt2ZnZzNHczaVBnM1Zoci9PVStKdjhyMGhjOUptNUpkTllzUzRMVXF5?=
 =?utf-8?B?SjlhbkNpeStmRUxxbVBjTlViU09SLy9wWnMrZUdMaDFaS1NLYVVDbUd2RnU2?=
 =?utf-8?B?NmxBd2c3dG5sNWJ2cVJNYmhXbHRQNmZZZmpmSGdqd2c3d1gybDVWQWh0WmtM?=
 =?utf-8?B?TGpkOUFaL3dabXM2RXFnSEZYOGwzaWVBMFppQUJZeGYzUllzVEhVVjFEcUNx?=
 =?utf-8?B?dmdaRUhtcUltQzk3NUg0eWlSdGdHUTdYU0ZCV3d1RE1hYUpiR3p3TG05ckM5?=
 =?utf-8?B?NkNtYkFUbGUvUFU1Ni9KVnphMCtCUTdub3Ivd2svM3JWUnVpVUhxS1gwWEUr?=
 =?utf-8?B?cVp1THlqbDlxNUxyMUJreW1WTitBL1kwNGloUy9NckFZRFlVRGE4ejBUa3dv?=
 =?utf-8?B?SlhDcWorUXpDQTFwall6Y05SS3J4Wklac21WSUZiN1ZBQ05STm9iSXdaanBX?=
 =?utf-8?B?cGtOT0xHYWthZWRlcDc0RFIyeGhDVVM4UzB0OWZJZ3ZWU2RtbHlEK29CSHh4?=
 =?utf-8?B?eC9qS3FzSWk5eUQ1SFprdlJoa0w5TVd6OTJiZTdIMXhKVlVJeHFKdlljdlN0?=
 =?utf-8?B?dDE5cWFDdjFpSWNKWXFwYlhlOWMzb21sVGxmcEc0a1hORG1GQVZZekR0akwv?=
 =?utf-8?B?NDRJWmpxa1ZmSHlJakdWdnQyMC9GQlNqZFVBaHNVc0VhcldkakFKaTlIVW55?=
 =?utf-8?B?NFlLa2haWnFPOTlCcE5xTEFXWlE3OU1JQkdRV0JFN1Z5T2dSQzlMcE5Kc3JN?=
 =?utf-8?B?S3BINVZGdVErSVJjbkZnbGNzK0dXa0h3c3hVYm1hc3l6U3AycG5qS20rK1Qr?=
 =?utf-8?B?UEhJeTltTDgwL1dqTEFEYjFvcm1RY0dER1I4d1M5dElHemU3OUdyWWh6MnRJ?=
 =?utf-8?B?NVBHV3hSS2QrOGt4bWk1T2c0eG1VUDV3WnlxYjFPV3ZkdEtpQVlJdy92MExw?=
 =?utf-8?B?S2lCaEJxQXU3NXNKTWJURnVQU0hhOTJsNmc0UkRUYVR3NGllSUxkdERPY1p2?=
 =?utf-8?B?T3JldjBHUDRjNExaSkNOdTRGbE16RkJoTjllWXJoempZWGg3ZnUrOFlacW1H?=
 =?utf-8?Q?7fvw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fd9ce9-f0bf-4976-2c9c-08db6026b14c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:25:50.4610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwgl6H8xchB2k002u3Dpw+q1srIIixB58oLsPDSPFtxCBjfRLIZi0qQqzhCAQMfIl07VZENv9Zfytc5RHE9RFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB8327
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thanks for your comment.


On 5/29/23 00:42, andy.shevchenko@gmail.com wrote:
> Mon, May 22, 2023 at 04:26:17PM +0200, Astrid Rost kirjoitti:
>> Add illuminance integration time for vcnl4040 and vcnl4200.
>> Add read/write attribute for illuminance integration time and read
>> attribute for available integration times.
>> Set scale and sampling rate according to the integration time.
> 
> ...
> 
>> +	data->vcnl4200_al.sampling_rate = ktime_set(0, val * 1200000);
>> +	if (data->id == VCNL4200)
>> +		/* 24000 µlux/step * 50000 µs / val  */
>> +		data->al_scale = div_u64(1200000000, val);
> 
> Without type these constant are integers. Is this okay with 32-bit builds?

No, I got an error on x86 on my first patch. But i did not really 
understand. All variables are within int and not defined as something 
bigger.

> 
>> +	else
>> +		/* 100000 µlux/step * 80000 µs / val */
>> +		data->al_scale = div_u64(8000000000, val);
> 
> Ditto.

8000000000 exceeds at least 32 bit.
> 
> Also, can you use constants from units.h (KILO) and time.h (USEC_PER_MSEC)?
> 
> ...
> 
>> +out:
> 
> out_unlock:
> 
>> +	mutex_unlock(&data->vcnl4000_lock);
>> +	return ret;
> 
