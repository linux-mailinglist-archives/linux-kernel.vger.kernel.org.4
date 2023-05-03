Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880E36F540C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjECJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:11:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A04259EC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:11:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f182d745deso47577805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683105051; x=1685697051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaoC3PHQvk7zFvJs+Qr9k0+mYfQsIaix2pxrBYU29ms=;
        b=CRXSobVpXSYru4BinE0vENUhBsSPob02mJj0ui0NK0K1IYwnS8+mEqufMpi3CoDpr+
         O++pJbkG9jE8pqX7WHMDs+qSiRKg3fwWQvralelqiwZ0CiJ8Kk71jSxz2HigUFjlbCuv
         bIgDbDf9vji2lR3EvAens+OxkJquZmtxuN/sbcLOtk8V3N5S/rhSxgeMiPa3FHnmxjzo
         TTrQYQVlsNgwb/76C+07arw/mqUugXL4O9sPF+mdPiBaz4f3S+eNjHwtwe8xKcofG4sH
         /e4rPPbPwpySqOjRHNhQHVq7MJAz/ukB4jLEvirSPQxbm3+zWqcvKIV4FgbDdn9lkXv0
         ZYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683105051; x=1685697051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaoC3PHQvk7zFvJs+Qr9k0+mYfQsIaix2pxrBYU29ms=;
        b=RyG61GVaSlKvEhuDBWQtqXTXRHx0qYnA37YpjdmuuOR58qF5L6uJeoVoI+eYtcwIW5
         AGJlCF4pA6QZn0hoSE5tmAiA5E64mBqpH7SdzaK277VnUwQNh7D35nO9bxHw0oUlBr6G
         4cuLNGy6wILmSbqQEEtbecqSNqazGZQLzys4b17b6bTCLxIxdkIPMnu6+bHCOI/xWgqX
         +x3Svs8Wz8j52L/jJjDkyxuXOy++yV0HD2uPvA0a3GkblYj06+nRgdROEjw9el/BQ46Q
         fsbaUv45aAaJ1hXVtYk1EU3u2eKmd/qNAJDB7FRLLHwoHXOV2jnp2oDvp0QPE4yvibXj
         RozA==
X-Gm-Message-State: AC+VfDx8iKg3c1lj5t7wEgxVeaLDJTkGMDFL0u8TyDZT1o4lsz1GM63o
        +/Jys+tsDZheknHCckyZb82Kng==
X-Google-Smtp-Source: ACHHUZ58LnUQtXDejYI1/H8uC+LEG2o4vb+AEPcHMm57SC9SyHauaRURPd/g3/gMpOXT05bilczeZA==
X-Received: by 2002:a1c:7208:0:b0:3f0:a06a:7593 with SMTP id n8-20020a1c7208000000b003f0a06a7593mr14737792wmc.11.1683105050998;
        Wed, 03 May 2023 02:10:50 -0700 (PDT)
Received: from [197.55.55.58] ([93.107.151.186])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b003f318be9442sm1257597wmj.40.2023.05.03.02.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 02:10:50 -0700 (PDT)
Message-ID: <aa193282-b35f-6293-7b7c-c26ed3bd4699@linaro.org>
Date:   Wed, 3 May 2023 10:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] media: dt-bindings: media: camss: qcom,msm8996-camss:
 Add CAMSS power domain and power-domain-names
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230503072543.4837-1-y.oudjana@protonmail.com>
 <20230503072543.4837-2-y.oudjana@protonmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230503072543.4837-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 08:25, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add the CAMSS power domain which is needed for the proper operation of CAMSS, and add
> power-domain-names to ease fetching it as well as the other power domains.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   .../bindings/media/qcom,msm8996-camss.yaml          | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> index 8a10aa1cafc5..27c9a11f0df9 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> @@ -85,6 +85,13 @@ properties:
>       items:
>         - description: VFE0 GDSC - Video Front End, Global Distributed Switch Controller.
>         - description: VFE1 GDSC - Video Front End, Global Distributed Switch Controller.
> +      - description: CAMSS GDSC - Camera Subsystem, Global Distributed Switch Controller.
> +
> +  power-domain-names:
> +    items:
> +      - const: vfe0
> +      - const: vfe1
> +      - const: camss
>   
>     ports:
>       $ref: /schemas/graph.yaml#/properties/ports
> @@ -209,6 +216,7 @@ required:
>     - interrupts
>     - iommus
>     - power-domains
> +  - power-domain-names
>     - reg
>     - reg-names
>     - vdda-supply
> @@ -326,7 +334,10 @@ examples:
>            <&vfe_smmu 3>;
>   
>         power-domains = <&mmcc VFE0_GDSC>,
> -        <&mmcc VFE1_GDSC>;
> +        <&mmcc VFE1_GDSC>,
> +        <&mmcc CAMSS_GDSC>;
> +
> +      power-domain-names = "vfe0", "vfe1", "camss";
>   
>         reg = <0x00a34000 0x1000>,
>           <0x00a00030 0x4>,

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
