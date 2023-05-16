Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C178705609
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjEPSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEPSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:33:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257256195
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:33:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so20279645a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684262035; x=1686854035;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UM5QhM60g6MRUI2fwaNDHDFdlzqdnsKU9vL4QdeC3fM=;
        b=hif5xAcXjEMtR3qp/0pniuFc8yhgidxzrVRBGI8mS8yJT3iuw0oBPV2TUzbrM2PIvI
         5vqEHD5/+O6MzZNSgejLzEzDfqdl963I91WqUm369iQbNFXarcHAodSnhUhH6lNmd0fi
         Lica636EvHSCFWwfeDlmT1mDjZvDtxT+foiLUczkeffbruqOVR6zEF2xrYbAWZupLs0I
         jWI5isYCxLM6g0rEZfYOMxfIKosajOKHfIvZx5ZgdqWXLnOylYGgR7Of9oYkUHOWWjw8
         UBvD8NrMMNNptYODI0nu7H6sJIU8N4UZ75QoU/+SnCzY5rxolY1oaXWLC0nJQ0b5IoOH
         1EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684262035; x=1686854035;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UM5QhM60g6MRUI2fwaNDHDFdlzqdnsKU9vL4QdeC3fM=;
        b=i6XPIutJW4BLjzAOp2I97EUMKk6MMgY1XhIAp+qLyxrfZHAqJDyhoB4Vpnw3mZ8wVt
         xCnjN/+lmtU8cLqiOuqYxvmZ0hEkxFVHCWr3oAbHj+rrqs3eev9CtQfDbta/gHC6NPWj
         jyztBwo4rLJR8ARqQkDURNGG2YmAji12uB4m5QLOEnwsJaB31mb5CpWzo+KD+dV2cXQ2
         Sl6/iMQeQ/2r35PlytB3k0eXTmU7NHadE/AkUWd/A1mj6ZtRExi+1LUJRQwuGD9xyaQn
         7heoXM6r8ae9G8dP1HZuX08IEx9K0NSaZfHaLz7PiMMz/4SoGSwZft4jmFUI12NdWRnx
         6WSw==
X-Gm-Message-State: AC+VfDzZNiaUCg8F4cho9ZRUdj9MZBaw9VR6gqc6Hmc6glMPu7Qw4NfL
        l490wWksRYEb4CO1bjH1rfEjKg==
X-Google-Smtp-Source: ACHHUZ5qknH76jgwfN5URsxgt3KIN0jVaSCObUcC8GPqVloC1zCIFVU0+dVSRUTPIXrDUqvf2iH0CA==
X-Received: by 2002:a17:907:6d1f:b0:96a:6f35:d1a5 with SMTP id sa31-20020a1709076d1f00b0096a6f35d1a5mr20106630ejc.67.1684262035502;
        Tue, 16 May 2023 11:33:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id kz23-20020a17090777d700b009659fed3612sm11136765ejc.24.2023.05.16.11.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 11:33:55 -0700 (PDT)
Message-ID: <9a9b074e-d5c9-eca8-4c05-f60861629a2d@linaro.org>
Date:   Tue, 16 May 2023 20:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
To:     Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515191909.611241-1-afd@ti.com>
 <13c1f6ea-63b5-9667-18a2-705829c46437@axentia.se>
 <895c84f5-4a3c-fd2c-2b43-1a1996862e15@ti.com>
 <7d73a37f-80b7-b623-1b71-fa19bf379713@linaro.org>
 <558ebfaf-bd7e-1760-5799-8ed430acad7a@ti.com>
 <32dbdaa3-067b-c997-778f-4fc8dafbbd87@linaro.org>
 <1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com>
