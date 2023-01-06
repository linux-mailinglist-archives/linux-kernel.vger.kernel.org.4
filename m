Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE4D6602AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjAFOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjAFOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:53:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5CA831AC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:53:02 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bs20so1484807wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fb113jvJzDpaLqkQd+chLk6YPOzvbAerk9emcElPRW8=;
        b=B9roCgNZ3+rIt6kkae9X8ldsFIGgC5Y/LAJrfN6RaNxbpKJwarDRvWjcsthOsW5+Bq
         CZVLxCmGkTzXy4WZW2gayuF1H0oWfNyb/fmrCE0YkIupIyvB8spgVEi2Ryh6/t/qWuXj
         cw2vs9mA0ucXzSA1iYpvpqf81mMRBudFtUvjDpQcfAwAselfjEIYq+oML/OV1Q3dArKD
         qZnwPFhsX37pAhhQBulKY4z3CyDONPfL1lSj/xxuOQgmI3JRjkw7+8n19V7AMhjqnQt4
         +2PAfu2Cx7XXebcWFMLl5763smmXHnTxqLChksC3PYTkBGlwBOlBI32eUOD8Pqd/UAMs
         aP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb113jvJzDpaLqkQd+chLk6YPOzvbAerk9emcElPRW8=;
        b=P32wy1UU408LzNV0ZFCUl7yChvk38g3/R85hC643PkyH2d+SvlwAU1cwoObJId23kE
         oba7f3sDLebj6Kb79DNG0OYUz5LWgZZDwP3GTZpVOiFayf8rpCsJcU5ClTU54vx/EMbO
         WA3y/rEzg5IuG/koVlJesRualkJ/op8Xt4uRygSi+TEGLguBqPpnyH400buOGflBDlDt
         dBTtTJGnk5aEm3Q3AfQkDcl4GlmaeJEZXqP8YS1jm5t3zUGqzlFKUmz7YYzTEgnKx0Iu
         Zw6fn/YukyRGO6cwbvmN4cduBpbPSdPYruWQ9Mb6HbLMxJ5H9qGuibGNSrAsIfbzrwVa
         4ikA==
X-Gm-Message-State: AFqh2koSKWnv0pTzZggqf34/S4nVOd7jAmyjS44xhl59qv9q4jHJ2y4j
        5mlXfi5+5P+AqNJa6qY0tyR98Q==
X-Google-Smtp-Source: AMrXdXvv0m7kio2W55PZZW8SweXh/614tgLKinx4xscU4tnyjQfdaGyNgovQo1p45Ysx0bmcjLxFfw==
X-Received: by 2002:a5d:5002:0:b0:28c:d89c:ae48 with SMTP id e2-20020a5d5002000000b0028cd89cae48mr18919200wrt.41.1673016780950;
        Fri, 06 Jan 2023 06:53:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b1-20020adf9b01000000b0028e55b44a99sm1322146wrc.17.2023.01.06.06.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:53:00 -0800 (PST)
Message-ID: <9771639f-5172-8f3b-3ce6-8fd195aa95b3@linaro.org>
Date:   Fri, 6 Jan 2023 15:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/5] PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
 <CAPDyKFrVjenwv0Fe36LBqML-R_w2TjoCwmbnqqOohV_1zH8vJQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFrVjenwv0Fe36LBqML-R_w2TjoCwmbnqqOohV_1zH8vJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 16:45, Ulf Hansson wrote:
> On Mon, 19 Dec 2022 at 16:15, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Realtime kernels with PREEMPT_RT must use raw_spinlock_t for domains
>> which are invoked from CPU idle (thus from atomic section).  Example is
>> cpuidle PSCI domain driver which itself is PREEMPT_RT safe, but is being
>> called as part of cpuidle.
> 
> Just so I don't get this wrong, since the cpuidle-psci also calls
> pm_runtime_* functions so it isn't PREEMPT_RT safe, at least not yet?

You are correct. Patch 3 here addresses it by... just not doing runtime
PM. This is a hacky workaround but:
1. I don't have any other idea,
2. It's not a big problem because RT systems are not supposed to have
any CPU idle (one of first things during RT system tuning is to disable
cpuidle).

> 
>>
>> Add a flag allowing a power domain provider to indicate it is RT safe.
>> The flag is supposed to be used with existing GENPD_FLAG_IRQ_SAFE.
>>
>> Cc: Adrien Thierry <athierry@redhat.com>
>> Cc: Brian Masney <bmasney@redhat.com>
>> Cc: linux-rt-users@vger.kernel.org
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> For genpd, overall, I think this looks like an okay approach to me.
> Although, let me check the whole series (I need some more time to do
> that) before I give this my blessing.

Sure, we are all have too many mails in inbox. :)

Best regards,
Krzysztof

