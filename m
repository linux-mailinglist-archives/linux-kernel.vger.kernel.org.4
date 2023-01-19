Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA8673E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjASQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjASQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:00:21 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461A86ECB;
        Thu, 19 Jan 2023 08:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674144019;
  x=1705680019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hs06Qo7oAoofI08dQn6aFgHJ1YUSmmef9AUGmmqhEVk=;
  b=HkW8Ph1J1HtpxfxOvE+PV/zxFtc9ZGsWMLjieJlu0KbkdU1YgdCWTEuA
   2ZeUZ730mGwKA/yNwTUdh7nxAzkYmTb5da9/CjdlUNzVE39GUcC4GZW8K
   z723MFwoTtG3W+Z2/IiMOjiu5GSNfp/s4L9TTeeTqU8kAyl19RhjjrYy6
   R/JWZEnT1EgKnsP8tijmfYQNRfTRuyw3L+CBIR8+QzwRUCqSaYyd212gk
   oDEPfI0LHAelxVyTMucs9CSCgiuzvFxJFU+oYX4dDKlJ/E+gJFMW2738I
   rEs104YPiTG3WKpkpdV3SE2cpuY2LQ6YZuLjwaWY7fi3+VEwPsBApv+89
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv2I6vjkMUexEsvFbNfsuhXLid8GUYIHMeIeCWYqMxNunF/6/+hLMd/8AL5ev797iayrssruvVWNk21O3DTHdVwipT3gdXBQgLc4KVN4Dpf6gfGTpnJFGHFyeYHRfeCNHsgArYwzUqd0VgOwZlrAV9oJHKvgdyGbfJCENYTEhKa7y9aqSvjWOrgXB0FNTcYDAd9fdiEotaV1BLH874ay5iVMRyId4rkBLVDWkNh7ccMbhcF+B5nNmS5qK+uOxOLtIgJsQNUWcRrisy0maCotxpuCZpKXffBUYYcCJKTrXLFlHyfY5XasxsfNKmwBdp8w6YPl2Gmqhoz1psGKWXO0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs06Qo7oAoofI08dQn6aFgHJ1YUSmmef9AUGmmqhEVk=;
 b=SO13Ikxp6+PbASFEgzsfMyQF60/UA2MED6sQZgkUt/KmAj1t/J+60rEzxXMIWEd/Puwi79yLg4hOmhEKZyVOOEg0gA2wRAjNHHEvA8rl5HGbs6KtiRDbl1uRBivQJ038BDHrCW68CCpkKLnScrUcxV6P+bMn3miiV6BFzfkqcNM2lJlFjWF2nlONR66ZlYIwUF4mA7dGP5WkhRaS0OUKSUacBby4RamYEPXlhqfJI+W3TRcdgeRvSNQJZfPdBHENFFpjk+5WAkC1uk9laLPWnt73ZsN7dIQAUmjyeXrLOZo97rREYGWWEfER+4DedeNIK+3CxVJLVkl3eM+9A9/aCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs06Qo7oAoofI08dQn6aFgHJ1YUSmmef9AUGmmqhEVk=;
 b=jTYLwMn0PP0s2WcKsChNuq76lU8YN0/02loHs28BFLvWx+5Digdl0XWzXr6lo7knM1MEYBYggv+WC5jZT9tNZbxsTEqER+csrZHwepC+73SclXN8u+m1INRjRrdhUk+cr8yF6K/FwQ/PjELQrap4nbFKNQHSlZDLQ9mErj/aO2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <832d7919-af7e-b765-e91d-a09e0cc89644@axis.com>
