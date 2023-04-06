Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34626D98BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbjDFN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbjDFN46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:56:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377F7AA0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:56:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so39601396wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680789387; x=1683381387;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtdWe2FmvtgwmWTeOABvPcq/IF1uN7ZuplszcAHjajI=;
        b=jOSEvV/5SZmvbDHZkDsiI5WEd69V0/TQu630mOausA4EmJ+Gl3R2IvxPQOYbNZzGqC
         42xFXvVsZr8pW16lHPH9pA7CH1bbgJA3F/F44vKLip2HAn8QaQYJwxoFST7AfdNAbSV4
         4BQeKKxZWLoj4JtOxS1Q7nPGoaP89nkOzme4oGlA3/y0zh7Xj9qBx6FAhdRUPfP4hi89
         +EtlWyytR9rkoVqXQsan5KPy41KOY8d+M73vmwn6grY2hITaI0jcgmqXcNxi39/51AW1
         hDBnmHExanfFuWsFA9oatcFcpRTx2/CztDedPCsukCJPlwhMJO+gg2+fpwROsd/vgaK5
         /z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789387; x=1683381387;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtdWe2FmvtgwmWTeOABvPcq/IF1uN7ZuplszcAHjajI=;
        b=nMTTbylOWpVqlPPVFnpY13WgqN0SgiyZBgNDp+7QSyFqsui+I5OV9jE0ZwCxfAtXKo
         VPwec/OMEQTUNPoYTsHpcdGFJcfJcA+yJc5WxEq9mnjl2kCs2C+soug5BjXDIrNEQNLb
         q0cF3CdaLmchrGRw1jaO4vWUpahOEeZImcN/DN9eC+vu+LSMbzLVmHsAQ9JOXs1m3cnv
         tRb3tZ6CcCL5cxfKBa8blPp/V/Y+eAnu2at19/bYTSV/sG5BF1KXPK0d9xS3gY7qiqEs
         LMbvRHrL/XVCeeVmyszF5Nk0LnPfbUffoUK5l4fX57q4wbb3sLuTab8BTmVx1Yz+kUHN
         lZmQ==
X-Gm-Message-State: AAQBX9fQY3uYET99NY0I84+hF6zM1hxLC9GSGLbj/k+mjhBwBbMxERsW
        DBjOXdA8zpspOa3jSg8Cu07iYw==
X-Google-Smtp-Source: AKy350ao7+BZhKsr9AmZG6YqOpkivPKyiVoqslyt9TcMeCroCbSSbfCW0oHA2IneDtOuI2lJUYLGrQ==
X-Received: by 2002:adf:f402:0:b0:2e4:cbbe:cfc2 with SMTP id g2-20020adff402000000b002e4cbbecfc2mr7273887wro.25.1680789387134;
        Thu, 06 Apr 2023 06:56:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id f7-20020adff587000000b002cfe71153b4sm1818118wro.60.2023.04.06.06.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:56:26 -0700 (PDT)
Message-ID: <a2b0c505-29dd-446e-ab5a-95f008254a72@linaro.org>
Date:   Thu, 6 Apr 2023 15:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clocksource: stm32-lp: drop of_match_ptr for ID table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230311173803.263446-1-krzysztof.kozlowski@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230311173803.263446-1-krzysztof.kozlowski@linaro.org>
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

On 11/03/2023 18:38, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
> 
>    drivers/clocksource/timer-stm32-lp.c:203:34: error: ‘stm32_clkevent_lp_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

