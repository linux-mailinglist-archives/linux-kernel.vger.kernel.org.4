Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9726E09A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDMJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDMJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:03:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF53A273;
        Thu, 13 Apr 2023 02:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxt0hLrvQ38nmwwsxE/sOeZPw5PYg72zw8RPO0ou0/wYTFy2/3Mp8jy7xTQu/+sXhMKPXZyMLfaOPZU5vL2Vfmob4zChhstLuehUvIzTezYKRozz1Cu4+V7MJDRuYkT+qCzfAisJOsqzLZ9XTxmzIK11jcI8HazM6f91HOM4pokTgoI+66ZSVeCy56OsB502zgZahfPfKXu2pxpyxjYXIYZsUpU5JRYRyo5FimSdvdOisZSvYJQOE3jTvbsCWzrTnyhifBYlog+ZuaP1RlWUZlg6n0jUt+xV4e5dCl1lFXhJnAFRu9dges0eH0AgdyRXjL2YJCInaTyUokrzaUMj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9JORRWECmz/90AJsKJpcuCuUahEX/sASbGgW/X8iTk=;
 b=iIcTY+m74/ZD2HIHK47Te5id7HTi8L2cdjg2pwxyV6PImXR13oLJbDMPnyi4/y5zKM/Kxpl9JeRUv8tT5F3RLkx3Jz1mJ4J4rXDv+0LnABlGey6TdQXGR+4cVHV183UbHDqJvgHpea6iN0ydmyHteXIh1AQJ/b3bZuyTklbBAXBXe+SxjZ7Hq+U3tJQzOSjbtVFfNfzUIdH+ve2G7P8K04MZ3cWSIc/9pcVhBCVBfQPQNtQ/Kh6Udqg2H1XvbhIaxtGLIfdHA+t5IsW6cAK6QLK6Lk3cc7r6ZKlKpiCOhTLLcLrIDi0Y4wKpChqjMg/DcQYskvco2tM2ohijt1hooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Thu, 13 Apr 2023 09:01:18 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 09:01:17 +0000
Message-ID: <1df3be1e-ebff-cbd4-0739-2b919b840eac@amlogic.com>
Date:   Thu, 13 Apr 2023 17:01:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2] clk: meson: vid-pll-div: added meson_vid_pll_div_ops
 support
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
 <d403dda4-e3db-4f26-6996-090a8c520b94@amlogic.com>
 <1j8rfp6u0h.fsf@starbuckisacylon.baylibre.com>
 <2e68acd1-f3d1-adbc-5ed2-66c40e006579@amlogic.com>
 <1jleiyyk7k.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jleiyyk7k.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|PSAPR03MB5542:EE_
