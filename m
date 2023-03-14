Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C046B8D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCNIXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCNIX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:23:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD226869
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:21:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so58513049edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678782114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3Pox4XAvLnFNQzaTLmAx4AjLw2hBw8wrTBcLaB41To=;
        b=ZR/9tsrYEGhcCJThIaIJws7+UnO3wfRjY13AR+L8pTE2iLf/QF/xZDThAuRYQfD+Qr
         t84kkVrfzgHZLQOSiPzs/zCfAySauI/dsZ1ErxYsyEDRPthrXo57QLEAfQ6kZUCjJ36n
         drRsxMysV01P38QFssHvXViAXdb0tsNclwCC78SCmKJwiECP1rubYB+GfyhqmrRB5A+v
         5hfBMe91fHW2gLwIXKGfnzW+NsCnWJRXgTRhKhzmBgy7TABrQddVBusWHXKQTnoqkr/N
         sub2YvXcga1oolpYAaEzSF32o7lG6LUfXkQhoRxXrg8uTbs3ZO8GfrlF8meSuqXRhfQR
         bqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678782114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3Pox4XAvLnFNQzaTLmAx4AjLw2hBw8wrTBcLaB41To=;
        b=7+V6G5Don818SRs73lk0k/ELRwWRmOfAg6cUdhcge/is0+MBzpCRm/6UXUfImVtsoz
         Wf56aetHXg5vgG+SjS3pI/kQvjbaz2iQUCEDr4MxnbNxwbV/8gG8rvNS6F/bzckgOQhE
         EqB91LRn3AsWoOZ/BZyZtQbOLSrl+3PEmx7MbtV1Q83QMz3dTizIoDfBJ7eQcCXuMpbO
         9j8OZXxm3pTFdI2XJDoBW6D8dvlVSuloCxHF7WttezC1Q8MrGEctHzowD0b4qG0WuO0K
         P05BBTeCXlkaQ8jKDsPYILo+BfWn83BR0jIMCUN5ZQQFDIJOgHKrvpRBGHytKhbttp3B
         mVEw==
X-Gm-Message-State: AO0yUKUkkBE2D9rqT1vI/RCz7CIuZiKJpKeE7rkvunS//W7UsOJdQZ6j
        9P0MM69g5S0OnK/R7xIR1zTVVQ==
X-Google-Smtp-Source: AK7set/RGW1Q0rfcXRKAWSYuVzvGhANcYDc1JFQ2Fy3W1FXxaxJXijT7RNC+s1L1k1sgw9XYkMt+0g==
X-Received: by 2002:a17:906:3986:b0:91f:32f9:82f0 with SMTP id h6-20020a170906398600b0091f32f982f0mr1308617eje.29.1678782114207;
        Tue, 14 Mar 2023 01:21:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6932:5570:6254:9edd? ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id bg23-20020a170906a05700b008d398a4e687sm780554ejb.158.2023.03.14.01.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:21:53 -0700 (PDT)
Message-ID: <92725aab-a540-b35a-6614-2b91039f433c@linaro.org>
Date:   Tue, 14 Mar 2023 09:21:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add Acer Aspire 1
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, agross@kernel.org,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230314064322.65429-1-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314064322.65429-1-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 07:43, Nikita Travkin wrote:
> Acer Aspire 1 is a laptop based on sc7180. Document it's compatible.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 1bb24d46e4ee..903a5ea42cf6 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -352,6 +352,11 @@ properties:
>                - qcom,qru1000-idp
>            - const: qcom,qru1000
>  
> +      - items:
> +          - enum:
> +              - acer,aspire1
> +          - const: qcom,sc7180
> +
>        - description: Qualcomm Technologies, Inc. SC7180 IDP

Please merge with this one and drop the description (or rename it to
something like SC7180-based boards). The sc7180 entries spread a lot and
it is not helping to read the file.

Best regards,
Krzysztof

