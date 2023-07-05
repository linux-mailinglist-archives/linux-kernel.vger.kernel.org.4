Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0E2748254
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGEKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGEKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:41:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80324E63
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:41:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3143493728dso3796937f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688553672; x=1691145672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88goqqosTuFo/x96Kg4wKBh8UXMAznfyTlC2iZi5QZg=;
        b=VWkK2Ls2GShcm8rjv2v4WGq3q+Yhov40dgVPs4iOOhOnljFDm7SmgcHcSAka0mLq6h
         p3wmGmMd0SHzs19gR2JqgfVjUxu7X2keQXIO5NW2EXOZztzo2zoa8H3r0cd/HywQ22JS
         OqlHzCzuzmFNUS6KQwIpDLU0NqMtGvPWy6kIYGPmkC4KDQHaWREDZ8a+oytBqWj8JyNx
         jJdCfGV56ycJEtHOZRncxijPLU4+gDRuKqSGawmMkk/W9Pr8yYl1U/n91rsXgZEuSAw9
         vDCbgXqMTVouFfXXMarLmrK3W/p7+ASjMRb6rHssrqCWhBBGDQHn9YDquveE1QMbPfPV
         aHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688553672; x=1691145672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88goqqosTuFo/x96Kg4wKBh8UXMAznfyTlC2iZi5QZg=;
        b=iOabCiJcNi2yVAMBxi/mstTQp7rtwloCwmM1ATAPfqoADvsde5mKHxEzPUvP1wjNzA
         S/y0gRz70ITW6m1Ldv8XB5AXiEnEHFtY9YiheTf4MNKVKbqHIUdkVPcIbPO/Ce+qs/YD
         XvLc1+0uVEaYOFpVOX/lU2ar8BbbS6QFBZAERCi1t1cZQxYMsZHNdwwTq0hBKMnEHSgi
         JAhpH4ZVD6ro1BhFZrjxJerMNeNczE92lh4AUobJsOgUGkF8KGXP5N8aM3YxTaEYFfgD
         D+bzz7g0Zd+IHWDMKwUs/zVx1MmFhrymAt8Q7MUO33cyXUZzq9Z31RKTUjSkoSR/4uVi
         m63A==
X-Gm-Message-State: ABy/qLauVpqw5s6A1Uxtt49hwFipGmTTstQAYNUHxi7uv0uYyTP1qqKr
        Se3v7noW6owTmxiZEAnbX1FMhQ==
X-Google-Smtp-Source: APBJJlF76X3ficyDs1/4Q++zss6/LXS7miOrOFC/V/Zbqi6qGsAVh719iwSI3BQ0uT/myXy+ikVTcA==
X-Received: by 2002:a5d:4a47:0:b0:314:1096:ed2f with SMTP id v7-20020a5d4a47000000b003141096ed2fmr14313429wrs.35.1688553671880;
        Wed, 05 Jul 2023 03:41:11 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l12-20020a5d668c000000b003143ac73fd0sm6364914wru.1.2023.07.05.03.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 03:41:11 -0700 (PDT)
Message-ID: <77c90891-3712-4b3b-a22c-d9ccba36f58e@linaro.org>
Date:   Wed, 5 Jul 2023 12:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/8] thermal/drivers/int3400: Use thermal zone device
 wrappers
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>, rafael@kernel.org
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
 <20230525140135.3589917-6-daniel.lezcano@linaro.org>
 <ab892878-9c66-f94f-cf4c-9961723411d2@linaro.org>
 <74c232550c6787ef34ddac67a61339e6c028fb0d.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <74c232550c6787ef34ddac67a61339e6c028fb0d.camel@linux.intel.com>
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


Hi Srinivas,

thanks for your answer. What about the patch 6?


On 03/07/2023 18:15, srinivas pandruvada wrote:
> Hi Daniel,
> 
> On Mon, 2023-07-03 at 12:49 +0200, Daniel Lezcano wrote:
>>
>> Hi Srinivas,
>>
>> do you agree with the changes in patches 5 and 6 ?
>>
>> Thanks
>>
>>     -- Daniel
>>
>>
>> On 25/05/2023 16:01, Daniel Lezcano wrote:
>>> The driver is accessing the thermal zone device structure but the
>>> accessors are already existing and we want to consolidate the
>>> thermal
>>> core code by preventing accesses to the internals from the drivers.
>>>
>>> Let's use these accessors.
>>>
>>> On the other side, the code is getting directly the temperature
>>> from
>>> tz->temperature, but the temperature is a faked on, so we can
>>> replace
>>> this access by the fake temp and remove the thermal zone device
>>> structure access.
>>>
> May be something simple description like this will be enough.
> 
> "
> Use thermal core API to access thermal zone "type" field instead of
> directly using the structure field.
> While here, remove access to temperature field, as this driver is
> reporting fake temperature, which can be replaced with
> INT3400_FAKE_TEMP. Also replace hardcoded 20C with INT3400_FAKE_TEMP.
> "
> 
> The change itself looks fine.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

