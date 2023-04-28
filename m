Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84666F1D31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjD1RJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD1RJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:09:33 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303E1BF8;
        Fri, 28 Apr 2023 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682701771;
  x=1714237771;
  h=message-id:date:subject:references:to:cc:reply-to:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fMMWkly7cUXo9HK3Ucn82WZfdYCVXGtNDn7o8iPqtf8=;
  b=OhKQsQgj0o7PsuWRzHB36BXu8F5Rxk1u6+WVhkZPGHA1KnKFlHQmE6ap
   XHMCtMgouWEH+OmxKPnn3g4cSxwt7frAyIGxPOyGlhFWjuUl0Zqfw1B2D
   ry9knAqwIthi4I0tiAh0bOfg3uosEn2FDPGk7/EMMZPixGEXClHcqcpEw
   YdSmM315ZvOpUoqhhLUwvVQPwHJ648Fn/XdAb1SC7nW5hXA9vIWHuL9wb
   S3AvdwM253KvlKYkc3yGbY4g8/YPDDJT//8YsrDwac3HTx6hsMnXXuxdl
   LbiFLgCat3SQW0jXzPXPrPxJwnuXlL+h0CTqYRLmfgiaYkrdZvzHylDQr
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=melPiRPHs2u7xMZYVrixjOyZiFUfAcERP9E6IjVH352RRa2HfFy/oST8E/VzQEykRVONzbFqayD5DKKmjhIAAi9iIc63ZEeEc+ulPlCyFyt/pRJcF50qVpTUHOB2U542LlzZGDvaWVtrPsGZI+PEYsUd5P9BT8BYLy4n8/F90nCKfkAFpmfGb8FA9GVkQkrzVjw0UMYtMoiI/B8cjuVPyli7iP94uWKP2tJFzDW212eB8rF11yxAJ7rS93CD7o+zfxbVMyt7sy592bpgIU26kArq758TTfZxl2ZCmTiabmrqzoJ6JqK8iMqeYwYLvV++140+ysUhAskPKXQNsBtE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMMWkly7cUXo9HK3Ucn82WZfdYCVXGtNDn7o8iPqtf8=;
 b=K+JoGZN87e4rsCzr9sFOq2c45XVMMToYLWHmKIFiLREXPHpcTg0Q1bWupu+kkYiTJDim5rbes3tkf4TrMzZAKbKmZ9F099G0zY2ay3cCCUkJZoTXzdt5AXHO3QdZkHAXmBuU4K/dcubvef5bX8cIRVFQOLUcTI4bYpJNJy2C9RW4xApoPeyyb3FZIlspbc6WQpDCxTyFcw1VZsWpczabb8hxGYneaSZI++O5c6XcZKT3/Odgr6LYKCpFoWRfXkKacSs0INfTqYi2LVrzaPgSV+7i11XMT9qnYu0sZeWbZqdO/0V2RfjxM1lCTwxC537POh/RaKScQxAGDM2mX7xwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMMWkly7cUXo9HK3Ucn82WZfdYCVXGtNDn7o8iPqtf8=;
 b=cOK6Gaops+9ae87oerap/D6tp5Ah5CTBMDZ58L97v4jR3bsRM4OARil2J8iY4Y7wfCF9hV3KXrZYyQyDfl27gYNgJk51UWJa3DYzMi78P+sLAkO8Uz3Mk9UQ91kd/+8BGp7BNLUV538bChWrnifMpydliZ5cGGFYRHchyak/FTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <1511d33b-dab3-cddb-cbf2-7db016678362@axis.com>
Date:   Fri, 28 Apr 2023 19:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Fwd: [PATCH 1/2] dt-bindings: input: microchip,cap11xx: add advanced
 sensitivity settings
