Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAC60CA29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiJYKdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJYKdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:33:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524CE16CA42
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:33:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bs21so4147486wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66cLoBSJDG8wtROQKHHj/HCiSoIoqGjskOnA1JjrMs4=;
        b=EsinVv7lY4mFWF9zAXFWNSq/PlLiuThvfBA6FIs32bxAt9cSRCW6CoNQM46JXHHV00
         vbLofaGo4uftSErfd0CaUJAloTKfyuSgpenM4aWYIWlmNidUQ1qRPc+UU+EGYbAqgAz6
         PqQmeRQYPLBp0Rse3uGTazS/bUI+GX6LajygaB7oIht8nxsCdzHZR2AFknUZRi7BxWbE
         /jCzdM3/l1sDgX9znlR7Jldhb1QOCPr6Jz0gL/EldC4VJUMQW4BIf4jy6cO43QbvRCzJ
         yPWc1jqcSsGtC8ugXBy+FcUm4iFjlibG2YPEOu572xmbZBPefBi8vI9oODVY3GCrThvQ
         5wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66cLoBSJDG8wtROQKHHj/HCiSoIoqGjskOnA1JjrMs4=;
        b=SY2IhV7tl54vtT2C5B/5n+KWJNGc3RjiPwG20DunVpeEjxRcyeROdel65pBhSPJ2UX
         WxgNI0hIpAdKcHZcmpKlNYHHGln97Bzj7I+rJSwElSUxYqcFt/dzaRhEOsX4HGJqoZ3c
         fOnEtq0OMMK6JkQZttTn3nkvY61yxpiASMS+PznpVIbqknKTyLRnRzTxiXQ01Np4z6mo
         /q+Q7RB3FWWPNhcp0LJIbxdEJZTtfbk7UpGU4CKq7lMtB9+XM97eyZOpiBheeyjoOc8y
         iBNJLY6w2o7Zm/jlY/1nkMbGMUIkZZmuOosfndIkMBFffLcJK4+EO6aiZZPIoYspIL7G
         +aHg==
X-Gm-Message-State: ACrzQf3u/LDCelcyQk7JnVhSku55bypBaBeC6PMHtymEScFl0ZepX98H
        Tr8qJ0K6DNnRf0dRYLE7/2V2pOVg+Dop+8ZtE7M=
X-Google-Smtp-Source: AMsMyM6M6qlAQjBljmmzOXjq4u3AucmyE7qU1ZqU4aZWRcPhut5obO/D02H6dN7TRWeW0zBEY3oB6w==
X-Received: by 2002:adf:dbc5:0:b0:22c:c605:3b81 with SMTP id e5-20020adfdbc5000000b0022cc6053b81mr24510392wrj.218.1666693980884;
        Tue, 25 Oct 2022 03:33:00 -0700 (PDT)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id g42-20020a05600c4caa00b003a84375d0d1sm10021817wmp.44.2022.10.25.03.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:33:00 -0700 (PDT)
Message-ID: <714a3bba-611a-fc78-cb62-f12be9a7e356@linaro.org>
Date:   Tue, 25 Oct 2022 12:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 4/5] pwm: jz4740: Depend on MACH_INGENIC instead of MIPS
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     od@opendingux.net, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221024205213.327001-1-paul@crapouillou.net>
 <20221024205213.327001-5-paul@crapouillou.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221024205213.327001-5-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/22 22:52, Paul Cercueil wrote:
> The MACH_INGENIC Kconfig option will be selected when building a kernel
> targeting Ingenic SoCs, but also when compiling a generic MIPS kernel
> that happens to support Ingenic SoCs.
> 
> Therefore, if MACH_INGENIC is not set, we know that we're not even
> trying to build a generic kernel that supports these SoCs, and we can
> hide the options to compile the SoC-specific drivers.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   drivers/pwm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

