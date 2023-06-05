Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89B8722901
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjFEOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjFEOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:39:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7246FA6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:39:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso41244015e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685975965; x=1688567965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fm6omFP2aCod8XtHm5L9yMfAAfEAX4qQM59CrdBf6A4=;
        b=RMH5yFvFB0L/bXyqSylorgHfQYaSpe5UFg3pbVvpMOsYNLI+duwnbm4E/mAvX75tff
         pftEb/5lY+zanSgbOgffu9KDhISS58D8Xzemn47sA6Q2fqNB/zT7GhuayAIJ04hgumfb
         8hkcYIkG+zOleWLy2rc1b3Gda2R/6i9NZ9VIh66Oir26xsZEdC5BxsaywJ7Ma9YRl5kK
         vl/J2WNI6h+e4m3szVQJcin+zCaQYog6iyf8jn0GOsw+Nbd7lLfuyRn6YZ5Z8Qh4gOtt
         qfwpfL/HDDZE7drv2hGb4s5QnTyB1oQelYwLG9VaI2suY8m/wNeNqCM7IbbYsBmNcSAg
         ppQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975965; x=1688567965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm6omFP2aCod8XtHm5L9yMfAAfEAX4qQM59CrdBf6A4=;
        b=E3vPoJ9m8kWjsTn9xBRT9IkACXlshNiTyEtNjGkcYRcc+2a5Rw4tF5NOCtuArETuzD
         JwX2PQORFCtUBq30MIoUPLMGdPGG3Q7tFKUaqx1eBMMqjhco2u2x/Rv1vTRed/nCUV8Z
         tPcCJvXhwPTc0u86qYxWyYRk0ubyIpUA72/wCShxnvPzlA2mPI6SGxp9QKWHq1FC0f4K
         E2fvGEoR0uVOLM9awwqEwIILm5h8dVPVog/HSS1woisv6nBCnNnArZZWDsYBY+s9/HuU
         cAjBZNPojq91yM1EA5zKdSFFV6wu7FoaoOLC+Df8FXRfdXzcdXEClJZ25MFrVaO3Bpwv
         GtGQ==
X-Gm-Message-State: AC+VfDzxco7tB0FQwkFJd4o2tZ8E8xxFBSLPBCB8wJobKs+GxUo6JrUk
        U1D+fdcXPh5ghA5K64f6Y1LcjA==
X-Google-Smtp-Source: ACHHUZ7Qw6Z8nNf0J0a233uM9vzNDjf3b+Y4VTNAP90U+Djmy4CPnjwmIeGuRE/YDnhaRXFeMoTCcQ==
X-Received: by 2002:a05:600c:2947:b0:3f7:3074:d2f2 with SMTP id n7-20020a05600c294700b003f73074d2f2mr3626394wmd.34.1685975964911;
        Mon, 05 Jun 2023 07:39:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2385:9257:ace1:1efc? ([2a05:6e02:1041:c10:2385:9257:ace1:1efc])
        by smtp.googlemail.com with ESMTPSA id c4-20020a5d4144000000b0030ade1b9400sm9960903wrq.30.2023.06.05.07.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 07:39:24 -0700 (PDT)
Message-ID: <4097223e-5297-1536-18bb-512ef28c8329@linaro.org>
Date:   Mon, 5 Jun 2023 16:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/6] thermal/drivers/qcom/tsens-v0_1: Add support for
 MSM8226
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-4-matti.lehtimaki@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230507201225.89694-4-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 22:12, Matti Lehtimäki wrote:
> The MSM8226 TSENS IP has 6 thermal sensors in a TSENS v0.1 block.
> The thermal sensors use non-standard slope values.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