X-MS-Office365-Filtering-Correlation-Id: 586879f0-ad7b-4062-9980-08db3bfda3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfWNxpgowprm9Zn+VCy81IZZWkgp6Kq0c02DZwmD2fS0Z9wYK0FrNVSIoXPbflTfNHd2y88WTQNDg0fwguOJqpsLGrKl2w3TAUg0MzsgsRqU/u8WSI61iqFXqogO8VP+uYtSQ3ZuKBx5ay0gk8+B4UGWtf5gcut7qvhuQOCQLl5I6nwp4LZoyWpo/srnQPCOhWnR1tsK3NWC1p6q0XXVtwsEzS1qAjls7XnumON8y/dGoWLOz5k0lghrJT5sMFvmJYXHFWRuqaTTKiyAwyvzRrsg2wFGwJiad3HSXoJJj1JpStzcnLSQPopjk1z8qEVI7o//tIRUcFXAj/jFk9jthCg2VbxZS44a4sJnG2hZkovcg9jAsigxoXkxE8jMIPV4M/aoBQO0t88fQoI6Qx4BsJ6rHPjIGKF/PhULWSm8zpiZ2eyHiP7Q3NtEU6JLAnrxHQlqZZ+e5Nd/67N/c1lLkxAWRWZxZTCwDNTZ0vMax2Av9aRVCfshXwiAqb8+W4MeHi3xe0+qR109rEbWiMkx5dyipJ+lXRPMiLRNzFb+iWq7Cd9fHpEhV0tE+e8JCNbkIIfGPj7m2DViVtIM5Z8YQah5RzwIoNrAyZ7skuAmX5C8eeXGScpvzvZJVPFyhJO+qShTaUMrjjXcPtC7le5oIEcP9lNdJ3EenhEG+qt2Y+MuS2eKseCkg0iMtnAzjOrvVHyew/p8u74gHucwRPILdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(396003)(39850400004)(451199021)(41300700001)(66946007)(66476007)(66556008)(110136005)(478600001)(31686004)(54906003)(6666004)(6486002)(316002)(4326008)(2906002)(83380400001)(186003)(26005)(8676002)(8936002)(2616005)(7416002)(36756003)(44832011)(5660300002)(86362001)(31696002)(107886003)(6506007)(6512007)(53546011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDA2RXc2dVdMWVI0cUxWUWpJZUZ1UGxiRzFKQytEd0FMdVluZW1oRkhoVW8v?=
 =?utf-8?B?S0YzWWFscnVlaFFIRkRPR25jeEkvMzhKWmRUeUpyd3AwN1ZSc3gyRFUyYlZE?=
 =?utf-8?B?RnhFMjc5d2xFdmNjMXJNT0l2SDAydEt4SEJLN1N2VHVWL0dEZ0JOVTFlWFc2?=
 =?utf-8?B?NTZIT2RGcTdvb2RZRkhoblZEampEUVJ6OXlWa3Q1eVpyb294TEY1OGVTT0pj?=
 =?utf-8?B?T0RxVEdTZ3VPdGt0YVNLK1JHeTVCL21ROHo4bXJKTlJVTHZzNmlJb21kSU1v?=
 =?utf-8?B?TTJKTjBuOFVHMW40aWRrdzJGTXlsZnJORWR3a3I4aFIxSnlvOTRkODJpRVJH?=
 =?utf-8?B?NFhGYnJZS1ZoNEdDSGpURW84NE1ZZEhzQ3A1ZTF1ZExHZFhjWUttNGQ1dThD?=
 =?utf-8?B?RzgvZ0ZROHpyWkllNm5pWk5mVmFJc3JPMkdrei9uVVA1cG12VFhtT3lYQ25D?=
 =?utf-8?B?UkorYVVoazF2cEpvbUdZTktwR1NuR09jaW14OHd1S09UbkExZGRHdTdUUVlN?=
 =?utf-8?B?R0x5Y29LeXBKaWExN3lUUjM0SjU4U045M0tEeGhjQUd1Ri9yanRVa0lSd2h4?=
 =?utf-8?B?MWFQWWRhYmtNTGFwSFF3SjNrWFV1RDlpUGE2ZnlQUGxlSU41UFFuWGYzUC9v?=
 =?utf-8?B?d3JOQlRwT3Rsazc2ZEV4cXJTdXV1dDErUUorcWU5cXNTOE10WmJ2ZVQ0SHpN?=
 =?utf-8?B?bmc1c0VaNXRNODVDQUNZN2Z5S0VSdVFmVGVKQUxuYzlyeGZxVzVlLzhLYktw?=
 =?utf-8?B?RFZMZjhoaW9IVUFhZ3NiTWk3WXo0QmIwWXRTNUFGZjc1ZmM1blFITGxUVDRm?=
 =?utf-8?B?VCtudWsrMGpoUEFGTmpLZ1ZxdUtEM0J0amdzZHRQeHNKZllkQ1N1QjhHYTQ1?=
 =?utf-8?B?cGZDYXJ0dGNqOFRkb0dpbVJJbGlyejFCWVNKT2NjN0tlOHpHQ0IybEdER2Va?=
 =?utf-8?B?YUUvdVBBUEcyaGRzTW94NkgzVnZLdFMvVVlxTXp4MUVzUTVZY2ExMEZQQ1c2?=
 =?utf-8?B?c0lPaW5HYmhHUGIxcS8vVnJ5enM1RzZlSkxYZ3NEbFpvWjVMaURlMDV6dXR2?=
 =?utf-8?B?dU1EZ3RnUFkrc1kwVDBtVEFFZGVFWEpHaG5zTDY2VUs2R1RrN0JyV29uSW0x?=
 =?utf-8?B?aEZZeDBKSWVIN2lyNGYwNlZzSXBIVkRHd295eDl4dXdMSkx3VUZZbWQrV1k2?=
 =?utf-8?B?aFFJWTdEVEs0Tkx5aHZwbUZ0NVp6V1RJMXpMZHBYT0FlWTZiZUNOQ05vb2Na?=
 =?utf-8?B?bmg2dDV0NXBEWWhHMit1WjduMmlhRksrSmQzWDZjdndiSXYyaWtBVWFzUThF?=
 =?utf-8?B?ZDVSWE1paElZRlZYYkNWZnhWcWhGUU83c3Qzd29VTzlDZUx0YlFuNFQ4Tldt?=
 =?utf-8?B?K2M3WURSY3M0QW1JSDBCZTkvREV5NWFvVDBYelFQVHhySWdVRG95dXp4NzBq?=
 =?utf-8?B?d0tsUFdqQlJ5a2hVRTJwVml1MFFMb2daTDNpNjArWUtUa1REREphUjA4MUJv?=
 =?utf-8?B?dnVPVllyUzN6OFE3UTRYb1VDeHpkc2QyY1o4NXRRQk5VQ0M4KzR4aXByS1Qx?=
 =?utf-8?B?MmgyM0dqQlNWMjRjbDhROGNOT2s3d0dxNC9YNnRVaFhyajAzWUlKbTlqaC9E?=
 =?utf-8?B?SWduWlZRbVc2SlE0NFZoVThJMmNhd01RbnZlc2tsek5ZbExEUjFsSHpPcXRy?=
 =?utf-8?B?Ni9udzhQbVVuaE16RVhNaGtuNEtuY3ptdkJpd3c3VnVnSnpkVDlZNDJTMk9n?=
 =?utf-8?B?dVp4TVdUT1VhcTRMUXJhZHp2L0FaRmcxbi91LzFXNGtYOXAvT1hJYTBtN3U0?=
 =?utf-8?B?a2t3a093SlVZRE5zYVJEaDZDN1dPdGpvYjR0aDMxN2NzQVlKem9ncFNSNk8y?=
 =?utf-8?B?Q3ErampBd1pBYmlUazRkU2JoYWtFRkh3NitEWXZTWEkwNmF6R3N2SjcycnU2?=
 =?utf-8?B?TjJ5Yk16UlVVcDZ5N1NXanNiR0ZNRTRiL1EvQ1VnQWVEYlppQlZzQmZtZEJi?=
 =?utf-8?B?eVFFcThjMFFWZXpaQlpVRmE1WmZBOG5WZi9TSkxGWmpMU3l5bDZSTlFsTXdU?=
 =?utf-8?B?RWhWRGo0YlFoZ0xqcitmYXprOG9ZRER4dnBWUFJlVHQ0eHNiZVR6MmYydlgz?=
 =?utf-8?Q?M9on7iTsP2SheaBUmmJ1GvHit?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586879f0-ad7b-4062-9980-08db3bfda3f2
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:01:17.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lE1R0meBRtQe43rDYotugdhfV7Xz3pt085MAHmkzOaiSMUXSgQyP4HC1kV7yO4JvJXnCpS7sM6jcp7TorU2DjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5542
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 15:02, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Fri 07 Apr 2023 at 18:08, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> On 2023/3/22 16:41, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Wed 22 Mar 2023 at 15:46, Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>>> On 2023/3/21 17:41, Jerome Brunet wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>> Hi Jerome,
>>>> 	Thank you for your reply.
>>>>> On Tue 21 Mar 2023 at 10:29, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>>
>>>>>> Hi Martin，
>>>>>> 	First of all, thank you for your reply.
>>>>>>
>>>>>> On 2023/3/20 23:35, Martin Blumenstingl wrote:
>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>> Hello Yu Tu,
>>>>>>> On Mon, Mar 20, 2023 at 12:35 PM Yu Tu <yu.tu@amlogic.com> wrote:
>>>>>>>>
>>>>>>>> Since the previous code only provides "ro_ops" for the vid_pll_div
>>>>>>>> clock. In fact, the clock can be set. So add "ops" that can set the
>>>>>>>> clock, especially for later chips like S4 SOC and so on.
>>>>>>>>
>>>>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>>>>> ---
>>>>>>> please describe the changes you did compared to the previous version(s)
>>>>>>
>>>>>> I'll add it in the next version.
>>>>>>
>>>>>>> [...]
>>>>>>>> diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
>>>>>>>> index c0128e33ccf9..bbccab340910 100644
>>>>>>>> --- a/drivers/clk/meson/vid-pll-div.h
>>>>>>>> +++ b/drivers/clk/meson/vid-pll-div.h
>>>>>>>> @@ -10,11 +10,14 @@
>>>>>>>>      #include <linux/clk-provider.h>
>>>>>>>>      #include "parm.h"
>>>>>>>>
>>>>>>>> +#define VID_PLL_DIV_TABLE_SIZE         14
>>>>>>> In v1 you used ARRAY_SIZE(vid_pll_div_table) wherever this new macro
>>>>>>> is used instead.
>>>>>>> I think using ARRAY_SIZE is the better approach because it means the
>>>>>>> references will update automatically if an entry is added/removed from
>>>>>>> vid_pll_div_table
>>>>>>
>>>>>> I agree with you. Perhaps the key is to understand what Jerome said.
>>>>> I asked you to describe how this divider actually works. Not remove
>>>>> ARRAY_SIZE().
>>>>
>>>> OKay! I misunderstood your meaning.
>>>>
>>>>> This divider uses tables only because the parameters are "magic".
>>>>> I'd like the driver to be able come up with "computed" values instead.
>>>>> What I requested is some explanation about how this HW clock works
>>>>> because the documentation is not very clear when it comes to this. These
>>>>> values must come from somewhere, I'd like to understand "how".
>>>>> This is the same as the PLL driver which can take a range and come up
>>>>> with the different parameters, instead of using big pre-computed tables.
>>>>>
>>>>>>
>>>>>>> Also I think there's a different understanding about what Jerome
>>>>>>> previously wrote:
>>>>>>>> It would be nice to actually describe how this vid pll work so we can
>>>>>>>> stop using precompute "magic" values and actually use the IP to its full
>>>>>>>> capacity.
>>>>>>>     From what I understand is that you interpreted this as "let's change
>>>>>>> ARRAY_SIZE(vid_pll_div_table) to a new macro called
>>>>>>> VID_PLL_DIV_TABLE_SIZE".
>>>>>>> But I think what Jerome meant is: "let's get rid of vid_pll_div_table
>>>>>>> and implement how to actually calculate the clock rate - without
>>>>>>> hard-coding 14 possible clock settings in vid_pll_div_table". Look at
>>>>>>> clk-mpll.c and/or clk-pll.c which allow calculating arbitrary rates
>>>>>>> without any hard-coded tables.
>>>>>>
>>>>> exactly ... or at least an explanation about how it works and
>>>>> why it is too complicated to compute the values at runtime.
>>>>>
>>>>>> In fact, pll and mpll are also fixed register writes corresponding
>>>>>> values.
>>>>> That is not true. The pll and mpll drivers are able to compute their
>>>>> values at runtime. Please have a look at the drivers.
>>>>>
>>>>
>>>> After consulting the engineer of the chip design, the clock is a digital
>>>> frequency divider, and the frequency divider is verified by the sequence
>>>> generator, which is bit0-bi15. bit16-bit17 confirms the size of the
>>>> frequency division.
>>> That, we already know. This is what the datasheet already give us.
>>> It is still a bit light.
>>> You don't set the bit randomly and check the output, do you ?
>>> The question is how setting this bit impact the relation between
>>> the input and output rate? IOW, from these 17bits, how do you come up
>>> with the multiplier and divider values (and the other way around) ?
>>>
>>>> Whereas other PLLS and MPLLS are analog dividers so
>>>> there are fixed formulas to calculate.
>>>>
>>>> So Neil had no problem implementing it this way. So now I want to know your
>>>> advice what should I do next?
>>> 1) Neil did what he could to get compute the rate (RO) which the little
>>> information he had. You are trying to extend the driver, keeping an
>>> dummy approach. It is only fair that I ask you to make this a real
>>> driver.
>>> 2) Because something has been done once, it not necessarily appropriate
>>> to continue ... this type of argument hardly a valid reason.
>>> I don't want to keep adding table based driver unless necessary.
>>> So far, you have not proved this approach is really required, nor
>>> provided the necessary information to make the calculation.
>>
>> Technically you are right. I am communicating and confirming with the chip
>> designer to see if the general calculation formula can be given. If not, I
>> will explain why. Please give me some time.
>>
>> But I have to mention that the SOC, although there is this register but
>> actually does not use the clock. Can we treat this as a separate patch that
>> we will continue to send and explain later?
>>
>> This way I can continue with the other patches of S4 SOC first, and this
>> clock stays the same way as the G12A first. Later, after the patch of the
>> clock is corrected, it can be corrected to "ops" as required.Otherwise, we
>> cannot continue other driver patches. I don't know if you agree?
>>
> 
> Sure you can send your s4 series with RO ops and change to RW later on
> if necessary.

Ok, I will be ready to send S4 chip other patch with VID clock RO ops first.

> 
>>>
>>>>
>>>>>> But every SOC is different, so it makes more sense to set it
>>>>>> outside. The VID PLL is a fixed value for all current SoCs.
>>>>>>
>>>>>>> Best regards,
>>>>>>> Martin
>>>>>>>
>>>>>
>>>
> 
