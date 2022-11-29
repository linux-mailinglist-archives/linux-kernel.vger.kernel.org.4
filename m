Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA73863C5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiK2Qu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiK2Qub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:50:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D4697D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:46:38 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a19so2200100ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICtfj5MrFnzqIlXyjbzwB9wa8iSvEdSbaEKexKUEIJc=;
        b=jMH1IUke8+dAR7OHQd3JnYU1kX0oyrqsEFAWO1oTAiGjsgYoZyM2Ij/fiKahZrVIA+
         wTmL6piTROPHj3R/PSRKmMC9K07fMjh7EFf/yzaIrIkC182v/dLaAxhMS9UukCYAb7uY
         glrlCOoUvuegt7zTAxj3A9eMz8sgO6X4I7O3eCRGBZUnhtMXvx0VmQTeMpBM3HjfhcmC
         4PdiuLvckaEd6TsFR/hQ9ZnTfJqYWIPEvJCVL0Ie4mLNp0TJ8vd678scKQNe0C6OLsbY
         iUcp5h+T7sI8a+JPTXHd4qGv8vpOgWP3C+ylm7tJZI22Fn36c4F+25MQjwORI9UGjL/x
         sDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICtfj5MrFnzqIlXyjbzwB9wa8iSvEdSbaEKexKUEIJc=;
        b=i5wB6QaMtQJdSHth7zOTP1LRkSWkFaO9OlC7f1BC3Xn1Nd4ARA926Kttr2vKD0wx/w
         MdNgaZuNHOdNU6EoTEeQNBAKi5Fy7T+1X27Vk9PZ9KAmE7KgfnanVswU+Ro1EOLjPQ6O
         aHmR1K1YmCpwGnjh6IkQiQxElYDHpv2C/xUCOiHPZ335UMEEKFJuL/S9/O15LYK6fTWD
         gjb4OsCsXHO7aZrKbLRFfBsnErbuY2Ex8Ha7abPCS7DLq0Am2JQInMIb9PB7+HG3aN2i
         NCIW/f6FFptg70fwUxiTR0S4OLJBMP0CYb41NNEOVVmTjA0tm401EzQgZt9+wmiFBP0B
         DCGQ==
X-Gm-Message-State: ANoB5plk7Y0vvvQS8jGIMQx9TfAUXAhuTQLPgWnhxTQY+fiwTGRXi0sB
        SinyA1ERTLxeQE+Oggbd/6Ts5g==
X-Google-Smtp-Source: AA0mqf5EPSPsnKesqrD3jEsnaZzm85qklfBTN9kJNC4bwKVrtKwKscKlmyoKtJ/VX7bQ1wuylKSKSw==
X-Received: by 2002:a05:651c:1070:b0:276:ac05:b821 with SMTP id y16-20020a05651c107000b00276ac05b821mr20048021ljm.84.1669740385895;
        Tue, 29 Nov 2022 08:46:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s28-20020a056512203c00b0049c29389b98sm2244556lfs.151.2022.11.29.08.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:46:25 -0800 (PST)
Message-ID: <bc1086b2-871e-c540-a276-78ff63debbf4@linaro.org>
Date:   Tue, 29 Nov 2022 17:46:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add an entry for
 WorldSemi
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221129140955.137361-1-gch981213@gmail.com>
 <20221129140955.137361-2-gch981213@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129140955.137361-2-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 15:09, Chuanhong Guo wrote:
> WorldSemi is well-known for their WS2812B individually-addressable

Drop marketing. If they were well known, they would be already in vendor
prefixes, right?

Add vendor prefix for WorldSemi that makes WS2812B
individually-addressable RGB LEDs.

> RGB LEDs on the market.
> 
> Add a vendor prefix for it.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 10c178d97b02..32274d894664 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1462,6 +1462,8 @@ patternProperties:
>      description: Wondermedia Technologies, Inc.
>    "^wobo,.*":
>      description: Wobo
> +  "^worldsemi,.*":
> +    description: WorldSemi Co., Limited
>    "^wanchanglong,.*":
>      description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
>    "^x-powers,.*":

Best regards,
Krzysztof

