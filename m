Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6A6EF0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbjDZJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbjDZJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:22:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576E4EFA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:21:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52863157da6so1867798a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682500883; x=1685092883;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxCxYUQlhPobw2YaHoERc69tjdRgnWZj+VY019M7IAU=;
        b=bvIR4KnC6Zzuh+3JQCJs7pwK+l2c7ezp/MVII5CzoKt4+A0E4ZCFlR3a0kINPtS4fV
         wVp3TgxR2yflOIBxLS54ClrNOoCyuLo8DjlI27JjjGofJTPkxXV3lt6/3eImb3oNB1e7
         /tTiuHOD91z6eabm5UZDAS6MhKxEDAharqs0EDXaiA7EeOu2nemA1yso+E3ylmi0Z3OB
         HUD4AHDkUNOWWW+NosZX3VFbqHzw52V1wH0h2cumFO2J1Bd79VUORFfRPo82UqBI6gLZ
         16kiRHo47w92iCszX7j/YxJRJENN/qDaFty7iUHaRDH1od8Qa6/HHsNW5Wk9aZBHhEaT
         SBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682500883; x=1685092883;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxCxYUQlhPobw2YaHoERc69tjdRgnWZj+VY019M7IAU=;
        b=LajUY2zLhkIbwt0dVdjnwkppNlfT8fYki/hqRLLnxcvI3eYshWyRFFnSAWnbGMbTKK
         m+M+nkO1BDTq0EyfAJs0ULizS4JVCGTHS78AHkO1q14TJy2WtbBfYd/0vtRRKj56bEV2
         dT/SW47edLwA/n6R3c58WmqYtDR4JcIqfqpIyuEjt8twrcK/4VTKeHw1LdwYoY6JLcfZ
         ZnlGgLa53iLh4p6DBs6DGo+E9pHkIqDRbJCNieUfEUijZE6rEfSMpMjmchurHfVza2CD
         OaAv9uYYlXlUuVeENsPQsU++2SETCD3GYCksBvySYioWXyb49vopjctZCXDG0S6qHN/p
         d8BQ==
X-Gm-Message-State: AAQBX9csKL0n5zzcyIPEtE1E7Q0muSpnD/3+AMaL04MS4VUtF66+TkVV
        FDGzZAouWkx7foHgXwkWvv/B4Q==
X-Google-Smtp-Source: AKy350YkLfCKdwJFqWdBbiclvdhiSi9Ia1cb+z/3icUJQz9gfl++MYJ55Q6nVFyZ75K6+8fIBbqF/Q==
X-Received: by 2002:a05:6a20:8e10:b0:f3:168f:4c52 with SMTP id y16-20020a056a208e1000b000f3168f4c52mr17386642pzj.25.1682500883243;
        Wed, 26 Apr 2023 02:21:23 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id q22-20020a63e956000000b005033e653a17sm9384884pgj.85.2023.04.26.02.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 02:21:22 -0700 (PDT)
Message-ID: <f966a8df-6998-f6f1-cc3c-fa92e1d5d34b@9elements.com>
Date:   Wed, 26 Apr 2023 14:51:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] leds: max597x: Add support for max597x
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230417094035.998965-1-Naresh.Solanki@9elements.com>
 <20230420115035.GE970483@google.com>
 <079eca63-54f5-7a4b-3b1c-e2515ceae9cc@9elements.com>
 <20230420135428.GD996918@google.com>
 <40b72025-16a8-1af5-d69f-659d37cdeab9@9elements.com>
 <20230421071921.GI996918@google.com>
 <03f1691e-bdc2-90cc-4014-585703d2cf4e@9elements.com>
