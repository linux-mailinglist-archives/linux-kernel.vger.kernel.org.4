Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EE6D9862
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbjDFNh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjDFNhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:37:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31E6592
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:37:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso2900866wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680788239; x=1683380239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+7Vxj5+1fyXV+eL8nJ1Llc6H+CJnZCnvo68WEvf1qI=;
        b=TJL/x5c1pfmycsaSviHfZtegoePrkTASlCJMMCg/li1lF+BaSMe3uiAglxj4ZtbUiy
         dypJQFJ89PnTkF4zT9fh6+z/50PKwl5YpyOLTRPGK8pRJ3EWBOJRI7P7pe7Z+pvrEFXp
         giGsAjsl/SorHCZruP6mSos1JSh4dcJHkB4VqZ/sf5DF7dwNkzbTpDFEBTv63TkclszA
         eBJ96Wb5PDL7b8RxZH3YO25BZ424K8GIaVBRtrdxtLnLvu0OM9Pd2nO/txubgb5tfPdt
         uhE1bBcoekgH2ZFe0mX2gGVyPtecEpFIuLTzaKl3YulDqzV9ZryMY8TfT6voDMiFbu9a
         HWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788239; x=1683380239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+7Vxj5+1fyXV+eL8nJ1Llc6H+CJnZCnvo68WEvf1qI=;
        b=5jE6juwcc+ZP+3a4lpFae/fEGthE9i3Ocq7SYPIpX49cEgBLAVa4mDL04oyrYBHZrp
         JJpr87HyFT4ek4wbTyTD/0Cfs0Ho5NFt3vz61sif4U6njeqlLhjYoKIgDPAMZVyBxwis
         377ZJjCdGwWEe64UMf9yQwrc/LxYtPkhk1Cwkcnkntn8pH2W52n3UgcMElNaj3BgG6Bb
         N3o9encVZtHXnBKUaVFiA0f8kXehv+iX5NpN0996tb82l2YCx47gjHv8nF4dIXpYNGvE
         jsA5BkOazRlNcuhFpS9Jl7Hd6/BuMvUvXb/Yfu6ORMsG0qFslC9S1u8hjXZwl4ZkY0AY
         yeIw==
X-Gm-Message-State: AAQBX9fTZW+F1O2fkSR0ic7RqztRlLqYuJXXRDvlptjr3XdDgjg09Ol2
        TLjev0cFkW5cMQvZiIHZ57lqyQ==
X-Google-Smtp-Source: AKy350Ym6+hh/Ov30ntceWQ1f9XrdNmhsbGJd5hSUDCKsz6rnCp0DgkgHrYNjDVU4+vi/FBitE9liA==
X-Received: by 2002:a1c:e916:0:b0:3ee:3e07:5d26 with SMTP id q22-20020a1ce916000000b003ee3e075d26mr7309618wmc.24.1680788239492;
        Thu, 06 Apr 2023 06:37:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id l17-20020a05600c1d1100b003ef6988e54csm5360385wms.15.2023.04.06.06.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:37:18 -0700 (PDT)
Message-ID: <dab77a21-89e7-5637-3f7e-87b21d84c7d2@linaro.org>
Date:   Thu, 6 Apr 2023 15:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: explicitly return 0 for
 shared timer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 11:40, Krzysztof Kozlowski wrote:
> For a shared timers, the mct_init_dt() should not initialize the clock
> even with global comparator.  This is not an error, thus the function
> should simply return 0, not 'ret'.
> 
> This also fixes smatch warning:
> 
>    drivers/clocksource/exynos_mct.c:635 mct_init_dt() warn: missing error code? 'ret'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202304021446.46XVKag0-lkp@intel.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