Content-Language: en-US
In-Reply-To: <1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 19:47, Andrew Davis wrote:
> On 5/16/23 11:49 AM, Krzysztof Kozlowski wrote:
>> On 16/05/2023 18:29, Andrew Davis wrote:
>>> On 5/16/23 11:19 AM, Krzysztof Kozlowski wrote:
>>>> On 16/05/2023 17:18, Andrew Davis wrote:
>>>>> On 5/15/23 4:14 PM, Peter Rosin wrote:
>>>>>> Hi!
>>>>>>
>>>>>> 2023-05-15 at 21:19, Andrew Davis wrote:
>>>>>>> The DT binding for the reg-mux compatible states it can be used when the
>>>>>>> "parent device of mux controller is not syscon device". It also allows
>>>>>>> for a reg property. When the parent device is indeed not a syscon device,
>>>>>>> nor is it a regmap provider, we should fallback to using that reg
>>>>>>> property to identify the address space to use for this mux.
>>>>>>
>>>>>> We should? Says who?
>>>>>>
>>>>>> Don't get me wrong, I'm not saying the change is bad or wrong, I would just
>>>>>> like to see an example where it matters. Or, at least some rationale for why
>>>>>> the code needs to change other than covering some case that looks like it
>>>>>> could/should be possible based on the binding. I.e., why is it not better to
>>>>>> "close the hole" in the binding instead?
>>>>>>
>>>>>
>>>>> Sure, so this all stated when I was building a checker to make sure that drivers
>>>>> are not mapping overlapping register spaces. I noticed syscon nodes are a source
>>>>> of that so I'm trying to look into their usage.
>>>>>
>>>>> To start, IHMO there is only one valid use for syscon and that is when more than
>>>>> one driver needs to access shared bits in a single register. DT has no way to
>>>>
>>>> It has... what about all existing efuse/nvmem devices?
>>>>
>>>>> describe down to the bit granular level, so one must give that register to
>>>>> a "syscon node", then have the device node use a phandle to the syscon node:
>>>>>
>>>>> common_reg: syscon@10000 {
>>>>> 	compatible = "syscon";
>>>>> 	reg = <0x10000 0x4>;
>>>>> };
>>>>>
>>>>> consumer@1 {
>>>>> 	syscon-efuse = <&common_reg 0x1>;
>>>>> };
>>>>>
>>>>> consumer@2 {
>>>>> 	syscon-efuse = <&common_reg 0x2>;
>>>>> };
>>>>>
>>>>> Something like that, then regmap will take care of synchronizing access.
>>>>
>>>> Syscon is not for this.
>>>>
>>>
>>> That is how it is used today, and in 5 other ways too and there is
>>> no guidance on it. Let me know what syscon is for then.
>>
>> Like described in its bindings (syscon.yaml). The main case is: some
>> part of address space (dedicated) for various purposes.
>>
> 
> That is a "simple-bus", you could use the same reasoning and make the
> whole address space one big "syscon" node instead then just poke
> registers from drivers all over.

Yes and both are discouraged.

> 
> It is not clear where to draw the line, and for that reason I would
> like to discourage "syscon" as much as possible and use the normal DT
> scheme of node per device/register space.

We all keep discouraging using syscon, so I agree. What exactly do you mean?

> 
>> Secondary case is a device, with its address space, which has few
>> registers from other domain, so it needs to expose these to the other
>> devices.
>>
> 
> That is not the case for "reg-mux"; neither case is. So you would
> agree that "reg-mux" nodes should not be syscon nodes 

I don't understand. reg-mux is not a syscon. No syscon compatible in:
Documentation/devicetree/bindings/mux/reg-mux.yaml


> nor should
> they force their parents to be one when they do not meet the above
> two cases?

reg-mux does not force the parent to be syscon. You are now mistaking it
with mmio-mux, which apparently for our Linux implementation it expects
parent to be syscon.

>> efuse is not syscon, because it is not writeable. efuse has entirely
>> different purpose with its own defined purpose/type - efuse/OTP etc.
>>
> 
> That was just one example I found, I have not found a standard way
> to describe down to the bit level in DT, only to the word/register.
> Anything more granular needs non-standard ways of describing which
> bits belong to which nodes/devices and using syscon to fetch the
> common registers.
> 
>>>
>>>>>
>>>>
>>>> ...
>>>>
>>>>>
>>>>> Ideally DT nodes all describe their register space in a "reg"
>>>>> property and all the "large collection of devices" spaces become
>>>>> "simple-bus" nodes. "syscon" nodes can then be limited to only the
>>>>> rare case when multiple devices share bits in a single register.
>>>>>
>>>>> If Rob and Krzysztof agree I can send a patch with the above
>>>>> guidance to the Devicetree Specification repo also.
>>>>
>>>> Agree on what?
>>>>
>>>
>>> That we should provide the above guidance on when and how to use syscon
>>> nodes. Right now it is a free for all and it is causing issues.
>>
>> Sure, providing more guidance seems good. We already provide guidance
>> via review, but we can codify it more. Where? syscon.yaml? It's already
>> describing everything needed to know...
>>
>> What particular problems do you see which need to be solved?
>>
> 
> My issue is the guidance is not clear, nor being followed. For instance
> this is listed as a requirement:
> 
> "The registers are not cohesive enough to represent as any specific type of device."
> 
> Take "ti,j721e-system-controller" for instance, today this region is modeled
> as a "syscon" node but it actually is a region of well defined register spaces
> and devices. Like PHYs, clock controllers, and our even our pinmux controller.

Then it should not be syscon. The platform maintainer should tell
submitter: this is not syscon, please stop this nonsense.

We do not have access to your datasheets and we do not have time to
investigate each one of device, so we, DT maintainers, cannot really
judge. Submitters want everything to be syscon because they can write
code much faster and shove into kernel poor quality drivers which do not
adhere to any design principles.

> Most of these devices use the normal "reg" property to claim their registers and
> so this space should be a "simple-bus" but we are forced to make it one big
> "syscon" node because a couple devices in this area have a Linux driver that
> requires their parent node to be a syscon node.

I don't think it is requirement. You could have a device which has
children, gives them regmap, but is not really syscon.

> 
> That is the point of this patch, to relax that restriction in this driver.
> It doesn't even change the binding, it only makes the driver match what
> the binding allows.

Hm, we might be talking about different topics, I don't know. I did not
look at the driver as it does not fall into category of bindings at all
and is fully ignored by my filters.

Best regards,
Krzysztof

