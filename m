Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6065A70490F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjEPJWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjEPJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:22:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD30B5592
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:21:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so25206066a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684228895; x=1686820895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLFC2bNX6txLnjTPD5+kbo++oGCyGs9/o5oXQDZQo4c=;
        b=iu0gLDPhCLaWcd6EPNDAMZ6RADmZTS7G17U99YpQtRVBlZ5XuiIUPr6/uZOmxwbE9h
         xTJ41HMul09+N1P7ZoYma9BMw6ie+5PW+hznisj7u8wHbDV+4fC7oTzMO1n9uAXz/1Sz
         QLRhsg24PRZUztVMhLfV99/GvIMJC5jcDPTZ4SYjpxMkvaU4Fx1Pw4tFyY2bpxySNvKG
         w/f49Nb3M/glSIUNwreXGY3xjvPh39lKiuehClugMZQCOeCcwqONa60EYADMN04C9Y5t
         ZGi8JBWP+pFZAz3uZELImxqWYSAU3jd1KEX3u+MvlBDFl1qsLTUAiCs2tcijr6lJhhcw
         c7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228895; x=1686820895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLFC2bNX6txLnjTPD5+kbo++oGCyGs9/o5oXQDZQo4c=;
        b=eGAH0McNIEj6sAwrditNejsr3WGsq8c8Q4hLhl2RRP9OH0NHTtV8XpA26cbCgSd5II
         2VfW3sd0lAwmdTyZjQX0DF7mIXM+y49D3bMeEgKV3frbPzsedKcA0kbb8Biv4Wf+nsTw
         80ddW1d/M8MpLxlaEalV6N1n3te0KbUAso79K2r/7nY6wP1cprgeU+oSwgZq22yPqZMw
         7JfXsskjZ0HMzeU4wAa0hogKW4Q3JQDgMFdk/R6Mhh9wMNcwAC9YeEMkBYbCmtq7EMe7
         XPw71YpSvG2J/Dq+8ZvfJCtqHhNF2+3Ze1ig1+hvNqh7GG2A4G7FwkEYX+TgnUBaWo4/
         NiXQ==
X-Gm-Message-State: AC+VfDxHdatVJ4xpOptAwwRxJzEpiJFM5M8TZtZNKGGqp1KJ1XO7jylf
        F0Q0lbEn+Vy0+1zvTan3V5LfqQDESKiEyeRhJgo=
X-Google-Smtp-Source: ACHHUZ7pSEzzkRBU/kT98UVCxfWhQeBfw5kAf0aPQHsa2kgcYfw+RMjIwWa+6b7fuAWllQ+0Y+XM7g==
X-Received: by 2002:a05:6402:614:b0:506:c2d7:503c with SMTP id n20-20020a056402061400b00506c2d7503cmr28441142edv.41.1684228895224;
        Tue, 16 May 2023 02:21:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7da96000000b0050470aa444fsm8008834eds.51.2023.05.16.02.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 02:21:34 -0700 (PDT)
Message-ID: <f2c348d1-4ffe-d515-17d5-ddb25bd38f53@linaro.org>
Date:   Tue, 16 May 2023 11:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 RESEND 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230516064736.10270-1-yu.tu@amlogic.com>
 <20230516064736.10270-3-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516064736.10270-3-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 08:47, Yu Tu wrote:
> Add the S4 peripherals clock controller dt-bindings in the s4 SoC
> family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

