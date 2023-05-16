Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F53E7047A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjEPIVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjEPIVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:21:53 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D515E132;
        Tue, 16 May 2023 01:21:51 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E992A85D4E;
        Tue, 16 May 2023 10:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684225310;
        bh=mNgFrfL2AiW/TFUWEH5fhJpUJ/Oa0Wnf/DxLzgqHfyA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=CIUi4ZVF/12jwJcvBGx7di7M1xOydHn5KCEEv9+WlCWpZrT6z36xkGcqUSVwFvtsM
         wBLQ5R5t6ncEmvpViagXLXU0/CzZq5AZfMDkRBplID1YA3H8sJTg8SmgVG11Ut06ya
         i/caIBywidu7yhJIBFvzQ8Q7mS/frNCBklM6dG9RCgEb9+D2DNdZNNFmF+LrmKxveV
         P8tlmvsSfhYv3vJ1Y7TQxRi0srIkNRB7VAdB6FkKS4GoN3B6bCUjGDbKUg1ByrwLCH
         7zgAYCROvPgW2h+US0S3ETb2RbqEXd9NrWxKgvW0OceeQvrJa/UCvL6bVeQvqaG0nc
         zWzieSK6il2XA==
Message-ID: <cfff63bc-a4d7-7124-2c43-bf90b5ccd2e9@denx.de>
Date:   Tue, 16 May 2023 10:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: usb: usb251xb: correct swap-dx-lanes type to
 uint32
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mike.looijmans@topic.nl,
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
 <601bd136-ddae-2889-0e63-5f62484ec849@denx.de>
 <9ae25267-c4de-8f14-df62-d9d0d1f1420c@linaro.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <9ae25267-c4de-8f14-df62-d9d0d1f1420c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 10:19, Krzysztof Kozlowski wrote:
> On 15/05/2023 15:47, Marek Vasut wrote:
>>> Please consider the environment before printing this e-mail
>>> On 15-05-2023 14:55, Marek Vasut wrote:
>>>> On 5/15/23 12:33, Krzysztof Kozlowski wrote: diff --git
>>>> a/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>>> b/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>>>> index 4d1530816817..ac5b99710332 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>>>> @@ -231,7 +231,7 @@ properties:
>>>>>          power-on sequence to a port until the port has adequate power.
>>>>>        swap-dx-lanes:
>>>>> -    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>>        description: |
>>>>>          Specifies the ports which will swap the differential-pair
>>>>> (D+/D-),
>>>>>          default is not-swapped.
>>>>
>>>> Would it make more sense to update the driver instead ? I doubt you
>>>> could have more than 256 ports on this device after all.
>>>
>>>
>>> I guess there's a bunch of devicetrees already out there using the
>>> (misdocumented) 32-bit array binding, they'd break in a bad way...
>>
>> I think it is the other way around -- if the binding was documented as
>> u8, then the existing DTs should use the u8 type if they are compliant
>> to the binding document.
>>
>> I see one board in next which uses this property and sets it to 0 , so
>> this one is not affected either way:
>> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dts:
>> swap-dx-lanes = <0>;
> 
> 
> First of all, the original binding did not define it as u8. It actually
> skipped the type entirely but:
>   - Example shown u32,
>   - Driver used u32,
>   - In-tree user uses u32 (although as pointed - as 0 so not really
> relevant).
> 
> Thus the ABI is rather defined by not-breaking users here, so I would
> stick to fixing it to u32.

Fine by me.
