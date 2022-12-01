Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67663FC38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiLAXpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiLAXpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:45:06 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F7BE6AE;
        Thu,  1 Dec 2022 15:45:04 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 589FC84225;
        Fri,  2 Dec 2022 00:45:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669938302;
        bh=tVAl2PUlhRY2y4+Skseue/tW4aAWv4TLrxfM05T5iMw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SXrfF3zm+8KNwwJqNthoMBvIJSRyAakH1WIH34/TPREIWZnazEI1c7qqH8QgI3fC3
         C0Bde4vtUUOCxo0cZRIq9yFBrLXqp69olbZE1DwffNLa5hB1U66N2f4lxfFbHj/Aut
         WZjUKD+8/Lq9JmoQC1h+mqxeVI2+BGDzey7EHvwSusOOKYDl3sAaoaUotaUC/39BoU
         NjER95d29KOx5ICkGBfHwb4XWCk3k/d3OxTWNuLR80vawknQ4OGlM0GdASCy6XcYgY
         dESBVnpiKSe/19hcfnpdS+iW6aSEBHHoDW16qHlDyhxvELI+revZU40zDILVN58YgQ
         Q5pCevsko/LKw==
Message-ID: <4043d693-7739-4709-8551-9f476031db70@denx.de>
Date:   Fri, 2 Dec 2022 00:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel@dh-electronics.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz> <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221130191905.GA2631320-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 20:19, Rob Herring wrote:
> On Fri, Nov 25, 2022 at 10:26:30PM +0100, Marek Vasut wrote:
>> On 11/22/22 13:23, Pavel Machek wrote:
>>> Hi!
>>
>> Hi,
>>
>>>> Mark the label property as deprecated as it is mentioned
>>>> in the description.
>>>
>>> Lets do it the other way around. Functions (etc) don't really provide
>>> good enough description of LED, and label is still needed.
>>
>> Can you please provide a clear explanation which property or approach is the
>> correct one for new DTs ?
>>
>> So far, the documentation states that "label" is deprecated, and users
>> should replace it with "function" and "color".
> 
> 'function' is what activity/operation the LED is associated with. It is
> a fixed set of strings which s/w may use. It is a replacement for
> 'linux,default-trigger'.

Isn't this 'function' more of a standardized replacement for 'label' ?

$ git grep LED_FUNCTION_ include/
...
include/dt-bindings/leds/common.h:#define LED_FUNCTION_PLAYER5 "player-5"
include/dt-bindings/leds/common.h:#define LED_FUNCTION_ACTIVITY "activity"
include/dt-bindings/leds/common.h:#define LED_FUNCTION_ALARM "alarm"
include/dt-bindings/leds/common.h:#define LED_FUNCTION_BACKLIGHT "backlight"
include/dt-bindings/leds/common.h:#define LED_FUNCTION_BLUETOOTH "bluetooth"
include/dt-bindings/leds/common.h:#define LED_FUNCTION_BOOT "boot"
...

Seems to me that ^ is closer to a "standardized" form of 'label' .

The LED subsystem does not infer any behavior of those LEDs based on 
their 'function' property as far as I can tell, at least not in the way 
'linux,default-trigger' behaves.

> 'label' is what is printed next to the LED for a human to read. 'label'
> can be anything and the OS shouldn't care what it is.

This part I understand. What is not clear to me is, why is 'label' being 
un-deprecated.

We newly have 'function', 'function-enumerator' and 'color' DT 
properties for LEDs, which seem to be standardized forms of describing 
what the LED is used for, which LED it is (if there are multiple), and 
color of that LED. This was previously described in the 'label' 
property, usually in free form of e.g. "beaglebone:green:usr2" .

> They serve 2 different purposes.

[...]
