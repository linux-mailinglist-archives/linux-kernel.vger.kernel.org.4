Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0069F298
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjBVKWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBVKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:21:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D019A28D2F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:21:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id p8so7311185wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/j0BfnrCEhVdiOlio/nDMN6dumXmN70t4sL/nEbtGg=;
        b=GNmVNqegus0CkMHKZPlBIsyM8lqvJHnnghxp/kR0qt3wPYhVy7syqKVVpUbEuVSYHl
         h3ON4kUamqsUja0gB2puPO0PL8/riIyXemHSnZtXNzSvJGBvnwz5hNb+jzCDsrdpHNen
         Majnw0xt4GVNQi5SXv/j8nQj1+vZoM9HAxdO6cb1Q74BlBdmvFxlXYrPjKHhvmGDopJL
         5NR6lC9IFzNzqsxYOgtPulFZlcrHf8bYs3KuXCEXnP5cy/GQGI0zBOD3vhw1mwNhn0DD
         yqEEqElvmi0OsdBpOvCtKI3l2b0GyeFNJ92kCZ/pUxa7zvKuBr9KxPUGhii4g/73b1kZ
         xVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/j0BfnrCEhVdiOlio/nDMN6dumXmN70t4sL/nEbtGg=;
        b=FptBFBlWCHdFNBZVaN/KwctfpAz9aAZY/KNSsCvKvdBs1lO7JZI2hB37n6w8wuRgms
         JUqHfEQ8Fvj5vrB7DZ4V0Ry0VZgs2yjGfA+3m8ybjgMc94567+HBbuCi6tOHIQos5x3w
         nWCwW11h7jbV9GRidZtLIb+Xj1jNoxpj+8CLQwxQneBJQLeHmZTbz9M83hUNiDTeUVsB
         gMPR8/qBHeUPybgfWO6vZprlKhseRjpe/tKz1SvcAD/LuUIvqLRz5GfEwuedaxJX3fXv
         YyOoNntpUjLuyycCOdgVoZVsGKetolpuXb4fjGUE1jdMYkO+6HvmOd3R81MpsuakcWAZ
         fx8w==
X-Gm-Message-State: AO0yUKVbaULqIGYt9Vp2dWJ0qQ1hBmQuFqSCJ+SfUT4sfE2tg5mmWzIi
        vZL2qw2yhUmc45XbidjzbR0Qig==
X-Google-Smtp-Source: AK7set9mJGpo7aAMHeJCPmz7r3fDVsWDYZu57myyP0o6LfkR4NtiNQffpn1liMDoWlfe8foSFDc/Ow==
X-Received: by 2002:adf:fb4b:0:b0:2c5:85ef:980f with SMTP id c11-20020adffb4b000000b002c585ef980fmr5648878wrs.49.1677061316323;
        Wed, 22 Feb 2023 02:21:56 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m26-20020a7bca5a000000b003e20a6fd604sm6782962wml.4.2023.02.22.02.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 02:21:55 -0800 (PST)
Message-ID: <dea710b6-b627-08e9-3d26-d73e6be2e852@linaro.org>
Date:   Wed, 22 Feb 2023 10:21:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 15/26] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212448.3318756-1-quic_eberman@quicinc.com>
 <963d84e8-7b91-c278-1978-4e73d73f7c6f@linaro.org>
 <7aa025a1-b211-f04c-9169-236102fe27fe@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <7aa025a1-b211-f04c-9169-236102fe27fe@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/2023 21:22, Elliot Berman wrote:
> 
> 
> On 2/21/2023 6:51 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 14/02/2023 21:24, Elliot Berman wrote:
> [snip]
>>> +
>>> +static struct gunyah_rm_platform_ops *rm_platform_ops;
>>> +static DECLARE_RWSEM(rm_platform_ops_lock);
>>
>> Why do we need this read/write lock or this global rm_platform_ops 
>> here, AFAIU, there will be only one instance of platform_ops per 
>> platform.
>>
>> This should be a core part of the gunyah and its driver early setup, 
>> that should give us pretty much lock less behaviour.
>>
>> We should be able to determine by Hypervisor UUID that its on Qualcomm 
>> platform or not, during early gunyah setup which should help us setup 
>> the platfrom ops accordingly.
>>
>> This should also help cleanup some of the gunyah code that was added 
>> futher down in this patchset.
> 
> I'm guessing the direction to take is:
> 
>    config GUNYAH
>      select QCOM_SCM if ARCH_QCOM

This is how other kernel drivers use SCM.

> 
> and have vm_mgr call directly into qcom_scm driver if the UID matches?

Yes that is the plan, we could have these callbacks as part key data 
structure like struct gh_rm and update it at very early in setup stage 
based on UUID match.


> 
> We have an Android requirement to enable CONFIG_GUNYAH=y and 
> CONFIG_QCOM_SCM=m, but it wouldn't be possible with this design. The 

Am not sure how this will work, if gunyah for QCOM Platform is depended 
on SCM then there is no way that gunyah could be a inbuilt and make scm 
a module.

On the other hand with the existing design gunyah will not be functional 
until scm driver is loaded and platform hooks are registered. This 
runtime dependency design does not express the dependency correctly and 
the only way to know if gunyah is functional is keep trying which can 
only work after scm driver is probed.

This also raises the design question on how much of platform hooks 
dependency is captured at gunyah core and api level, with state of 
current code /dev/gunyah will be created even without platform hooks and 
let the userspace use it which then only fail at hyp call level.

Other issue with current design is, scm module can be unloaded under the 
hood leaving gunyah with NULL pointers to those platform hook functions. 
This is the kind of issues we could see if the dependency is not 
expressed from bottom up.

The current design is not really capturing the depended components 
accurately.

Considering platform hooks as a core resource to gunyah on Qualcomm 
platform is something that needs attention. If we can fix that then it 
might be doable to have QCOM_SCM=m and CONFIG_GUNYAH=y.


--srini
> platform hooks implementation allows GUNYAH and QCOM_SCM to be enabled 
> without setting lower bound of the other.
> 
> - Elliot
