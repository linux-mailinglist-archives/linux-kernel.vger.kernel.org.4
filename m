Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0F7700656
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbjELLIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbjELLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:08:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F71100E2;
        Fri, 12 May 2023 04:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CFCD60BBA;
        Fri, 12 May 2023 11:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AC6C433EF;
        Fri, 12 May 2023 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683889714;
        bh=9uveR+4HYlpo1o+OKWBaWxTrmSSdNHP4bkHON+B5Ca4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eZDFxVHWMJnaWOukTLVUSpkhBXwrNDHdPhZFxbpxgbEbGOQZGH0Ti3Nr0r2iKfCsG
         s3yH9nCaIFpVL+fSqouciEkGPOrRRe7jWDt1WeavYEA97j5PhRgfUBC7JInsW0EnUV
         fYwLxf00oDA9dS76n8MS52KBqrw5LvzEsjAvCnj4rWa/jS/Eh6EQk8XUBwm0sxbMs0
         IUhMQ5D4dxQrufUL7/AU7eo2T6QozVrKa03b6A5YSmyBjWAld/kZyoXhhPoPjCAmjR
         zo3ryU55J8OzNKIPsTfIkuewUq9SlkOfWbwmcjpuOOE1kRlOpPuw3S1j7bnKEotS9W
         zhgFEstL2dEsQ==
Message-ID: <40592737-4330-101b-5425-091572e61c6f@kernel.org>
Date:   Fri, 12 May 2023 14:08:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: cdns,usb3: Add clock and reset
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230510132816.108820-1-minda.chen@starfivetech.com>
 <20230510132816.108820-2-minda.chen@starfivetech.com>
 <9cf5965a-8290-dfff-9f92-07ed2df66650@linaro.org>
 <05057f6d-cb38-8e4a-5d30-82863e0cda44@kernel.org>
 <028fb8ac-d6cc-6fee-f50b-b965e69e7d0c@linaro.org>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <028fb8ac-d6cc-6fee-f50b-b965e69e7d0c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/05/2023 17:49, Krzysztof Kozlowski wrote:
> On 11/05/2023 14:16, Roger Quadros wrote:
>>
>>
>> On 11/05/2023 12:26, Krzysztof Kozlowski wrote:
>>> On 10/05/2023 15:28, Minda Chen wrote:
>>>> To support generic clock and reset init in Cadence USBSS
>>>> controller, add clock and reset dts configuration.
>>>>
>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>> ---
>>>>  .../devicetree/bindings/usb/cdns,usb3.yaml         | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>> index cae46c4982ad..623c6b34dee3 100644
>>>> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>> @@ -42,6 +42,18 @@ properties:
>>>>        - const: otg
>>>>        - const: wakeup
>>>>  
>>>> +  clocks:
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>> +    description:
>>>> +      USB controller clocks.
>>>
>>> You need to list the items. And why is it variable? Your clock choice in
>>> the example is poor, I doubt it is real.
>>>
>>>> +
>>>> +  resets:
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>> +    description:
>>>> +      USB controller generic resets.
>>>
>>> Here as well.
>>>
>>> You had one clock last time, thus the review was - drop the names. Now
>>> you changed it to 8 clocks... I don't understand.
>>>
>>
>> Different platforms may have different number of clocks/resets or none.
>> So I don't think minItems/maxItems should be specified.
> 
> Yeah, but we want the clocks to be specific per platform. Not anything
> anywhere.
> 

Agreed. So we don't specify min/maxItems at top level but use conditional
constraints per platform?
Which means we will need to add platform specific compatibles as well.

-- 
cheers,
-roger
