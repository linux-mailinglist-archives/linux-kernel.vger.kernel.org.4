Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6374B6E8D06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjDTIoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjDTIol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:44:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5292D56;
        Thu, 20 Apr 2023 01:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROhxDDm+pzc2AVMYoUsiWUyO9WK027heKsRmQGVvcWCbO8qxGUZK/f0pgNSPuTzXGDNAIPYs0vGuq7dDw99XnpKrIT5WIL6g87+L1cfXosKbbWoK3Nt0HzEW3I+wD9VvNQr1LdrUjiVLQqpRfg2oBIGiQcKU+lLZaGCkE+v3CTX/vEU58N+mCNL47bDF1uHpvvwtraIkP6e1W2R5+E/3Qr2Y2AmbgBKDyJ7IED+RkNqwwOEgmrG8YyuaYF02xyDUL6kD2U3qC6YBU1KQYvXzMS0+DjfOGnlHdXCa7p5Ggn43Rs+3gZKaMekly/5veacSaNHBTLVokXoekS65dkXh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CghG2Slv8gmivGg+Io3vlsM0D6+rRhOth2U7N343ePU=;
 b=XwDq/tLS5pR2Ec5542Vbh1/98fEwBwI82dcNgRQJRkkxYbM2/zFOtLBFRYnpU/Do/QgVDJUmBFfVsnt6hO45VRKDclB8wZnMPN8AmGuCbhRzpwuuxOBVp0GfFAcfBhwYfEBtHn2NqPWVndABw2YJH0hN6vm4oUIud+HH9c/hXPbf5O8SkewkGz0QFUzAufdarbUvOnn1p3QTMtMMfn5jVLCrgtvEKizY0a8v6ILZAa6mBnlcEtgEd4m9LnIFlKru+BPBkYvSNI+D61el+axBuqCX8Mv3Yk881bi8G0qhhKJxvg6q5/itfJtSWh+sjHFFLaBQxHYEXfyG3x625H+CAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7033.apcprd03.prod.outlook.com (2603:1096:101:e2::14)
 by PSAPR03MB5639.apcprd03.prod.outlook.com (2603:1096:301:66::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:43:52 +0000
Received: from SEZPR03MB7033.apcprd03.prod.outlook.com
 ([fe80::9d77:7adc:25da:b086]) by SEZPR03MB7033.apcprd03.prod.outlook.com
 ([fe80::9d77:7adc:25da:b086%3]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 08:43:51 +0000
Message-ID: <1c7322c9-8d2d-1cd1-95dc-dd9ec861981f@amlogic.com>
Date:   Thu, 20 Apr 2023 16:43:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     =Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-2-xianwei.zhao@amlogic.com>
 <20230419131416.cns3xvkbzjeyrnux@CAB-WSD-L081021>
 <661cea17-a4dd-75d1-6a7e-16efa5aea52b@linaro.org>
 <20230419160405.d7qfir3nv6tlxx2a@CAB-WSD-L081021>
 <427e79ef-156d-027e-9296-6f4e6513a04d@linaro.org>
 <20230419170043.auzfa32weevmrt4e@CAB-WSD-L081021>
Content-Language: en-US
From:   Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <20230419170043.auzfa32weevmrt4e@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To SEZPR03MB7033.apcprd03.prod.outlook.com (2603:1096:101:e2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7033:EE_|PSAPR03MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec77e24-939d-4a79-6aef-08db417b5cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFpQ3Gdl6y63zDvKo0onDEaOvFmqdZLiVoPsuf/X4Ld1VIY8ymngAptDhHmkhKCkrjryKoQsV8KJSIgnT7ZZ47m543p0d6FnMHhKGYr3BgwMHxMmGVyfx9Xe/tx1NvApaUspeZeVYQ1iTzjX6ANhKFxuenZZYWJ3i9Citrl6pxmSfC2gB5Lb52Xb5T+MCQWWpFnQC4IdFZi8SOW9ahoMx6GHe8E1Y4hltTVqfucXO48Pq1PGCc41pKeMzaOFNIA/vmTatG2ypH1A2gFHbobZLEyabGTIoZUK7nosYCAzN1gyFFMPDSQccrBml7ePjn+X6D869h7cVHCyQhezdr0vkpcOIN3Aq47prurj6x2mbSK7lqZLPXKUF881XC31qZuuo13w8uIt9PYf/NRL1WIIYlipfeNbzIwwh8PvpPrhrXzmUHKPR12467Upfdv/iBH9HB44X3WkL5NAuOVh/XWM/4YRJEQ9u7YMsf7/LqHqaz+5CX20Iez/WyOW7yjRPmTxANX5LyaVcDvxlNmlRFHQAALEb/dVL7foEFmZ6TGFUK1tJko/gRNkBUKkpN55mH/RXAu2391RSvsToVJgtyxpOrSsbWSlBjk5gG9qkipPMQqo8ZByfVIa1z5D7oSZvqTR8XfQfb7A/Bml/FPWbBl5Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7033.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(396003)(346002)(366004)(376002)(136003)(451199021)(31696002)(2906002)(86362001)(36756003)(31686004)(6486002)(6666004)(53546011)(186003)(2616005)(6506007)(6512007)(26005)(966005)(478600001)(66476007)(4326008)(66556008)(66946007)(41300700001)(38100700002)(7416002)(110136005)(316002)(54906003)(44832011)(8936002)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3RRaXlHZ2RVcjlXMFJ5dDdVQWxndDJBeHlzenY5d0lsTGdXbXZjR09uc3Rx?=
 =?utf-8?B?K3JvYkMrcjNFMVBxZkx5UlF6Q1dTd3FRSlhDdTQwaFVkangyeXRReE9MN0tE?=
 =?utf-8?B?TDZjZGRndHBrbFBXOVpnRkZ4NTM1SE5iZjcwMnM1dEE5Zm5OQnVKWEtjcjJy?=
 =?utf-8?B?d0RESmNBa0Nzdk5pdDhkdWJjbW9pbnhCMXdYM3k5S2FRQnRJY0ZqSlBYR05k?=
 =?utf-8?B?YWZxQXVYVW54MHF2Qms1WmtQRjZ2NUpSdUhTc0ZUb21RSVdSQklFZFJIOCtF?=
 =?utf-8?B?dDRJVFVCUGpUajNBMHUyVERpeDhCbkV0RTdRdDB0OWc3eDdsVDlFRjlma050?=
 =?utf-8?B?T2F6Mm02YkVhdmpvVmtlL2Y1VHkrUVVjcThKaHEyLzNIRVlYUlpEMWt4T2M0?=
 =?utf-8?B?T3MzZUVFUm4xZWVFMHNwYU9HamVEY0dLQzZCNi81NkkzZ2IrK1djUlEybzlU?=
 =?utf-8?B?WmliRmRkWlV0ZnJBekhVd3JKY0gvQVlKQmprTUluUWtqM0Q5VFZJQ0lyZzJI?=
 =?utf-8?B?bzI5ZUx1bHlBNE5vWjUwVlpzVmRtdDJhc01HdERhUXFEWmxkZm5qNlhibFZT?=
 =?utf-8?B?cG5Qd1BUN0Y5MVRpUVhwejREazJVMlFOVTdHTzZPQXZCUzFpNFVPbDBqb3Y5?=
 =?utf-8?B?NktXNG5kRjFzOXJvdUN3QWhLMlhWZStGRXVXUXVzTm1aZGQwM0MzNWdoY1Jm?=
 =?utf-8?B?QUtPSjZpT1lOSHBBcXBlMWlnQzVZU1NWZE1hZHd1V3M4WW9wNnNERkMydkNr?=
 =?utf-8?B?TUMwZTN2bE9KekZYZVlURGxPNmZ4WjM3bThXTmo0d0JjQTZxTXZpb25SY1lG?=
 =?utf-8?B?ZWtVL003T1FvUnd3cEtMWTZrOHBWa0FJNTlkOXBJeWV6bytQaFcyamU0MXNI?=
 =?utf-8?B?NjFiN2x1V00yTWUwOGNpbEE0eEo5NDFwY3NldjFUbEd6QnNrRjV6S0gyeDFw?=
 =?utf-8?B?VGpRRVNUUEdWYmdYVkt4WG1PZnQzaDZZWWNRVVZCeWpaVldReFRxS2NXdThq?=
 =?utf-8?B?V3NyVlBxM0JsTXNSUGdaNWpqUnIydlBROHJKRExWM1JBRkRCejdSdW8wWHdZ?=
 =?utf-8?B?OVIvMStjUnhjQ0YwVm9oRkFDNmYxdUZoOG51aFpzMGlENkYyNU1NSUMvYzBS?=
 =?utf-8?B?MDl1TnN6TnRjVmRYZTRlc3c4NDNpUWRxdTVlNUcrSzYzeENIS042aCs4a3Fq?=
 =?utf-8?B?RWF2MHo3RHo3M0JTa0FoSVdpL2JXc2UzNzN5ZDNiRG42YXQ1NDlESi9rTDk5?=
 =?utf-8?B?bkNwb2RKcUY3Qk41aThUYXJRM1c3RmQ3QzliT011OFE1WGVpSTRhNHppdThq?=
 =?utf-8?B?QzFaYTBxcXE0MmRxTG91VC9WdEdwVnF4MVRKOUNqbVppai91N2xUdEpsbjJY?=
 =?utf-8?B?cDFHOTc3aHBuRGRiZjNQa1V0MDlYOHFXd2RHaU1NQi9iK3dXeXdjZUdJRXI2?=
 =?utf-8?B?M1IzempWaUZINHduWVIrT0NKanVBZVRzSFdmalhZb2dyalRXMTVBVmlxZTNR?=
 =?utf-8?B?ak9zVlEzQkt5ZkhHMjJJZGJJd01RRnBSdk5YWGtsOXh5WmhKeFFRRFFHRUNR?=
 =?utf-8?B?NHVkaEVlVmU3L2pJWmJzTXB2ZkVTTDVGL3dDalU0Qnl4MWRVd1psY2c4bnpq?=
 =?utf-8?B?WXJSSzBJMEwxTmVFa2NYcDBZWUc0cTN1Ty9jZldLVHdmVUlhRVhYcjcrOGRK?=
 =?utf-8?B?dlh0aDdKMldxdXZiQ0VxSlZRMEtyZnIvUmhlb2lIRmpqbjJiVWpoRFhwaHFp?=
 =?utf-8?B?SkV5MVFvd2YxR1grSDg5VXh4b3lHRHI3WHZZcXJWanYvSEpUQzlxOTdpQ0Nn?=
 =?utf-8?B?aTF0a1ZkTjhBdGl2N1VjOVpnTlZEUSt2Z1NTWk16TFp3VW0rRjE5TGRzYUZr?=
 =?utf-8?B?QmFRSjZKV0tvRCs5aVlYcThLM0ZydTdOZEhMMytGN2FkdkJiYXVya01QQ0Rv?=
 =?utf-8?B?MUM1alBuVFJxTEFpM251UVJqT216Q3RlRnlidW1ZNnNwQ2pLeGpaVVNnS21T?=
 =?utf-8?B?M1M1Rm5NQWZOT0RQOWI0UWNYdnhvWi9scDJ1S1F2NVFzbHk4U1pYc1EzZkg2?=
 =?utf-8?B?YWRZcDVBQ3grMTgwbnNDMlVMVGlCNFUvQy9ibmd3QU13ZXZaRWRTcm9adkY1?=
 =?utf-8?B?U2pyZ3UrdzVzL3R1aHhwNGdCaXJIWHZTWGVsWHU0R1BaeFFpT3ZxcnJVVlNr?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec77e24-939d-4a79-6aef-08db417b5cc0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7033.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 08:43:50.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHr6qSiiHLHHSV/lbw5SaBcz7H8E/sLZl2qQrw4lVeonYPI8kyltG9EfS6sJWB7XznERgDUPOTBRnl793nC9NSofjgGcIBmo6xZSatSlnow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5639
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/20 01:00, Dmitry Rokosov wrote:
> [ EXTERNAL EMAIL ]
>
> On Wed, Apr 19, 2023 at 06:25:07PM +0200, Neil Armstrong wrote:
>> On 19/04/2023 18:04, Dmitry Rokosov wrote:
>>> On Wed, Apr 19, 2023 at 03:43:12PM +0200, Neil Armstrong wrote:
>>>> On 19/04/2023 15:14, Dmitry Rokosov wrote:
>>>>> On Wed, Apr 19, 2023 at 03:38:33PM +0800, =Xianwei Zhao wrote:
>>>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>>
>>>>>> The C series SoCs are designed for smart IP camera
>>>>>> applications, which does not belong to Meson series.
>>>>>> So, Add ARCH_AMLIPC for the new series.
>>>>>>
>>>>>> There are now multiple amlogic SoC seies supported, so group them under
>>>>>> their own menu. we can easily add new platforms there in the future.
>>>>>> Introduce ARCH_AMLOGIC to cover all Amlogic SoC series.
>>>>>>
>>>>>> No functional changes introduced.
>>>>>>
>>>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>> ---
>>>>>>     arch/arm64/Kconfig.platforms | 12 ++++++++++++
>>>>>>     arch/arm64/configs/defconfig |  2 ++
>>>>>>     2 files changed, 14 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>>>>> index 89a0b13b058d..bfbc817eef8f 100644
>>>>>> --- a/arch/arm64/Kconfig.platforms
>>>>>> +++ b/arch/arm64/Kconfig.platforms
>>>>>> @@ -162,12 +162,24 @@ config ARCH_MEDIATEK
>>>>>>          This enables support for MediaTek MT27xx, MT65xx, MT76xx
>>>>>>          & MT81xx ARMv8 SoCs
>>>>>> +menuconfig ARCH_AMLOGIC
>>>>>> +     bool "NXP SoC support"
>>>>> NXP? Did you mean "Amlogic"?
>>>>>
>>>>>> +
>>>>>> +if ARCH_AMLOGIC
>>>>>> +
>>>>>>     config ARCH_MESON
>>>>>>        bool "Amlogic Platforms"
>>>>>>        help
>>>>>>          This enables support for the arm64 based Amlogic SoCs
>>>>>>          such as the s905, S905X/D, S912, A113X/D or S905X/D2
>>>>>> +config ARCH_AMLIPC
>>>>> Do we really need a different ARCH for Amlogic IPC?
>>>>> I can imagine that it's not the Meson architecture at all.
>>>>> But maybe a better solution is just to rename ARCH_MESON to ARCH_AMLOGIC?
>>>> It should be changed treewide, and is it worth it ?
>>> As far as I understand, the A1 and S4 families are not fully compatible
>>> with the Meson architecture, and we haven't provided additional ARCH_*
>>> for them.
>> The GXBB, GXL/GXM, G12A, G12B & SM1 are also not fully compatible,
>> but they lie under the "MESON" umbrella which covers SoC since the
>> Meson6 architecture. It's a facility to include/exclude Amlogic
>> drivers/DT, nothing else.
GXBB, GXL/GXM, G12A, G12B , SM1 and S4 belong to media box.
So, "MESON" represents the media box series.
Up to now, "MESON" works well for all existing chips except A1 and AXG.
>> If you compare it to BCM or NXP, it's different situation, the
>> different ARCH_* actually targets totally different SoCs from
>> completely different Business Units or from companies acquisitions.
Firstly, the new C series is totally different from previous MESON series.
 From the perspective of application, the new C series is designed for 
smart IP camera applications,
while MESON series is designed for hybrid OTT/ IP Set Top Box  and 
high-end media box applications.
 From the perspective of architecture, the new C series integrates the 
sensor interface, image signal processing unit, Dewarp, video encoder, 
neural networking processing unit,
which MESON series does not and will never have.
Secondly, there are C1 and C2 besides C3.
Moreover, more other series are on the way, such as T series.
If we always stick to "MESON", people will get more and more confused.
Therefore, I think it is the right time to add ARCH_AMLIPC.
>> We should have named it ARCH_AMLOGIC since the beginning, but we
>> can't change history.
Shouldn't we deserve a chance to make it right?
>>> In my opinion, it's a good time to split the Meson architecture into
>>> proper subsets, or rename it treewide (maybe only config option
>>> ARCH_MESON => ARCH_AMLOGIC).
>> MESON is only a codename to differentiate from other SoC vendors
>> because Amlogic used it as a codename for a long time.
>> Compare this to Allwinner's "sunxi" or Qualcomm's "msm".
>>
>> This config has no functional mean, it's only a config namespace.
>>
>> Renaming it would need renaming it in all subsystems Kconfig/Makefiles
>> and will certainly break builds with custom kernel configs
>> in various publicly used builds like Armbian, meta-meson, LibreELEC,
>> Debian, Suse, ...
Let's get back to ARCH_AMLIPC.
We just need to add ARCH_AMLIPC in the necessary subsystems 
Kconfig/Makefile.
This change will keep the existing MESON related code,  and will neither 
involve renaming nor break any builds.
>> So it's pointless to change, and even add a different one since
>> it's not a family differentiator since the Kernel is modular
>> and works around DT to determine which drivers to probe.
Proper names play an important role in understanding the code, right?
>> Neil
>>
> Thank you for the detailed explanation; it makes sense!
> Actually, I disagree with creating a separate ARCH without first reworking
> all of its subsets - that's why I started this discussion.
> Now, I see that you share my perspective and believe that C3
> should be added to the ARCH_MESON subset, so I have no objections.
>
> [...]
>
> --
> Thank you,
> Dmitry
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
