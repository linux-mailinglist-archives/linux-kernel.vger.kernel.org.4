Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916674498C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGAOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGAOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:20:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D071FC0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 07:20:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so20540505e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688221212; x=1690813212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvAVVgJkmeA4hsydfmvG5kZr6g/WLMdVAO+gG1MB6IE=;
        b=hbVwVpLQ7okN8jl5JiOiVF9PGdz2A7jSY2udUcUwG+e6m2LOkY80CAdKlbYiPIwbRa
         OHMOhPLKVMceX8ek39BezmowNf9W6IuzzSXEqruWBQLxyJbeGmKkvOgaahWAB/bLKI7K
         Id3IX1QAVZ0hkIfw33867/5u57Kp57o2aFS4YmOBxV2erTXw+0yhQcyYDtnuhW8G+0L/
         5aGyvzaNrPhB9jxvbtQi40PQTwIF+0Fu5UHOod8vWTtYZVjazP5LZ1a7FccWX6PkKO0b
         aWcSPjrJ2VNrw3opC2fBDcTqgM9iPn5o6eZv85Y664OMAyF06zSeOFCq7nCyPxkmLxan
         i8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688221212; x=1690813212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvAVVgJkmeA4hsydfmvG5kZr6g/WLMdVAO+gG1MB6IE=;
        b=MdkuDFBnJNSYPlKgZbr4e3LzteXqZ1FRx3NbSexeNZiSEvYvILFMk/HOtPLUTdwLMT
         4UqC4wL2XZw2eKWWv2jmtyWsocJUQE/H0+tMEnQ22VAE1rG7yDxXc7PKKgPP6kshIRe3
         H3fQgZXzKidNAWi9ydZK4Wp8USafmHRfqJsV0s/yMRbb5PXwTgprwfEjsTlYS3Zz/fmK
         WOAh99iODJHc2Cxopk+bvXXR/sdBhimjDPjq7xr+M1eUQuL8ojezo0aqnNbALk4pqi6T
         NDfvJRWvKLP7bE/dyU5HxsSh2aGc44v/Q78fUbdMulDWGW/TACjnNjaVVNC3Ul0fdgCS
         f8vQ==
X-Gm-Message-State: AC+VfDyNK6ZyzL+81ORPnSpP3oI+iG8EO2l6k8XhMJjjD2ANKaInRiLd
        TPku4flWsP1aGSGmf5wx+kpHCg==
X-Google-Smtp-Source: ACHHUZ7AvvU8HSIWlyr+fMlByVzT11D6vdN/V6YHGjUK3ae6gLfOmZRSkmiaBQXkZGld6pMBBrBsJg==
X-Received: by 2002:a05:600c:2905:b0:3fb:ba04:6d57 with SMTP id i5-20020a05600c290500b003fbba046d57mr4419571wmd.5.1688221211966;
        Sat, 01 Jul 2023 07:20:11 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l17-20020a1c7911000000b003fbb9339b29sm7060737wme.42.2023.07.01.07.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 07:20:11 -0700 (PDT)
Message-ID: <a98b6393-8d59-6824-3505-975a458c4575@linaro.org>
Date:   Sat, 1 Jul 2023 16:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
 <ZJ+Do990LVNQx4rp@uf8f119305bce5e.ant.amazon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZJ+Do990LVNQx4rp@uf8f119305bce5e.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Eduardo,

On 01/07/2023 03:38, Eduardo Valentin wrote:
> Hey Daniel,
> 
> On Fri, Jun 30, 2023 at 12:11:25PM +0200, Daniel Lezcano wrote:
>>
>>
>>
>> Hi Rafael,
>>
>> On 30/06/2023 10:16, Rafael J. Wysocki wrote:
>>> On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:
>>
>> [ ... ]
>>
>>> So what about adding a new zone attribute that can be used to specify
>>> the preferred caching time for the temperature?
>>>
>>> That is, if the time interval between two consecutive updates of the
>>> cached temperature value is less than the value of the new attribute,
>>> the cached temperature value will be returned by "temp".  Otherwise,
>>> it will cause the sensor to be read and the value obtained from it
>>> will be returned to user space and cached.
>>>
>>> If the value of the new attribute is 0, everything will work as it
>>> does now (which will also need to be the default behavior).
>>
>> I'm still not convinced about the feature.
>>
>> Eduardo provided some numbers but they seem based on the characteristics
>> of the I2C, not to a real use case. Eduardo?
> 
> Why I2C is not a real use case?

What I meant is "I2C is slow, ok. But what is the setup where the 
problem arises?"


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

