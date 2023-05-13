Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C807013E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 04:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbjEMCHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 22:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEMCHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 22:07:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0EE103
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 19:07:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f450815d0bso42756125e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 19:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683943628; x=1686535628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ri6DfJJiXodRZE4XO0pCUcvs/5LQusUOoMEf7lrh9AQ=;
        b=wOd7tExQYofrH35omv+OsDMQMMKOvftHjJXWVYsapMHJGLUqBn8r/xt9bmt/eHciZn
         N1KNeMl6R7xy9gq39n8u1++Uz/vGjZ5O1jJGUQslNwUO2uGSlVUK9mdZmtQq54SFSXVm
         5pbpRmaaqWNafZX+S3432StDFVjsQl5I5u/+h+ceWh0OfgjRw7+D8yNwn/7+0Zp5AS1+
         GCCmHvDmO0Vhzc2PWtVvxQUSbRMiUcgFEgoud8uJaL2eejVcD6oPpByB2R+LQy0RHYdO
         wOGcq3uvSDb4To1hEDTIHk2UKVRqwzkQDUvGZZmthTGG9oiOzYiKK+Nsdn1zbXzhUj67
         suWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683943628; x=1686535628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri6DfJJiXodRZE4XO0pCUcvs/5LQusUOoMEf7lrh9AQ=;
        b=J41CVrOE15LDyjSqtBHVRjrfQ7WhM6X3wUqlokVUcAILm3KC7GtYXMrXJVWPZk0ZR/
         6sItErQ35ZavnTo+xux4QHiQ9VBjyfTSwr2Yjx5Jh8H5tjfK1L/KgyX9QLauQolo5NaI
         6TdVLhbZMdBEUlv19MLRLSqlDKBESaLSoHUHa8cPp/SE9WqyBpMnWaklj9m5NasSXb+n
         WIirEowvTGTDzCisag1kwXZeeDn6B7Hz2hV/nlCikHVVlj19l+cZUO7YoJ44CCaQU1l1
         siq/xQaNHM8PSiuKKIRIn3MIYtw1CXD5n/lTXuwqO3hfKUJ5yjN75G8Etu+99gUgw2wG
         AUvw==
X-Gm-Message-State: AC+VfDzeTBVciSzGkt156GS76qVuIFrS0koalTrUmW0Z/iAfblYWyKhd
        vDCASAV4OBQgiL4801XqqE+cIQ==
X-Google-Smtp-Source: ACHHUZ7kDK0x1ux72xu3F648weOC108BgVQ5USsBi69lf0rCEJA4C82rI2gNWUpO4uZtJsRyDCsRow==
X-Received: by 2002:a5d:510a:0:b0:304:79c1:725d with SMTP id s10-20020a5d510a000000b0030479c1725dmr18364830wrt.45.1683943627891;
        Fri, 12 May 2023 19:07:07 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b003012030a0c6sm24749701wrm.18.2023.05.12.19.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 19:07:07 -0700 (PDT)
Message-ID: <008030d3-386d-bed0-ad31-f06b27ba00c5@linaro.org>
Date:   Sat, 13 May 2023 02:07:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: power_supply cooling interface
To:     Pavel Machek <pavel@ucw.cz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <164f2458-fb66-f238-7143-bdbe1e200870@linaro.org>
 <ZF5t5BWqLLEvDdfz@localhost>
 <b1237581-3ece-a358-f1ba-7a3ebb08d8d2@linaro.org>
 <ZF59BS77uUpEZK6X@duo.ucw.cz>
