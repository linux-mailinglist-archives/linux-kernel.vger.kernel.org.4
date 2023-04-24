Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221AC6EC925
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDXJkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDXJkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:40:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1910FB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:40:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f625d52275so4019340f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682329215; x=1684921215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmtJHqgiwvXx/8gjp5v9kiWbqKm1+hRv4Ak4FX7g+qg=;
        b=PZbkhwli/ViShMSoWBxjP+7nfjqJNvla0jfeniKbMDx7VqKLZKVKas/JFD3WbC+YD3
         FDcDwsrjc/pkoRmiy/p1nc9hCDKRcn1ZTvnD6gn1bwvlV0mdDHP/0OCgavBel8tRh4/V
         QNZttuKibnAzs+UB350A5ko9QiaMxORlPeAs0TRnxsfM4udcUyZJq5H3pmxAU9DuqEoW
         lmFouUs5XJzmFViFAV4s9FiPCUFw61TrsPVDgJcbnOWV21uSvWPQ+TT4+2tu77+UoEhX
         lumHSKfPsn2xW+Qnp5Z7Lo3/htLYPT/U69JXfyvL82djCXsqjMEGWWaVEyexBbFJFFzX
         JtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329215; x=1684921215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmtJHqgiwvXx/8gjp5v9kiWbqKm1+hRv4Ak4FX7g+qg=;
        b=aXRHb9B7TTp96MDYzas9Zi3oJMHkjrx5VolP+KaQBXc3BrKRoMGVeNdwiDPCf0Ldva
         d470DOmRtBUzblHTQ+WJJqQ0Q+nINpcF2jlVQyNkmtkPt3vtTDClqtzznJA5xn3y53/C
         pVYpvYmymAaymhl0M0EPpBQ97FGOEP2NO40A1ITwQsjIkJhZN0y5IjKSE0ThRQHL/bJ7
         v8c8PyqSB1JfMZ8GWK6X+ryY3mae7XiAH/+v4XjPB/HN7oNMEPfzVstbuOxPoDnq2DTY
         yIhT2XDEpKP5GRsJS8q8n4dyhq4AVSUseKDbiW2pOYxEn5xAHiODJ2/Z0pv/oAjA6Eoh
         TpVQ==
X-Gm-Message-State: AAQBX9fyuK9oaaZGH/cfyJ0R5spDO289kYtHRjZTWB/R9GM3nxPtg6fX
        rvoAdDiDct3ckVBaztEpefH7GTQpJUNpnbiiy6o=
X-Google-Smtp-Source: AKy350b+JJBv78Bl3d1mUBUw1PAmpTxrMXAlFY5AJ+h+vCWFg/VNn9S50+cXGxbg2QLFKY3fsU0gDA==
X-Received: by 2002:adf:cd85:0:b0:2ef:2cce:d7d8 with SMTP id q5-20020adfcd85000000b002ef2cced7d8mr10414410wrj.22.1682329215430;
        Mon, 24 Apr 2023 02:40:15 -0700 (PDT)
Received: from [192.168.29.232] ([49.37.170.173])
        by smtp.gmail.com with ESMTPSA id n3-20020a7bcbc3000000b003f175b360e5sm11838246wmi.0.2023.04.24.02.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 02:40:15 -0700 (PDT)
