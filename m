Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9966D52BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjDCUlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjDCUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:41:29 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CAAE1;
        Mon,  3 Apr 2023 13:41:29 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 6-20020a9d0106000000b006a177038dfeso7157717otu.7;
        Mon, 03 Apr 2023 13:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9C/3hBrTR7K2nHN4gC1rv1X/TFSh2EbFRlM3X5whh8=;
        b=4DJ0H4/8HyQvdTG70jhQVWFCoVFtsuki6y+O9Vye9ynNm8+FQXDZy5Ilhb8sPpNInW
         pswVY3FgVMZdUDBzDE3TsHqulppzQtBFbS26FFYknRLtyX02Mflyib3heZy08mZ0yhMw
         aZpgK0WFED8IoTmEeJ65r4lo+af4AUYFS5H24Lxbqp/n3TJZcX5QJDtA6ZjQr9dhFcZ4
         E+lRZEA9j61i7KNjPsa8HQAmciF1yB7Gucb7GFu7aYNu+N7vOKZCv4S+oFjorxdHpuWY
         MirDsgjxGSLbyAMG5Vd/v0aacH0uADYyVtsiEaJccWppq9JGrosgMazf6dRQ+G3qVkh5
         F8YQ==
X-Gm-Message-State: AAQBX9eu32GBPNiNZEDwrwvWyTRLUYcEYzHHTVsgb0QooeSeLIw1+s+3
        Ub1pdcq4CZ/13NFrYa3dzA==
X-Google-Smtp-Source: AKy350bLaMZm4zgOYFd0dWu6aGZldut/svNiHGH7Kc2jWFeeDzQmIG9nsGYpwa5jcpaQGkCUr2yC+Q==
X-Received: by 2002:a05:6830:571:b0:6a1:2a17:16f2 with SMTP id f17-20020a056830057100b006a12a1716f2mr8533665otc.1.1680554488633;
        Mon, 03 Apr 2023 13:41:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z1-20020a9d7a41000000b006a144b97e73sm4629237otm.74.2023.04.03.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:41:28 -0700 (PDT)
Received: (nullmailer pid 1710521 invoked by uid 1000);
        Mon, 03 Apr 2023 20:41:27 -0000
Date:   Mon, 3 Apr 2023 15:41:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/7] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p
Message-ID: <20230403204127.GA1708388-robh@kernel.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328193632.226095-5-brgl@bgdev.pl>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:36:29PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The KGSL iommu will require the clocks property to be set. Enable it for

Isn't KGSL the name for QCom's adreno vendor driver? What does that have 
to do with bindings?

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
>                - qcom,sc7180-smmu-500
>                - qcom,sc8180x-smmu-500
>                - qcom,sc8280xp-smmu-500
> -- 
> 2.37.2
> 
