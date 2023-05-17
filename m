Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A7E7063B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjEQJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEQJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:13:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D64CA0;
        Wed, 17 May 2023 02:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4AFse6EjiGdDg53xp7D29LEGrR1Xf4Vl0wdXh8Dku7rpdWTJdL9+EWwSLlunl5koE3CHNUQT1o/HcYYNpQQKk+/qHr41SJrrmkHmnG/fKWoEZlYO90KUo3S4bc2Ne25ZfPLXCVvHvsErEMzth4GR/hMR58ZQvfLnGFAKgPXO4Rr+abwsGoKxh8WpZQG50+46UHFMHGwFNtXFHgN1ofBO2qa3MscaSnuaop0h6ZyeyimvOZdscebBMjo43Ddd05sQER1a8hXgmHqKlB+l7Hfc2yVaENmT9wX5F9zLvBT+NN+aRYzPAvXOrXZSU1Xjk5wSsHwRbAAkvzQR7RhxoqoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk8LvYO9hmb+5twYvpXajf3dMrXZww/EUU+Z9QlmVdg=;
 b=A84KZaGu6Nghw7kmb3wFvIaPe6qGtVfJjX/aSda5ovMZibRTcvPslOrSdaXdTDeMWvHBFS/zwm3hzndBkCo54rgqa/O5lG6qaOfvK1J0IUaEZB0bLdbkYuSgCuTIRVZGZEoLI75x1HRCei/YiXnFjR+yHMoL3ayNz4TZ17HvqkeDZ+V3LJnz/TWq1DdN+x7GfopDbvCnHbypNuf3ivSBmCfmd7FZLa9hMSiaj7MAyvAVyJi10dNECL5roiglbEPEGfKLrNfyM2e3jblmu7ktQeFod3uLHG4wTbC9FdmFYUlCLoL9TaFmk5PdHsue73ifA3KAzBLcZrjnMYRIhvEPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk8LvYO9hmb+5twYvpXajf3dMrXZww/EUU+Z9QlmVdg=;
 b=d6fdki6RQxvqi9jB3/K/JlYb5phCwv5kvi0bkRPad0mLSL8vZeN4fwPKaYtlWObLpHzbRUKorSWH6MwDZ09i/UXvpC+NERcNhlA+Sh8VKKyeryq7EJ+GiuioSxs1dhTw+zrZWyIp/iSr2AuQuHCc5lIz86r0SWJioEBdnC1H07Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV2PR08MB9928.eurprd08.prod.outlook.com (2603:10a6:150:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 09:13:41 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.034; Wed, 17 May 2023
 09:13:41 +0000
Message-ID: <bab79d4b-3dfc-6f2b-fd10-009a8902239d@wolfvision.net>
Date:   Wed, 17 May 2023 11:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] dt-bindings: touchscreen: add virtual-touchscreen
 and virtual-buttons properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v2-2-f68a6bfe7a0f@wolfvision.net>
 <58c8b822-8b47-3269-3b78-334b53c20bff@linaro.org>
 <99e39fb6-26e0-eb9a-3c07-e07d1fa4122c@linaro.org>
 <d32e46aa-af50-ad60-7679-5c235487039e@wolfvision.net>
 <ac6d8bcb-b16b-6c50-a9b6-975560059bdc@linaro.org>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ac6d8bcb-b16b-6c50-a9b6-975560059bdc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0054.eurprd03.prod.outlook.com
 (2603:10a6:803:50::25) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV2PR08MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 4506e541-8f08-4442-1343-08db56b7019b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9CrcvzOPhpNKJzLSpx7yRcx6cY/OViDWw/FLUkIdMumo8KkIdSiZd1nyvAKSsCFEj4tg95RgSrAO28gOQJItkW2UcST+mmlH1wA2ZI15mFpYNeeVhwrFkPEaTHa0W1osAIAeRXk5l4zdm2hL3X2XVj8cpr1CRklFu4dBXD4LsrEbOGVTl5fbr0VQlDwYk7qQIXX82RPgKqbhMX43BfzbEUdLBhkwn7YdjduN0y4CP9YW8xMoOAim1CJzk4gWWNyGkICnJWu2eHh4D90oaRXJjsZdFugyJ6zStwD1kEUGAHXxAOGcvIXWI+E49CrWaqncyyU7QeLcr96T7ldnJUYnB3CpWIhjKhA3pfv5XYtItVygJoUuCWUWQCPrWzaxYYzg3hRszmGfjeB4B5L21KtaNyqTgWmvoOLCyt3vLQQJ3UCwKgntZJ5QbDdlJIlHNQQCM0Vg5DJCQc4XAIotPwBBd9yGKEUyuzFykSAeUjKULaul+ORuqAa213URWgQUYsz+WSUagKYZ0VJy0IehPjNnzXiAjjHN4+4n9kLuDoS+i3HeQBpHEiN9q6ZSU1efJxhcxRfB5h5dGrUva2fz4qscLyln3xamOPmqdXhsEPAiAxiNOdouddSS2dMODWgohvg7TvntrNxnSZ1eIp5462JWf6wFd/QbYD77Pk3k8/oFpkQqztRm1uAzKhKebMw0QB72AHJ0AVWXT182iVYNcWvFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(136003)(366004)(376002)(346002)(451199021)(31686004)(6486002)(6636002)(4326008)(66946007)(66476007)(86362001)(110136005)(316002)(36756003)(478600001)(66556008)(83380400001)(6506007)(26005)(2616005)(53546011)(6512007)(186003)(8676002)(7416002)(41300700001)(8936002)(44832011)(2906002)(5660300002)(31696002)(38100700002)(34154003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTdJSE50ajVLeUlOZjFWRG5VS0NlakFBS0VQbHpUMDdiQVRBNUgvaVl2TG5K?=
 =?utf-8?B?anhyYTlsT3VHQ1JlREoyaDlBUzJiSUJIWmwzVllvZjg1Wk5FQ0JRbjFzS2h2?=
 =?utf-8?B?aHVzVzczMC8rQjRHZW8zUlhXSGIzQXB6R0xqeDdZd3FtaFlDVXlyYzNUTnhH?=
 =?utf-8?B?Y2FPeEdVSElDazc4SmV4NWhkcmhGSGVXZlozcTUybTArWjRrT08va2dueHA3?=
 =?utf-8?B?QVdyVSthZnpzbHI2cmU5TFp2V2RJdGpaL1R3Uk1jVjM1V0xPQWR5anZrYjYr?=
 =?utf-8?B?dHFqZEh1dEdMVkJCZTZGNDlEeDhuQkdNY0FOT3F6V3JNTGhIelJvSTNUMEky?=
 =?utf-8?B?aEVON1BHdVRaVzA3dVdacXg5WFVXVmEvUWFlb0ljZDE4NDMvU3VpRVNrdDJU?=
 =?utf-8?B?RkY2UFI5K29IZXFlL3lWMHB3ZUJHNXZabUdEU08yUTlHWDBUVEI3L3lQNUtJ?=
 =?utf-8?B?bnBnWThqeXlrMWlrRHdwNG9qMGJHWURJMHdiQ1g1U2ZkaG9vV1dJSXhOeXZt?=
 =?utf-8?B?NlNWbVlpMVJERkhGek50NzJrQ1o1WDBvRmxCMHA5cktuQ1ZkRlphV1NWekww?=
 =?utf-8?B?YlhLVjE4SWJlUE1Rd3QyV3pZdnVUL3FCZER1TGJjL0hURWJUM2RoRGc3MHl1?=
 =?utf-8?B?cUpQaWxEcC9oUThvdThIdlVpdW5IUEdnZHdybjlhSjZnSHMzcHpNRmJEY1lN?=
 =?utf-8?B?Skh2UzNNTjdDS25OMVp0TmZwMmozN29KQUNWZ0s2aUlXZXRDL0Npbm5qR1FX?=
 =?utf-8?B?U3krd29VMTkrbGttSkRtQ3E2c0lENXNabVFEdzVOWFlCblVLV1lqODhJcnU3?=
 =?utf-8?B?bVZFVmV0Y0swc2EwZ2tOR0dqOHFIeGpZWi9LbVNRaEsxc2w4TWd5Z3FJOXNa?=
 =?utf-8?B?VU9TZHpORnY5VnI2STY2QkJVYnJOckxMN09xSVVTeFhtN3c2RzNUOXQ4NXJJ?=
 =?utf-8?B?TG5GS2JtS1VsQlY0aU5YTDlQbGt6eEVkTUFxekV1OGFkSXJhcXRhbnhRb09N?=
 =?utf-8?B?T1hYNklzVDd4cjJTOSsrdnBmVkl6cm9BQmtxY2tuVVZwTFdjbnNJQ0NLYXNs?=
 =?utf-8?B?WTMrREhrN3hPUDlHaW9yeVZEamtWZzVHMUZLekxzclJ1Ym5TeDdXWmcrVkhJ?=
 =?utf-8?B?Q2N6cWo0bXNjY3c2b2pGTTFnT3pOUDd3MXYxL2NDa3djS0ptTWxqYnpSSWxI?=
 =?utf-8?B?TGRMcmo3OHZUb3o5UVNONUF1cDAyMEhiRWxmOUtxSUJadlUrVy9MTnBHbENY?=
 =?utf-8?B?Qmt3R3dORTI1SWR6UjRYNHhaV2ZTZG0rVERwQzYrVVZoVmVOaC9zR3dMYzVK?=
 =?utf-8?B?WDRuaEFnSkgxSTVleWlzcGI3SzlRQmFoY1pDVzkxd0ZTaExVRXdJcFBjVThU?=
 =?utf-8?B?YXp6RnBMUWFrYVp1dFVsZXdtc3VTMXExN0l5WFl2dWRaMG50aWVGNEdDL0E3?=
 =?utf-8?B?RzRoc05xVC9qbStsVVcwWXhNMXgwRDg4cWI5cUIxaU9aYTlMMjNEN3VIQTJk?=
 =?utf-8?B?SE1ZUnNneDBxd25CTjhvTlYzbFFMa3luWUNxeXhkM3pRNVo5YW05L1JQdnpV?=
 =?utf-8?B?UmxzUjRuYndvSDZWNGFHZXhJeUR0eWJCOUU0azF5THptYlYySDQyQm5iR0Uy?=
 =?utf-8?B?NG0vb20zRDU4VkhZd1BtanFUU2tTMkh4STE1enhhYm81cnIrUG9CS0tzVm1P?=
 =?utf-8?B?akU5aHdMY2R5R0tkZXJ2cVlLMjVkQjNvQXpnK1BvTmhCcVpaYlc1dDNzVmFN?=
 =?utf-8?B?K1RON05rUExCN3UrZ0EzQk0vUVd0VTYwOU1MSGlPVVIvaXhhenRSU01BUzc5?=
 =?utf-8?B?NHVmTmROWWp3RUJLRytUT0NVdkxNWnhrcXRheVFCTUZZQnJMNzZUNHNIcGlk?=
 =?utf-8?B?NjI4dGdiUnFTRkZlNXp3N1NhWC9OaHUwYlZUdWd2WHFPYTFJQ0grbWVxRUpz?=
 =?utf-8?B?OFlGd25WUXM0SkhuMGVvSk1BcHdIWEd0ZUhXSjQvZG5nQllyRGJqWitRMEd4?=
 =?utf-8?B?OEY2K09QMHJXM3dpWTVFeFp5K21UMXNGaDlYemY4NjErU3VCWU9TOTc1ckFZ?=
 =?utf-8?B?QmhCbnoyUzM1Q01YMHZIZWVLOTc3ZXVHM21ubDhMLzlrNEdvWnQxejhVUjF0?=
 =?utf-8?B?anIycFpXcEdOUFZYdWthVTFqc3d0NU4vKzJ2SGl4Sk1tWkZvMUdJM3VPb2p2?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4506e541-8f08-4442-1343-08db56b7019b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 09:13:41.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kud0/sinwikuFPfL4+M36psqhYhwyb5lnz6WHl8q5P7B2L/hsoMlLlGg1lyXKwpx36X4uhdv4NkudhuhWlCHhqz2nboG9z6Ag4oTqNl45cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9928
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.23 10:59, Krzysztof Kozlowski wrote:
> On 16/05/2023 11:03, Javier Carrasco wrote:
>> On 16.05.23 10:13, Krzysztof Kozlowski wrote:
>>> On 16/05/2023 10:10, Krzysztof Kozlowski wrote:
>>>> On 15/05/2023 17:00, Javier Carrasco wrote:
>>>>> The virtual-touchscreen object defines an area within the touchscreen
>>>>> where touch events are reported and their coordinates get converted to
>>>>> the virtual origin. This object avoids getting events from areas that
>>>>> are physically hidden by overlay frames.
>>>>>
>>>>> For touchscreens where overlay buttons on the touchscreen surface are
>>>>> provided, the virtual-buttons object contains a node for every button
>>>>> and the key event that should be reported when pressed.
>>>>>
>>>>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>>>>> ---
>>>>
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Apologies, second thoughts - why calling all this binding and properties
>>> "virtual"? That's the word which immediately raises questions, because
>>> bindings are only for real things, not virtual.
>>>
>>> Touchscreen is just clipped, not virtual, so maybe "clipped-area"
>>> instead of virtual-touchscreen? Buttons are real, so maybe just "buttons"?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> I guess it is a matter of perspective. For a user the buttons and the
>> clipped area are 100% real, but for a driver developer they are virtual
>> in the sense that there is not an "active" hardware behind apart from
>> the original touchscreen.
> 
> 
> The feature describes the hardware, not driver. To understand what does
> it mean, look from hardware point of view - does it have some virtual
> area or clipped area?
> 
>>
>> I just wanted to avoid misunderstandings when implementing this feature
>> for other drivers. One might wonder if the touchscreen now has
>> mechanical keys attached to it. With the "virtual-" prefix it is clear
>> that the objects are not additional pieces of hardware or extensions of
>> the touchscreen functionality.
> 
> But what if actual physical buttons are added there? You still would
> have clipped/virtual area, just without virtual buttons.
> 
>>
>> For the virtual-touchscreen your point is stronger because there is
>> indeed a real touchscreen hardware no matter the area you define, but my
>> approach was keeping homogeneous names for the different objects in case
>> some new ones might appear in the future: every object that gets on top
>> of the touchscreen area is virtual, so add a new object type and name it
>> virtual-xxx.
> 
> To me, word "virtual" suggests something which does not exist. Kind of
> something abstracted or symbolic. Opposite to "real". Here all this
> really exists. You have physical stickers on the touchscreen.
> 
> Maybe this should be then "dedicated"? or "isolated"?
> 
> Or just "overlay-area"?
> 
>>
>> I have nothing against about doing some renaming and I will do it if it
>> is required, but with the documentation I think it is now more clear
>> what everything means and in the end it might make more sense for the
>> drivers so they can differentiate between real and virtual devices.
> 
> Best regards,
> Krzysztof
> 
I think the word "overlay" is more precise and does not lead to any
misunderstanding, so I will rename everything to xxx-overlay and
overlay-xxx in the code and the documentation if that is ok.
virtual-buttons -> overlay-buttons
ts_virtobj_xxx()->ts_overlay_xxx()
etc.
