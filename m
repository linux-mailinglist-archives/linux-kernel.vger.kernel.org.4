Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA266BD92E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCPTaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCPT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:29:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EC07FD6D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:29:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h8so11864496ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678994992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WyU0qfnRULjYvTUDcZG4NUcXj63E3kuf4oqTEgEhWM=;
        b=QpZ370ktfsNBat3WA/Sytl7eZ2icaf9k5ZVtBvzG+miJw0o3kMpS53pUzaPKYBRzlm
         3RNMMlqqLCDNSmLyPt7rzFqC+e4fvuBk9STtIJQxJmZutKpTl9qYw6x1POw04z6kzTUC
         mBhD+sk7VwyoRxOa4/5+XB7moNAKCb5l8reeiMvisr559sTx3FKtB8sRLssnbgn3heLz
         6DzVS3WrFm01OYQjwtS+uNhqojvO8LfE5Gzve3HvboTn1r02KcYrfAxJ9fynmUczbplt
         wf8G06BjUJVJsXw3O7H0NMaymAngotahtTTmOiIwcb1oM26a7hULDA9hT2FITUrb5NJB
         D2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678994992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WyU0qfnRULjYvTUDcZG4NUcXj63E3kuf4oqTEgEhWM=;
        b=0dYLD/sI9Fs0qmF/AAf/JYyXi2W7ORB06B/vl/qpfY+NEpCtTzBo0cz14CEmTgC16n
         GrPT/2PDnUsyjW7Vt1/nGixUjrmBUc9gCcQ1Xvq+IYt6VsK/DiS/9osn0Tuu8eBXzp3z
         EbL2Xv+pO0lOzhJWR7rFreoqeGdh9nrcZudwcBCgIlNBY4XJFHaATohhXof/8xJEj4Y5
         qhqR2LeQ7MZeFGHzch0DJghqktc35bCRVRdiXCyLwO8Qdiy996b+5yBtHej2eZTdIVhf
         MIHGI0MbT/V2124bPtuylvRU0xnSecwnxw+ltarAhapwLsQ/s7ElwEzjXvmMZcE2fJbC
         UvzA==
X-Gm-Message-State: AO0yUKW8k7rorzAOANlfQ5GsOylXB1U5eNReYXghMyKjbfKE6A4jwldb
        m4k6nylG35vIx42EvGfwi7+dXw==
X-Google-Smtp-Source: AK7set/rsWHRHF7nlHEmPrEiunpAYhgOMGUC46mRl1vyeV9hyy07MsCnraZ9ocmj2iYUnIVfgEGT5g==
X-Received: by 2002:a17:907:c304:b0:8ae:e724:ea15 with SMTP id tl4-20020a170907c30400b008aee724ea15mr11491159ejc.76.1678994991923;
        Thu, 16 Mar 2023 12:29:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b008d1dc5f5692sm17887eje.76.2023.03.16.12.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 12:29:51 -0700 (PDT)
Message-ID: <f09e93e1-235a-ea0a-902d-4f41a8c90ee5@linaro.org>
Date:   Thu, 16 Mar 2023 20:29:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
 <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
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

On 15/03/2023 11:52, Konrad Dybcio wrote:
> Both of these SoCs have a Qualcomm MMU500 implementation of SMMU
> in front of their GPUs that expect 3 clocks. Both of them also have
> an APPS SMMU that expects no clocks. Remove qcom,sm61[12]5-smmu-500
> from the "no clocks" list (intentionally 'breaking' the schema checks
> of APPS SMMU, as now it *can* accept clocks - with the current
> structure of this file it would have taken a wastefully-long time to
> sort this out properly..) and add necessary yaml to describe the
> clocks required by the GPU SMMUs.


> +      properties:
> +        compatible:
> +          items:
> +            - enum:
> +                - qcom,sm6115-smmu-500
> +                - qcom,sm6125-smmu-500
> +            - const: qcom,adreno-smmu
> +            - const: qcom,smmu-500
> +            - const: arm,mmu-500

If you drop the hunk later (from allOf:if), then what clocks do you
expect for non-GPU SMMU?

> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: mem
> +            - const: hlos
> +            - const: iface
> +
> +        clocks:
> +          items:
> +            - description: GPU memory bus clock
> +            - description: Voter clock required for HLOS SMMU access
> +            - description: Interface clock required for register access
> +
>    # Disallow clocks for all other platforms with specific compatibles
>    - if:
>        properties:
> @@ -394,8 +420,6 @@ allOf:
>                - qcom,sdm845-smmu-500
>                - qcom,sdx55-smmu-500
>                - qcom,sdx65-smmu-500
> -              - qcom,sm6115-smmu-500
> -              - qcom,sm6125-smmu-500
>                - qcom,sm6350-smmu-500
>                - qcom,sm6375-smmu-500
>                - qcom,sm8350-smmu-500
> 

Best regards,
Krzysztof

