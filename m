Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9AC6DAB37
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjDGKJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbjDGKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:09:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9504C3F;
        Fri,  7 Apr 2023 03:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF8AjjuvJg418m/kz7kgmam6E6OF1FvvYAzXuq8Tbg8PGJNPaAkgTCBaqciTHSMyAL6PCvPPTu3eevF28iON6YnBnoNXBZn6eBFllc8PukEv9NmD8Tb8t0ikZEY9WLvU7UMiIL6x5lUTGMj84FZ2VP4CqdzwLREypIEZOEEWlGwCJAza+o9iKBlGAO7oPRFVI+XlNI8bT7Eed4lOZLokgr9gDwbRplr4efzDJXVGo9pXQgF+qBTL0AfuS11X8GCiEHnJJ6dGWCF24AGgS3bGLIDUW5ZPm2LSDnTmHb2hOSYk+cTarz1/Ae7PicKfVH/KccALC3GxVcNPdj2DDMPwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JU+YZvAf2iuW88Ac/wo2w/ZdeMLumyrkd/qm1Ub/P0=;
 b=DgITWUexVMXGZYGWQsDJFti9t14a9Yaf+VL6c5pCqAKY74yP5z6PTIJ0snEjQBOxKFqv1KR4Ja+whEeTSJshpXDY9bMAsoAOb1chG7/aTKulJULi33tP+K/88KXEoQRUO4MU8cv3mmD6lVsvbd7wcaoyaYuzKIlttZPDR7hHRKb0jNJvGudxhoV11N6DvWsE/0xjcvpY73nDfFfcNT9ELQIu+ATVC6+DrYL5E1e84RGlm+A2YtDw7WIlMLi9+sFhEUMdhfWgQLGBNb6MZ0fJDXX63cSlqlZpmiWErwC5Bz2yyanHlxJr8C3d7Hm44rOFgznHoRYoHw/96wr7CT3Gug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SI2PR03MB5971.apcprd03.prod.outlook.com (2603:1096:4:148::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.33; Fri, 7 Apr 2023 10:08:18 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%6]) with mapi id 15.20.6254.034; Fri, 7 Apr 2023
 10:08:18 +0000
