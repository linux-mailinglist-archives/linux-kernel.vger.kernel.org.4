Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B76CD4D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjC2Ijk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC2Ijj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:39:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE8F126
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:39:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t10so59991587edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680079177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rkqB/pSe/Uf7R42daYkgCUwin72MjNO+JZK0n3K2tQ=;
        b=n3Zg/ZOZCZVkFUFIPMFYGKnyC2Gd4zbeu4gOy8Sd4gV7yTM2R3xU/tm4qczpz2p8YB
         NoyQ2Gkk53995Zqiki4UfjrpfOtZDdedjGFjEMIuZut3bIa+RZHXbuTl7kdtKCO57f/w
         MyXOmSCfaULhG7MLuni8qChzuMFQR3Mf7YofJI8BtbkFyq1dpVf9MNSNW++474A7r5DL
         TieFob+JBwnmuSFNexVry2t01GUhpoAHHiNvnqIeqhSa9OwkMTNFw0oNwiTCVqH9rlp8
         ptSMZRZfoSwVJJ4zM2EYsVPvaDnZlxV6pjDeNWh3Gd/4MbTSSVfFlimd0kOyzvz6ZGbD
         YmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rkqB/pSe/Uf7R42daYkgCUwin72MjNO+JZK0n3K2tQ=;
        b=Beco5csmifrhVyzyfgRJdgV2S0Dsm8lQe2ise+nOZ/QPbdU+voo0SiBJdUuyos7Buc
         Juw3l7AIM/uDCCOFlRUBw4jBLepxT6DbrfQ3YfIRm1dcyztwsOlA0icZ2WDTbOqgAgfs
         Wqm8rqyRCYDiCzriiZ7WhL5Ify3Qx1imruPdqtGBzKqv4gSCqvyZc3BGXo7bIzB8EZY9
         WBMmfhfCmAnZ9U2HaXLPEA306zgxxsKdNmQ3hF4WfjOUEnWMQCApX9VYVRUmEX7QqLKG
         bjjHOdzoBoYH+AFzklmw8IykaCzTzQcMWS7AGiPqBw/BGyx37fk6DydBDp5/mIXm4ro4
         7h2g==
X-Gm-Message-State: AAQBX9cuHvJcBkfX6Q/h5vP+hsIoxiNrb4nMHGDA+j32hIkGA2zcGQe9
        ZKmRfu01O/GdBE8eTV+13iHl/epAeJSGS/GtCpYJLg==
X-Google-Smtp-Source: AKy350aLnZoE3VH5F+C9qZoroickOae9EztGyVhx2T4moZpvdDOO2NmhS3zjPSDiQb1l+vkSWljpNA==
X-Received: by 2002:ac2:5966:0:b0:4e9:d85d:9032 with SMTP id h6-20020ac25966000000b004e9d85d9032mr5581749lfp.54.1680078679782;
        Wed, 29 Mar 2023 01:31:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e7c06000000b002a5f91380e2sm1030479ljc.84.2023.03.29.01.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:31:19 -0700 (PDT)
Message-ID: <14688a5c-c50a-4876-e7b7-565b106b431a@linaro.org>
Date:   Wed, 29 Mar 2023 10:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/7] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-5-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328193632.226095-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 21:36, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The KGSL iommu will require the clocks property to be set. Enable it for
> sa8775p in the bindings.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 807cb511fe18..74d5164ed1e8 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -375,7 +375,6 @@ allOf:
>                - nvidia,smmu-500
>                - qcom,qcm2290-smmu-500
>                - qcom,qdu1000-smmu-500
> -              - qcom,sa8775p-smmu-500

Then you need to describe them, like other variants are doing.

Best regards,
Krzysztof

