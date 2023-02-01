Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A993D6869B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjBAPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBAPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:14:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A82330197
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:13:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2704867wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoczYxoYefo3q4e07FBM/XL6+cv7m/SSyckrYjyJ2jI=;
        b=tKqceXX1fCVRHew9rbSIswyEw480KhF951nMK1gj1DdIhvCvbgj1t6GvTU3G9iaQxH
         iVa7e5vbdIuDNBybRTT+DyPj3ccs3A1j1+MyANhBFIIU19ON3n44XMZAwsxdOL6d2+DM
         eULyNbAaBwUqdWooBXQj1s8/iSacT3+UUKqZlJH4U1EPKv2Rntizbvw8gE3I3MjE4kqj
         KlqQi64oVMkjzUIgIbHqL/yM+mBOwvn1yEolssdvtRkjwIXzflL6VWj2aNuGfFJ7++tS
         Swt11PCjQA4ugJBF5kJbRBvbUwAT59apFz0EIjtY3KseV4VKfo4unm0fyupUd5xyjnCv
         ipjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoczYxoYefo3q4e07FBM/XL6+cv7m/SSyckrYjyJ2jI=;
        b=Gu249gv//7W8gGmmhbOCN63Itannn6uHTNwEA5ZAjsLFJK2VjRYGk59JJqUehG2XIH
         VPHcpfZPABKeqdEbLQSE4055dTUJxaHQyGWBOvAOxvJSby+uwhJaA/qDPxIzag9P5m/s
         alsGyY9YVmbowZmj3IKal1+LAqXtmt6KlrO7BXVTIEE+qIPcsAXmyU1RBJhZej+Gob1o
         YH3EXa6dDlib9qtzkFpEmNj2KzoqF9d3gzooF0gi7becUr0uCGd1ib80OjEafd8hGmaE
         kUwwKeOtC/g1OaS3wxEs36PFpIkP8CNlTa9xmQ/gX5mi+AgmwWdvUpZ50F8YHdSpMCe2
         3bUQ==
X-Gm-Message-State: AO0yUKUBVcMsPlgKzIKoWrW1gNLhvdbTt9WTvoZPwxds2JLtTmX+OVeu
        umVknRknu0SbfIewTSz+6qLXkg==
X-Google-Smtp-Source: AK7set9QAWNS+grEJLKmMBdY3r/mHJMdSn6u8/EAciwP5Bos5o8XwQWXVoxusxhjfO0PYZufrwYWiw==
X-Received: by 2002:a05:600c:b8f:b0:3da:f5e6:a320 with SMTP id fl15-20020a05600c0b8f00b003daf5e6a320mr7872902wmb.22.1675264403721;
        Wed, 01 Feb 2023 07:13:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c130e00b003df241f52e8sm861132wmf.42.2023.02.01.07.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 07:13:23 -0800 (PST)
Message-ID: <e28c9048-635d-3936-e440-27e293501ff6@linaro.org>
Date:   Wed, 1 Feb 2023 16:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: describe sa8775p-tlmm
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230201150011.200613-1-brgl@bgdev.pl>
 <20230201150011.200613-2-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201150011.200613-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 16:00, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add DT bindings for the TLMM controller on sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    tlmm: pinctrl@f000000 {
> +        compatible = "qcom,sa8775p-tlmm";
> +        reg = <0xf000000 0x1000000>;
> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        gpio-ranges = <&tlmm 0 0 149>;

You have 148 GPIOs, so s/149/148/.

I'll fix other bindings as we have such mistake in several places.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

