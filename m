Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453636F4ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjECCdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjECCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:33:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2028.outbound.protection.outlook.com [40.92.22.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6ABCC;
        Tue,  2 May 2023 19:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIilEx66rVN5QrYydOvooc9R3lNpRUU1Jj2UGnue50jhxs1bA4hW16Ak52MgAMB7rMVFnIWUC4B9MaykH6yAAmaT3+32nE8t/QPtjCdb2ip/TZUZbDQiFUh6GkVYEypg10LtbOprhMz/eGUGPbCM/AT207g55Cnxnz8q4ixubiKc54hCtuglyTyBYNpr+EBPMsnmE0itfUCHJTQ9kB5dEbx/8kwRAS/S95um2sKjUpsLi2utYNHEBGzHexd/IPw6j0R1JKnQRXS9jg9vJUHHXQwGv4bMhjlnZLmciCIrNuuwPfjPSVP2qnIQJt7WGwpHam9bRpa0c2D3CQVT1ei8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJM3Ssln65QkZf4hAOiRUsSB8q7b4Kj1oQ7SgbBtln8=;
 b=RzUAvZQfSWsmnebqJYwOQAz1EAIMrRL78JB6svzk9ogLJwKYFpjIkmx7cYAYYVKoprdTP3TboJ19FaMZmz6zyaMfQzDZhL86YUA2M7hKvpmsTReZk6cSnPa+nxSu/QEuQfPF4df6UIosoz2mET5cKUeM8OlgYMFesp4gRZ58v6HtAS/5pJ9GLYmN2yWv9d/XASFW+o5cD7uwaGM0TyjcUS6XysZuT5LLJcJxSkK7XNe6hVdEWHjAMssQ38LnwrDTfBFoiRT6CLT/t3jqPohvm/UX97a5ILZUFr3ciGRyoX9m3F47Y5BzBk5+Yu6Cseisx98Q0voOtjCMt1vTNV4g5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1P223MB0701.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:25d::16)
 by BL3P223MB0083.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:34d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 02:33:39 +0000
Received: from SA1P223MB0701.NAMP223.PROD.OUTLOOK.COM
 ([fe80::64af:3f2f:114a:288a]) by SA1P223MB0701.NAMP223.PROD.OUTLOOK.COM
 ([fe80::64af:3f2f:114a:288a%6]) with mapi id 15.20.6340.030; Wed, 3 May 2023
 02:33:39 +0000
Message-ID: <SA1P223MB0701849F355676ED9CBE58CDCB6C9@SA1P223MB0701.NAMP223.PROD.OUTLOOK.COM>
Date:   Tue, 2 May 2023 19:33:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/7] ARM: dts: s5pv210: Adjust I2S entries to match spec
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <CY4PR04MB056784D54ADDBB4F57F82D4ACB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <4ebe2bb9-4f92-2dff-6737-d057e5950b24@kernel.org>
 <f44c9881-6f7b-f4f5-8225-e0c74c83fab1@kernel.org>
 <CY4PR04MB05677B21384FCE2013EB1B94CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <414f1ad8-8ee1-9913-c0e8-b4f66f3e7180@kernel.org>
 <288d8b93-8dfc-2aa2-4c36-49a2612820fd@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
