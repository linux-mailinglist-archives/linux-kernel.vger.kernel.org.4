Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097E730222
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbjFNOlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjFNOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:41:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C4FE4D;
        Wed, 14 Jun 2023 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686753666; x=1718289666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2H0918Rqgl2h0POEbvxjKrAOS5koy+0gr8134epCcvI=;
  b=0kT+tcBjqqDhaYUYfgWt9Rto7mN4yWrLgrNiBMHL28DSv/3E2K1xvpza
   ++sLApWSRfBX/F1GAwYy5niylm14ZDWqCl+Zidtmy5PfeHD1RZ3vn7GgZ
   SlAXy6sE7pNKTNdPedHo+JYCnpOgcUxwV7KO0Eo9JV0PJcGByxvKIxEzz
   BWFTtLAv+oOpSPyBSegLBuv3J+hRxu64bQ65GrNejTwW56YVZESFABw1z
   vAZ35syPnO6qQlCo1wiWBARTse+/lD7/e/vgkD2BGHpOi1PS0rQ9ew4YA
   XRmeV7zJMjuMeL10jsJOcaf4fZKowuf4aBqAztJtXoU//8a3pFJbNbIJh
   A==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="220274370"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 07:41:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 07:41:05 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 14 Jun 2023 07:41:00 -0700
Message-ID: <423eef3c-54f0-5c88-9bc9-82c0198b6da6@microchip.com>
Date:   Wed, 14 Jun 2023 16:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-2-manikandan.m@microchip.com>
 <a0b059d1-df4d-10ce-fb7c-7acea0a20793@linaro.org>
 <20230613-slider-coherent-d508d67afc91@spud>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230613-slider-coherent-d508d67afc91@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 at 20:21, Conor Dooley wrote:
> On Tue, Jun 13, 2023 at 08:17:13PM +0200, Krzysztof Kozlowski wrote:
>> On 13/06/2023 09:04, Manikandan Muralidharan wrote:
>>> Add new compatible string for the XLCD controller on SAM9X7 SoC.
>>>
>>> Signed-off-by: Manikandan Muralidharan<manikandan.m@microchip.com>
>>> ---
>>>   Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>>> index 5f8880cc757e..7c77b6bf4adb 100644
>>> --- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>>> @@ -8,6 +8,7 @@ Required properties:
>>>      "atmel,sama5d3-hlcdc"
>>>      "atmel,sama5d4-hlcdc"
>>>      "microchip,sam9x60-hlcdc"
>>> +   "microchip,sam9x7-xlcdc"
>> Google says sam9x7 is a series, not a SoC. Please add compatibles for
>> specific SoCs, not for series.
> We had this one a few weeks ago, see
> https://lore.kernel.org/all/add5e49e-8416-ba9f-819a-da944938c05f@microchip.com/
> and its parents. Outcome of that seemed to be that using "sam9x7" was fine.

And it's where it begins to be funny, as the LCD is precisely one aspect 
where we differentiate between sam9x75, sam9x72 and sam9x70...
So please Manikandan sort this out if difference between these chips 
will be better handled with different compatibility string, in 
particular about //, LVDS and MIPI-DSI variants!

Regards,
   Nicolas

-- 
Nicolas Ferre

