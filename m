Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E63610730
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiJ1BWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiJ1BWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:22:14 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8EA6C39
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:22:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b25so2578028qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCnIPWmpmhl06fh13Fy5AXQxpTL6Lb8+uJ/N2EsF5sI=;
        b=a+TYQ/L6Z22mSRK++ipMB62pRGbMAza1TqHp6EmZ5qIur4iTr8b9vHbWq5oNoASmFo
         XI1mZYLDd/qLyuOw9A+VkjnkVNN4tYCewcBs56oNagZYqPBkDls0YhuD4G9Uvgo2DtNi
         eoNdgUolg/0m5hWqOhaVbul9bLQwtznp9xUeRi3GpxJ4nGFEz5iS1QCTOSlQMjku5zus
         hD5LHP0f0Lw7k3kOY4pMR9PudaTXIwvNosUL7gecx1KWSrNZf3e0yf9hf8fP+/9MkKYA
         lKOuVLFsA29Og/04EgfUGab27q6gNNX4L/XOfsWtq83iMXK4VxetNV/+8Nx14y5PCmog
         ZYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCnIPWmpmhl06fh13Fy5AXQxpTL6Lb8+uJ/N2EsF5sI=;
        b=e8Hbttrw/Q2b2wdDG86pEUStcXYIv+Y7SCXZuzfD+SuqtiUKs9iPzOVE14RLu3eTQf
         ISHsll/sfEDRsvDYE7acsBPGNpL4R52bjg51vWKKOV0cZ2466TGVk9rWIHfjyUtgcP+p
         EJW9FTZK+QUfzrhrr1ZZOAVdzp7EwbLofzPWzLqdxC9+jJVExx6nsBIuH7VhUH6GnW9o
         bU9jNj1qXq/+qYqY+pKZYkhvxsFXdYcAYcEn0QL0pd7cMEnclS/2C39llqCyp/0mtijH
         +XCl8C+upzEfE6KKpx9yVn9LDr3CD8Ao6A/ZvYLcv8a/x3ibcWhVgK+VijG+kgMH9WNW
         vbmA==
X-Gm-Message-State: ACrzQf22eaqbfmFk6TTzJY9KFtMM2JutQrCd27+vcPvyXdZLrue/78R3
        63/g1Wa9fc4zyEVlx+Oa5zsBYg==
X-Google-Smtp-Source: AMsMyM7Fg+6+mD8eIp9eaV2K/rmXf4ydEmw4VGWcoJSJ4mvc+INqLL4ODYEyRv+PfdsskpLTYRhVMg==
X-Received: by 2002:a05:620a:4256:b0:6f0:fc14:5b37 with SMTP id w22-20020a05620a425600b006f0fc145b37mr25423947qko.503.1666920132669;
        Thu, 27 Oct 2022 18:22:12 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id h17-20020a05620a245100b006ecdfcf9d81sm2016666qkn.84.2022.10.27.18.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 18:22:12 -0700 (PDT)
Message-ID: <ee37b5a1-5afc-71b3-f777-add295d9ce17@linaro.org>
Date:   Thu, 27 Oct 2022 21:22:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add regulator-output binding
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
 <20220929210714.GA2684335-robh@kernel.org>
 <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
 <Y1rRCq9Kdd2zPPkw@hatter.bewilderbeest.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1rRCq9Kdd2zPPkw@hatter.bewilderbeest.net>
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

On 27/10/2022 14:42, Zev Weiss wrote:
> On Thu, Sep 29, 2022 at 02:27:20PM PDT, Zev Weiss wrote:
>> On Thu, Sep 29, 2022 at 02:07:14PM PDT, Rob Herring wrote:
>>> On Sun, Sep 25, 2022 at 03:03:18PM -0700, Zev Weiss wrote:
>>>> This describes a power output supplied by a regulator, such as a
>>>> power outlet on a power distribution unit (PDU).
>>>>
>>>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>>> ---
>>>> .../bindings/regulator/regulator-output.yaml  | 47 +++++++++++++++++++
>>>> 1 file changed, 47 insertions(+)
>>>> create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>> new file mode 100644
>>>> index 000000000000..40953ec48e9e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>> @@ -0,0 +1,47 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +
>>>> +$id: http://devicetree.org/schemas/regulator/regulator-output.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Regulator output connector
>>>> +
>>>> +maintainers:
>>>> +  - Zev Weiss <zev@bewilderbeest.net>
>>>> +
>>>> +description: |
>>>> +  This describes a power output connector supplied by a regulator,
>>>> +  such as a power outlet on a power distribution unit (PDU).  The
>>>> +  connector may be standalone or merely one channel or set of pins
>>>> +  within a ganged physical connector carrying multiple independent
>>>> +  power outputs.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: regulator-output
>>>> +
>>>> +  vout-supply:
>>>> +    description:
>>>> +      Phandle of the regulator supplying the output.
>>>> +
>>>> +  regulator-leave-on:
>>>> +    description: |
>>>> +      If the regulator is enabled when software relinquishes control
>>>> +      of it (such as when shutting down) it should be left enabled
>>>> +      instead of being turned off.
>>>> +    type: boolean
>>>
>>> I'm not too sure about this one as there could be various times when
>>> control is relinquished. It is userspace closing its access?
>>> driver unbind? module unload? Does a bootloader pay attention to this?
>>>
>>> Rob
>>
>> Thanks for the feedback, Rob -- I'll admit I was a bit unsure how to 
>> approach that, and this may well not be the right answer.  What I'm 
>> really aiming for is an appropriate way to express that regulator 
>> on/off state should only ever be changed by explicit (external, e.g. 
>> userspace) request, never as any sort of default/automatic action.  
>> The two obvious things to guard against there seem to be automatic 
>> enablement during initialization and automatic disablement on de-init 
>> (shutdown, unbind, etc.).  The former I think can be avoided by simply 
>> not setting regulator-boot-on, so I added this as a corresponding 
>> property to avoid the latter.
>>
>> I'm definitely open to suggestions for a better approach though.
>>
> 
> Ping...
> 
> Would something like this be preferable as a more direct description of 
> that?
> 
>    regulator-manually-controlled:
>      description: |
>        The regulator should never be enabled or disabled automatically,
>        only when explicitly requested by an external actor (e.g.  
>        userspace).
>      type: boolean

This looks like putting policy and OS behavior into DT. I guess it easy
to understand in case of Linux which disables unclaimed regulators
during. But what if other system/firmware does not behave like that?

And what is the "external actor"? OS is not an external actor?

I could not get the problem you want to solve with this property - I
looked at cover letter and at commit msg.

I can only imagine that you want to keep regulator on, after last its
user disappears... but for what purpose? Do you expect that after system
shutdown the pin will stay high so regulator will be also on? If so, you
need hardware design, e.g. with some pull up (if control is over GPIO).

> 
> That would leave the question of which property takes priority if both 
> regulator-manually-controlled and regulator-boot-on are set -- should 
> the binding document the answer to that?  (I personally don't have a 
> strong opinion on which it should be.)


Best regards,
Krzysztof