Content-Language: en-US
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <ZF59BS77uUpEZK6X@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2023 17:53, Pavel Machek wrote:
> Hi!
> 
>>>> I've been working on a driver for the charger found in most Snapdragon
>>>> 845 phones (the OnePlus 6, SHIFT6mq, PocoPhone F1, etc). I wanted to
>>>> include support for the POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT
>>>> property.
>>>>
>>>> My understanding is that it exposes the current limit as a cooling
>>>> device so that userspace (or frameworks like DTPM) can optimise for
>>>> performance in a thermally constrained device by limiting the input
>>>> current and thus reducing the heat generated by the charger circuitry,
>>>> a similar idea was applied on the Pixel C:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4496d52b3430cb3c4c16d03cdd5f4ee97ad1241
>>>>
>>>> However, reading through the sysfs docs for cooling devices, and
>>>> looking at the implementation in power_supply_core.c, it seems like the
>>>> behavior here is wrong in a few ways:
>>>>   1. The values should scale from 0: no cooling to max_state: max
>>>> cooling, but the power_supply docs and the only existing implementation
>>>> (the smbb driver) just export the current_limit, such that increasing
>>>> cur_state would increase the current limit, not decrease it.
>>>>   2. (unsure?)The scale is completely different to most other cooling
>>>> devices, most cooling devices don't seem to have a max state much
>>>> beyond the double digits, but CHARGE_CONTROL_LIMIT is on the scale of
>>>> uA, so approaches like incrementing the cooling state by 1 don't really
>>>> work.
>>>
>>> Did this get solved somehow?
>>
>> Thanks for resurrecting the discussion.
>>
>>> Anyway, I am not sure mW will be useful here, as elsewhere it is mW
>>> thermal and here it is mW from charger. Most of that energy should be
>>> stored in battery, not converted to heat.
>>
>> I'm not sure to understand the comment. The question is about decreasing the
>> speed of the charge of the battery because the faster it charges the warmer
>> it gets. Doing a fast charge is ok, if the phone is for instance on a table
>> doing nothing. But if the environment is hot (a car, a pocket) or there are
>> other sources of heat on the phone like a game, the temperature of the
>> battery could be too high (or the skin temperature). In this case we have to
>> balance the heat contribution of the different components by reducing their
>> performances. The first knob to act on is to reduce the charge speed of the
>> battery by reducing the delivered power.
> 
> Understood.
> 
>> For that we need a connection between the thermal framework which monitors
>> the battery temperature and the power supply to reduce the charge speed when
>> it is too hot. This connection is the cooling device.
>>
>> The cooling devices have opaque values where the min and max cooling effect
>> vary depending on the implementation (eg. a fan 0/1, a LCD light 0/1023).
> 
> Aha, ok.
> 
>> Here the power supply has yet another unit (uA) to act on and difficult to
>> translate to a cooling device discrete numbers (that is my
>> understanding).
> 
> Well, if you can accept 1000 steps like you do for LCD, all you really
> need is maximum current and then stepping in 1/100 of that.
> 
>> With enough components in DTPM, it will be possible to create a generic
>> power cooling device using the unified unit uW with the powercap API.
> 
> I was trying to point out trouble with uW: you don't know them in case
> of battery charging.
> 
> You know phone is drawing 500mA @ close to 5V (-> 2.5W), but you don't
> really know how much is stored in battery, and how much is turned into
> heat.

You can know the thermal effect if the charger IC has a temperature
probe, and use time constant estimates to figure out the power losses.
> 
> But I guess you could approximate that somehow.

Also knowing the rough efficiency of the switching converter under the
circumstances (current limited? proportion of input current going to the
battery? voltage? battery voltage?)

I can attest to charging losses being a pretty significant heat source,
at least on the phones I've owned.

It gets tricky with phones that use charge pumps (e.g. OnePlus/Oppo VOOC
charging) to offload the thermal losses to the wall charger. Some
devices also have 2 or more battery cells, enabling them to be charged
in parallel for greater efficiency from a PD charger at 9V. My OnePlus 9
gets noticeably hotter when charging at 5V@3A compared to 9V@2A.

Most SDM845 devices use "parallel charging" with two discrete charger
ICs (one in the PMIC, one external i2c), effectively allowing for much
higher input current and much greater efficiency.

Can these be modeled well via DTPM? As I don't think the existing PSY
subsystem has a nice way to deal with this, and I don't think it's
sensible to offload all of that to userspace.

> 
> BR,								Pavel
> 
> -- People of Russia, stop Putin before his war on Ukraine
> escalates.

-- 
Kind Regards,
Caleb (they/them)
