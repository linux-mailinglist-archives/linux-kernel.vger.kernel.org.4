Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B1963FC39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiLAXpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiLAXpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:45:07 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BEBBE4F8;
        Thu,  1 Dec 2022 15:45:05 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 298D985291;
        Fri,  2 Dec 2022 00:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669938303;
        bh=lvh7bk0X0xJ0k9t1hMcrOK74zP9ebDwEIsFtFQSr3UY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GT2sE7J+6qvb84xLBa7huCUrgAM0aCNnh75bDqOEFGmc1jXSm7iHydrf1lyTGlFbn
         CISZL8J1vU8T1t3WJhGZTqNtTssjyAyNvYDzBQCggFmhSw7VjN0QuaU8kZ3FqgBnFi
         D1pCBTCywASNtBkeB+ub07CPpL/944xJLVn9ycK4MuHQEPIjaw6Cf7W8CXJklOZrs2
         yRPIPL983S87TI82sMQcb4bjm7rtGmqSBNLVANBdI9mRP+4zG6jRBz0CvGB2O0uOZ9
         4S+zavS9dq9ZWX+THOaoL0FPKH0PSLohkXld2J/Ac1cZX+Gpx76qMqiSyXD29y1J9c
         PL4n96QeDJF4w==
Message-ID: <66e960c0-3743-ed7d-f8b1-747ecdc61f9f@denx.de>
Date:   Fri, 2 Dec 2022 00:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel@dh-electronics.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz> <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org> <Y4eufPCzKbfp9k3z@duo.ucw.cz>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y4eufPCzKbfp9k3z@duo.ucw.cz>
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

On 11/30/22 20:26, Pavel Machek wrote:
> On Wed 2022-11-30 13:19:05, Rob Herring wrote:
>> On Fri, Nov 25, 2022 at 10:26:30PM +0100, Marek Vasut wrote:
>>> On 11/22/22 13:23, Pavel Machek wrote:
>>>> Hi!
>>>
>>> Hi,
>>>
>>>>> Mark the label property as deprecated as it is mentioned
>>>>> in the description.
>>>>
>>>> Lets do it the other way around. Functions (etc) don't really provide
>>>> good enough description of LED, and label is still needed.
>>>
>>> Can you please provide a clear explanation which property or approach is the
>>> correct one for new DTs ?
>>>
>>> So far, the documentation states that "label" is deprecated, and users
>>> should replace it with "function" and "color".
>>
>> 'function' is what activity/operation the LED is associated with. It is
>> a fixed set of strings which s/w may use. It is a replacement for
>> 'linux,default-trigger'.
>>
>> 'label' is what is printed next to the LED for a human to read. 'label'
>> can be anything and the OS shouldn't care what it is.
> 
> Unfortunately, no.
> 
> We use label as a path in /sys/class/leds. And it looks like integer
> "function" is not really adequate for describing what LED does. There
> are too many LEDs and not enough integers, and it is common to have
> same function ("activity") on multiple devices ("wifi", "mmc", "eth").

The Documentation/devicetree/bindings/leds/common.yaml schema indicates 
that function is a string, not an integer:

"
  32   function:
  33     description:
  34       LED function. Use one of the LED_FUNCTION_* prefixed definitions
  35       from the header include/dt-bindings/leds/common.h. If there is no
  36       matching LED_FUNCTION available, add a new one.
  37     $ref: /schemas/types.yaml#/definitions/string
"
