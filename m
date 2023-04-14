Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D106E1D90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDNHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDNHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:55:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B96D61B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:55:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id xd13so9627431ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681458909; x=1684050909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MX6fVdL7wxeWaRqB1f72ozHdllS9D+KpLFRVzWoVQBQ=;
        b=h0CFJl9uAw67dUL4yY7QzwF1QY7ic002r/rOSBbtCwD9oG0uHugRCs48n9B82cNfQk
         ghyjnqRl5p2mnDrJFZsZaS8h7f8sOpJWlzQYcEN2c6Cm/ss+Ik2/XoEh2YfrJfVYfjfM
         aP/dLv66OBX/5A8564+WLPTjuQsjrBcRAdJHCINnAvSh+VY6VBOBwu5hWXJnKCx/vwIa
         w9qeKrxo6tZfs7Z3AF2ZfplPaclSbRuhCQrFfUoiQDSiMBcY99jALLMxweT1T2B343nK
         GVcDz3wEu6aLKoAWK0fI/0j1MKH7RXSpXzp6vw5wRe+Y7MiMj4ThdQgTBfvN5Ct/tzls
         dhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681458909; x=1684050909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX6fVdL7wxeWaRqB1f72ozHdllS9D+KpLFRVzWoVQBQ=;
        b=gHTwSZC/sg2Rtf/NU+VUYYGCyqMDbjGEg7C7IHLiNABIDzD3KTdxa6ntvmBOdvSKLJ
         Co+QXY2p4ksr780WTivTadxv67uFrcGt07UYcMAhZJvbJobdsiJsEyd2pdOkSNxtXeGg
         Na2oYVTaYLOT8+8J6V1GYqZIXJU6O426CeY2Qdix6KgZMptaWV3XM8WOmS0dMaPk3vun
         RwOlxRspGm1KAaC047iY7BTeaJIZuo9xvptO1clnEGN7jgrhhbongUi3fi9WQJ4VXRQV
         3MyEzlFo/GByRqMdeP9ZIkOxFj3+waiCgkt+whFjyGk1SovUDwYGS+wK33gEz+kJIs9A
         UGBQ==
X-Gm-Message-State: AAQBX9eks3Urqqc1QuM96/QROoYlfhyebmHivmLPJxeob43cnuFRkqKI
        7hoQglpOWvfAkyAUFrAF33jcLQ==
X-Google-Smtp-Source: AKy350bxn545iqVRLBUHXEmEW5pwE+NR2So3C/xmKqr6ULNBknC8Ntejoz/1D66bV9Yjj5epi33Ulw==
X-Received: by 2002:a17:907:1c1d:b0:94e:f862:e0ac with SMTP id nc29-20020a1709071c1d00b0094ef862e0acmr89568ejc.17.1681458909499;
        Fri, 14 Apr 2023 00:55:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c957000000b005066ca60b2csm1790424edt.63.2023.04.14.00.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:55:09 -0700 (PDT)
Message-ID: <517a0967-4632-27b3-a161-e96ea83d3d78@linaro.org>
Date:   Fri, 14 Apr 2023 09:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/8] dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
 <20230414-pmi632-v1-1-fe94dc414832@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414-pmi632-v1-1-fe94dc414832@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 01:17, Luca Weiss wrote:
> Document the 8 GPIOs found on PMI632.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> index 1096655961f7..2179444b7a83 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> @@ -52,6 +52,7 @@ properties:
>            - qcom,pm8994-gpio
>            - qcom,pm8998-gpio
>            - qcom,pma8084-gpio
> +          - qcom,pmi632-gpio

You missed update to other places.

Best regards,
Krzysztof

