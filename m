Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5672F7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbjFNIdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbjFNIdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:33:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC7B1985;
        Wed, 14 Jun 2023 01:33:13 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA0EB6606F13;
        Wed, 14 Jun 2023 09:33:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686731592;
        bh=O4wceCLCcU4ElsM9C74KpJfkq3+lvd+dFw6bAs1GHuI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UabF4q/AwVwNZNBrPx33yKyXzurYBJFapho6dYnLVtDEWtAxSdHWo8zd0MbGkWVuz
         kLNHFkQq9vPSkVS3bq6uQzKJkEN3o6Wbbjl2D6DGjm/Ha9rOGjOruUW+aieZp1CAt0
         eP1CjrKxLJIto7O7nBt72xAiakCihCQA9bdFsJPs6mZw1+5lkad/5pdnaNNRoGt7do
         tL8RxHK8tG0luAGntFRK7ObLFpuyxtgvsDUsGJL0qrE0dnP36XKwcsbeWDBfGc3oM+
         TFUvyZu0fRoSCaKgurJNAarfJBlVnpgeXBTRbx2vxIQFfIq0GqafeSLEVTypJ7plkc
         mBf618f6rVFVQ==
Message-ID: <6daa58c7-055f-bcef-f82d-c83c0941d13c@collabora.com>
Date:   Wed, 14 Jun 2023 10:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 3/8] dt-bindings: leds: leds-mt6323: Support WLED
 output
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, pavel@ucw.cz
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
 <20230601110813.2373764-4-angelogioacchino.delregno@collabora.com>
 <75d78713-fc8f-24a9-a422-2b4d57c5d488@linaro.org>
 <88f37d33-6545-d307-17a9-896e86d0ed50@collabora.com>
 <d8a09620-9891-8072-8602-403128ba8d30@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d8a09620-9891-8072-8602-403128ba8d30@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/06/23 08:59, Krzysztof Kozlowski ha scritto:
> On 09/06/2023 09:51, AngeloGioacchino Del Regno wrote:
>> Il 02/06/23 10:32, Krzysztof Kozlowski ha scritto:
>>> On 01/06/2023 13:08, AngeloGioacchino Del Regno wrote:
>>>> Some PMICs have a separated WLED string output: add a property
>>>> `mediatek,is-wled` to indicate which LED string is a WLED.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/leds/leds-mt6323.txt | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
>>>> index 052dccb8f2ce..904b2222a5fe 100644
>>>> --- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
>>>> +++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
>>>> @@ -30,6 +30,7 @@ Optional properties for the LED child node:
>>>>    - label : See Documentation/devicetree/bindings/leds/common.txt
>>>>    - linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
>>>>    - default-state: See Documentation/devicetree/bindings/leds/common.txt
>>>> +- mediatek,is-wled: LED string is connected to WLED output
>>>
>>> Why would it matter to what the output is connected to?
>>
>> When this property is present, the MT6323 LEDs are managed through different
>> hardware registers which are specific to WLEDs: if we have no indication of
>> whether this is a WLED or a LED, we would program the wrong registers.
>>
> 
> OK, so it is rather the choice of output in the device? What is "LED
> string" in this context?
> 

"LED string" is a term that is commonly used to refer to an array of LEDs.
Usually, in the context of displays (so, WLED!), it refers to the LEDs array
that forms the backlight.

And yes, it's choice of output in the HW.

Cheers,
Angelo