Content-Language: en-US
References: <d7f77779-5d28-b78a-da4e-cc237b2a04b9@axis.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <jiriv@axis.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
Reply-To: <8a790966-d985-c0fc-498e-c17e69a6622e@linaro.org>
From:   Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <d7f77779-5d28-b78a-da4e-cc237b2a04b9@axis.com>
X-Forwarded-Message-Id: <d7f77779-5d28-b78a-da4e-cc237b2a04b9@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To PAXPR02MB7263.eurprd02.prod.outlook.com
 (2603:10a6:102:1c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7263:EE_|DU0PR02MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 7735b14f-8509-4d91-95e6-08db480b5274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7y0quFo41FewyQkT522Iq4Y0O7+AfgJ1LJTFG0io1zn3Rx0A5wDwgpNhkILXo3AEa0jF38H9ya9jn59SOB6dwy2S7N8X+/utnAwyBfKRel9/E1csHF3bA7RW7AqSGbAnXpxYw4PLtzdmgvUs5svcHBNJ7J+Azi4v4r+pbgkffJHWR+gul1VNXGdkW67DfPlmOzaI1vqqKhcaEFlcZdP8S1sFlpZW/NAOWNg2bejWRQr/JFXS6Mf6bqgRRAgKSf8cnq6oSSrqXRxEYYptyqOdNqaq5uOCQ0KPtMPppDs1vR4LIKJa7XPpbaY4ZOWUtf/13UYw1wM98r0mkjPC4TFP88pOQkqFdXC6IsXtEMjA3Ko3ghrXg+5skBMX41nJgB2eIzzaF73rI/sbwcxomr9xNbUvDPbh4/yMQt/UI7sJHYsHjDvpc4nDq6jyDKPZUBBfsvAlmNDF/gLLkYk0mTQ8yHp30m0IxnXJdppGxPuJOehleQMEEFBq6cmsr5mwt131/S5T/OcuFl2olVJFExh7P/NH+myfb7AbRt8O7Gj9taCCpfS/ei7zTdyfGk9Hgvchw+DOqOmYcUXhvb61KBIO+iF/Ohmrh9H9/Hok6pq+i1s49mTEjT9IrnXNBKHuyQvHKNUqL9+kc5jSpkiimQ8gpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7263.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(6666004)(38100700002)(31686004)(83380400001)(478600001)(4326008)(186003)(6486002)(2616005)(66946007)(66556008)(66476007)(316002)(6916009)(41300700001)(26005)(6506007)(6512007)(83170400001)(53546011)(36756003)(8936002)(8676002)(31696002)(2906002)(42882007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBMNWVGeVU1YzdpKzhieS9wN3VWQ01aY041LzJKZXRZWmtNVE5tRFpYTE54?=
 =?utf-8?B?ZHFEeS8vWUtEdllVcWFsRW1xV21QTkpsUktTbVE2RytJZWhZaGpqbVNwTlhT?=
 =?utf-8?B?OStnajNNR1A1enNEbHh4aU1NcnZaV3A0TjJWK1NOYk5vUHgxei8vM3FzR2Vk?=
 =?utf-8?B?czJIOEU1VzUzSHRMRmtLWG91TFpCNXdzU2ZRT0s1eHFrVDVpK2tPdE8zN0Jw?=
 =?utf-8?B?dmRYL2xJV0hmc1lSMDcxZy9mT3B3MDJTeHRQeG5tOVF6ZndrbDc4ZzM0NDVy?=
 =?utf-8?B?dVdhVUtvTjlxbytYSWJESEE3QjhFSGxURUhkbWJpUEd3Qk5RRXRXdjFSRklR?=
 =?utf-8?B?dXpnc0kzWGNsV2cvckFSbHFQdWszNHRkQ2N5cnIyNlhoTlYyVTNnRGcyTkJ1?=
 =?utf-8?B?MU81UWZMd2cxcE9aN2FkRjNsL0RPWUVqTmw1U2hPME81bE9FVW42UW52ZUdy?=
 =?utf-8?B?NklMOFFDTTVKa3VZZHM1ZUZwT2krRWEzNHhzWWFSQXdrWjlFUzlSS0lxeWNQ?=
 =?utf-8?B?K2FweTA0Tm5rWmVMaFlkWGVKd0hzR0ltL0VLYTRVWHFGK1hxY05IMGViTE9j?=
 =?utf-8?B?K0tZZ2d4QjBIYlZBQTdRZDI5ZWJIamd3VFdGSGNINnl2YkNJYlAvUVlBUEUy?=
 =?utf-8?B?ZGhnTTlaV1hTUW5LMUJCdUc0VE8yNy8wUG5ndXNjS3p4a3dtOUtZL0dvV3B5?=
 =?utf-8?B?clZQUjZIdlovMjQzMmtlRkw2dEhvZEVLeHFpbFZDbW0rcGh6eEVVY3FtZUJS?=
 =?utf-8?B?UXJobWxYMGxBcnFWVkt0NzVBOENQS0FLdVFvN0RXUWplZWN0NHZMT3UwTDlK?=
 =?utf-8?B?bWJ1b3A1b2RSMXNoTFNLeE1LUWc3ZVpEY01zb0Y4WW1CbFNibE1WeFlTM29v?=
 =?utf-8?B?bnNkb0ZEYnBhSkpkUERKN0dGRGU5cWZPWEIzTXR0dzM2VGdhQWNwQWlnM2pz?=
 =?utf-8?B?K3BseGdwQnI0ZmY5NENGOU54R2JPcFFqZTBSK1VxMFRuREIrSkY5NWt0N1FF?=
 =?utf-8?B?amVZQmJZcjdNSG96OGZCenNkS08zTE9YMDVRb0RhZVQ2K1VMQ21rbDZQelRZ?=
 =?utf-8?B?L283WXBadE5TSW5DOHJsVnpkL0VvSUI4cHZkeWtPaW5MQ2I4MnZoVyt5VUhQ?=
 =?utf-8?B?cFBBNEIwYUF5dWs0clV3WVFVMHV5Q3RQMUZzV0NPRjFPOTVsQ2h4V29uMTBS?=
 =?utf-8?B?WGJYTS9veXJGVlNJZUxya3M5OTFvRDgyZ0tPd3hQT0tEczV6TmpFSUZYS1Ni?=
 =?utf-8?B?SlhLekRKYWF1ZHd2TlJtMlEyNzE5U2NGNS9ZMEJCdlhWQ2NyL3ZoK29ZNGEx?=
 =?utf-8?B?bS93aThIaVp5dEpITXNuZHVnWCs1cG56cURBNUFvRmlzQU5aWTJwKzc2MG0v?=
 =?utf-8?B?TmFldWgvUXQ2bHdwbk8vZzVWeFRyNitUTllibUNiSUZhcUdjRlN4ZlpJemNo?=
 =?utf-8?B?cmdTanFtcmxmT1pWN28yRitrOXEvVThlOElIRkhXTTZWUFozSVlSQTlBTXRo?=
 =?utf-8?B?ajFPWXlsMnhOSUVSMjl0QVE2b2xGR0ZveW1uYno1b0Q3dUtrQkFyZVZ4anVE?=
 =?utf-8?B?LytwTXFtTGtUY1graXFlbHJmR2dRVWNYQ0J2ejNwa1RwcnFjaFoyeDJxZU5x?=
 =?utf-8?B?amVBWHRRQWdvVTNyV0dhZGJXUUY4RVFNQ21EV1FwcktWWFNGb2F5bnlFMzV0?=
 =?utf-8?B?VGNBSVpSUmtBQWpnWTYzNjU5VGFia0ZUUExQMXJ6bUZzM2pvUjVTOFVsWXk4?=
 =?utf-8?B?TFoxbnJtbGwrRTFndzdVVGh4b2ZNTno4bUNSK0s3U0hWa1JKWGZQSmdPaW91?=
 =?utf-8?B?RGpnWlZ6YTdCR0piUy9SaVJqaUZxem9CN2tqMGI0WTg1NnZ4VWZTRk4rRFFC?=
 =?utf-8?B?Nkp3am5KbzJoRlg5aUFkdzZCNWNSeEx6ZzE3RjIxd2d2Y3g0dzh4eSt2VFgr?=
 =?utf-8?B?UEVoMGsvb2hKVVRPMENwZ3J1UTJmVEk4ZDNoSk1MMlVEdDllODdYbVpiaTBY?=
 =?utf-8?B?cUxCVkl6cDJiOEtHR0p0aitmVFBKTVpBblFxRlp1YlM1YWJVcVMrVWJGVDE4?=
 =?utf-8?B?c1I2ektMOFkrZ2h5S0l0L2ltWitaOFhKdE9RTHAvZHpWNW9Fc0szMUdlNFQy?=
 =?utf-8?Q?zlBk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7735b14f-8509-4d91-95e6-08db480b5274
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7263.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 17:09:26.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsJTxbn+3V5xxrxrzjGj/vmkBrR9bacpbYUa6b9xWWCOIWOPZ5igx1dd7eAz+ORd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8524
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
and thanks for the review

On 4/15/23 11:10, Krzysztof Kozlowski wrote:
> On 15/04/2023 01:38, Jiri Valek - 2N wrote:
>> Add support for advanced sensitivity settings and signal guard feature.
>>
>> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
>> ---
>>   .../bindings/input/microchip,cap11xx.yaml     | 64 ++++++++++++++++++-
>>   1 file changed, 61 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> index 5fa625b5c5fb..08e28226a164 100644
>> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> @@ -45,13 +45,13 @@ properties:
>>         Enables the Linux input system's autorepeat feature on the input device.
>>   
>>     linux,keycodes:
>> -    minItems: 6
>> -    maxItems: 6
>> +    minItems: 3
>> +    maxItems: 8
>>       description: |
>>         Specifies an array of numeric keycode values to
>>         be used for the channels. If this property is
>>         omitted, KEY_A, KEY_B, etc are used as defaults.
>> -      The array must have exactly six entries.
>> +      The number of entries must correspond to the number of channels.
>>   
>>     microchip,sensor-gain:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>> @@ -70,6 +70,58 @@ properties:
>>         open drain. This property allows using the active
>>         high push-pull output.
>>   
>> +  microchip,sensitivity-delta-sense:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: 32
>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.

OK. Will remove them.

> 
>> +      Optional parameter. Controls the sensitivity multiplier of a touch detection.
>> +      At the more sensitive settings, touches are detected for a smaller delta
>> +      capacitance corresponding to a “lighter” touch.
>> +
>> +  microchip,sensitivity-base-shift:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: 256
>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256]
>> +    description: |
>> +      Optional parameter. Controls data scaling factor.
>> +      The higher the value of these bits, the larger the range and the lower
>> +      the resolution of the data presented. These settings will not affect
>> +      touch detection or sensitivity.
>> +
>> +  microchip,signal-guard:
>> +    minItems: 3
>> +    maxItems: 8
>> +    enum: [0, 1]
>> +    default: 0
> 
> This was not really tested. Missing ref, mixing scalar and array
> properties. You want items with enum. And drop default.

Ack. I will fix it.

> 
> 
>> +    description: |
>> +      Optional parameter supported only for CAP129x.
> 
> Then disallow it for others (allOf:if:then: ...
> microchip,signal-guard:false)

Ack. I will fix it.

>> +      The signal guard isolates the signal from virtual grounds.
>> +      If enabled then the behavior of the channel is changed to signal guard.
>> +      The number of entries must correspond to the number of channels.
>> +
>> +  microchip,input-treshold:
>> +    minItems: 3
>> +    maxItems: 8
>> +    minimum: 0
>> +    maximum: 127
>> +    default: 64
>> +    description: |
>> +      Optional parameter. Specifies the delta threshold that is used to
>> +      determine if a touch has been detected.
>> +      The number of entries must correspond to the number of channels.
>> +
>> +  microchip,calib-sensitivity:
>> +    minItems: 3
>> +    maxItems: 8
>> +    enum: [1, 2, 4]
>> +    default: 1
>> +    description: |
>> +      Optional parameter supported only for CAP129x. Specifies an array of
>> +      numeric values that controls the gain used by the calibration routine to
>> +      enable sensor inputs to be more sensitive for proximity detection.
>> +      The number of entries must correspond to the number of channels.
> 
> Most of these properties do not look like hardware properties. Policies
> and runtime configuration should not be put into DT. Explain please why
> these are board-specific thus suitable for DT.

All these parameters are intended to set HW properties of touch buttons. 
Each button can have different PCB layout and when you start without 
setting these parameters in DT, then touches won't be detected or you 
will get false positive readings.
E.g. 'signal-guard' change property of analog input from button to some 
type of shield.
I made all of them optional for backward compatibility.
Maybe 'sensitivity-base-shift' is really not necessary to have in DT.
I will remove it if you agree.

Best regards,
Jiri Valek