Message-ID: <03f1691e-bdc2-90cc-4014-585703d2cf4e@9elements.com>
Date:   Mon, 24 Apr 2023 15:10:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] leds: max597x: Add support for max597x
Content-Language: en-US
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
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230421071921.GI996918@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21-04-2023 12:49 pm, Lee Jones wrote:
> On Thu, 20 Apr 2023, Naresh Solanki wrote:
> 
>> Hi Lee,
>>
>> On 20-04-2023 07:24 pm, Lee Jones wrote:
>>> On Thu, 20 Apr 2023, Naresh Solanki wrote:
>>>
>>>> Hi Lee,
>>>>
>>>> On 20-04-2023 05:20 pm, Lee Jones wrote:
>>>>> On Mon, 17 Apr 2023, Naresh Solanki wrote:
>>>>>
>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>>
>>>>>> max597x is hot swap controller with indicator LED support.
>>>>>> This driver uses DT property to configure led during boot time &
>>>>>> also provide the LED control in sysfs.
>>>>>>
>>>>>> DTS example:
>>>>>>        i2c {
>>>>>>            #address-cells = <1>;
>>>>>>            #size-cells = <0>;
>>>>>>            regulator@3a {
>>>>>>                compatible = "maxim,max5978";
>>>>>>                reg = <0x3a>;
>>>>>>                vss1-supply = <&p3v3>;
>>>>>>
>>>>>>                regulators {
>>>>>>                    sw0_ref_0: sw0 {
>>>>>>                        shunt-resistor-micro-ohms = <12000>;
>>>>>>                    };
>>>>>>                };
>>>>>>
>>>>>>                leds {
>>>>>>                    #address-cells = <1>;
>>>>>>                    #size-cells = <0>;
>>>>>>                    led@0 {
>>>>>>                        reg = <0>;
>>>>>>                        label = "ssd0:green";
>>>>>>                        default-state = "on";
>>>>>>                    };
>>>>>>                    led@1 {
>>>>>>                        reg = <1>;
>>>>>>                        label = "ssd1:green";
>>>>>>                        default-state = "on";
>>>>>>                    };
>>>>>>                };
>>>>>>            };
>>>>>>        };
>>>>>
>>>>> Where is the DT binding document for this?
>> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml?h=for-mfd-next
> 
> You need to update it.  It is different to the one you supplied here.
Ack.
> 
>>>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>>> ...
>>>>>> Changes in V5:
>>>>>> - Update commit message
>>>>>> - Fix comments
>>>>>> - Add necessary new line
>>>>>> Changes in V4:
>>>>>> - Remove unwanted preinitialise
>>>>>> - Remove unneeded line breaks
>>>>>> - Fix variable name to avoid confusion
>>>>>> - Update module description to mention LED driver.
>>>>>> Changes in V3:
>>>>>> - Remove of_node_put as its handled by for loop
>>>>>> - Print error if an LED fails to register.
>>>>>> - Update driver name in Kconfig description
>>>>>> - Remove unneeded variable assignment
>>>>>> - Use devm_led_classdev_register to reget led
>>>>>> Changes in V2:
>>>>>> - Fix regmap update
>>>>>> - Remove devm_kfree
>>>>>> - Remove default-state
>>>>>> - Add example dts in commit message
>>>>>> - Fix whitespace in Kconfig
>>>>>> - Fix comment
>>>>>> ---
>>>>>>     drivers/leds/Kconfig        |  11 ++++
>>>>>>     drivers/leds/Makefile       |   1 +
>>>>>>     drivers/leds/leds-max597x.c | 115 ++++++++++++++++++++++++++++++++++++
>>>>>>     3 files changed, 127 insertions(+)
>>>>>>     create mode 100644 drivers/leds/leds-max597x.c
> 
> [...]
> 
>>>>> +	led_node = of_get_child_by_name(np, "leds");
>>>>>> +	if (!led_node)
>>>>>> +		return -ENODEV;
>>>
>>> It's odd for a device to be referring to itself as the "child".
>> As this is leaf driver, LED specific info is present in "leds" node in DT.
> 
> I'm aware of the architecture.
> 
> If you give the LEDs driver it's own compatible you don't need to keep
> doing this self->parent->child level-jumping craziness to obtain
> resources.
 From my understanding, it is preferable to have only one compatible per 
chip(in this case MFD driver), and the leaf driver can leverage it 
unless it is not serving the purpose/breaks something.
I think this is acceptable as long as it doesn't creates any 
issue/breaks anything.
> 


Regards,
Naresh
