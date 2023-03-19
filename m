Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0216C00DF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCSLhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCSLho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:37:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8BB20A1A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:37:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er8so24898568edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679225853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjQK98wMTvC2q3E7fdiQTGy4CfE9nib0P1aeqr32BDM=;
        b=CNN+BQW1qwnIWDvTxDCdF3J/x2g//K0JqhfSGQ0F1o+DOFxtJMpexG7Zg2xkstrcG3
         N+bDvSoc3N+PX8xxyOpd4P5FQyhLI7jmL6DiHr17l04ctANkt/h/obwznW6Ey2lYYQQU
         eP2I596H+O3bmLUf6p+46nb/f7yBcuo7lzxfgySwO2BcdcVmDv45qTT7YshpQk33z034
         C3rS/NaL3yaQbNCXzcGPGc5C4/FRf1ebAXvgljWLU1fDQSFe8a8q04Z4NFFYizrr+uiC
         AYnUZxGFufy4sIdurjFrVZbDayiYAgPBKzWOFy1RXzaONpIXOOt6Ffh7VM4DM14tCvBD
         itHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679225853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjQK98wMTvC2q3E7fdiQTGy4CfE9nib0P1aeqr32BDM=;
        b=hXEsIm0vFmKJm4SHHSz0qE+Dd34CPZtoiTr/LPE5/45aZ4psE6NQtvskvqJEAFMsCj
         Ta0s2wiY/Iyd3nCXivlbgidusygF1zbOWode9YuDG9XiCcS/qY8MvUSIbLAMs3YZS7ai
         uSataDcC8QV9bDVIYsHkQNYjDCNvky45599uAQwNTO6rosTwD4q1T9MtoLrgkVgQz2YA
         nWLQiZ7fEFlvZBA1eQNN0nciqX7Kyp9kbVqcYP/AwDqUJZUti1DVAptLWDdmGX3aXCZN
         Rf4MDCNZBMmMgRvBEOCjDwx/4KhVucNU7Hyqe0a5tKYLq/mz4YyNuPqPeK6qhTJOboQQ
         ALkA==
X-Gm-Message-State: AO0yUKVsBlzSZ82EIV/AP3CmCjpYRpnDE68+ulL1PMpgiVf07wUDF3cd
        qTsNSuO1Vn4CWKCon+Jl2liXoA==
X-Google-Smtp-Source: AK7set9U0AOSAuCrrvQlU6ITw/snJRIJElKkSVMThrbqvxYqk0NpWETXKzJ097yOzmwdgjDNpq92Zg==
X-Received: by 2002:a05:6402:c2:b0:4fe:94a2:81be with SMTP id i2-20020a05640200c200b004fe94a281bemr8384168edu.7.1679225853579;
        Sun, 19 Mar 2023 04:37:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id s29-20020a50d49d000000b004fc2a75c6b3sm3408547edi.23.2023.03.19.04.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:37:33 -0700 (PDT)
Message-ID: <7098b2cb-eba9-ebae-1edc-f4c934bbd898@linaro.org>
Date:   Sun, 19 Mar 2023 12:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: watchdog: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Julius Werner <jwerner@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230317233643.3969019-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317233643.3969019-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2023 00:36, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

