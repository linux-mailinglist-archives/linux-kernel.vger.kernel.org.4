Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAE72D03B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjFLUKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFLUKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:10:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA3107
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:10:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9788faaca2dso788032666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686600633; x=1689192633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpuzEvfKwfzbfk8K6DkABkAcSBXLdYg/EBl9ao3GFl4=;
        b=jW2L5HaOFSwPmAe1FuBRkEMRlcdterbh3EmlzNdnllG9rjvbRJRXSPcCjBVVpxIhtv
         OoTc+mjfQqv6j3/hcx6ha7geqpcs4ZgITPa666jeMil3fIWyps5+x/8qE7n72EaUwrsw
         zZv1OME5rSJNbn6R+sRcAr/Xlj8NeU3udqa8/oUEMRxHJwTGbF3Wv+dEHRIJh7ozYHeR
         FmUg7wF8zNY1Ph+k+Ds9AATY9TSeYDZ2W/1BKznZoDKzy9IcwljiFf7v7uygwE/Jp3cU
         zTtDzOqb54yVwFbgmJnuMqJTbPFXlp9WjXzRgYGIKsn9gbowsXg8WUYUVPTQLEwxE/A2
         5Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686600633; x=1689192633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpuzEvfKwfzbfk8K6DkABkAcSBXLdYg/EBl9ao3GFl4=;
        b=EsxAMYgiwut50ZXF9RTDPLLMFdJ/V2NG6vRQl92K3Ur2S136rA+0/2rEKlCx/HLJEc
         /5IjMoXZuIq2wLXriIOT/lvO7UaR56ecrG0hhtQLpjN41ZCE92SyaxnSwXrfmx2O16Wn
         ANO4HH+rUml8YaWcOvFW9oqPhSDmsxHIinhA56Z9wS+EmumyttgfBhP0P5LpMuBRdtOz
         5Qb1/zev4Ueqi1TNLkYr1Qakr2vnFtqvxHgguDBITgANuGtT5zU4d0WGujG7PpYmOaIS
         0vyvRCoTmXLgKTO9KaUQIw1T3BjAsZ3qVl8QMrs693C+IMsNYkk9jVHd88hOVehv/1Hk
         eDEg==
X-Gm-Message-State: AC+VfDxpu0qe7ZloMENc38kjd3B7cD/jc7sTtnZaalo10Wxyn95YHNNC
        vLNaBAoQHv7ps1rR3mzj88YAjg==
X-Google-Smtp-Source: ACHHUZ52f+8BHAN5M3G+G5uogFT+frGi0I+BR4/O7lowpDkKSKSpowggXDr/YYiCAFy8sa5naxdVGQ==
X-Received: by 2002:a17:906:6a1c:b0:978:ab6b:afe9 with SMTP id qw28-20020a1709066a1c00b00978ab6bafe9mr9992679ejc.66.1686600632773;
        Mon, 12 Jun 2023 13:10:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id oq19-20020a170906cc9300b00977e0bcff1esm5712483ejb.10.2023.06.12.13.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 13:10:32 -0700 (PDT)
Message-ID: <6d76105f-daa1-1cd0-35b3-1727aa967bcc@linaro.org>
Date:   Mon, 12 Jun 2023 22:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] w1: ds2482: Switch back to use struct i2c_driver's
 .probe()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20230612072807.839689-1-u.kleine-koenig@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612072807.839689-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
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

On 12/06/2023 09:28, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> commit 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/w1/masters/ds2482.c | 2 +-

Thank you for the patch.
It is too late in the cycle for me to pick it up. I will take it after
the merge window.


Best regards,
Krzysztof