Content-Language: en-US
In-Reply-To: <03f1691e-bdc2-90cc-4014-585703d2cf4e@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 24-04-2023 03:10 pm, Naresh Solanki wrote:
> Hi,
> 
> On 21-04-2023 12:49 pm, Lee Jones wrote:
>> On Thu, 20 Apr 2023, Naresh Solanki wrote:
>>
>>> Hi Lee,
>>>
>>> On 20-04-2023 07:24 pm, Lee Jones wrote:
>>>> On Thu, 20 Apr 2023, Naresh Solanki wrote:
>>>>
>>>>> Hi Lee,
>>>>>
>>>>> On 20-04-2023 05:20 pm, Lee Jones wrote:
>>>>>> On Mon, 17 Apr 2023, Naresh Solanki wrote:
>>>>>>
>>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>>>
>>>>>>> max597x is hot swap controller with indicator LED support.
>>>>>>> This driver uses DT property to configure led during boot time &
>>>>>>> also provide the LED control in sysfs.
>>>>>>>
>>>>>>> DTS example:
>>>>>>>        i2c {
>>>>>>>            #address-cells = <1>;
>>>>>>>            #size-cells = <0>;
>>>>>>>            regulator@3a {
>>>>>>>                compatible = "maxim,max5978";
>>>>>>>                reg = <0x3a>;
>>>>>>>                vss1-supply = <&p3v3>;
>>>>>>>
>>>>>>>                regulators {
>>>>>>>                    sw0_ref_0: sw0 {
>>>>>>>                        shunt-resistor-micro-ohms = <12000>;
>>>>>>>                    };
>>>>>>>                };
>>>>>>>
>>>>>>>                leds {
>>>>>>>                    #address-cells = <1>;
>>>>>>>                    #size-cells = <0>;
>>>>>>>                    led@0 {
>>>>>>>                        reg = <0>;
>>>>>>>                        label = "ssd0:green";
>>>>>>>                        default-state = "on";
>>>>>>>                    };
>>>>>>>                    led@1 {
>>>>>>>                        reg = <1>;
>>>>>>>                        label = "ssd1:green";
>>>>>>>                        default-state = "on";
>>>>>>>                    };
>>>>>>>                };
>>>>>>>            };
>>>>>>>        };
>>>>>>
>>>>>> Where is the DT binding document for this?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml?h=for-mfd-next
>>
>> You need to update it.  It is different to the one you supplied here.
> Ack.
>>
>>>>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>>>> ...
>>>>>>> Changes in V5:
>>>>>>> - Update commit message
>>>>>>> - Fix comments
>>>>>>> - Add necessary new line
>>>>>>> Changes in V4:
>>>>>>> - Remove unwanted preinitialise
>>>>>>> - Remove unneeded line breaks
>>>>>>> - Fix variable name to avoid confusion
>>>>>>> - Update module description to mention LED driver.
>>>>>>> Changes in V3:
>>>>>>> - Remove of_node_put as its handled by for loop
>>>>>>> - Print error if an LED fails to register.
>>>>>>> - Update driver name in Kconfig description
>>>>>>> - Remove unneeded variable assignment
>>>>>>> - Use devm_led_classdev_register to reget led
>>>>>>> Changes in V2:
>>>>>>> - Fix regmap update
>>>>>>> - Remove devm_kfree
>>>>>>> - Remove default-state
>>>>>>> - Add example dts in commit message
>>>>>>> - Fix whitespace in Kconfig
>>>>>>> - Fix comment
>>>>>>> ---
>>>>>>>     drivers/leds/Kconfig        |  11 ++++
>>>>>>>     drivers/leds/Makefile       |   1 +
>>>>>>>     drivers/leds/leds-max597x.c | 115 
>>>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>>>     3 files changed, 127 insertions(+)
>>>>>>>     create mode 100644 drivers/leds/leds-max597x.c
>>
>> [...]
>>
>>>>>> +    led_node = of_get_child_by_name(np, "leds");
>>>>>>> +    if (!led_node)
>>>>>>> +        return -ENODEV;
>>>>
>>>> It's odd for a device to be referring to itself as the "child".
>>> As this is leaf driver, LED specific info is present in "leds" node 
>>> in DT.
>>
>> I'm aware of the architecture.
>>
>> If you give the LEDs driver it's own compatible you don't need to keep
>> doing this self->parent->child level-jumping craziness to obtain
>> resources.
>  From my understanding, it is preferable to have only one compatible per 
> chip(in this case MFD driver), and the leaf driver can leverage it 
> unless it is not serving the purpose/breaks something.
> I think this is acceptable as long as it doesn't creates any 
> issue/breaks anything.
I just wanted to kindly follow up and check if we are aligned with the 
approach. And kindly let me know if you have any concerns regarding this.

Thank you very much for your time and I look forward to hearing back 
from you soon :)
>>
> 
> 
> Regards,
> Naresh
