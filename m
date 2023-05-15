Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C995702EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjEONru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEONrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:47:49 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD1119BA;
        Mon, 15 May 2023 06:47:47 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C49868475E;
        Mon, 15 May 2023 15:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684158466;
        bh=WVwn+9dAXYd/CF585ou76WlhqyT9xY6kYSiNbeDUwAw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=E2cjuQIl3TcpV7aPoE+0DBLy5UJf5S02FxX34f03IC2C2t0vq4Bw+6Uo8FgQdVb2E
         RajAQMmRmQaCwzhJCTuwmCMFptE0eTYBmQ/XF9Sy4bvb3LUUgrULzwjIlk2AGRLgqM
         5MOfV0p9mrLwS+1OBNV6lJ0PrgPelrVLeEqmM4othMsxrM99gY4Ll/MMDOmiD9mxDI
         4czMV6IRjM7MFb+Lo47x2bXSnx/xRJhfB5elpNAoAGGgmeeQhIvHNpOk3HSTOwhJXs
         8kasOsFLsBZqn6RpOLDD33SvmTR/yDpKMvOoysQVKEAgUW7NVRDh5TKb5EFax+RFIc
         SU8y1ewbz+sxg==
Message-ID: <601bd136-ddae-2889-0e63-5f62484ec849@denx.de>
Date:   Mon, 15 May 2023 15:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: usb: usb251xb: correct swap-dx-lanes type to
 uint32
Content-Language: en-US
To:     mike.looijmans@topic.nl,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Leitner <richard.leitner@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515103337.130607-1-krzysztof.kozlowski@linaro.org>
 <9b62a0db-1374-2c89-5ea3-286467bd1e4e@denx.de>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ed9c8f5a-900b-42eb-a8c2-543ccf3145e3@emailsignatures365.codetwo.com>
 <da66656e-ddd6-99cf-41ee-d6b2d318bdff@topic.nl>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <da66656e-ddd6-99cf-41ee-d6b2d318bdff@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 15:17, mike.looijmans@topic.nl wrote:
> See below...
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl

Can you please drop this part next time ?

> Please consider the environment before printing this e-mail
> On 15-05-2023 14:55, Marek Vasut wrote:
>> On 5/15/23 12:33, Krzysztof Kozlowski wrote: diff --git 
>> a/Documentation/devicetree/bindings/usb/usb251xb.yaml 
>> b/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>> index 4d1530816817..ac5b99710332 100644
>>> --- a/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>> @@ -231,7 +231,7 @@ properties:
>>>         power-on sequence to a port until the port has adequate power.
>>>       swap-dx-lanes:
>>> -    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>       description: |
>>>         Specifies the ports which will swap the differential-pair 
>>> (D+/D-),
>>>         default is not-swapped.
>>
>> Would it make more sense to update the driver instead ? I doubt you 
>> could have more than 256 ports on this device after all.
> 
> 
> I guess there's a bunch of devicetrees already out there using the 
> (misdocumented) 32-bit array binding, they'd break in a bad way...

I think it is the other way around -- if the binding was documented as 
u8, then the existing DTs should use the u8 type if they are compliant 
to the binding document.

I see one board in next which uses this property and sets it to 0 , so 
this one is not affected either way:
arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dts: 
swap-dx-lanes = <0>;