In-Reply-To: <288d8b93-8dfc-2aa2-4c36-49a2612820fd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [pfNlgPCs2sqrLe1/iWoLQUBmMJxNXSts042nUjxEeKgr8ZWmak+eOKxfmerocBGY]
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To SA1P223MB0701.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:25d::16)
X-Microsoft-Original-Message-ID: <f4247821-0d37-4426-c38e-ef3818850f7b@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1P223MB0701:EE_|BL3P223MB0083:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1037e5-3646-4f37-5036-08db4b7ecd10
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rvKn97GyXihtrmyj7oXHN7sJlaX66/aOiKdTwHmaBELnedBB1D6gxjhroBX/d9HihRgN2dHwPS4KO2/fJUQ12IhkLbQ8F6/nGcXijJgiodbZ/nQ+GGAp68O67eKcjcWq/30GktRSs2m88S5PvcDhEIVmB5pOABFgQTpEty1HGuUY1hrT//lEcF7Dbp2q5MeVk7qCdj+z/tvGLH5J+3rCzoTC0HyHkQyHO5mocs4DzfYkHABiuXCeGGB1IqD5lNB1dbwPB5h3YRPrJ+6xmG4EgVrvJ13MN9VF5bRgf96S7ve3ZZJAg4WsSkL9tTlL+MvDXcPmHY4+nrZFpjiqtKso2r5SlraDGOhBGHRuHsDjwRPpKcBMLPzTUgZMGVN5f8ybIj+poDNFdgwj5Hh/0/EtWdPKByfEN7edpJlyHuqE4a7vJ+vqWW5890AhwdcH1yQqRjaiIwEpjXaL4UiX3c884nRPoMZJjLj/FWwm1o4Mt4CDzyVlBEWRQpEgX9E+ejvu74u56ns1wMJfPcr+wrq/CkzhnGwU8yo/WBozg2hJM0RaWahS1ZPbllrLi4n5a3S0XUF43cAZq3ysNB2miLEytWdVDIC8nJD0I6HAuLYyPI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnpMb2xXenlZYnlFbWxhaDlzamkxdzlmemdYZkNHcGRsL3prUEczdHVRbkpv?=
 =?utf-8?B?QlR4Rlc0T1FZdUFJYXlxVmo4L3RYODRKSG5qQUx0R3NHbGV6MEFmbWlldFh1?=
 =?utf-8?B?NUVSSXlvY0c0U3hobGF6cVFwN1U5a1dtR2Z5OWh2OUw1bnVDVklxSW9LY1dH?=
 =?utf-8?B?ajV5dlJrT2RZVGhPeG5PM1drdDdoR1IzSTlaZHRxa0c2am53MUtwOXc2Nk43?=
 =?utf-8?B?MVREOXp1cHNTU2NINjAzZWVETzV0RkdDL2lKdU40eGR4a29WNWErZ0ZJY0cx?=
 =?utf-8?B?c0UyV1ZvRnhFN29uMFFtbDVlMUZFSVpJVEpEUVROZmNjeVB6WkU2U0J1Mkda?=
 =?utf-8?B?MzRGRG9ydnNoSnpYeEV6WC9XU3FxYTBtbm9paHg2T3doS1NROWl4dHdjMUJP?=
 =?utf-8?B?eHBlUytrOHlMR1NMQ2dzTHFqR1dyTUFMTnFqZDY1ODJCZDdkUnNuMUpnblhI?=
 =?utf-8?B?YytYT051UjJISTlzdVUyaDRtdlNJa3pPVEZNaGp3QXpCZTcybnVEckVsNFZU?=
 =?utf-8?B?Vm5yWlp5ZWhwUkpJcFozb05YbnlKWXFTVGxCQk1hRi9UeDlveDJOTUZYb0tT?=
 =?utf-8?B?WmlJTmdGeVBLaGN0dU9TcEg1cHVOSCtMM0pkVTdUenFraVE0cmV0TjZUQWhz?=
 =?utf-8?B?NURSclhzRk9kc1Z1Z3ltRnlUV1pBYjlVc21YZHgrZjJoWlE2cmVsYmZnM0k5?=
 =?utf-8?B?VnB6ZjZSVENqeHhRNWtuczJqOVJSSURxdS9YWEh6Rm1XRVhTd2c4dHZpQmNa?=
 =?utf-8?B?VVBwbitLV2RWa2ZOQzBBTWRST2xXb1VoeG9oZjJmK09mb20wZkZPZHRuUHZS?=
 =?utf-8?B?NlkxeXRSL0ZWaEZxbGZhVTg5REhxUVdqTzJhNWsvb3QvSmJkMThNQ0l1RHY1?=
 =?utf-8?B?LzQvZ0FmRS9rUVVxVmdyWVRhaHBQeUFzc1FwMVJpZHBRblp1MU5OM01iOG1M?=
 =?utf-8?B?cngvaEFNTmRaeG01dHZETU1zaEtzQVpXMndJYVEyZEZEOTNlRlRCVG4zL01T?=
 =?utf-8?B?dWFvdDl3cjFkcnBmSmhvV2NzSEkyTzJMemNqUTRmcCtnbmhLS1UzUXE2RDRz?=
 =?utf-8?B?NWI3SlprUEtvMHZBOUkxSEpEZmZBNmZOOHd6NGkyaXlmV0NMd1k0b1I5d1pw?=
 =?utf-8?B?T204VEk2SllRekc4SmZBY1ZzcTZJNzczNDRjdTZ0MHJiU1poNmw5SUZ5RU5S?=
 =?utf-8?B?a01ZdFNPNGRZc28ydjhwL2RBaHdEMnNuNGEreTNjK21KN0IyNENLMVo4T3p3?=
 =?utf-8?B?MC9FeHNzK3g5TnkxeTF0bkhaT3dHaXE5ZGdpMDZMdm03dGc3SklZYlZIWk5Z?=
 =?utf-8?B?M1E0NnoxWHpaNU5QbFFOMVJRbXpFVnZTM3JWRVdlelIwN2hHdzZtOVRMRkMy?=
 =?utf-8?B?eWRxN2QrSzNmSHRnRmcvcVBBUytBTEpTVjU0LzVHT3QrL0psc0tXbklrMzZj?=
 =?utf-8?B?TFVTNWxzWExjc2xEanlwcUlXV0JrcjBFNlFpNFVBRWFhejQvdm1IMnFOdURr?=
 =?utf-8?B?cmlJbTRDMjA0MVE3aUFtM1c4d1VYRUdaVTFXQjhXMGxTOWs2MGRQWEljTEVJ?=
 =?utf-8?B?NmRvY2ZVdmVLV3JFc1FJSzZva3g3T0F6SHVQUXB0VzVMdXhrK3hmQkxaZE9x?=
 =?utf-8?B?QXFIdEV4U1ppSHE3aWo3dGFncW5GdlZSMExmL1BRVDNBSW5MWWhkWmtVQXBT?=
 =?utf-8?B?cWJVUVY0RndWTUtVMmNTT0lYM1l3TzB0bHFaTmpoS3BReWllTE4rNDhnPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-1ff67.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1037e5-3646-4f37-5036-08db4b7ecd10
