Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1D7268D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjFGSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjFGSdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:33:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855C1FE0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:33:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5169f920a9dso1616305a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686162810; x=1688754810;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/jEtJl4NZ6AFVWENqpwdvujWaidPCP3Ivs0uh/tsyc=;
        b=yyIsvyaz+YC6j/5Dzy/+MNvUGSoqQNTFQzpkiVol4liPe22EGvhC9TO/27GhWPbBwp
         6d/U7GKG1gKpGtTAhwDpMMTjjnOJn2K0IMkJjXx9OKUuIjnWXul5jdf1beGBPRUiSWrQ
         61CotoHz24j2RiaSunM2l0L/wXkl5oJrikWRcqors/KsHkNV3dFcb1raqWQGurILjbZR
         NBKXoJgJXmn5SMlzEf+I52CAxYH9w/OthqDQ6d93oWasrKe1PTlqhqykZlmC5N8yaUyk
         tpU5MNh8ajbWEIjuqo0xRKGWK8EtVJQpm4jLR8EbUIUuigBQ6UUEmVxEw/mjrgN1K80r
         EwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162810; x=1688754810;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/jEtJl4NZ6AFVWENqpwdvujWaidPCP3Ivs0uh/tsyc=;
        b=DewAUeARFWcCb8rOmOcwGJCUZJQyznaEdfJd4s/olNIvIuKHkTm4MRZktmC6AfWQot
         0bzSJvD+VSg0+yFslxDkg2TthMNYFpQS1xQTbdpCB6WBKKUQXhcs7RgP2St0QURNQUNV
         boaoKHFIWqBdxHflobbZAUtIbEOhBwIqMaAid1O8ojxH67wDtB9DIvjlDEMFaKxhx5m4
         p/1fI1QiaVAyI5bzZ7cPXvXfu/I6o4A6Z/uxNlCyxDWsBTglBzirooWeduCg9ZA+1KbM
         R9Cr3PmBKcbGRxcDabYyvIQJvuZ08ze8NYsebimL0POrHcY5Js8h7GVqaJ94nEGdalca
         hS3w==
X-Gm-Message-State: AC+VfDxPxFnHu2ZE/qa5C+/i2n4UpEeBYenE2HNL57wiR3p8SL6Ipl4S
        HQsZfJAtTJmIfm5mN/573i243w==
X-Google-Smtp-Source: ACHHUZ44tSnQcNjSduQ/Kmu2KqHCyGS/zvLF7ZqpuqAWBIXrj7HWJDdybMg3GIK5gBATFvAVVoRLaw==
X-Received: by 2002:aa7:c256:0:b0:514:a302:c334 with SMTP id y22-20020aa7c256000000b00514a302c334mr5962899edo.14.1686162810142;
        Wed, 07 Jun 2023 11:33:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bo28-20020a0564020b3c00b00514b1d2759bsm6452502edb.42.2023.06.07.11.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:33:29 -0700 (PDT)
Message-ID: <8fdd584e-988f-8542-f635-c0f6b5e63580@linaro.org>
Date:   Wed, 7 Jun 2023 20:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/9] dt-bindings: usb: dwc3: Add IPQ5332 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl, quic_srichara@quicinc.com,
        quic_varada@quicinc.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <d07f804802f0678746aeba55910a83209ecbe054.1686126439.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d07f804802f0678746aeba55910a83209ecbe054.1686126439.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 12:56, Varadarajan Narayanan wrote:
> Document the IPQ5332 dwc3 compatible

Full stop.

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index ae24dac..9c3d6f4 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -14,6 +14,7 @@ properties:
>      items:
>        - enum:
>            - qcom,ipq4019-dwc3
> +          - qcom,ipq5332-dwc3
>            - qcom,ipq6018-dwc3
>            - qcom,ipq8064-dwc3
>            - qcom,ipq8074-dwc3
> @@ -246,6 +247,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,ipq5332-dwc3
>                - qcom,msm8994-dwc3
>                - qcom,qcs404-dwc3

What about interrupts?

Best regards,
Krzysztof

