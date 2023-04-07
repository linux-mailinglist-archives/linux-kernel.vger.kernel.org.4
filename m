Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7B6DA90D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjDGGpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGGps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375066581;
        Thu,  6 Apr 2023 23:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C400664EFC;
        Fri,  7 Apr 2023 06:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C5AC433D2;
        Fri,  7 Apr 2023 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680849946;
        bh=sMHAm0SIvY3L1eUS8vd59ZrC6BLoBQte0hiO3SR+Z/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hrR+hzSiKmLUyvnWqpgZPDgPkM4oO4PAzIyphCpshDjlKUKlnXgke0BVpgBXwMLfo
         pls7flzb0+l3M9Z4dAZ+/QBuDD2lfNNyLBMcfhDl8k6NG9pX28KTVbRmR1c+uAHUG5
         xxFCRjRlWWdcutbqRYxJhgp5x0+jrDUOkEIJBG2TTxpfZDSQFA6GHc0a4NLa9iVaNw
         BFebZ+5fFNQ27tVCZXCGfUsynvu2X3Vu5Hph0CV78vMVUoB5OeNyoNazrekz9Xo/6O
         u/4dOIVrwLz/9cxLuaVCBsN+3/GwNSf2XnT1L5jz8GJaRv8wJRRXbWU1nvqPuKaEae
         1hvyDxNXTr9Wg==
Message-ID: <83faad26-bb59-14a9-23d8-9e53a235a18e@kernel.org>
Date:   Fri, 7 Apr 2023 08:45:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Support Honeywell mpr
 sensors
Content-Language: en-US
To:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230401185717.1b971617@jic23-huawei>
 <20230401162701.1d3caebc@jic23-huawei> <ZC8oepuINTaMqN9M@arbad>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZC8oepuINTaMqN9M@arbad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 22:15, Andreas Klinger wrote:
> Hi,
> 
> thanks to Krzysztof, Lars-Peter and Jonathan for the review and suggestions. I
> have one thing to clarify. See below.
> 
> Jonathan Cameron <jic23@kernel.org> schrieb am Sa, 01. Apr 16:27:
>> On Sat, 1 Apr 2023 11:42:15 +0200
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> On 01/04/2023 11:09, Andreas Klinger wrote:
> [...]
>>>> +  honeywell,pmin:
>>>> +    description:
>>>> +      Minimum pressure value the sensor can measure in pascal.  
>>>
>>> Use standard unit suffix:
>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
>>>
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +
>>>> +  honeywell,pmax:
>>>> +    description:
>>>> +      Maximum pressure value the sensor can measure in pascal.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32  
>>>
>>> Same.
>>>
>>> Why these values are suitable for DT? Does it depend on type of sensor
>>> (thus it is implied from compatible) or on system setup?
>>
>> I think we'll end up with a lot of compatibles, but that's still better
>> than free form description.  May still need these as well though given
>> the datasheet helpfully adds a foot note.
>>
>> 1. Custom pressure ranges are available.
>>
>> Might not be worth including all the details though but unhelpfully the
>> bits we care about are after details like is the gel food grade or the port long.
>> Definitely can ignore the encoding of i2c address / spi in the last few bits but
>> may need the transfer function.
>>
>>
>> mpr-0025GA-A maybe as a form?
> 
> Just to clarify: There are 32 different pressure ranges and 3 transfer functions
> which means we'll end up with 96 compatibles and 96 I2C ids.

You anyway need compatibles per devices, don't you?
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

I already commented on this.

> 
> Would it be an option to have only one dt compatible and to add the pressure
> range as dt property?
> e. g.: honeywell,range = "0025PA";

Did you just decided to ignore my comment?

> 
> But because of "Custom pressure ranges" we still need the DT properties. In this
> case there's another "mpr-custom" compatible, right?

Please go to my email and respond to comments.

Best regards,
Krzysztof

