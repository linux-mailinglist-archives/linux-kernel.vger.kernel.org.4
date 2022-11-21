Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3986320FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiKULoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKULnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:43:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC2FCEB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:43:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so18384934lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJjIdqBUf7mCDkNqH+fJaGpki5XNddXN56C3IGVthfs=;
        b=jvsDyTDvEEvKahs+I0jRYw1UOVoegcSDrbK5OOi8YXXwsq7VNyteHXOyXn21Pzxhw+
         KzPhlop/Xi6XvvE7NiGQF2tTJBNxJmsTGPdk1SmEsQBqzYxMv2JN6+4mQiApfNguPDZO
         x+QS1bxhl3JqlppiKfBywx/sSkjPDhYlMdiKAZ+FyqVQ85ozSoGDVDo0M26XxpeGnJdm
         z87SAjvU26Ysw0pnSMJ4+50pu2CXUnDK5W6GG0uI0Bu4hxYZyBULp+dOQoxuDHkvpget
         o0Ugqy/QRTYMfIKglRY4b82MR6O+SZBgKCTSQBvLTuUD9UCrkSPI0m462w77WLmtxTAu
         XsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJjIdqBUf7mCDkNqH+fJaGpki5XNddXN56C3IGVthfs=;
        b=ZjCW20WqY24jIEnNTMKPds2O8we2upjcPUX/zhF/Y1vygz9cax1XoHqPx2dSAwdLH2
         P+u3SJbs4l6Blok8J79CPb5ljVYK6HDeXndptOsxCXv31wZyFdqxi7YLVlYWQk3m9c9K
         a204bffiBmO96dtrP8GiZBBPWyAdhMoL/zNccOH6RV4/NW7VdpFcPDpb8CcrfMGEoluJ
         15BJcuXze6HW4i210MNzacBLaYvYrFOQmdYfD37bkQB7qEOPKzg9dsKVnTA6XSzqf4Qv
         g4Io4+Ls9csi1koOJ18ShZX1muhM7jgfqKHOfD6VcBLxltoE5szzYQJOchlC5tdyJTHB
         a7HQ==
X-Gm-Message-State: ANoB5pnOm5apaRGAgTJ1/QZ2uVIZyNNB47MA7D4kpjUFe2vULBmSAhOz
        ENiN03vGHpfEN6DBgJko9JyoFg==
X-Google-Smtp-Source: AA0mqf4LUV1uVk6m74MISW9MOGRH7u8VqLFXDuWZECSkhQDyJLDgHXZotMMipUi7nB4QWKNPRWlPrQ==
X-Received: by 2002:a05:6512:b17:b0:4b4:b90a:69a1 with SMTP id w23-20020a0565120b1700b004b4b90a69a1mr5108694lfu.76.1669030997603;
        Mon, 21 Nov 2022 03:43:17 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w23-20020ac24437000000b0049480c8e7bcsm2001366lfl.176.2022.11.21.03.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:43:17 -0800 (PST)
Message-ID: <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
Date:   Mon, 21 Nov 2022 12:43:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com>
 <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
 <20221115150417.513955a7@bootlin.com> <20221118112349.7f09eefb@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118112349.7f09eefb@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 11:23, Herve Codina wrote:
> Hi Krzysztof, Geert,
> 
> On Tue, 15 Nov 2022 15:04:17 +0100
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
>> Hi Krzysztof,
>>
>> On Tue, 15 Nov 2022 14:07:52 +0100
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> On 15/11/2022 14:05, Krzysztof Kozlowski wrote:  
>>>> On 14/11/2022 12:15, Herve Codina wrote:    
>>>>> Add the h2mode property to force the USBs mode ie:
>>>>>  - 2 hosts
>>>>> or
>>>>>  - 1 host and 1 device
>>>>>
>>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>>>> ---
>>>>>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>>>>> index 95bf485c6cec..f9e0a58aa4fb 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>>>>> @@ -39,6 +39,16 @@ properties:
>>>>>    '#power-domain-cells':
>>>>>      const: 0
>>>>>  
>>>>> +  renesas,h2mode:
>>>>> +    description: |
>>>>> +      Configure the USBs mode.
>>>>> +        - <0> : the USBs are in 1 host and 1 device mode.
>>>>> +        - <1> : the USBs are in 2 host mode.
>>>>> +      If the property is not present, the value used is the one already present
>>>>> +      in the CFG_USB register (from reset or set by the bootloader).
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum: [0, 1]    
>>>>
>>>> 0/1 are quite cryptic. Why not making it a string which is easy to read
>>>> and understand? Can be something like "two-hosts" and "one-host". Or
>>>> anything you find more readable...    
>>>
>>> ...but actually you should rather make it a property of your USB
>>> controller, not clock controller. You have two controllers and we have a
>>> generic property for them - dr_mode.
>>>
>>> Best regards,
>>> Krzysztof
>>>   
>>
>> IMHO, this property in the USB controllers does not make sense.
>> Indeed each controller cannot have a different 'mode'.
>> Some controllers are USB host only (EHCI and OHCI) and the USBF
>> controller I worked on is device only.
>> 'h2mode' allows to choose between host or device on one of the USB
>> but not at the USB controller level.
>>
>> This property should be handle outside the USB controller nodes.
>>
>> Currently, this node (declared as a clock node) is in fact a sysctrl
>> node and can do some configuration not related to clocks.
>>
>> I agree with you something related to choosing USB Host/Device in
>> a clock node seems strange.
>>
>> Some discussion were already opened related to this property and how
>> to handle it:
>>   https://lore.kernel.org/all/20221107182642.05a09f2f@bootlin.com/
>>   https://lore.kernel.org/all/20221107173614.474707d7@bootlin.com/
>>
> 
> We advanced on this topic.
> 
> First, even if 'renesas,r9a06g032-sysctrl.yaml' is present in
> the devicetree/bindings/clock/ directory, this node is really
> a 'system controller' node:
> - title: Renesas RZ/N1D (R9A06G032) System Controller
> - compatible: renesas,r9a06g032-sysctrl
> 
> It handles clocks, power domains, some DMA routing, ...
> 
> Now, the property 'h2mode' allows to choose between:
>   - 2 USB hosts
> or
>   - 1 USB host and 1 USB device.
> 
> This switching is system wide and has no reason to be done in
> one specific USB controller. It can impact multiple devices and
> PLL settings.
> 
> The 'renesas,r9a06g032-sysctrl' node, as the system control
> node of our system, is the best candidate to handle the property.

Not necessarily. IIUC, you have:

1. sysctrl with some register(s) for choosing device mode
2. usb device or host at one address
3. usb host at separate address

If so then:
A. Pretty often we have wrapper nodes for this purpose (USB, phy
wrappers or glues) which are usually needed to configure something for a
generic block (like Synopsys etc).

B. Pretty often the device (so your USB host or device) needs to poke
something in system controller registers, e.g. for power or some other
setup.

Your case looks a lot like (B). We have many, many of such examples
already. Actually it is exactly like that, except that it affects
possibility of another device (e.g. choosing USB device blocks having
host there).

C. It looks a bit like a multi-serial-protocol interfaces (so
UART+I2C+SPI). The difference is that such cases have all these nodes
defined as a children of the protocol-wrapping device. Not here.

I would propose to go with (B) unless of course it's causes some crazy
architecture/code choices. Why? Because with exception of (C) we should
not define properties which represent DT node choices. IOW, Choosing a
node and compatible (e.g. usb controller as device) is enough to
describe the hardware. No need for other properties to control some
register in other block.


> 
> In order to be less cryptic in the property value, what do you
> think about:
>   renesas,h2mode:
>     - one-dev : the USBs are in 1 host and 1 device mode.
>     - only-hosts : the USBs are in 2 hosts mode.

Name looks better, if we go this path.

> 
> With these details and change on the property value,
> Is it ok for you to have the 'renesas,h2mode' property
> in the 'renesas,r9a06g032-sysctrl' node ?


Best regards,
Krzysztof

