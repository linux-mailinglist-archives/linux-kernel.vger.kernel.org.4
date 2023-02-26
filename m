Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68D46A333C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBZRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBZRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:37:12 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3AE1969E;
        Sun, 26 Feb 2023 09:37:11 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id o3so3063923qvr.1;
        Sun, 26 Feb 2023 09:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeF01LQTKaPSV+yQ93rapV3zfUy0qKLEYnaX7XN4O38=;
        b=ihR8gfQ+7ev4LlNaB5baCdFzAa7yFgSFgRZVniyl2Jly+jnedViqgJWTj5CLabik9q
         J/AoLeQxIgt6+9ZoS4+DA65iBt7y/l7Ud83Ntj45laXv3UsddvR2/8ks5KBOuuNRB1Cu
         Atzb4sUAhdBvdlXCSAXDCDgpjwgmsm5NAxyboslpLmrNScCgH5J9KIIAAlf6UPYbvdYU
         wLbEjZou1Oi2QsOD0co5EBn/53AfgSgJk6sGKiEgowvJ4iPzY8tFoLIEOwoPK/NS9LNz
         qO4UBpMO7ZHvJ44pGN4Bk2vaKbjPDJvoywN+MAD2yL2TBrsR/xd04KHZWdDGiK55tD5l
         NbYQ==
X-Gm-Message-State: AO0yUKVqiXJ38UwK4WDiWFQR3jn5BTkACqnXq1vmWOCFwvRcgO87reuV
        YwPJC7Cax1FpimQY7Q7kdQ==
X-Google-Smtp-Source: AK7set9lx5qiJgttqc85n8rLAbbDJ8e24SNnumaCwpqbEuYDGUtgKPCqFotwbIQbTouCNSdj1fegvA==
X-Received: by 2002:a05:6214:27ea:b0:56e:ad32:2d66 with SMTP id jt10-20020a05621427ea00b0056ead322d66mr37723114qvb.10.1677433030778;
        Sun, 26 Feb 2023 09:37:10 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a121000b007417affecdcsm3347213qkj.69.2023.02.26.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 09:37:10 -0800 (PST)
Received: (nullmailer pid 69080 invoked by uid 1000);
        Sun, 26 Feb 2023 17:37:06 -0000
Date:   Sun, 26 Feb 2023 11:37:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: arm-smmu: Use qcom,smmu compatible
 for MMU500 adreno SMMUs
Message-ID: <20230226173706.GA60188-robh@kernel.org>
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:16:08PM +0100, Konrad Dybcio wrote:
> qcom,smmu-500 was introduced to prevent people from adding new
> compatibles for what seems to roughly be the same hardware. Use it for
> qcom,adreno-smmu-compatible targets as well.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> - Add this patch, omitted previously (big oops)
> 
>  .../devicetree/bindings/iommu/arm,smmu.yaml        | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 807cb511fe18..4d7f61700cae 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -75,9 +75,19 @@ properties:
>                - qcom,sm8350-smmu-500
>                - qcom,sm8450-smmu-500
>            - const: arm,mmu-500
> -
> -      - description: Qcom Adreno GPUs implementing "arm,smmu-500"
> +      - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,smmu-500"
> +        items:
> +          - enum:
> +              - qcom,sc7280-smmu-500
> +              - qcom,sm8150-smmu-500
> +              - qcom,sm8250-smmu-500
> +          - const: qcom,adreno-smmu
> +          - const: qcom,smmu-500
> +          - const: arm,mmu-500

4 compatibles seems excessive. Is adding one that helpful? Is 
'arm,mmu-500' useful on its own?

> +      - description: Qcom Adreno GPUs implementing "arm,smmu-500" (legacy binding)

Perhaps fix the existing typo: arm,mmu-500

> +        deprecated: true
>          items:
> +          # Do not add additional SoC to this list. Instead use previous list.
>            - enum:
>                - qcom,sc7280-smmu-500
>                - qcom,sm8150-smmu-500
> -- 
> 2.39.1
> 
