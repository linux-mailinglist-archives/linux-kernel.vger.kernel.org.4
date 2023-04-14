Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA06E266A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDNPHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:07:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635F19B7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:07:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o29so6767081wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681484821; x=1684076821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5G4acQ0YYxhQvYnJSv+B5dVG1vy5noU+wXB8XCEGhs=;
        b=xpW2qXtILthIrOadnsYwrhnn5SOUqlrhF+0hm97rQFBEOaO8efbMhQa06KjMS0erLm
         bqqmi4B9lUNp+Vr7RTiADB8yKqvH+whmimfkPBP0WoJ2Qo6zaWCZMITv9/MAqak8kr4a
         oWGYckWz609NEkxDwmNYM2//INiFr1mhCbe8Zz9PjGzSQRQE6q16UZj5YtVcXHXQucMw
         rxMcNBvfSM2KbDXaggbENyuq3STprcbTsdUlhzhDMbcJfa2DiiP6ju9ph5y/gEf9PIFN
         gjaDiWT8+qgizLjIqnaQI22xDfZhUmbRxAPmSYwhxn5EnSOmil7vLblbF9MQi5L1yX0r
         4Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681484821; x=1684076821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5G4acQ0YYxhQvYnJSv+B5dVG1vy5noU+wXB8XCEGhs=;
        b=fa45l5Sfrnj7mkdMNy57l5MtvXu23gYG7wNzsIVx75qDpvtJ2vOQz72PZwZY4eOo9B
         lXUZxNYmz/n1OHeRF0RsywDebUHz4v64M9PI/dB6hS0R819J4kS64YQtJLrX0P6KrmmH
         0jLelCJfdv0dLCqmAMnBGkFh5neFHrvOjSgYO9/cu/VmSkmejvdS/SPyJBSwymnea/Jr
         j25hsa0zXzSL0j+PKzVyoJEOAf7ZrirOYQFGmahVyKsDqC00k+JMgTt5etuQayUiLchz
         PxSIvxPpKINxdZFLRKO/MBEA+N1izYxJdsWc3Z99tySB3dZvQStLZWwzr/KfeztDju2r
         s9lg==
X-Gm-Message-State: AAQBX9djUT81it54HFirBKwBYvaioWB6cF24ffPZTue7oXkoIBVqUzWv
        XqfH4hRIMr7RerFpNP1nYSPhSw==
X-Google-Smtp-Source: AKy350Y3gDuNVPCX5TuJ6d74iqJqYpE2/bT5MRXOpciGEnoDcvv5+ZoaOBAph412EfPOLrbKItbQnQ==
X-Received: by 2002:adf:ee87:0:b0:2ef:b8d1:9560 with SMTP id b7-20020adfee87000000b002efb8d19560mr4999490wro.30.1681484820527;
        Fri, 14 Apr 2023 08:07:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7529:f7da:b8df:f1dd? ([2a05:6e02:1041:c10:7529:f7da:b8df:f1dd])
        by smtp.googlemail.com with ESMTPSA id g12-20020adffc8c000000b002f79ea6746asm754650wrr.94.2023.04.14.08.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:07:00 -0700 (PDT)
Message-ID: <ce9b3b01-e496-9e02-5583-41893b7154c7@linaro.org>
Date:   Fri, 14 Apr 2023 17:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Di Shen <di.shen@unisoc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org,
        Di Shen <cindygm567@gmail.com>
References: <20230320095620.7480-1-di.shen@unisoc.com>
 <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
 <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
 <CAHYJL4rnfVp+X3imbxWzUd9ixTFAPe4ioLyi-t50PwhL0y5v8A@mail.gmail.com>
 <da59b4ef-1532-1b3a-7a73-9a095d8c9390@linaro.org>
 <CAHYJL4qJwKHFsCPUvLzmUEAJtEfHDAO23D5=0zAXOYSCABJ8_g@mail.gmail.com>
 <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <e31da1fa-168d-9a85-cdb3-66192d887d83@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e31da1fa-168d-9a85-cdb3-66192d887d83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 16:18, Lukasz Luba wrote:
> 
> 
> On 4/14/23 12:12, Daniel Lezcano wrote:
>> On 13/04/2023 10:40, Di Shen wrote:
>>> We have discussed this question in patch-v1:
>>> https://lore.kernel.org/all/f6aaa5f1-495d-a158-14d8-ddb2bffbd9c2@arm.com/
>>>
>>> Simply put, we use the trip_temp in the Android System; set different
>>> trip_temp for thermal control of different scenarios.
>>
>> The changes are dealing with the trip points and trying to detect the 
>> threshold. That part should be handled in the thermal core or thermal 
>> trip side, not in the governor.
>>
>> AFAICT, if a trip point is changed, then the power allocator should be 
>> reset, including the cdev state.
>>
>> It would be more convenient to add an ops to the governor ops 
>> structure to reset the governor and then call it when a trip point is 
>> changed in thermal_zone_set_trip()
>>
>>
> 
> Sounds reasonable to have a proper API and fwk handling this corner
> case scenario.
> Although, if there is a need for a 'easy-to-backport' fix for IPA only,
> I agree with this patch, since it's straight forward to put in some
> Android kernel. We can later fix the framework to handle this properly.
> Anyway, both ways are OK to me.

Unfortunately, we can not do the maintenance of the Linux kernel based 
on an 'easy-to-backport' policy to Android.

This patch could be applied from-list to Android as a hotfix. But for 
Linux the fix should be more elaborated. One solution is to add a 
'reset' ops and call it from the trip point update function.

Did you double check the issue is not impacting the other governors too ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

