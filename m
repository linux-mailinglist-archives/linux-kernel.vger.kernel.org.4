Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2CC653DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiLVJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiLVJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:50:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDE7291
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:50:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so845518wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BC96UXa/60GmNBDXzBupjKc3kOL06fUzjxmrqDhVx4=;
        b=qgKpVLT7FFLz34qr7khgYH88j38xzgB5SvPDQm9BYUgiN1en1xlQgNZ1nzyehdl0lo
         +eJXuSMsYuGh+1iWtsUyAnLEO/GKnerw70uHt850zJyIL00hy0LHoo2lB9jSC7uSgQxI
         gy5cbmfB4lZ8UBlzrNqGnvJVJyk9Qiy2ZVj88QMjdIA6S56f/wuRjuMFad8fMuseuhgH
         +hae50VcJVjZCpPy/v8CGbCv8ayEVl6QIkD570PlaksT9vSuKONikyQePTLoC1+/C/aj
         y9LYGxgGjuI9jaMMWOWTP0IPY2ZO4zYZnNKoGvf0lV5Gc40Zfq9MwlwyKqhkMEfexu6j
         F85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BC96UXa/60GmNBDXzBupjKc3kOL06fUzjxmrqDhVx4=;
        b=jmDtUS97Xt9mxh8eG6FK26lr09tnyt0dh8U8RRxpIN97GMXBBSifVNnKvlZflCTTzZ
         jIh9+2rUV64TdVMG2fs7gDnmc9QBiGy/T0yuKXt2F4cdtL7bx8mZD9+nTnwAH48mjSg5
         TpRIhmXxrvUfbLMu4fBrxrNcwn1VJZd/Lnr4Ca8+CtZKiwZghxvwarZatKVsCrLqOofg
         ZKEsj3UW2oHJZbrS44Ol9pH9YWRekhQfC9cbJpi7+fjwXtbhPWbRiYfrSkUxdJkFj9AU
         tAH9GVfLrqODLeA0AHerqLbu+m6a8XsmmxQXirggBKwylcpYLosGycrvVqhLlmG7Zki6
         afvg==
X-Gm-Message-State: AFqh2kobNt1up3No0+M+O6Bty8Rz1f2gA7aO0VsyepfVp3VtdX9XFQ9M
        fxsNRzanECZtgfuBfWElCtqkCGjKM3SGE56E
X-Google-Smtp-Source: AMrXdXtBfgYtdNkmF7R3rHycwU/ToI8iv2d2tXc9e/OwzLrx9KqJ27aa8d2c7VE05cA4k7Nq8OdV3w==
X-Received: by 2002:a05:600c:3b1c:b0:3c6:e60f:3f66 with SMTP id m28-20020a05600c3b1c00b003c6e60f3f66mr3688758wms.29.1671702632298;
        Thu, 22 Dec 2022 01:50:32 -0800 (PST)
Received: from [192.168.175.23] ([37.167.112.50])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c468c00b003cf57329221sm2750992wmo.14.2022.12.22.01.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 01:50:31 -0800 (PST)
Message-ID: <de6a5000-260e-bb4a-31c4-a0cfe533fad4@linaro.org>
Date:   Thu, 22 Dec 2022 10:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/4] powercap: idle_inject: Add prepare/complete
 callbacks
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
 <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
 <e2af7a4b-99f4-f88e-fbe7-5d3595d6211b@linaro.org>
 <3e59c5216fad003f079224cd08a7da9b30f6365d.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3e59c5216fad003f079224cd08a7da9b30f6365d.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srinivas,


On 21/12/2022 21:58, srinivas pandruvada wrote:
> Hi Daniel,
> 
> On Wed, 2022-12-21 at 15:52 +0100, Daniel Lezcano wrote:
>>
>> Hi Srinivas,
>>
>> On 30/11/2022 00:34, Srinivas Pandruvada wrote:
>>> The actual idle percentage can be less than the desired because of
>>> interrupts. Since the objective for CPU Idle injection is for
>>> thermal
>>> control, there should be some way to compensate for lost idle
>>> percentage.
>>> Some architectures provide interface to get actual idle percent
>>> observed
>>> by the hardware. So, the idle percent can be adjusted using the
>>> hardware
>>> feedback. For example, Intel CPUs provides package idle counters,
>>> which
>>> is currently used by intel powerclamp driver to adjust idle time.
>> Can you provide an example in terms of timings?
>>
>> I'm not getting how 'prepare' would do by returning a positive value
>> to
>> skip the play_idle_precise() and what will do 'complete' ?
>>
> intel_powerclamp has a logic where if the current idle percentage
> observed from hardware is more than the desired target inject percent,
> it skips calling play_idle().
> 
> For example if you want to inject 50% idle and system is naturally idle
> for 60%, there is no use of calling play_idle in the idle injection
> framework to induce more idle. In this way a workload can run
> immediately.
> 
> So trying to emulate the same logic by using powercap/idle_inject
> framework. So prepare() callback in the intel_powerclamp driver calls
> the existing function to check if idle-inject should skip for this time
> or not.

The function 'prepare' has the 'cpu' parameter. How can it compare with 
the desired idle duration as this information is not passed to the 
callback ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

