Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7967C9DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbjAZL3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbjAZL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:29:10 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFDD5A36E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:29:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q8so905676wmo.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yi05t/VOBeL9Xnu+fJhCYB52XrFsP31dwzmjWFoL5Q=;
        b=Ax2jcixBK/8CdkhM78ZzsaWl52LrDZOyjm75jH8HJQl3kJaSlHtHPf75yb7Ggpy9Wd
         NsK0bTpk7zzLP4vYpTJvWaw88G1XrFxZuLATydC6iTfC5UFZQHueoW4c8Z1RB8UG9GPa
         ueM75Izo2kRRo/SsSKlDKlhNOxragGhdyq9ZF85GZXP77nap3zpNkIWnGeoYeKeuFNAW
         QrtC3UnlbWOPVRvAItmMnMV2hvcRGLbcURso/6caoqn8EB3c2g4xShq1dW8KSvsuCdhV
         9oeJORNbM65bUV9Nfbpl2bacMLvix24+vgvc0VzNoSTEDdITyVm+iz3uduriK6FHtrGq
         uniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yi05t/VOBeL9Xnu+fJhCYB52XrFsP31dwzmjWFoL5Q=;
        b=r36Sz5/KkQN4SSeGZzDgV1dkh+twmrqUfwyynxgjf5Ehjtf4t9QL5oT9PW5fuPOvzO
         Vk1FzNU99aJXJUMlKKOmm8jEOgeFiC1xBxmnE2NzXw8m81An/sgdrmFX1pQXusV72jdA
         705GqR0nCMGo4S4xD1nFWDsBewSSPrTzegTrRsSlCoduzkPXipc70yE7gH5eF+eQGYA1
         cgeLi423DUWcWp26Ce5/5MsOcP23Bgn7jO4WfN6JmxnWE1NAwooc1ltPY6yN/r7NQ6Ks
         yHyzVhEgCCN33BaJ0BFj98bxIGaIWPavG5KuF2d6YWZeoRG2Vffw/Ui6g8YyMh6Kklma
         MXTg==
X-Gm-Message-State: AFqh2krTb3JAy1S4R9FWB7zJShvMZsje8PFoIOzGNN2lT75CTtTKTKmV
        Ta6neGW4fCdhnxO34XHAPOYysg==
X-Google-Smtp-Source: AMrXdXswfmW2mpkE5sM92A2xT4BBBDbk6lGbM+Devvp/22M6OYHW0kKyI80AWcok45tkRMJWycpnMA==
X-Received: by 2002:a05:600c:539b:b0:3d9:f836:3728 with SMTP id hg27-20020a05600c539b00b003d9f8363728mr35701761wmb.11.1674732547775;
        Thu, 26 Jan 2023 03:29:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c180a00b003daf672a616sm1180102wmp.22.2023.01.26.03.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 03:29:07 -0800 (PST)
Message-ID: <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
Date:   Thu, 26 Jan 2023 12:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
Cc:     Li Chen <lchen@ambarella.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
 <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
 <87sffyhgvw.wl-me@linux.beauty>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87sffyhgvw.wl-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 14:40, Li Chen wrote:
> On Wed, 25 Jan 2023 20:14:16 +0800,
> 
> Hi Krzysztof,
> 
> Krzysztof Kozlowski wrote:
>>
>> On 25/01/2023 13:06, Li Chen wrote:
>>>>> Feel free to correct me if you think this
>>>>> is not a good idea.
>>>>
>>>> This is bad idea. Compatibles should be specific. Devices should not use
>>>> syscons to poke other registers, unless strictly necessary, but have
>>>> strictly defined MMIO address space and use it.
>>>
>>> Ok, I will convert syscon-based regmaps to SoC-specific compatibles and of_device_id->data.
>>>
>>> But I have three questions:
>>>
>>> 0. why syscon + offsets is a bad idea copared to specific compatibles?
>>
>> Specific compatibles are a requirement. They are needed to match device
>> in exact way, not some generic and unspecific. The same with every other
>> interface, it must be specific to allow only correct usage.
>>
>> It's of course different with generic fallbacks, but we do not talk
>> about them here...
>>
>>> 1. when would it be a good idea to use syscon in device tree?
>>
>> When your device needs to poke one or few registers from some
>> system-controller block.
>>
>>> 2. syscon VS reg, which is preferred in device tree?
>>
>> There is no such choice. Your DTS *must* describe the hardware. The
>> hardware description is for example clock controller which has its own
>> address space. If you now do not add clock controller's address space to
>> the clock controller, it is not a proper hardware description. The same
>> with every other property. If your device has interrupts, but you do not
>> add them, it is not correct description.
> 
> Got it. But Ambarella hardware design is kind of strange. I want to add mroe
> expalaination about why Ambarella's downstream kernel
> use so much syscon in device trees:
> 
> For most SoCs from other vendors, they have seperate address space regions
> for different peripherals, like
> axi address space A: ENET
> axi address space B: PCIe
> axi address space B: USB
> ...
> 
> Ambarella is somewhat **different**, its SoCs have two system controllers regions:
> RCT and scratchpad, take RCT for example:
> "The S6LM system software
> interacts with PLLs, PHYs and several other low-level hardware blocks using APB reset clock and test (RCT)
> registers with a system-layer application programming interface (API).
> This includes the setting of clock frequencies."
> 
> There are so many peripherals registers located inside RCT and scratchpad
> (like usb/phy, gpio, sd, dac, enet, rng), and some peripherals even have no their
> own modules for register definitions.

Then the syscon is the parent device of these peripherals and clocks.
You did not represent them as children but as siblings which does not
look correct.

> 
> So most time(for a peripheral driver), the only differences between different
> Ambarella SoCs are just the syscon(rct or scratchpad) offsets get changed.
> 
> I don't think such lazy hardware design is common in vendors other than ambarella.
> 
> If I switch to SoC-specific compatibles, 

This is independent topic. SoC-specific compatibles are a requirement
but it does not affect your device hierarchy.

> and remove these syscon from device tree,
> of_device_id->data may only contain system controller(rct or scratchpad) offset for many Ambarella drivers,
> and ioremap/devm_ioremap carefully.

I don't understand the problem. Neither the solution.

> 
> The question is: can upstream kernel accept such codes?
> 
> If yes, I will switch to SoC-specific compatibles and remove syscon without hesitation.

Sorry, none of your explanations here match your DTS. Your DTS clearly
models (for some reason there is no soc which makes even bigger confusion):

rct_syscon
clocks
 |-gclk-core
 |-gclk-ddr

but what you are saying is that there is no separate clock controller
device with its own IO address but these clocks are part of rct_syscon.
Then model it that way in DTS. The rct_syscon is then your clock
controller and all these fake gclk-core and gclk-ddr nodes should be gone.

Best regards,
Krzysztof

