Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5369E5F45D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJDOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJDOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:43:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D4D1EADB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:43:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so317218wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQpwdWBVfGvNqGlsQv8V0gxUPQGB3BlZHYdPUarfDzI=;
        b=XL4FJfToQAvuTIQDtm/aK99Xv0bfVcCbVHRtsUcWDtZ1cfaqc1Uxpjg7uWaSmvfrpu
         CMWak4XX3TTRrWJmvBPfLoCTZjTqge3bQY9Gk3yrDQpeS0ZfPomnxd/7plagloxpNL+C
         Q5qSPFbmyaNwp+Z9GUvvglc23ZqxwYkyBNLg6ea+lywQq4QUK0ErJ2Hx2qaAKKSdK2kc
         sqyIDwR4fbEq2yriLXrbwb70DbEPDXvQdAJ7cy4ELXOYByZR3TIZ1R+CysltY6RTMC1C
         Qnbcf6TPstuY6NR9qvjPdgAWbwrMN6GjRNYaYstTEnPOfwylTeqUafRpAM7axjAIyasG
         nbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQpwdWBVfGvNqGlsQv8V0gxUPQGB3BlZHYdPUarfDzI=;
        b=tvSfgahiYcgRzfyFpBcis7FSwAwBba1HxNJ6BmXgGHcydOtTCPENkjVjRhcKqdblXI
         1TsNO80wk68EziWKQw2qcgI5QdcypSPEK1nwKVVZW4PKobhdMNgNpYe+fCOyzZm6A63i
         t/fCnxRS/FDoDGjEu1S1pstxVjQWGnCtAKS0BSTnNcyxJXdKa/kWvXoYRUGbcqI0wrmq
         cfxqe2WviM5R8BkRL3U5KCH5ypVITTwjkizIZUpaPhji7Tapu3ySbM/cSkJoc3EVwn0I
         O8tDG3ZwVFZPYDotX4OnB3HYM1UKR1HWbzAS0ExpwECgKWanpKLdbVutp1tqofixpTdu
         Pyag==
X-Gm-Message-State: ACrzQf25C6uYSYkuWycR+E8/fu+BKS89QeLEgNIWstwxavwXFdhMHfa2
        v44FTAAobTlSmrMyIZlQ5Sf/2Q==
X-Google-Smtp-Source: AMsMyM4CZfrhh7SeXg/rlI3rwchH+ZoY/XZDpry68XgSC0DOxdCGqnasy5kRDKy61ynkJYv61KJn6A==
X-Received: by 2002:a05:600c:a05:b0:3b9:cecc:9846 with SMTP id z5-20020a05600c0a0500b003b9cecc9846mr69013wmp.3.1664894609527;
        Tue, 04 Oct 2022 07:43:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id e16-20020a05600c2dd000b003a83ca67f73sm15191211wmh.3.2022.10.04.07.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:43:29 -0700 (PDT)
Message-ID: <088a8367-5ca4-674d-9d2f-411840d5a883@linaro.org>
Date:   Tue, 4 Oct 2022 16:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] thermal drivers for v6.1-rc1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <58a7d685-e9e9-e47a-1e20-41b18302e6a7@linaro.org>
 <CAJZ5v0iMkQNwWPBegwpsr+CTtaUr_Eq=_CsQG3QSwdWEmOmPCA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iMkQNwWPBegwpsr+CTtaUr_Eq=_CsQG3QSwdWEmOmPCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 16:36, Rafael J. Wysocki wrote:
> On Tue, Oct 4, 2022 at 11:41 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> this is a pull request for more thermal material for v6.1. I've dropped
>> the trip point rework as a lock issue has been spotted on exynos.
>>
>> Most of the changes are fixes. There are more pending changes for the
>> thermal drivers on the mailing list but they require some more review,
>> so they will have to wait for v6.2
>>
>> Thanks
>>     -- Daniel
>>
>> The following changes since commit 2e70ea7fb9873e642982f166bf9aaa4a6206fbec:
>>
>>     Merge branches 'thermal-intel' and 'thermal-drivers' (2022-10-03
>> 20:43:32 +0200)
>>
>> are available in the Git repository at:
>>
>>     ssh://git@git.linaro.org/people/daniel.lezcano/linux.git
>> tags/thermal-v6.1-rc1-2
> 
> I don't think I can pull over SSH from a host where I don't have an account.
> 
> Did you mean git.kernel.org?

Yes, indeed :)

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tag/?h=thermal-v6.1-rc1-2

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
