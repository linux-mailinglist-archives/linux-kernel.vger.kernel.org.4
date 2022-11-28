Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C9763A960
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiK1NWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiK1NWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:22:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59128D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:22:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w15so3569703wrl.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhbBkSDwHlHH0UHOowiGpYRjP/BNGJMJPMdWWSz42QA=;
        b=EZMk4j+gRD2su1lSk6Dh4S9SqMttrcFzvzp9NR9iWKg/GupbxWVHAKbaPtPSgn3OcI
         6aLMwIBBXns41LSIjx1RWLxO4olVj1ZkDfGjtmObxICMcZC7ZRHONQ3fWoMtYbuDTTII
         L5OIOujdPiLSG/obZxOLbiD4UwmjeLxHHdVMuTEmx0+BDGnfwAVa6K4unqAE95N+oSfF
         92WdCpdh6xkxdHo9TeyUw75tu5wM3bFrMaj905mPkBhk5wO8q6oagHJfP1t0KNu0NrIV
         UoCL6aIRSZ4awWKbeYQ3W3VOtUlAuhfYeDwmuK5522CleGCGRSQZugqOK2BEaK6LsYjn
         Dnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhbBkSDwHlHH0UHOowiGpYRjP/BNGJMJPMdWWSz42QA=;
        b=KU9B1V4bBQCfAdTQL3ewGKTjGn07Zom7hNbQ5yZ032Rd4N9FW8XjosengzJ+pTmCjN
         BgJHOrexqpdJ5PQDfhZ9yNHSAsPsylGs0uQvQkeMWULAR9krt7tcNmW3LqyZz3cinwGV
         lSDUlC57ZFK1rJvRvpjmX3GvkrvtiO6TIDI+KZnp4xkfzTq2PT/aiGnhAPvGK2yJn6Cr
         3Vn6xjSE9eHAmi1o1s7XNIJUaZY06S7agCYUazUWvA3A7dzBsmGsQwuYReKkVePt+Q5u
         hpL9lfF+PElYCrw0z/pxMXQumaOX2/EoYi3CFYSl41JtOFw5MN0cJgYHfxha3oJfOtVD
         I1yg==
X-Gm-Message-State: ANoB5pkkYG/foPtFKIpp2U52Pf3f/7wn5dlMPokvyzGbiYeq2eUnsBWi
        4OkTdJbiTs2gb4LHFdR9JqerGg==
X-Google-Smtp-Source: AA0mqf58w/DEZHxUShQzoxCSVQ5SqSh3D2w7q07+UqmlSkpj2RaT0tdephhSMxffxuUJvs3wQHDcDA==
X-Received: by 2002:a05:6000:1181:b0:22e:53c0:ead8 with SMTP id g1-20020a056000118100b0022e53c0ead8mr31469890wrx.210.1669641749766;
        Mon, 28 Nov 2022 05:22:29 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id iv19-20020a05600c549300b003cf87623c16sm21303856wmb.4.2022.11.28.05.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:22:29 -0800 (PST)
Message-ID: <9ac3a182-fc30-0834-8555-a4ec334531ae@linaro.org>
Date:   Mon, 28 Nov 2022 14:22:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rafael@kernel.org
References: <20221117122904.6759427e@canb.auug.org.au>
 <20221128102212.39f90b0c@canb.auug.org.au>
 <1a60d0b2-c020-4fce-d7f2-3534c9e14c84@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1a60d0b2-c020-4fce-d7f2-3534c9e14c84@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 28/11/2022 13:51, Rafael J. Wysocki wrote:
> Hi Stephen,
> 
> On 11/28/2022 12:22 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> On Thu, 17 Nov 2022 12:29:04 +1100 Stephen Rothwell 
>> <sfr@canb.auug.org.au> wrote:
>>> Today's linux-next merge of the thermal tree got a conflict in:
>>>
>>>    drivers/thermal/thermal_sysfs.c
>>>
>>> between commit:
>>>
>>>    05eeee2b51b4 ("thermal/core: Protect sysfs accesses to thermal 
>>> operations with thermal zone mutex")
>>>
>>> from the pm tree and commits:
>>>
>>>    dca20ad5acb7 ("thermal/core: Add a generic thermal_zone_get_trip() 
>>> function")
>>>    aed8b46d141c ("thermal/core: Add a generic thermal_zone_set_trip() 
>>> function")
>>>
>>> from the thermal tree.
>>>
>>> This was just too painful to fix up, so please fix it yourselves or
>>> supply me with a resolution.
>>>
>>> I have dropped the thermal tree for today.
>> I am still not merging the thermal tree ...
>>
> Sorry about this, but I cannot fix it myself and Daniel is on an 
> extended leave.
> 
> Can you just drop it permanently from linux-next and we'll sort this out 
> when Daniel is back?

Yes sorry for that, I'll go back in a couple of days and sort this out




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

