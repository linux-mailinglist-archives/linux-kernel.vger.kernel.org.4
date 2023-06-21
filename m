Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0D2737CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjFUHsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjFUHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:48:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7E811D;
        Wed, 21 Jun 2023 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687333695; x=1718869695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4elCiOXAO/1skXbd8OBCX9scHIUqUf+kd1BiTdR6iKw=;
  b=SZ5bqnKK1tp0U4lWUj9/NqnWCc3e5h3/TH6YBQnhXyK/Yr3nNk6nOgMb
   PZjLiegr9vVSdXlpT+esN6768AiK4f+gxjGvTfKIkbuFhHCYqfJ1Ni58M
   HwyJVFeXquHmDhrooXkhCjCtg1Rn1dUlSXj2NgneI9LRDuzB8TfII2EOE
   owNUbF+qFoRQbRXnUSpjhrmgSlCoWO8xaOrW8wNYW44/Ez+V/LNQvmbXq
   I0s7ZuTugwKq0yrhY+7KY8coP1F2L/QYcFX1oOQHRvPBaQ4JaWiTj9ouh
   IEAW5BwmPa3EfKcUp/clRl6pDE9SPGDYY9nUScAnvVVSHhG3SJlnl33eh
   w==;
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="231305443"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 00:48:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 00:48:14 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 21 Jun 2023 00:48:10 -0700
Message-ID: <ef09246c-9220-4c71-4ac2-2792d9ca519d@microchip.com>
Date:   Wed, 21 Jun 2023 09:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Content-Language: en-US
To:     Manikandan M - I67131 <Manikandan.M@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Hari Prasath G E - I63539 <Hari.PrasathGE@microchip.com>,
        Balamanikandan Gunasundar - I64410 
        <Balamanikandan.Gunasundar@microchip.com>,
        Durai Manickam KR - I66125 <Durai.ManickamKR@microchip.com>,
        Nayab basha Sayed - I73920 <Nayabbasha.Sayed@microchip.com>,
        Dharma B - I70843 <Dharma.B@microchip.com>,
        Varshini Rajendran - I67070 
        <Varshini.Rajendran@microchip.com>,
        "Balakrishnan S - I71840" <Balakrishnan.S@microchip.com>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-2-manikandan.m@microchip.com>
 <a0b059d1-df4d-10ce-fb7c-7acea0a20793@linaro.org>
 <20230613-slider-coherent-d508d67afc91@spud>
 <423eef3c-54f0-5c88-9bc9-82c0198b6da6@microchip.com>
 <3a3f4463-981a-e8d8-8ec4-06f2abfa3b4d@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <3a3f4463-981a-e8d8-8ec4-06f2abfa3b4d@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 at 08:44, Manikandan M - I67131 wrote:
> On 14/06/23 20:10, Nicolas Ferre wrote:
>> On 13/06/2023 at 20:21, Conor Dooley wrote:
>>> On Tue, Jun 13, 2023 at 08:17:13PM +0200, Krzysztof Kozlowski wrote:
>>>> On 13/06/2023 09:04, Manikandan Muralidharan wrote:
>>>>> Add new compatible string for the XLCD controller on SAM9X7 SoC.
>>>>>
>>>>> Signed-off-by: Manikandan Muralidharan<manikandan.m@microchip.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>>>>> b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>>>>> index 5f8880cc757e..7c77b6bf4adb 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>>>>> +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>>>>> @@ -8,6 +8,7 @@ Required properties:
>>>>>       "atmel,sama5d3-hlcdc"
>>>>>       "atmel,sama5d4-hlcdc"
>>>>>       "microchip,sam9x60-hlcdc"
>>>>> +   "microchip,sam9x7-xlcdc"
>>>> Google says sam9x7 is a series, not a SoC. Please add compatibles for
>>>> specific SoCs, not for series.
>>> We had this one a few weeks ago, see
>>> https://lore.kernel.org/all/add5e49e-8416-ba9f-819a-da944938c05f@microchip.com/
>>> and its parents. Outcome of that seemed to be that using "sam9x7" was
>>> fine.
>>
>> And it's where it begins to be funny, as the LCD is precisely one aspect
>> where we differentiate between sam9x75, sam9x72 and sam9x70...
>> So please Manikandan sort this out if difference between these chips
>> will be better handled with different compatibility string, in
>> particular about //, LVDS and MIPI-DSI variants!
> Yes Sure, I will replace the compatible as s/sam9x7/sam9x75/g to handle
> the different variants of sam9x7 better.

Moving to sam9x75 is probably good. But what is your plan for 
differentiating parallel and LVDS (on sam9x72) and precisely this 
sam9x75 variant which in addition has MIPI-DSI?

Regards,
  Nicolas


-- 
Nicolas Ferre

