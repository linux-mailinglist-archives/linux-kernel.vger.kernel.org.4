Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5BC6C4450
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCVHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVHrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:47:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072d.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A25AB5A;
        Wed, 22 Mar 2023 00:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm1tRkYvo0XDzx1kYEp/4dQ+pKg2eDcWV+ezWu2r1sFrwOFFFn1VLGEbLckilDnNhgSo/XHje6PHxK/41+guK3hPgEKR59h4reGzCGMyB/RXkLMd2UhGhZMpTzWaPfS+ItAYjQN/oC/z2EEFWNVFpfBXjec83Mvkuo/Wep3iXfZ4dpcQQ2IWTCrzcsG1VyhWmMd9wk/4LqIEvrNmxE6tqiEcq5xzwy7H3bxU5TrU59T0nM1ULn8mwXODjS5gPR9gy66mN9WwlzxDa9r4zLu/i3aW4C8jYhc6utellDoCGD10XtjoB9e6UvFrSJi+3SXyrXyGEadp1nDdU4A4EPJ7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dg3e+nbqaB4EjGFuSk/oGwyeaKBflpxfE0oSZwEW0s=;
 b=leZHhNZ6l5i2Hmtaxn/5Ogz9Nnem4Gk2vNzPVecziLhxn149w+eWWjdFHTct+AjJKyNe9RwA6bb9JmUY8OYnRFoQECCwWeP7L/IRhKyE33XPZRImIQl71VdTxggObonBebD0QsqzCKpDzh9JA+BdJ8NXUPL+I8WFtaIuQbzuQBfpIRTJwH9vtpt1M/liLtFRv2h8yPKLHX7t2LdnhUZYNjimAXaHD593YQzi2BkId2UOfIe4A8Js9E35RwfSd9cy5KjBLALLQsE4BJXB2gxFjnSZ5Oa/HP6wc4NeK4hrkRxmZeCwStp0bYv1qjiaCmeLkrrIENBvnxqXqrudgt5C2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PSAPR03MB6329.apcprd03.prod.outlook.com (2603:1096:301:5a::9)
 by KL1PR03MB5522.apcprd03.prod.outlook.com (2603:1096:820:56::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 07:46:23 +0000
Received: from PSAPR03MB6329.apcprd03.prod.outlook.com
 ([fe80::3262:d4e7:7c19:dcc1]) by PSAPR03MB6329.apcprd03.prod.outlook.com
 ([fe80::3262:d4e7:7c19:dcc1%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 07:46:22 +0000
Message-ID: <d403dda4-e3db-4f26-6996-090a8c520b94@amlogic.com>
Date:   Wed, 22 Mar 2023 15:46:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2] clk: meson: vid-pll-div: added meson_vid_pll_div_ops
 support
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, kelvin.zhang@amlogic.com,
        qi.duan@amlogic.com
References: <20230320113445.17260-1-yu.tu@amlogic.com>
 <CAFBinCAE-ihq9oeXc=GqUEHVKUYM+n_e+2_5+gDMTGQcEEhRtg@mail.gmail.com>
 <b5e647e2-4561-e6c1-016f-2c3b260916bb@amlogic.com>
 <1jsfdy77n8.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jsfdy77n8.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0164.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::20) To PSAPR03MB6329.apcprd03.prod.outlook.com
 (2603:1096:301:5a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR03MB6329:EE_|KL1PR03MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c97c4b-cda2-4aec-d31c-08db2aa987c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6n1Jt4/GhBW9UdkW6d/zJ/WkTKwjO+Nj00QQJW0WlMzozEtS6YVti0xAhBSY39FQb2PUeis2MlxVR0eYyXq40eJTdtazuV/QDwuAzSMaZSSvDnGWk38lDtY7vMejVkLsTByI1De98vG0UMRRXfCRHyiO185GxD6i2/9hXLXon5JnVPKHYafmivG2mUgyJ89dBDpM9O4vc8FldN4FQScWjdAo4yyEoVotnaWZCsAahoToNBBZ6BOUlQDXHBDjZWIEoCcrsr9uncG9uNstTizSW+V9gzH25eNwbNVL/2aJSiURLqsJDMXkpxMdH3/TCTO3d856KkVphsBMI4QtmK8LK752tqFY0vRMgImQLZH/MXtsaWsq2AVaDIrl6tnw2DeUu0OlDy3/dbAp4NYegUg+5OdaAa7JwMiKIi/BCPFxRWhOna6j1QxKrfbG9ZtYPfQ81KuSWpCPRHyiMy2Wz3/R5dhQg3i1K70ISLb3b21jZqmtwuU5wupJylYPFvmimRLpuLGPcAA5VgRT/f8eGFqkASKqeAWj7hcrNL9+fX1YSU9D7ITPeSwwXxoWk4yjN8iU5r4lT7XEnepcf+PdMGI/FTYTMIxtE2tLZ1jpAUhcOwCbE3pSR/rsuiht7dccx/OYeD/Nt+xMr7yJ518GTgFbg1wspcFx8M2pqeD/LZa9nG8k+x98gaXOCmF5OWpCEBlFGVdAXbxKGLhLFJ9bIYdgsWRD/WF1Yz/OR4zrDcgjdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6329.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(39850400004)(376002)(396003)(451199018)(53546011)(186003)(2616005)(31686004)(107886003)(6666004)(6486002)(6512007)(6506007)(26005)(38100700002)(110136005)(316002)(31696002)(478600001)(2906002)(86362001)(83380400001)(44832011)(54906003)(36756003)(7416002)(4326008)(8936002)(5660300002)(41300700001)(66556008)(8676002)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCt1ZkZ5dldyNXFJUEJiNFpMRUZKWFhhQW5tSmxBVElST3lDSjJXc2oxSno0?=
 =?utf-8?B?TlhzSGlCZ0RkSXVYWElhWXhKYlJnVDBrbW1RU2thTDFOWVBWaGs3di96d2wv?=
 =?utf-8?B?aHdRWjVPRTEzNUh5RlVCdWtHMHRsS041ZllOVVQ3c2Zib21oWXJzak11am14?=
 =?utf-8?B?TEc2Wndsc2FDSFh2V1lrbWl6UmVMQ0sveGY1YjlBRm5BZGVJVmZVdUFlakVE?=
 =?utf-8?B?QVYrS0tVTERaSWVHbVRKWEI1aDl0MXVka3loTmJKb3NWSzNSRzRBcmgxMkJa?=
 =?utf-8?B?anJKT2FXWGY0R0dabUJxRUoxZ0IxejZJbldkUjIvRCtaS3YrZURsZDN2bTgx?=
 =?utf-8?B?K29sc0dhVWtYb3grQWU5Z2crU1c0a3VZUitHb0ZSay80dUJVYjdzTGZieWlB?=
 =?utf-8?B?RllqY2VYdUpjL005RnoxcHZEN3htUDhSZGFhYWhsbG4vcjFpNUJyY0t3cjZF?=
 =?utf-8?B?TlVMMk5yMXlFWGZmanV1SFpRdk85clN2YW5IaVBtQXR0V1pFRlljNlpFemli?=
 =?utf-8?B?MjBRSytiYWxtVmY2YmthVEh0VmYrazh3Zk02VVVab1ZLMHN0N0tOYkhqRVRT?=
 =?utf-8?B?OVlmV1NFMGNma0ZvQWg4d3BmMENCeVNhbkx1aTc0ZWUraWNkck84b2JEdEdD?=
 =?utf-8?B?NC8rOWszUDIzcDNCV3FvYkU2RzdyV0hUaTJpdXh2QTQ0YVhYNWZiMEdZZHdH?=
 =?utf-8?B?SkthTFN0dTZhcExGZS85SUdid3NHeTY2elFQVmYxVG5rTFVnY3lneUxSNHpw?=
 =?utf-8?B?cTAyQVRuZEM0UlB0VGZIR1ZhMnlZTUQzbHdDdTFOR1JpZlc3UXIvN3NiblRq?=
 =?utf-8?B?SFQvM293OTNpdlBYRXRpR1ZSb0dIdlNCcFI0eUZXUU9BMWlYdmF0eFAyK1hq?=
 =?utf-8?B?cmNCRmxFc3JXQkp4QXRCaHNEL3kzcXFldlFMd05xaGNMSTB5dXNNVWVMcVR5?=
 =?utf-8?B?REVva21aeXJlODluMjd5TS9sS1IvakcrMTMrZFZ1alNlUEg3OVoyQ2I0MmZo?=
 =?utf-8?B?TXAwQnkvb0VFTHJTaTg2UW0zTjd2WWhYUGNqdUdxOVNmd1pLMVFia1pEVmVy?=
 =?utf-8?B?WGpQUVM4b1ZNcEtnSEpXRHhleno4ZlpvRWFIdTZXWU15SUtvYW5CREowbWIw?=
 =?utf-8?B?VHN1QlZObTdVRGk2YkpOUnpTY0ZGMlhVUXpLbzRqeG9hRWthWjJaaGlvajFL?=
 =?utf-8?B?ZHZ6MTA1QWZ5azVzczd2SkZnUitOak1heDFXRTRjQVlsb2puOVlzT0xiaURY?=
 =?utf-8?B?WUk3RC8wdG13cXNBVjJkcXpCV3JxMWtBSWpHRStOOC9DcUU5QXRWZVNvNzho?=
 =?utf-8?B?VGhaS1lKTmhBcGx4UDhISEtqVnh5MnFnV2N0Q28zbVc4TmZDMmNTdGVPdUtT?=
 =?utf-8?B?cjBaM1pHa2Myb3lwNEZ0WGoxOWpqYWp5dE83Nlg3cXF3SkFVTkt2UkQvcWMz?=
 =?utf-8?B?YzNFSGVoZDJ0QTYzcTFnQWxpTmFpTk52Wk0vZTBRSk1tQkorUmhOdzBtRXJS?=
 =?utf-8?B?ZzZRZUpKZGoyVUNJbGU3ZlZtTlhiVUkzTVFmUHpmTWhKbjR4ZGsrRkI0dWVn?=
 =?utf-8?B?RURhdUJxbHNEU1dFNFFKcms0Qy93S293RFJCV0xoTC8rV1JwUXJQSkFuSzg5?=
 =?utf-8?B?ZnlPVVM2aitQVkJvRys0VGZ3YkFLNkhjZ2J3eEN4dGxIK2xXUng1TnA1MnRy?=
 =?utf-8?B?bmIybDQyMXVZWUdxaEVzWGhHSzlkLzgwazRFNkNNbXhwUlZKNmhZVnE1VSti?=
 =?utf-8?B?MjZxSVBtMUlxYnBSL0YvRkdUK0Jpb1RuNCtLeURzRUU1RHlBcWlPV2t0N05h?=
 =?utf-8?B?eEdUaGZjRysrZVJMcTltUFlrZCtVZnJjdDROMmhkV3p4c1lWTXF2bG4yWGVh?=
 =?utf-8?B?Mm5kSzlDTEhOcmd1aVdsTjRqL1BiRWlhbGh6blFwWllyWU5KeFBHKzRSVUZZ?=
 =?utf-8?B?SytqSkxRQ1pJeXRQaWNIWnMwdnBWYnFBSTU5bEtIQjU4TzFTaVZHeWRITVk5?=
 =?utf-8?B?S3dUNzByQzcxM05zblpYUlJCMmplWmV0RlpIc0lyaHExT0d6OWJCdE9KdnhQ?=
 =?utf-8?B?TWthc05wR2c1RjIzOEdaRE1UYWNYN202S1VoWXY4OUx6OWRhNEhEUjY3cHVp?=
 =?utf-8?Q?aGxBp35NzJr3kFZrtydhj6PPJ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c97c4b-cda2-4aec-d31c-08db2aa987c9
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6329.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 07:46:22.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXF0JHVrCs8jYQZANYBZAFAD3QzAvROObfMXlwDap/oX+tu1w+4l85yaDYqOhHp7K2tG+J+o1U/3v46M977fpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5522
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/21 17:41, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
Hi Jerome,
	Thank you for your reply.
> 
> 
> On Tue 21 Mar 2023 at 10:29, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Hi Martin，
>> 	First of all, thank you for your reply.
>>
>> On 2023/3/20 23:35, Martin Blumenstingl wrote:
>>> [ EXTERNAL EMAIL ]
>>> Hello Yu Tu,
>>> On Mon, Mar 20, 2023 at 12:35 PM Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>> Since the previous code only provides "ro_ops" for the vid_pll_div
>>>> clock. In fact, the clock can be set. So add "ops" that can set the
>>>> clock, especially for later chips like S4 SOC and so on.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>> please describe the changes you did compared to the previous version(s)
>>
>> I'll add it in the next version.
>>
>>> [...]
>>>> diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
>>>> index c0128e33ccf9..bbccab340910 100644
>>>> --- a/drivers/clk/meson/vid-pll-div.h
>>>> +++ b/drivers/clk/meson/vid-pll-div.h
>>>> @@ -10,11 +10,14 @@
>>>>    #include <linux/clk-provider.h>
>>>>    #include "parm.h"
>>>>
>>>> +#define VID_PLL_DIV_TABLE_SIZE         14
>>> In v1 you used ARRAY_SIZE(vid_pll_div_table) wherever this new macro
>>> is used instead.
>>> I think using ARRAY_SIZE is the better approach because it means the
>>> references will update automatically if an entry is added/removed from
>>> vid_pll_div_table
>>
>> I agree with you. Perhaps the key is to understand what Jerome said.
> 
> I asked you to describe how this divider actually works. Not remove
> ARRAY_SIZE().

OKay! I misunderstood your meaning.

> 
> This divider uses tables only because the parameters are "magic".
> I'd like the driver to be able come up with "computed" values instead.
> 
> What I requested is some explanation about how this HW clock works
> because the documentation is not very clear when it comes to this. These
> values must come from somewhere, I'd like to understand "how".
> 
> This is the same as the PLL driver which can take a range and come up
> with the different parameters, instead of using big pre-computed tables.
> 
>>
>>> Also I think there's a different understanding about what Jerome
>>> previously wrote:
>>>> It would be nice to actually describe how this vid pll work so we can
>>>> stop using precompute "magic" values and actually use the IP to its full
>>>> capacity.
>>>   From what I understand is that you interpreted this as "let's change
>>> ARRAY_SIZE(vid_pll_div_table) to a new macro called
>>> VID_PLL_DIV_TABLE_SIZE".
>>> But I think what Jerome meant is: "let's get rid of vid_pll_div_table
>>> and implement how to actually calculate the clock rate - without
>>> hard-coding 14 possible clock settings in vid_pll_div_table". Look at
>>> clk-mpll.c and/or clk-pll.c which allow calculating arbitrary rates
>>> without any hard-coded tables.
>>
> 
> exactly ... or at least an explanation about how it works and
> why it is too complicated to compute the values at runtime.
> 
>> In fact, pll and mpll are also fixed register writes corresponding
>> values.
> 
> That is not true. The pll and mpll drivers are able to compute their
> values at runtime. Please have a look at the drivers.
> 

After consulting the engineer of the chip design, the clock is a digital 
frequency divider, and the frequency divider is verified by the sequence 
generator, which is bit0-bi15. bit16-bit17 confirms the size of the 
frequency division. Whereas other PLLS and MPLLS are analog dividers so 
there are fixed formulas to calculate.

So Neil had no problem implementing it this way. So now I want to know 
your advice what should I do next?

>> But every SOC is different, so it makes more sense to set it
>> outside. The VID PLL is a fixed value for all current SoCs.
>>
>>> Best regards,
>>> Martin
>>>
> 
