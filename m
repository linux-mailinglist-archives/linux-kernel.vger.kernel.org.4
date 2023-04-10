Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBDE6DCA21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjDJRoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDJRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:44:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2015.outbound.protection.outlook.com [40.92.98.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2191710;
        Mon, 10 Apr 2023 10:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXiJOHG+7RnvMPWm2LoYQ73R/vYUKhRsS+dw8X2n4ib4Y8Vq4eZ2dFWqIc9iUVEkNhX/vZU7pRwqhvsqmQ5AY4MDNLd7edKZ1ZG2dwAD0SNbEE56lMoMOvDbuNU46Cl4owWkqaMRBgLta6u/TDCUUvWs1KEKBNhsSyv4l5v27HoQ5+WefZQB3wluHAqVctbTptzyWs1UOoKcXji0yj+qhJnLapA3M64OFXebXQT/v98vyD2PljnOe88AM/73+SoyLEWBm/jDpcvJ6+MHyLvYtt5KYH3d4ZpxcWHC/CoD+8Kr779MqfqFUCXivgS1elhx+cy1mI9byltjf0QgtfxhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL71AjY6jerm1y7Dcl363HdeZCqcZyknfRxhQSCv3Co=;
 b=XoyuA82ONpNwTENxjPuGGwSOrkFIH3vW51VWG6J3tTvtJ26Zggnqln7F8YpvkJmC7SCOw15xo1/avv0J2/GGyoC8r8wY0Ry2weAT8M2DtotUJuZ1yWmlSfeHqIpq+yPsS8GOFxDperLuGO4vOvZZ4FigRv2HPAyEoCZd3eLajwjplGO9ADAGxk5x2uBM2rx+JQhpp8rXTtoCqdNnBaVub23YdkagAkHoTYlnTfceVlT483c2qI4Y5W6sH7jlsk7eO+tYAftyE4WUyS7GlbUE1mIAAsHAZDE69Ah2+X49VXV//mUVBhcdRrAtRQ9NhDVHa38RgSGrSuOX6DgNQqOrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL71AjY6jerm1y7Dcl363HdeZCqcZyknfRxhQSCv3Co=;
 b=EMxh++3opsICvcgSlaTjQKbJqMCh8hQq5idh8osME/zeZUnhvhNGi5uwm8vJ5Eh5+bWV0nE6Ne2D8gNKVwlE0hA6G9jlHDR4hkmLPS7huWoNid+E/JuLhrtoQZgvnjrIya1ueTmd3hp1XpUuH5zmrJEPy5eLBaGp/V10E5u9B0A6Ga2y6avYy6iyo/jBoQnep3pV59voc5po834oDm6ACz1jVn3AlxHnD6EUOjqu/DzCLqqYPzadzQIp44+5fKvkMQSpZPjvvbleBxSJAUPkaQrTx9nX0QUPHw4g+gyPJrZLhrFPqBi1QnkHCEbGHyyImR+tKlhy84bJiEJqf3renw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TY3P286MB3778.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 17:44:02 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Mon, 10 Apr 2023
 17:44:02 +0000
Message-ID: <TY3P286MB26117EC770F2CCC029C7BFA498959@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 11 Apr 2023 01:43:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230407141813.89-1-wiagn233@outlook.com>
 <TY3P286MB26117891DFB2DD615A7C54EF98969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ffe813e4-e3ad-3dff-b8e5-42b0f82faed3@linaro.org>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: mfd: x-powers,axp152: Document the
 AXP15060 variant
In-Reply-To: <ffe813e4-e3ad-3dff-b8e5-42b0f82faed3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [9CGGj2NSCLZvaPf4H/NcDKeJMisKBtk4nRthjUGS0eCo46zTaf+UAg==]
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <2f8d27a0-41ce-3dc4-5b95-85c65717a3fb@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3778:EE_
X-MS-Office365-Filtering-Correlation-Id: 064c3666-4c03-49b6-d54d-08db39eb2c2b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1jr9dcDuQIhYl9IFipklOIdm24LUhf6RbhUsToH4CWCfLL/T8TIZDXa7EqlNgbsX3/FK/cA9L/pLkvg3zPBol6ahElHxyMLTTV2RqdPbGj3oEkRHXNNhfvpSXefLzAQZ52qJvUss85kETxcYok+YRvJC9tLZUJWvSzcXA4orlrYyfSuOCaD9EDxXvqtzcynrZLxGZw834DHeJa1Z4D8ZURi8bHn9a91WLrcVSl9RRptH2/E3do+xMM6qCIWvZLfet5Egl3uLzUQeyRqtO6JlsRtpZC1r00pF87tahFZCpkOXItW82GLrTO2OovGfPqvMjwG3hxrNpLEnV/jbTCUeW0/61tyFwKNLZaiztfQl2TA7bzMnjjfDvQIOZ/gsnWCKxrNFNguWl6Q/F0ApXt7j5wfnVpsso1XrVpxURiQfZsdWgZ4oeGGGnVduZx/2CE70JsdLi8JnZMRn/zCHZkUmk275hoyTFQX77so4bWgoTXthoN64DuiHGrYB4dKEQa18bCL203dTBvJ+WVoSGXOvKpeML0p4q9rEEeNZzHORD134N2lmZ8ItfpQfDR8p/42T1IqFaKbhJeApQPx5Ut4OPMkpVXn3plzx3rVj2LfObJMpDQ3etzrCh8QNXOrHPZ9E
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUM2a2VJclE0Tjd5SzlWQ2UvdHcrRnNyVWtSTkR3bHFXcFIyMkJFd0ZET3ll?=
 =?utf-8?B?K3FyUkR4ZjBjQVlhTmc4WXVsek1icm0xSUFYNGtoUW1vSytzTGRVNjY3YXdz?=
 =?utf-8?B?aDNJMTRmUGJrdS91ZU1wc1R0VlZ0bGdCdUZOZllyakRuTWY2K1lLYk8rN1M0?=
 =?utf-8?B?YTJqbFBsUEU4OFZXNXVxbnF5VTVnbkRoNEVGWEY4a0JocmRySTcvais4LzFu?=
 =?utf-8?B?WUZxeDdJMS9kR001OXVGZStHK1hkeVRRSVVoalFiUDRPeUFxViswVmZQbjlr?=
 =?utf-8?B?VHF4aDdDK21qRk9DRDl3VnBRZ2VyVVByRU5CWjBOWjlTOXZ5eEpFNm5XZXpt?=
 =?utf-8?B?ZW9yYjNFUW8rK0dBMkpzTkZ4V3orQzlBNTFQWG5MYi82bE1BM3VIc01IY1Iz?=
 =?utf-8?B?NlZOR29pZTAwVFBUOVFQQ0hKRkZQNmpHZDdVNzJObEk5L3ZSY1RhTWpxamI0?=
 =?utf-8?B?aDZyaDZrVUtITURMb1AvZS9tZTRKY1RacEo1YlFwMEtwUWl2dXVqSHZWZGJ1?=
 =?utf-8?B?OFhXeUJKOWdrVVc2ZCtiaEpDM0w1c0FCMTJXU0dTTW1lMXgwMWZjYmZQbFUx?=
 =?utf-8?B?SnZoMW1ndThYUlFtU01Hc0ZocHJrQ0o4bjM2MTE0RStUUU5MM1pUY1VPQnk3?=
 =?utf-8?B?U1B2SlZaVm9nMGt3c2YxL3VHNG9hcE8yRzhPZTBjMUVCVThiMVVnV05uRXlX?=
 =?utf-8?B?eDIwMjIrTWQ5UTMxWDlpdmJlRUJMbU1UT2lPK2JKYjRDeVNGNGFleFVhSVpp?=
 =?utf-8?B?dUtFb05TUkxyWEFyaU1ZV3VpZGZpSnAvUSsxc0hxZ0hqemJKUkE3RnA1a1V3?=
 =?utf-8?B?QXY1RlpuTWNibWpqcGx3ekFQd05JcE1sOUJBSHc3alNGKzZCZ20xRExwYlZE?=
 =?utf-8?B?ZEJhZys2d3FSLzdEZ2xoL1NkbDFGM1dNekZCUTVIeFJxZ3ZoM1QwRG1Qenlh?=
 =?utf-8?B?QWdoaGhKNWdjR0NyVUNiamU3cG9VakZRSWk4Y3VDZzNxZHU5K0lxVDZxQmxl?=
 =?utf-8?B?WDlxR01iOWtjQWhjOXptUkVKUXMxbjl6emtIMlFzajY2azJoazV4Y2NlM3FT?=
 =?utf-8?B?R2s0blY2VmxmNGduZDg4b1JmVFY0dC9aWEhOK2lZWktaeU96U2NkT0hTUmE4?=
 =?utf-8?B?czdCeEloUENIb2F5bzR2bVZ1TllTampuK0M0YVRxYWgrdDRnL2RMWTlNbDZF?=
 =?utf-8?B?NGk1YlplaVMreVI0ZkNrZWxqK3B2SVBFbDczTndZTmRjcUdKM0RjYlJucHBC?=
 =?utf-8?B?S3NqRlY4ZGVPbDJpU1BEU3BTTlpQeHpJemFrNk9kWnQ1RzNVbFliR0s2c2R4?=
 =?utf-8?B?UlZtM3FxUjFOamdmQXJWTEljRFAwRDVMd2QxNEM4ZWdZTHlucnVra0lvbjlV?=
 =?utf-8?B?eHpyaHgvUUlMaUJLbmpMVHovY1ljVnVDRGxCa1BQVFhvekRhM0EybFJjM2hI?=
 =?utf-8?B?aWJxVUpKWGpHMU1FOVZYZ0djQ1FYV1llaXdNeVB0NFhGYjlGZTlkZTE4UEpM?=
 =?utf-8?B?MGxVdER4amFkc3BYMCs2NEIwTTl2V084K3l5UVFlYXBtYmFITzdQREZ2VjRS?=
 =?utf-8?B?UUFQUG9MWlNkZlJIa09ubER5TEJROVBzZVNJQTMvNEhLWW9BVk1wdFY1TnNs?=
 =?utf-8?B?N1UwcDFvRU5CNmVzV2lOajhTeUFTT0swT1ZoSGtoWWIvRERJeWRMYnh1bHpN?=
 =?utf-8?Q?X+YSrvYXDPwzzzn3n5QJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064c3666-4c03-49b6-d54d-08db39eb2c2b
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 17:44:02.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3778
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> On 07/04/2023 16:18, Shengyu Qu wrote:
>> The X-Powers AXP15060 is a PMIC seen on Starfive Visionfive 2 board. Add
>> relative compatible item and CPUSLDO support for it.
>>
>> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 ++-
> 
> I received cover letter disattached from rest of patchset and everything
> duplicate. Please check your process of sending patches.
Duplicate is because first batch is disattached and a small typo. I thought
disattach was my fault, but the second batch with re-generated patch file also 
has this problem... git send-email reports everything correctly so I don't know
what really happens to my series..
> 
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
>> index b7a8747d5fa0..e150a8bf040a 100644
>> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
>> @@ -92,6 +92,7 @@ properties:
>>            - x-powers,axp806
>>            - x-powers,axp809
>>            - x-powers,axp813
>> +          - x-powers,axp15060
> 
> So you have chosen order by absolute number, not alphabetically. That's
> fine, but keep it for the future entries as well. :)
OK :)
> 
> 
> 
>>        - items:
>>            - const: x-powers,axp228
>>            - const: x-powers,axp221
>> @@ -260,7 +261,7 @@ properties:
>>            Defines the work frequency of DC-DC in kHz.
>>  
>>      patternProperties:
>> -      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|drivevbus|dc5ldo)$":
>> +      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|cpusldo|(dc1)?sw|rtc(_|-)ldo|drivevbus|dc5ldo)$":
> 
> It seems fixed strings are at the end of entire pattern, so "cpusldo"
> should be before "drivevbus".
Thanks, would fix in next version.
> 
> 
> 
> Best regards,
> Krzysztof
> 
Best regards,
Shengyu
