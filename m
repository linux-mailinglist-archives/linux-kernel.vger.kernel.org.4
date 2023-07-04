Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3081074699A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGDGY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGDGY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:24:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E13010C8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:24:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d88f1c476so5855614a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688451862; x=1691043862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5eCsOJy9Ofd+ETWcmJPrap6so/UqnGdg6zXiueUWc8A=;
        b=j+vkh1FZQZxv9BL4CKwRdy9cloWqo7JXFEuiIPVgmAsxi6iR4P5sVaV2E7HnBR2sUW
         WZk0I98h40WnUOAP22HUWEnNOFlHgGcp0lJbXGTikrBKHBPeh9wZsrzyrZ2SXQAybYMD
         XI8RYu24hIDkqdrOq23qYl2Ayd4FCBkfCtCE83ZNNEcFDg/4/PPCYi950BHWYSG4eK7D
         4PHEYdk+JSnjWDfH9r/YEcdz8oB+IX1MrVRgnbkX7T8tVK46AubZQ/LyJbRj3rBD1UOm
         pPb7b0j26UJB97acK4dcbjQz5uyIItgCJfDXZV1ycK1HaubEIvwEFOYvumNQGxPmeFvE
         DrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688451862; x=1691043862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eCsOJy9Ofd+ETWcmJPrap6so/UqnGdg6zXiueUWc8A=;
        b=Pv3J/lD3yyS3LZVz1zEc8jj2ptT2rVejQ4MRxqbgcn8Mdf4tHcGxWm0C5dVm3d/4W+
         jl5uV3a7Kic5/R2MeLXWp7ICeGrU059APcyVqpGoddmfPf4sgm7AWkzAumghQOBLAnsE
         JIiSWg/827pcBFPfyBa9f1qJGb8f6Zh+SAqoZy9I4wXIROjYBHr/TCQ4ptuKY/wNsw9f
         6bU5buwyLfJQLOheQccS/dwqvW54eBGyR3/4MkNxlMe0EHSE0MeO6peW2Yay4eXbTywa
         JmxN1zLoTZmZxkrw2mvtgPaLaXF8kWZWXzNUpbOkF86ksLAbJaJY8eZFfm3beHclCQzT
         ZF5A==
X-Gm-Message-State: AC+VfDxAy5K9GfJlaqns8Pi2idO4lG+x72mZUbOmw7aQu1RMJllYNvh2
        fsspTsxmjfIPLtbm9xKEL3gCLg==
X-Google-Smtp-Source: ACHHUZ6A+b8UpKl21Lt9pXmnyuhpQ+c/7Yy14E6LSeuADTSnL1rYpr1HmLXggyqq5Am4aijIaWe54Q==
X-Received: by 2002:a17:906:cb90:b0:978:adad:fe18 with SMTP id mf16-20020a170906cb9000b00978adadfe18mr8416367ejb.21.1688451861694;
        Mon, 03 Jul 2023 23:24:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id jo19-20020a170906f6d300b00992d70f8078sm5713242ejb.106.2023.07.03.23.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 23:24:21 -0700 (PDT)
Message-ID: <e143a039-d71a-bfec-172c-120990bdc357@linaro.org>
Date:   Tue, 4 Jul 2023 08:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/10] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba
 support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-5-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688395346-3126-5-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 16:42, Rohit Agarwal wrote:
> Add support for the pm7550ba GPIO support to the Qualcomm PMIC GPIO
> binding.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> index eaadd5a..9470eb0 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> @@ -25,6 +25,7 @@ properties:
>            - qcom,pm6150l-gpio
>            - qcom,pm6350-gpio
>            - qcom,pm7250b-gpio
> +          - qcom,pm7550ba-gpio
>            - qcom,pm7325-gpio

Keep alphanumeric order.

Best regards,
Krzysztof

