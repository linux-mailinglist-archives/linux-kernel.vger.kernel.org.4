Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E856C2831
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCUCbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCUCbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:31:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26242BF3B;
        Mon, 20 Mar 2023 19:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPxW1nLp92zAA4RL1/eB2KQn1lYwo9sSrjs2qVmQjtwRh1SpbYeilRSV/+6j7TwlUMtryXFuJ9z0rukA0SZNeoGz9Lb2TEIalKk2MiitHm8s4soEr6bBxj4uVaSny9HliLkqArn79TJuCDoXtiNMaOLbmYTLUyW0jmjopTVQttNkFppPul0Eb37DvYZ8mFEhSQ+UBS5K+mNaD6yZ22RivGR20EeML4gw/glf/eH80tlq9jmAENg6tjbS9lK/1QzAFgcu45wyEGomwqIx5YrM/0tm6CV9zPTeK8jFrfS9PCMZNOuXz49NzOdodd2BoYON3bUydtIffI//qkor9SU/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7xCt5bGts4l07TSUXTI5HH6jdlNYjXViQGoWIFmhqw=;
 b=JcewCIVqqybln2eFDpZmgoaIbvXhrlPi6sKKptBHylfEygAET7kjMN2VFQ+zWW8OKO4IXVohF9ZsJbgHiP3btvZHpLxl3w03thf9xxTZ9Op8bhMoVKs/rD2x7dwpWLj1ffEhYzbtSlsDxtEe5fcud7ATAsN+p+IgKw+hB+LgoS+3u1ZIHoEBjS9e0LxRe0Nj9c533hkTJFs50829h6z4OTz4x5b65GnDkW0g40ZVadUgISzxNZxR6FvsHjCAT27zTgWtMjhCAT5F4reNTIs4zpwDxVApiDpCRTZo/75L2AdlP86KlxbUDRM2UU6wZ1X7Bi/X2AzBWzgy3CULD6P3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PSAPR03MB6329.apcprd03.prod.outlook.com (2603:1096:301:5a::9)
 by KL1PR0302MB5204.apcprd03.prod.outlook.com (2603:1096:820:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 02:30:09 +0000
Received: from PSAPR03MB6329.apcprd03.prod.outlook.com
 ([fe80::3262:d4e7:7c19:dcc1]) by PSAPR03MB6329.apcprd03.prod.outlook.com
 ([fe80::3262:d4e7:7c19:dcc1%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 02:30:09 +0000
Message-ID: <b5e647e2-4561-e6c1-016f-2c3b260916bb@amlogic.com>
Date:   Tue, 21 Mar 2023 10:29:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2] clk: meson: vid-pll-div: added meson_vid_pll_div_ops
 support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, kelvin.zhang@amlogic.com,
        qi.duan@amlogic.com
References: <20230320113445.17260-1-yu.tu@amlogic.com>
 <CAFBinCAE-ihq9oeXc=GqUEHVKUYM+n_e+2_5+gDMTGQcEEhRtg@mail.gmail.com>
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCAE-ihq9oeXc=GqUEHVKUYM+n_e+2_5+gDMTGQcEEhRtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PSAPR03MB6329.apcprd03.prod.outlook.com
 (2603:1096:301:5a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR03MB6329:EE_|KL1PR0302MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b65780d-c081-4568-0d99-08db29b42fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2C0spAM9Ci61ur+DH2qMJ+S6UH3aHvis9AP3xEV8J07b5wkJOb0HSAxoL1j4K92vVou55Z+1zuywZXZCVkdLmZ2YEmpye53KDb23gHukfnW9cMWvTN6SVffvEvCZzEz2ctlyyEGMqf9AX/v5+CjJFVHwOZ82b39k36MbyTr3s8lVXg6LpO5lL25QUgF0WhTB/cEGVML7vYA8dPZmq7G87bKGKDCoeJRy5fUxw1EzjsGaWw/31d5e+1BH50SVe2TOFNQ3t6TpjK0DZ0IDiz6r1utYVDQSem5zgGo54t6nNfrsuJow67vOBHXgJo+5tb5fVmO1Ja4MHiJ3rTsJu/3NIVyH58DnkbWuwiIe1bahHdGiJBa6rM5/PGY0+hdGsuZcTu7z7qpmc3Pcl4Y7PIa0sX939r2Rvgf8bI47qHoN0gp/ZTH5te2HlAomyJaz9ByRZYloef4hDkUyK7tTF+CSIIuZKcvUFeUQ5Rva8smrZX7VImZ/6wfzdqOMZ3Sm4aLpjTcIohwBARd9T87Jz0wrR3UxuvFyNzYIoZJgisAnDAxVf42is1/Neo7Kzp0VR3hsy3Ol1XxrrQEcAjk+dS0yjMNqh8Ah016BoeXVVIWBlnPls6Mq8wzgZXQbze5dnfb5M7c/+QY6EK0n52HoLGfZB8SQ93fr2UsL9IpRkW90hqQ5Q9m5TjnDJHasIdd+M+5G6OC9p/SP9J6pYxHXw5mj7IifATD4LpikkwlaafpTZtcnOOAzpksiwKUXy/RnL2mLaR/c4iZDg8OHn2xpOA18qOzVsmLvAQYgiRMpmsyPniQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6329.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(366004)(376002)(346002)(136003)(396003)(451199018)(44832011)(41300700001)(8936002)(7416002)(5660300002)(4326008)(6506007)(86362001)(36756003)(31696002)(38100700002)(2906002)(107886003)(6666004)(83380400001)(478600001)(6486002)(2616005)(6512007)(26005)(186003)(53546011)(31686004)(54906003)(316002)(66476007)(8676002)(66946007)(6916009)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJHZFRNdEdza2dQblBRZVR5TGFyTzVITW9xZG9HUnNsSE91Q3NnSlkvalF5?=
 =?utf-8?B?NDBtQnp5UmtkRkV4bmdGbi9aUTVURzQ2STlzM1VITFNENCtEc2tPU3cxMjd3?=
 =?utf-8?B?Q1RFUng3V3pzampDQ1RIeGJmUmRBM2VhOEkyaGZlK2hwN1AxaUVKTnJoVm8r?=
 =?utf-8?B?QkgyT1FTcG1RbUhRek1hRG9XTWZXY010UmJBVzE2dlFMMkxhZWwzck9NbXZt?=
 =?utf-8?B?Mk51Z0tMRGhvS3JuZ1l5aGIvYStzTzlTODlFZHpZdXBSNW9sbXBJUGZtZkl2?=
 =?utf-8?B?WlN6VkZTQ2lTaVhnNnk5cDJVN1hGek41c1prOVJFT1U2alBqMklpanNaZEow?=
 =?utf-8?B?akZPcXNzRU1rMldNSVZ5c09kaUtNeUExaTQxQTZYYk80OE1RZHlRQ2puSkJn?=
 =?utf-8?B?NTRDTGFZWUJZS1RoaDNLTVVFd1YvM2xYYTJWeVUwczNIWDU0QzdWZEg4MHhY?=
 =?utf-8?B?S2JYMnk3d1lMMHdYbWk0VHBYd1dlTndGODNVb2x4ZUltbjBhRGNwWm0xVUtF?=
 =?utf-8?B?c3lmSjEydXRuUjhuekdQYkFvbnZDU3BlN2lrQ0dWYXdaVGJDV0lSU1hSSDN6?=
 =?utf-8?B?cW1iL1VlVGM5YWdkZzlzbnVVaFlWQjRIOEhlalRjMkN2QXpoSUFXNFptWUlj?=
 =?utf-8?B?YTNHSTdTSFVoZmMrek9xU2pKWm9MMHZaV1dqNnIrcFUxTFcyQUMrdis3UUs0?=
 =?utf-8?B?azNTbVRlNm1HUko2UVczZ1ZvOStKQjhhQUJnVkdkOG5uYTNYcUh6OGJhQVJn?=
 =?utf-8?B?clpXU2tEa2I1bGorY0txR3JERVZrVm1GL05DVjJZdzNQOFJNSlVwa1VIb2Q3?=
 =?utf-8?B?dThJTFpCbVZXNUl0YThLSVhMYmV2T1dIVmMwb05QWllpSUlGN0lZZjlYckdX?=
 =?utf-8?B?K2ZWSldsY3A3NWtDRmZ6ejhNeUxFOStmNjJOZ0RTb1pNS3dvWlJUMXloYWxj?=
 =?utf-8?B?RGpSbVIvU3hINnM0cVRISlBQQ2FJODVoR0ZBeUNsTnVkTXZFT1hUWUVXN1R6?=
 =?utf-8?B?TU11YUpYanEzNm13MUZWZW5XYW1EVmtMRnVreDZhdXI3MkNOcWUxbHZ2WmFB?=
 =?utf-8?B?aUNtZ3IrUDhQSzFCc2lPSFdnamtuLzNiaFFzZU9qdUlOaU9leXBuakM0VTBt?=
 =?utf-8?B?Ykw3KzdtSkdyRmw2QzlNd3ArOFlpeFByYVR4dVBDakEveGFlbkI5VU9HVkpF?=
 =?utf-8?B?Y1JVM211VU9BZ1ZwekpvS2M0L1lnNERmMzRPVnl3THBTa1kzMlpiQkkrM1pW?=
 =?utf-8?B?U1htU3VrZi8vSFdJY3JzUHlkTDhHQ0NGUm9SdGZkOEdaZnR0UUE4b2JXUDQ5?=
 =?utf-8?B?SWY2OU5WdUpYWTdTYU9uUlduRXNnV3NlL0RxbU8wcm5DbUx4eTRkMk5kaVhQ?=
 =?utf-8?B?Mm80TGdteU1YaTUzT0ZlZmgzSTRzWGliZlJmR3JBVVEvZkJiV0hzRVFoRloy?=
 =?utf-8?B?OG80TzRYQWdxQmhpeUJKNnQxcGRLNldEMjNzMTBzVmpGNjJJQmpGbndlbE5B?=
 =?utf-8?B?cERrZy9ZRnFVY0ZwdDUwdjFPS2N3SjA5cnFOYUxRcnFERDJFd25jdHpjZ0NR?=
 =?utf-8?B?QitFL2xWSXVJc01pUXF5aXRLUW5nZUwvdU4xM3dyQ3Y0MFNCK25xVFdRQ3VD?=
 =?utf-8?B?OFR3dTRNRVN5MmtjN1ZpWGRxM2VkNllJZUZmdHBxNkhlUGpRRklnQ25zL3NL?=
 =?utf-8?B?VWdxckZkK3lML0V6Z2t2MDBadE1QOFdsN05wc0F4YzZ1eXJubWRHajRHQW94?=
 =?utf-8?B?ZS9EMExHZWovYkpDSFF5enJtZDIra2lGY21lTzVmZndqVm5ZcEZ2NUdvcHJs?=
 =?utf-8?B?YXdiWitwNmwxWTRHbjZOem9aMStSZEw4bnc2RlRUa3pDYWZZUkdCKzZmbXpU?=
 =?utf-8?B?NzdrdHdUaG5PZm54eDRmZmkyRnl4ZHhRVVhJSFYySTN4Uk80T21CN20yMXN0?=
 =?utf-8?B?emxZWGs2aVUxc3k0ODBKN0Q3R3BJMmx3NFdsNWZQdzhHRnJ0TWtVYnMrdkc3?=
 =?utf-8?B?V0MzMlZGRVpvQ0hUd2RlcTJNRDdFUncyNDgwUjNrWkxnWCtrdCtSOEUzejZn?=
 =?utf-8?B?KzU3dkR4cWJpUndWcFBBOWlnQy9RdGtydXUxS3dzc1dYczlYOUFOME8rbjJh?=
 =?utf-8?Q?+DJoVrrSjTqgAUk0chEbf8Hn2?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b65780d-c081-4568-0d99-08db29b42fb7
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6329.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 02:30:07.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qysil+Zs4eISICnIpOdeD9tdirY+re/pLQKk58DhfjqCKqwIosa5w10hqxK29t8qiC2nupS0iI09+7GbaNCn+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5204
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin，
	First of all, thank you for your reply.

On 2023/3/20 23:35, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello Yu Tu,
> 
> On Mon, Mar 20, 2023 at 12:35 PM Yu Tu <yu.tu@amlogic.com> wrote:
>>
>> Since the previous code only provides "ro_ops" for the vid_pll_div
>> clock. In fact, the clock can be set. So add "ops" that can set the
>> clock, especially for later chips like S4 SOC and so on.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
> please describe the changes you did compared to the previous version(s)

I'll add it in the next version.

> 
> [...]
>> diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
>> index c0128e33ccf9..bbccab340910 100644
>> --- a/drivers/clk/meson/vid-pll-div.h
>> +++ b/drivers/clk/meson/vid-pll-div.h
>> @@ -10,11 +10,14 @@
>>   #include <linux/clk-provider.h>
>>   #include "parm.h"
>>
>> +#define VID_PLL_DIV_TABLE_SIZE         14
> In v1 you used ARRAY_SIZE(vid_pll_div_table) wherever this new macro
> is used instead.
> I think using ARRAY_SIZE is the better approach because it means the
> references will update automatically if an entry is added/removed from
> vid_pll_div_table

I agree with you. Perhaps the key is to understand what Jerome said.

> 
> Also I think there's a different understanding about what Jerome
> previously wrote:
>> It would be nice to actually describe how this vid pll work so we can
>> stop using precompute "magic" values and actually use the IP to its full
>> capacity.
>  From what I understand is that you interpreted this as "let's change
> ARRAY_SIZE(vid_pll_div_table) to a new macro called
> VID_PLL_DIV_TABLE_SIZE".
> But I think what Jerome meant is: "let's get rid of vid_pll_div_table
> and implement how to actually calculate the clock rate - without
> hard-coding 14 possible clock settings in vid_pll_div_table". Look at
> clk-mpll.c and/or clk-pll.c which allow calculating arbitrary rates
> without any hard-coded tables.

In fact, pll and mpll are also fixed register writes corresponding 
values. But every SOC is different, so it makes more sense to set it 
outside. The VID PLL is a fixed value for all current SoCs.

> 
> 
> Best regards,
> Martin
> 
