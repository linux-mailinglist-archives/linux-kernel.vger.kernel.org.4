Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3068EA80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBHJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjBHJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:07:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29632CFE0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:07:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so15992620wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4ZQciB8ZwmkpMVddUcUzrwLwz6Z7cq/83Qj3Q0atmU=;
        b=hkDoqVGsptUTfJqlyT49ejMokW0JYKMZbQol5A5WUZiFInHZ1jrH/PdWqc1S0JMhfJ
         pZW+Q6dzDM4r7+GTwb4D+ZbUzSrymoVGq28pT56o6EyUfYZWAn27ahyQhRFfE3mgxQMP
         jF8yxOoZ1yOy3yE94ibybLSJ8HKo0+SCUH8LmFXpgKa+Fd1xffaVT3vJdjSeKkF+sC0S
         HaXmh7u7oaMNOu3vTDzuH/pBxNTKoU3btXtWBq9cPljLZBJPa6oCCTCf+LAW0I1XhN94
         oohsgeUrECqkRlIt4D46u5zE/UEW8Qts/K8SUIIobyjJJs78L6xcPZ6obac011uONbVC
         uzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4ZQciB8ZwmkpMVddUcUzrwLwz6Z7cq/83Qj3Q0atmU=;
        b=kfh0r8nARkV36Qzg1UY76nW4zc+GRZuBRJiCSr3gXk5rDBtWRl/vsmh7aIK2/dr1h9
         F9rU16M4s5HOmWmQ6DpJR7MHXiSYDkCOT1m7pY4NvhNOVnvCMsqB1NLWru0yRP4/1gbP
         JdQsNYaZwGss9bUY/A1fc8o7lfsW0g8Cj8XUGYWaNS+cdU++O7i3dT/7F/6KyxVBnB8/
         D80lob6R44RvKtdYFr1brNBO8Z6/r1x6GUoXguKHiJ+5sTJuUXUjZHRPxj5p8SgMn3+X
         oCsT34ukdxV6rdKFWIUGQ6EiyVNbZhHUL9l5VXBAUI+o+aLyFO+88y8AHOiwa4pjRDh8
         beZg==
X-Gm-Message-State: AO0yUKUuCgB6zPanIBDI9N9NBSyWKimiliPQhpWRxUaXsOIXPJ3HPKGX
        YIxKWyyR29Vr4m9H+Q9YNO2hMA==
X-Google-Smtp-Source: AK7set+i4/mF3tuzG+szJ2lcPZsyvdjR9PF/3EclzZpQf/1YK2drwfAH9ZsvoZR0IL+XWJwpk2btMQ==
X-Received: by 2002:a5d:6e8b:0:b0:2bf:c753:573f with SMTP id k11-20020a5d6e8b000000b002bfc753573fmr5357264wrz.24.1675847231626;
        Wed, 08 Feb 2023 01:07:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d4687000000b002c4008f0daasm927795wrq.107.2023.02.08.01.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:07:11 -0800 (PST)
Message-ID: <d6338459-1aed-b4ed-52de-941b37ef420a@linaro.org>
Date:   Wed, 8 Feb 2023 10:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
Content-Language: en-US
To:     neil.armstrong@linaro.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
References: <20230207-topic-sm8550-upstream-smmu-bindings-v2-1-680cbfae6dac@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207-topic-sm8550-upstream-smmu-bindings-v2-1-680cbfae6dac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 14:40, neil.armstrong@linaro.org wrote:
> From: Abel Vesa <abel.vesa@linaro.org>
> 
> Add the SoC specific compatible for SM8550 implementing
> arm,mmu-500.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Rebased on new bindings using qcom,smmu-500 & arm,mmu-500
> - Dropped driver changes since we rely on qcom,smmu-500 fallback
> - Link to v1: https://lore.kernel.org/all/20221116114001.2669003-1-abel.vesa@linaro.org/
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 807cb511fe18..bc27919ab9f9 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -53,6 +53,7 @@ properties:
>                - qcom,sm8250-smmu-500
>                - qcom,sm8350-smmu-500
>                - qcom,sm8450-smmu-500
> +              - qcom,sm8550-smmu-500
>            - const: qcom,smmu-500

This still needs update in allOf:if: for disallowing clocks (or
specifying them).

Best regards,
Krzysztof

