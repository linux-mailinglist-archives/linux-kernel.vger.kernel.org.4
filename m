Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3000A62BB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiKPLZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiKPLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:25:01 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538031263D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:15:15 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id k19so21392472lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPTBK4i32JE74oeyl2w5naP6xdf7gqgsnorC/95qyaA=;
        b=zjMU9q7O8ibiI5n7mv4RqLHUoTHaF51bmWPW8hydg0L9brVyaGjH+GgOYSeXoQREBb
         c36Jftu0NYWEYQ4hBs0vRZf6frfcH53mmGfJx7W9Eh5+ruyuAamhG8rabO/ihOmOjTPE
         +a0xsAFYjyzXUHAuyRINXpcTvfEmAeADDMXSOQeOxvgPfKZDzfDCiSVrAloH6nb+/YHt
         DajaeR1Dje/GyQye89rfCpZ4YUbL6ttYQjt/IqIsmLzEOeyBLodTWmcit8GO7Q+sxD/+
         65it1R+sytXWOTfxFUKkdz+f0ufI37SSupgy0RwiX25zxfRQN6eTp497yLNUy18tuOmL
         WF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPTBK4i32JE74oeyl2w5naP6xdf7gqgsnorC/95qyaA=;
        b=vwiD/EDKsurSJWIBHYJHLLnbLhxacPvZa4sETKkyn/VxcL7W3O/L3UaxlwgNA1ciOy
         LnLIG0GmLRz+ReufjDcPftKWpEZUHwtG96z3H9GPSVHT+QIsaugDFUQ15iKHOMttL10o
         DxPhUFT/KB4W2fELoadIVyx6Br/U4teCLb/6JgZ03Ihw8RFgAP4lgZ+LHnj6QviGy8tc
         X2l5Fa74aDML4vomEhVFKhAal64mjDhLyGeQPl5lG9hL+1eDxZLQd80MVSFnR/uZQoBH
         YzQJFOrhijNXs28l/YHDevgUJz82fA57o5xEVFC54ED4DrKZYZF7cVPLUNbEi9+qjjD1
         RIGw==
X-Gm-Message-State: ANoB5plr2L2Z2wUr0YCIFPbFFbf4Hof6JnyRUn5wobkiarJH/ArX8F3z
        fIZYVzdu8qLM1vUvQF0zjBHzbA==
X-Google-Smtp-Source: AA0mqf5ihjyvkIyifw8CFqqU5Orm4NFCaoiopIgkbXL26iq+HaS37xWbhgfUGb7eWmnfVKl7UEAXxg==
X-Received: by 2002:a2e:9d8b:0:b0:26f:bfd1:cc14 with SMTP id c11-20020a2e9d8b000000b0026fbfd1cc14mr7652383ljj.256.1668597313694;
        Wed, 16 Nov 2022 03:15:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h7-20020a2ea487000000b002770a9ed61bsm2844322lji.66.2022.11.16.03.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:15:13 -0800 (PST)
Message-ID: <6ada48f1-a39c-23a7-9422-c44dfe403254@linaro.org>
Date:   Wed, 16 Nov 2022 12:15:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/7] dt-bindings: mfd: qcom,spmi-pmic: document pm8550,
 pm8550b, pm8550ve, pm8550vs & pmk8550
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-spmi-v1-0-6338a2b4b241@linaro.org>
 <20221114-narmstrong-sm8550-upstream-spmi-v1-1-6338a2b4b241@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-spmi-v1-1-6338a2b4b241@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 11:11, Neil Armstrong wrote:
> Document compatible for the pm8550, pm8550b, pm8550ve, pm8550vs & pmk8550 SPMI PMICs

Please wrap commit message according to Linux coding style / submission
process:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

With commit msg fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

