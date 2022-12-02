Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB61640733
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiLBMzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiLBMzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:55:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FBCCD79A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:55:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so4236185wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8nwFAVUL+C7SWYVf0+J0zLwlgEn20ZWKm0zFPaEV4E=;
        b=MEDzrqZEbcqqTNFxSu5wqduzlckIso6QNl/IFc91rSwJ52Aj8gO7RmyWyTFixFHdZH
         i63+HSaszv/G+5ACzyx4j2339xQnCD2mYGy7IlvRCQzd59sLl1/eU6ILe2elCMRYAKmU
         DjODkIkDWEYP/5YnMn3DEkGMoa3ArqXBYmVTTdvVg0JHlWWp6ZZ4Hz8tFJLICEQNYVcD
         U3PUBDFBiO0L1mGza8g65Dd74mMk/8KC76ZgG5nA8EnrZMTdYT1hPpgsiDQQD37eXdKA
         ADcwFtTF3H4aberrfq3CZW8GPvOG8mwUVChOmCFbyq430UI8Wd23pMw1m1qDcDpsDjOg
         vg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8nwFAVUL+C7SWYVf0+J0zLwlgEn20ZWKm0zFPaEV4E=;
        b=BMTTGNl0C34+OiLvYJJvq3DP+sFAgAJ99xTHRHh3YZKqeBhfci5mPfZuBzTW9gKh7F
         6tQHHS9IXQcLgwQUThwlA9qNKRemNCT9nzCX1Lug+gsETr1dibVSH8z14peDY2UJYIZE
         dwywPvqZP7IClgARSSzAthu/2mJcZfSd2fSs+t4MibwkfXC06ymrHuWNhFnFSPzigLbZ
         YFvll+a/ojX/qgz6Lzj6EVoT+TwF5tJDsAUVlGMvAXLBwKpVUpi0M6GKI2cGSLJuK/Ni
         BlTzX9fCToxW3w251LY+Aj5dZQtv0L00mrFhL/tfIo+cUa2SH8tY0WitLqwhhdJd6IB9
         rnjQ==
X-Gm-Message-State: ANoB5pnCr9OD6421iJDYyHwbX7Uw3cYTFAJm9fV+zG3ANUhyigQBTQPp
        loBoN0I5DTZUpgpS1AZsHueCYw==
X-Google-Smtp-Source: AA0mqf4VHIt5cv8WRue9NTVVdmlQjzQ3tP5gESKG5joDWyze81xfScvNKmKbTvmeoIX47lG934ERhw==
X-Received: by 2002:a1c:f006:0:b0:3cf:ecd8:330d with SMTP id a6-20020a1cf006000000b003cfecd8330dmr41637139wmb.130.1669985737325;
        Fri, 02 Dec 2022 04:55:37 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r2-20020a056000014200b002422bc69111sm8657389wrx.9.2022.12.02.04.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:55:36 -0800 (PST)
Message-ID: <5f6dac1e-5d17-122c-5e52-1b15bff7630f@linaro.org>
Date:   Fri, 2 Dec 2022 13:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/4] hyper-v: Introduce TSC page for root partition
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dexuan Cui <decui@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        x86@kernel.org, mikelley@microsoft.com
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <Y3JIk6sW9lZ6UvC7@liuwe-devbox-debian-v2>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y3JIk6sW9lZ6UvC7@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 14:54, Wei Liu wrote:
> On Thu, Nov 03, 2022 at 05:58:43PM +0000, Stanislav Kinsburskii wrote:
>>
>> Stanislav Kinsburskiy (4):
>>        drivers/clocksource/hyper-v: Introduce a pointer to TSC page
>>        drivers/clocksource/hyper-v: Introduce TSC PFN getter
>>        drivers/clocksource/hyper-v: Use TSC PFN getter to map vvar page
>>        drivers/clocksource/hyper-v: Add TSC page support for root partition
> 
> Applied to hyeprv-next. Thanks.

The series should have go through the clocksource/timer tree or at least 
should have specified the targeted tree for an Acked-by from the 
clocksource maintainers.

In the future, please follow the process

That said,

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

