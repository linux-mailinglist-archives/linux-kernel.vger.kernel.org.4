Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF266E15D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjAQOzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjAQOz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:55:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003493E611
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:55:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t5so26442032wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjMtAXp2Uc3jN3Go7h+qhiCgrFMAwcAe7Z4E0GtlCSM=;
        b=BdY5EhD6G8agOvC/8vCZdAsg3KPQLQ4M2YNzYM+7VGY6pcVI9FpW1WorCzDU3t5Utr
         aVYMl/9kcCoJ4P2hPokaEfmV9dBVQx8FhMMmRRNHEkwL2GgfEbkdmu3FG+7incjQbOnY
         7oxu9AuHpWWkprTj7ppvV1fJ56wZBvwcSGbAfcNvkcKUvrwVl+9V40WRNQd3W2qkGlNw
         71qWE4ebOdPw6oyqZo5MtQJ+7a9UTYAC+xac/LlQXSHMZ9hx6QQNBvt0caQ1n5zRkidz
         6Lk1pSSafb4HsqyuMMBMMHJvoHbTprbYIKDGIYAI+9r1zI67SVVPT2Q1EfZnLT7FBC6+
         SNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjMtAXp2Uc3jN3Go7h+qhiCgrFMAwcAe7Z4E0GtlCSM=;
        b=4R40GFaYvIqjGt+ufq7xPzvxxoa+QJWOQUyU5pxyY2OWMvY9PmWEohQ3DZL5hPrRbw
         WtjjeSN3OG+jkDYmNGRDbTYkmnPNWEuCmdJkkgvf8TiWrfi7xWszAjHHxzNzQJ520NLN
         wYzRT7IQ+GemhBaTyyStKgKWx/9jTy/yrb0gUvnfzMUCGmzBG+855q2M282uxFL69iA9
         usAq+76jwIdQHOJvA9mup5x2cjqH7XF8XpE46HQeukcMQ1eckTNAoQkL8SAwy44pAkaJ
         umnuES3n6OOKv9+Kc6gg65rNdLXJkNU3Ozsw3dp5/waPsIVPZAViTDkeRkMLk/PLTtPl
         YOsA==
X-Gm-Message-State: AFqh2kreG6mOx/j5CkuN91oe0TLRfUyYfzpvV1eAdRjGXzW0i0TUPInG
        Kf/UM1OWEZRaypTWyZ8oFmBZWw==
X-Google-Smtp-Source: AMrXdXuoEADPFwOeSMK8QvjN9Hg1La2fYgyMSdFzwnANd3I94nHWan6AsHFlQnxaAaTANxTfLyzpTg==
X-Received: by 2002:a05:6000:71d:b0:2bb:f4bf:e758 with SMTP id bs29-20020a056000071d00b002bbf4bfe758mr3459801wrb.48.1673967325481;
        Tue, 17 Jan 2023 06:55:25 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n6-20020adfe786000000b002bdbde1d3absm18853433wrm.78.2023.01.17.06.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 06:55:25 -0800 (PST)
Message-ID: <1e3d8fba-b706-6b4e-2a19-c150ee85d152@linaro.org>
Date:   Tue, 17 Jan 2023 15:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/4] thermal/drivers/intel_powerclamp: Use powercap
 idle-inject framework
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
 <20230117020742.2760307-4-srinivas.pandruvada@linux.intel.com>
 <e2b1b18a-26c7-1a45-bad1-4233024062eb@linaro.org>
 <CAJZ5v0h5uu5UWyzTJV=RPdoyEB41-dBheOy4C05tVXpKinZtvQ@mail.gmail.com>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h5uu5UWyzTJV=RPdoyEB41-dBheOy4C05tVXpKinZtvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 15:49, Rafael J. Wysocki wrote:
> On Tue, Jan 17, 2023 at 12:16 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 17/01/2023 03:07, Srinivas Pandruvada wrote:
>>
>> [ ... ]
>>
>>> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
>>> index f0c845679250..6c2a95f41c81 100644
>>> --- a/drivers/thermal/intel/Kconfig
>>> +++ b/drivers/thermal/intel/Kconfig
>>> @@ -3,6 +3,8 @@ config INTEL_POWERCLAMP
>>>        tristate "Intel PowerClamp idle injection driver"
>>>        depends on X86
>>>        depends on CPU_SUP_INTEL
>>> +     select POWERCAP
>>> +     select IDLE_INJECT
>>
>> Just a question, not a comment. As IDLE_INJECT depends on POWERCAP, is
>> it necessary to select POWERCAP also here ?
> 
> Yes, it is.
> 
> If IDLE_INJECT alone is selected, POWERCAP may not be and there will
> be a broken dependency.

Ok, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