Date:   Thu, 19 Jan 2023 17:00:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 4/4] ASoC: dt-bindings: simple-card: create jack for
 aux_devs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230118125226.333214-1-astrid.rost@axis.com>
 <20230118125226.333214-5-astrid.rost@axis.com>
 <d5ae4755-26df-f4e7-b69a-83d9431bfbee@linaro.org>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <d5ae4755-26df-f4e7-b69a-83d9431bfbee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0097.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::6)
 To DU0PR02MB9467.eurprd02.prod.outlook.com (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|VI1PR02MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: fdee5af0-d626-4f06-19ec-08dafa36401d
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anxnespDo770DXzzjvITbCXhilXmT1M156Z5KIdTAnaBDgXwBw9/304aVhD1XX7Ec7SRz/h6hmhFQIk4Bea85UZ0NMiFakGE92tziKzDIQ9wfINrwuo7usa61NWVF3v5u+7AmbvdOBcL2Kt2df86SlfUg5375Dv+MqeyEVYKr2vkNS2pjbNFIYI7jcZV1u4FlxAQwpR6nlnMlCScquCIcddlorIBYWq3AsVcyEyItQ2wT/qKg4/B2nHD4i8yJVes5Nbj+MAHSlVDHvmPVq+jJFXmgfYONOY5LMcyqlW3pOexSLtj843gTmif3AjBPkYqPhdPqkZNMYxeDDclCsXdfJ9ItpO2Cgd5gIOxA90KonmCVsy5yTyyS0LsM3s8tkvmvXTUleuku1/JHNyCgHARbMmyxhRjzvo3uCwfvNA1FpuSp4lgZ6COOU4Se+Jv3E963SyftP4RcKLYJ+KEErBf6j8XHo+FTTCiUIy6lgAUHKLEleSqTrXYl9Kv6yAuZRWsODiP3/X1sjeMqXNRlOikl3GP+iklHZXVzfnLX7q+1v5SBWBXWRBg4Yhb+4OD+EYqUhCrzZOSwi+KE8C7eUbWy45I9hTHwMrBXexJg449bhTv0NnLWA6rfaJPcT6JaLPMzEn5PnmVF9gBFn4DsRG4kZ0OAZ52QfqYRBRVgp+5eLGrCt/qA0Y9xtKpcd4bJR+vv/orKDXmoXLLSiOHfKQKlxtgf08u43ILP+M+sZ8czTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(31686004)(36756003)(6506007)(31696002)(186003)(478600001)(110136005)(6666004)(26005)(53546011)(6512007)(2616005)(8936002)(6486002)(8676002)(83380400001)(5660300002)(66556008)(66476007)(4326008)(41300700001)(66946007)(316002)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFqVW5Ccjlwc1VRT1NqMWNPWUl2ZWdnQUJQWGVyQ0ZBQXhaaEVHemR3STJi?=
 =?utf-8?B?T0lSdUZUQTFnN0duNGx3TllRT2ZGQVpXMm95cjNLNmxrNVI0U1VFU2dIek9H?=
 =?utf-8?B?R2FnUElKeDZKNFNuQk1HYVplYmxrUm5HZTZNd2Vsc3RIekhJakh6UUlVYmdI?=
 =?utf-8?B?ekMvZnJOdnRZd09zMzkzTkExR1d6SEhYRW4xdUdiRlFDWG00ZlNZVzRUVmN2?=
 =?utf-8?B?RGt4dTJUYnNEVVEveEl0M1NVNVowaWQzanVIcmg1eXZTWmtFMnlxaXZMTHI0?=
 =?utf-8?B?a0Q2ZVZhcG5WcEdWUDIyNk1vWlRXS2ZtUkFlZGc1UU9paDVzWVh6YmQwY1h1?=
 =?utf-8?B?OXduclpGaktNMno5QmNlcW81UnZ2SEVrLzZJNngxckJwcXpHQ1Zuc1RHTVg4?=
 =?utf-8?B?UGswQi9XeWE4TGk2STNGYVpidlROM2o0QzVncnl1YnJMTkZDODdjUjVnYzRr?=
 =?utf-8?B?eGRtM0FtZ0p6WHFoUGRiMEFiRkNySjZHNWhJR3c5Wm5ObWtLTHpkL1NlYWJt?=
 =?utf-8?B?dXYzaGcra3psYXkwMURQKy9OdVpLdmpLVDJzVzYzYWJHaFhSdDJITXFsN3RH?=
 =?utf-8?B?R3VabEdvQ3FObDl2aWRFNHcwVE43eXNMYlBIYkZGZlIzUlFNdWZDVVB4U3dI?=
 =?utf-8?B?ZVV4bWlrZ2FiSXN0NGV5K0F1M2U3LytvNktVQmNTRzgzbWJCU0p1NmZQMTB0?=
 =?utf-8?B?UEdDcExPMjVkcUpjN0NyR3NWREhqWmRHSTJoQ3o0Zk1uUHNZRjBLdStHWXI1?=
 =?utf-8?B?bVkraXlRT0g0RHlvRSs4UWp4U1VuTkVCM0JLbmRXRGlwVGVaRHBsMHc4NFBH?=
 =?utf-8?B?NVpwT3pERVlrbDg5QUNjdVFnM0x1VDdQNVd5NXRqSjRxM3lBR2t6dlBmWWF5?=
 =?utf-8?B?WllNY3Jsb0JNNjZmT0NRTnZHbmVORnRLQ1JGelNOQzZ4em8vQWdLM3d6T0V0?=
 =?utf-8?B?M2xVditKa3dUZUhadEhjVjgzeVhEYnhuYk9OZTJxN0JHQll0TDJiMytQY0la?=
 =?utf-8?B?b2Q0SCtBcUZ2VXU5REFiYWo1RXVlZWJ1ZFdtV0lieVlWQnM1VEx6ZW5kbDY2?=
 =?utf-8?B?WGhtdzFxU1FJUzlBTURUOVpLQ21sMDNIb3B3VFFybHUvSnBZMElqYUVOeG1T?=
 =?utf-8?B?MkNpRFdzVE5iRVhFSUkvQ2pCaEdOamRuTFFSVGhRYzVxbzZhUHRqdWJLNktj?=
 =?utf-8?B?VUF5aEhBQXJ4dXQ5QWZYVEoyeFZQMFZ1eFVmOHFGWk9Cb3MwWExRR3dET2lX?=
 =?utf-8?B?cE93T1lQZWoxaE1adWZkVlZwUEQxVTZJczJxUGVncXVvbFZheGJkS3NMMTJY?=
 =?utf-8?B?VmRYNGtENzQyaGI1TnlFZERlZ1ZaZDZNUFRFTFB1aVFuMjVBMUt4SVZnbmxP?=
 =?utf-8?B?YkEyNm8xZTJKNUN2aCtKa21oQkJvRS92Z01iWHpySWhFWThZOWV5OG8zYnpY?=
 =?utf-8?B?MFdSLzFHTzlpRCtOeGkyeTFCK0M2UVVIVktnb0dwbmZselhweEUyYzZoUmFN?=
 =?utf-8?B?Vjd5UlBrbTkxbGR2cWMzU0tLN3ZLd0ZoblhtQmwrR2g3c3NGU0J0bXpYdmVD?=
 =?utf-8?B?M3ZBdkUxV3Z4czJHYkEyS21haGpQSktmdVlJeHRqY05TL1lkZDRuN1NCK01j?=
 =?utf-8?B?d1JMU245aFRlNnZwTFBJMGZXUnZsa2IxeGVyNGptTVo1Ni9lNEc0aUdzMitn?=
 =?utf-8?B?bVRwYUxYUzR6QnRDNU1wOVl0a29SSmxmU1dwRVlpRHcwdlloNC83eFVyMjY2?=
 =?utf-8?B?R1NBY2lXUnhZTS9SK3RxV0l3VStKSVdLTENxbk0rS1hHQTdhVzhvUGVPVE1H?=
 =?utf-8?B?Zi9SQ2hnczQzUi9hbEU4ODRhUFhSQlc0YktXK3ozYlhzODhQMUFCWndVSVRC?=
 =?utf-8?B?ZjQwcDRxZUhjMHJOb1FCeE9JQUp3ZzlLRkxQMWNvQWlWbUhQanFpMnEyL2Ra?=
 =?utf-8?B?MXI3clk3QUw2T3VIRG5QMkM1akhhRUJ5Y2ZwOTV1bUVxK0gwRjFacCtUemJz?=
 =?utf-8?B?ZFZmNittd3kwZ01qMkVMcDRqRDlwN0ZyTG8vYW00NmhST3VxUURyVkRGUDVZ?=
 =?utf-8?B?SnNtaU1lMTFTRTF5S2xxbXBQNzVuWGlydUtOaU5ZVWhuSmlZMnBxRURqVC9Z?=
 =?utf-8?Q?yVas=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdee5af0-d626-4f06-19ec-08dafa36401d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:00:13.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egU6cVvdud9EaqBBpLzsfOhd8sfV4ihnmuhhG5PUM73vHv9yE59qRoH148DjvF9pjOOG+/bzY1RfD6Nxlmdk8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5968
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you! Yes this makes things much easier. I will fix it.

Astrid

On 1/19/23 12:18, Krzysztof Kozlowski wrote:
> On 18/01/2023 13:52, Astrid Rost wrote:
>> Add simple-card,aux-jack-types:
>> Array of snd_jack_type to create jack-input-event for jack devices in
>> aux-devs. If the setting is 0, the supported type of the device is used.
>> A device which has the functions set_jack and get_jack_supported_type
>> counts as jack device.
> 
> How a device can have "set_jack"? Isn't this part of code? Are you sure
> you describe here hardware, not Linux driver behavior?
> 
>>
>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>> ---
>>   .../bindings/sound/simple-card.yaml           | 35 +++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
>> index ed19899bc94b..2635b1c04fc9 100644
>> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
>> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
>> @@ -199,6 +199,13 @@ properties:
>>       maxItems: 1
>>     simple-audio-card,mic-det-gpio:
>>       maxItems: 1
>> +  simple-audio-card,aux-jack-types:
>> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> 
> Drop quotes.
> 
>> +    description: |
>> +      Array of snd_jack_type to create jack-input-event for jack
>> +      devices in aux-devs. If the setting is 0, the supported
>> +      type of the device is used. A device which has the functions
>> +      set_jack and get_jack_supported_type counts as jack device.
> 
> Same problems.
> 
> Additionally, if this is a type of aux-dev, then maybe it should be just
> added as argument to aux-dev?
> 
>>   
>>   patternProperties:
>>     "^simple-audio-card,cpu(@[0-9a-f]+)?$":
>> @@ -498,3 +505,31 @@ examples:
>>               };
>>           };
>>       };
>> +#--------------------
>> +# Add a headphone and a headset mic jack,
>> +# which use an auxiliary jack detector e.g. via i2c.
>> +# The events, which should be enabled are:
>> +# SND_JACK_HEADPHONE = 1
>> +# SND_JACK_MICROPHONE = 2
>> +#--------------------
> 
> No new examples, integrate it into some existing one.
> 
>> +    sound {
>> +        compatible = "simple-audio-card";
>> +        simple-audio-card,widgets =
>> +            "Headphone", "Headphone Jack",
>> +            "Headset Mic", "Headset Mic Jack";
>> +        simple-audio-card,routing =
>> +            "Headphone Jack", "HPLEFT",
>> +            "Headphone Jack", "HPRIGHT",
>> +            "LEFTIN", "Headset Mic",
>> +            "RIGHTIN", "Headset Mic";
>> +        simple-audio-card,aux-devs = <&hp_jack>, <&hs_mic_jack>;
>> +        simple-audio-card,aux-jack-types = <1 2>;
>> +        simple-audio-card,cpu {
>> +            sound-dai = <&ssi2>;
>> +        };
>> +        simple-audio-card,codec {
>> +            sound-dai = <&codec>;
>> +            clocks = <&clocks>;
>> +        };
>> +    };
> 
> Best regards,
> Krzysztof
> 