Message-ID: <2e68acd1-f3d1-adbc-5ed2-66c40e006579@amlogic.com>
Date:   Fri, 7 Apr 2023 18:08:13 +0800
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
 <d403dda4-e3db-4f26-6996-090a8c520b94@amlogic.com>
 <1j8rfp6u0h.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1j8rfp6u0h.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SI2PR03MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b64b51-9b48-4fa9-c6d4-08db3750021c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMfad8yfv+LUTa1kIkVUpLMnjYAUjk39XTvecf6RAb4EJhGwjii8qAUztEzMVql+MYdSG7mf4Dudq3S65iC3HXu7wXLFENaTrzlsFBcjpDniWeSMsuUPuQ3sTioSUJmrfXStwHRVwCtgeYSPvihjH4biogRt1o8qG8Dnq80xVt+x2rlucfyIcUJMkEyBLMQO6ByzMutypUgUVT9xI1yJ9WvW1cjWJPXb4y+22TTmamvs/jeMDOjBjs32wWp3w3Kfgu8i2fPcJu5sG+61l7IMIEYY7kMdUbQjiWg2TpMNkLSgCrFvi6fVmh+75pMiswW0/9gpDiCANn0o+u6E0qmqcue2MATI3ArI6jceiPdjP46PfODk2x4QizukkNrTL+xAKjjTyJn6vLUM89RZxNehca2C2zvz16AbULqtmfS6P41W/mcN8ivdSWS9I94JLM9uSw0M8Gwt/UWFtI7n17+bydyO5+C+Lrpn1Ja3yjGv/7sO+gu9ssM9hIe4LRhNKNIA7Ugczfc9tmO8Slk0QhC7aNBp3gKkCEQqrLEhzBXgZXMMRV7zRLR7yWZo3rlqTKDnNcZ89PATNWh8Qs2RBBCZ8ZA15kYPOIKeeeib4SJfYscNpL+IdczQTS5aLEl5QbVaRm2KpoczAFy8r1ZpdJO4o7rfCvYfcojiHjQ57UvfKY2jKc55ZooCkAgq/tx46nV+1+cNVDV6nP2fjgUgHmGH3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(396003)(366004)(346002)(376002)(136003)(451199021)(31686004)(36756003)(38100700002)(5660300002)(2906002)(7416002)(44832011)(31696002)(8676002)(86362001)(66556008)(66946007)(66476007)(41300700001)(4326008)(8936002)(83380400001)(2616005)(107886003)(110136005)(26005)(6506007)(6512007)(316002)(53546011)(54906003)(478600001)(6486002)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFRTzlidVk3THppWTg2UkZnVDIyMmJHb2NPcjJLK0g3Mm1HMHRGOFpjL1lt?=
 =?utf-8?B?S2tKdGoyVlRKVzRaNHdaWGU1MGJpNko3bWJQTE82anZWTWxCYzRhODJGMDJB?=
 =?utf-8?B?eDFRUVdYa05SeVA3NVpMTExQSU15QmRQaUdwbjRJOG11Skk5MHBOWUFNcExv?=
 =?utf-8?B?MEVyNjgzbmhwTEw2OUM1akhTMkxIUlBsdXVzVElMd1IxMnlNazUybC9BSDlJ?=
 =?utf-8?B?ZHNzV0E0QU5kSmVtRk5VMkFGUkZVTTBTbzNTdUliME03bzh6M0c0elg1TFMx?=
 =?utf-8?B?TkNqVnpUeFp1ckJSbDR4RjlCWkdRTjdHTWVPVXZrdS9jdVpCN1IxS3JQQTNj?=
 =?utf-8?B?c0lrU0xUSUFKam40Z0pRZ3k0R29MekQzSTlIMTF1WGxVMWJ6Y3pvaDFqSkRC?=
 =?utf-8?B?T05RREJJaWpEVWJEMyt2azBJOEdtSXlYdDgzcHovTTBubXExVXNJR2RzMWVh?=
 =?utf-8?B?Mlg5MGVyUG1YUW9qRzFmY2I3ZHdDcWFiVFgyT0NpdisxUFRxTzg3SXR0OGpn?=
 =?utf-8?B?MTZrZXlqU0hKY2g2WkoxRFR4ek1aWEFMN0lqVzVCNzZDUmR0WVlnVEhaTVJk?=
 =?utf-8?B?NVBDTlg3S2VPeEs3cHdPallLaVk2VmJaNFJKbFVWd2F2S0tMd1d0NlBjMVM4?=
 =?utf-8?B?anJ4TXFtWUFLRUZqVlJBdmZDSkt4dGpMKytqNzJ2UnBweWZMK0Ezdkc0SnBo?=
 =?utf-8?B?dmxZV2JzaHNRTE0rZk9oT0N1eWh5VHZ0ZW0xVlRHb01LZkpXWC91ZnlPSEpj?=
 =?utf-8?B?ZjdMT3FWdFRrUE9NUTRCcHoyVzZBR1NKK3IzVmpiYlE3UXZzQVRHMlJCK0xL?=
 =?utf-8?B?aFA3WUxtdFQ2b2w3L1o4QktLMDh5NnQrQlV1Nkoxamc4VHFqNDdpWktyb2F5?=
 =?utf-8?B?OXkxVTVseVE3REhURE9uekJ4djhnMTNmN1ZUOG5FMzIrMzVjRnJTMWJ0czJO?=
 =?utf-8?B?KzVCdTZFTkI4QWtTN1BhUDRLUytQT2xyREpJcnZmUGdlYlhsQlc4RXMrc3du?=
 =?utf-8?B?RURIaXJrSDhjUEJpYnN3ekYzZ0wwZytTV0FsY0R1U1Q5YUxydVVRUzVSMUY1?=
 =?utf-8?B?V1MyRVZwSmtMSE9jSjJnQkVxTGpkOXBhQm4yY3JJUGFmU3k1VWxEOVd3NFlJ?=
 =?utf-8?B?ZWxDQURTMnFMbnBtVXJYbDU4QkYrYTVGWG8rTkd5RVpkR1JrcElaaUVpZnM2?=
 =?utf-8?B?RXA1NkdzMGFYUjBFRkJUNFcvUlZJUEdlT2VDc1VveFVvZjBuVDhrMENFQ28z?=
 =?utf-8?B?VHZqeDBWQTlwODdoU0ZlQTlpbWJackljZUhmYjNscjZFSExkT2JrUVFDbjhK?=
 =?utf-8?B?bUYrZ0Vhc3lIa3F0K0R0U0J2cXVCR2RBakFFWnVSbldLei9qZ0RZMllLcitL?=
 =?utf-8?B?T0JpRWtqMk96R29HTEVFOC9oaEx5bFd6T0gxTzQxcUkzQmJiYllIVjZRY3B3?=
 =?utf-8?B?OVFOemdPSE5rWnBHdDB0bGNHSXdvb1BMT3NPU1pMdU5Wbm9tNW1FK2tScTUz?=
 =?utf-8?B?c3BmTjZ0RUs5OXQ2eFVPWTkyQk9Rcms1ajU3RmcvRUM1QzIzNmlrbnkrVzBD?=
 =?utf-8?B?S1dsWm9FdzNjZURYS2JtUWhIRG1rQ0pCMGR5TnE5Y0tIa0NJWTNXUCtvR1lp?=
 =?utf-8?B?NVB0Y1NLb0o2MlFQbHk1OEZ0RlVkbWJ1aERaMUtaQndmdElLUldOTUpLa1Fx?=
 =?utf-8?B?S0RtY3dJcitpaWNEY2t4cllIVHZxUWl6MEk0bGdnKy9lNURFVndOdnNOcDFY?=
 =?utf-8?B?VDdpZ1REYmk1NVIvWWxpOElhN000Y2RhVVBUdDBaeDZnTHRsL2owV3lVRFY3?=
 =?utf-8?B?RW9TTkhmN3dRZG5sd2hGaW1waGFaTnA2dnpncDRRdjQ4a00rT3V0bThNT1J1?=
 =?utf-8?B?ajlXdGovZFhvSmNwbXBiYWRXOWpGZ29IZ1laak9nOWd1UkFSKzlZeG9SVVFH?=
 =?utf-8?B?bmkxWXpWRElVYTBSNXlQOENrNVU4bzArUUF3a3l5aERCYldvL3ZIcWIycGxx?=
 =?utf-8?B?Zi9OeWczK1BTSHlvQ01vczBaSmJIRlhlbFN3M1ozZFpacHNIS2kxdFI4NnhB?=
 =?utf-8?B?T1pDMkp2WDMvS0p1MXhlSFRFbDBHenpNV204cHJxZkRKQytCOU9BN3RmaEw0?=
 =?utf-8?Q?xHs7MIkpDoc0iqCjpMbhAg6DT?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b64b51-9b48-4fa9-c6d4-08db3750021c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 10:08:17.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR04uRXufwlpS0yCUsjJ5Ml178rnbnoNl4N8PbNAa+GViSZq5nRkGhhq3PDat2g0N0DFZf4gqFb1vY32ApVUNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5971