X-MS-Exchange-CrossTenant-AuthSource: SA1P223MB0701.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 02:33:39.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3P223MB0083
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-21 02:44, Krzysztof Kozlowski wrote:
> On 24/03/2022 12:49, Krzysztof Kozlowski wrote:
>> On 23/03/2022 18:24, Jonathan Bakker wrote:
>>> Hi Krzysztof,
>>>
>>> On 2022-03-23 8:15 a.m., Krzysztof Kozlowski wrote:
>>>> On 23/03/2022 16:14, Krzysztof Kozlowski wrote:
>>>>> On 23/03/2022 16:03, Jonathan Bakker wrote:
>>>>>> Based on the device tree spec, clocks should be ordered tx/rx.
>>>>>> Re-order from rx/tx to avoid warnings when running make dtbs_check
>>>>>>
>>>>>> Additionally, the number of #sound-dai-cells should be 1, not 0
>>>>>>
>>>>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>>>>> ---
>>>>>>  arch/arm/boot/dts/s5pv210-aries.dtsi |  2 +-
>>>>>>  arch/arm/boot/dts/s5pv210.dtsi       | 18 +++++++++---------
>>>>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>>> index 70ff56daf4cb..503b5a50ef1a 100644
>>>>>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>>> @@ -644,7 +644,7 @@
>>>>>>  };
>>>>>>  
>>>>>>  &i2s0 {
>>>>>> -	dmas = <&pdma0 9>, <&pdma0 10>, <&pdma0 11>;
>>>>>> +	dmas = <&pdma0 10>, <&pdma0 9>, <&pdma0 11>;
>>>>>>  	status = "okay";
>>>>>
>>>>> Except that fix that's the same commit as here:
>>>>> https://lore.kernel.org/all/20200907161141.31034-26-krzk@kernel.org/
>>>>> so just extend it.
>>>>>
>>>>> sound-dai-cells should go to a separate commit. But are you sure they
>>>>> are correct? The Fascinate 4G seems to be using them as cells=0.
>>>>
>>>> See my previous patch and discussion:
>>>> https://lore.kernel.org/all/20200907161141.31034-10-krzk@kernel.org/
>>>>
>>>
>>> Thanks, I'd totally forgotten about this series from the past.  I'll re-test
>>> those commits and submit your copies of them in v2 if that's OK with you and
>>> that they're confirmed functional?
>>
>> My dma fixes change lacked this aries fix. The sound-dai-cells needed
>> more rethinking.
>>
> 
> Hi Jonathan,
> 
> Any plans for checking/fixing/testing and resending the sound-dai-cells
> fixes?
> 
> Best regards,
> Krzysztof
> 

Oops, I forgot about this again...  Unfortunately, I don't really have the time
right now to do so, and don't know when or if I will.

Thanks,
Jonathan