X-Spam-Status: No, score=-2.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/22 16:41, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Wed 22 Mar 2023 at 15:46, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> On 2023/3/21 17:41, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>> Hi Jerome,
>> 	Thank you for your reply.
>>> On Tue 21 Mar 2023 at 10:29, Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>>> Hi Martin，
>>>> 	First of all, thank you for your reply.
>>>>
>>>> On 2023/3/20 23:35, Martin Blumenstingl wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>> Hello Yu Tu,
>>>>> On Mon, Mar 20, 2023 at 12:35 PM Yu Tu <yu.tu@amlogic.com> wrote:
>>>>>>
>>>>>> Since the previous code only provides "ro_ops" for the vid_pll_div
>>>>>> clock. In fact, the clock can be set. So add "ops" that can set the
>>>>>> clock, especially for later chips like S4 SOC and so on.
>>>>>>
>>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>>> ---
>>>>> please describe the changes you did compared to the previous version(s)
>>>>
>>>> I'll add it in the next version.
>>>>
>>>>> [...]
>>>>>> diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
>>>>>> index c0128e33ccf9..bbccab340910 100644
>>>>>> --- a/drivers/clk/meson/vid-pll-div.h
>>>>>> +++ b/drivers/clk/meson/vid-pll-div.h
>>>>>> @@ -10,11 +10,14 @@
>>>>>>     #include <linux/clk-provider.h>
>>>>>>     #include "parm.h"
>>>>>>
>>>>>> +#define VID_PLL_DIV_TABLE_SIZE         14
>>>>> In v1 you used ARRAY_SIZE(vid_pll_div_table) wherever this new macro
>>>>> is used instead.
>>>>> I think using ARRAY_SIZE is the better approach because it means the
>>>>> references will update automatically if an entry is added/removed from
>>>>> vid_pll_div_table
>>>>
>>>> I agree with you. Perhaps the key is to understand what Jerome said.
>>> I asked you to describe how this divider actually works. Not remove
>>> ARRAY_SIZE().
>>
>> OKay! I misunderstood your meaning.
>>
>>> This divider uses tables only because the parameters are "magic".
>>> I'd like the driver to be able come up with "computed" values instead.
>>> What I requested is some explanation about how this HW clock works
>>> because the documentation is not very clear when it comes to this. These
>>> values must come from somewhere, I'd like to understand "how".
>>> This is the same as the PLL driver which can take a range and come up
>>> with the different parameters, instead of using big pre-computed tables.
>>>
>>>>
>>>>> Also I think there's a different understanding about what Jerome
>>>>> previously wrote:
>>>>>> It would be nice to actually describe how this vid pll work so we can
>>>>>> stop using precompute "magic" values and actually use the IP to its full
>>>>>> capacity.
>>>>>    From what I understand is that you interpreted this as "let's change
>>>>> ARRAY_SIZE(vid_pll_div_table) to a new macro called
>>>>> VID_PLL_DIV_TABLE_SIZE".
>>>>> But I think what Jerome meant is: "let's get rid of vid_pll_div_table
>>>>> and implement how to actually calculate the clock rate - without
>>>>> hard-coding 14 possible clock settings in vid_pll_div_table". Look at
>>>>> clk-mpll.c and/or clk-pll.c which allow calculating arbitrary rates
>>>>> without any hard-coded tables.
>>>>
>>> exactly ... or at least an explanation about how it works and
>>> why it is too complicated to compute the values at runtime.
>>>
>>>> In fact, pll and mpll are also fixed register writes corresponding
>>>> values.
>>> That is not true. The pll and mpll drivers are able to compute their
>>> values at runtime. Please have a look at the drivers.
>>>
>>
>> After consulting the engineer of the chip design, the clock is a digital
>> frequency divider, and the frequency divider is verified by the sequence
>> generator, which is bit0-bi15. bit16-bit17 confirms the size of the
>> frequency division.
> 
> That, we already know. This is what the datasheet already give us.
> It is still a bit light.
> 
> You don't set the bit randomly and check the output, do you ?
> 
> The question is how setting this bit impact the relation between
> the input and output rate? IOW, from these 17bits, how do you come up
> with the multiplier and divider values (and the other way around) ?
> 
>> Whereas other PLLS and MPLLS are analog dividers so
>> there are fixed formulas to calculate.
>>
>> So Neil had no problem implementing it this way. So now I want to know your
>> advice what should I do next?
> 
> 1) Neil did what he could to get compute the rate (RO) which the little
> information he had. You are trying to extend the driver, keeping an
> dummy approach. It is only fair that I ask you to make this a real
> driver.
> 
> 2) Because something has been done once, it not necessarily appropriate
> to continue ... this type of argument hardly a valid reason.
> 
> I don't want to keep adding table based driver unless necessary.
> So far, you have not proved this approach is really required, nor
> provided the necessary information to make the calculation.

Technically you are right. I am communicating and confirming with the 
chip designer to see if the general calculation formula can be given. If 
not, I will explain why. Please give me some time.

But I have to mention that the SOC, although there is this register but 
actually does not use the clock. Can we treat this as a separate patch 
that we will continue to send and explain later?

This way I can continue with the other patches of S4 SOC first, and this 
clock stays the same way as the G12A first. Later, after the patch of 
the clock is corrected, it can be corrected to "ops" as 
required.Otherwise, we cannot continue other driver patches. I don't 
know if you agree?

> 
>>
>>>> But every SOC is different, so it makes more sense to set it
>>>> outside. The VID PLL is a fixed value for all current SoCs.
>>>>
>>>>> Best regards,
>>>>> Martin
>>>>>
>>>
> 
