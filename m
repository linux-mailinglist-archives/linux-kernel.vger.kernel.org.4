Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10B7394E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjFVBuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVBuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:50:21 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA43135;
        Wed, 21 Jun 2023 18:50:21 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77e29871264so205058139f.0;
        Wed, 21 Jun 2023 18:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398620; x=1689990620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2Mze3/Yq/nh7qSNdsMivay/QWy7TAVvFvMJtevVwEw=;
        b=LxOENwPGudg7uw5nUaSHRY7hvCyIhaYlBZmSimvPOswf1xBvCEJx31g5ko2klDk7Az
         m/LBjBuu7ad47o5LEyDivlmPBX3n8TNEuGyztYGJ5Vi3B+SDb0vrhrK2zGGYa3b9xpWF
         MC7ZBVfkg1JmXOD/KIwEYAKFweJPm5bPEugjMfiVMi8ZlVzVxa+w/uFvng27ezj2j+AJ
         +BXvN/OlsD7b6sMuUVlTPc70IUa9neX1nGdoO8xeu4qDAE+s2RqgnJ+f40sNXRmicxOK
         HRtdYSAaw7BcwbQ/6/F0DeH1UDGzCUFA8EueFCNXbbeWZG63zgcat1VpqWZPeKkSBs+2
         oVSg==
X-Gm-Message-State: AC+VfDyH66NOvUzVy6NpDsAWfJ7GFSjkAjC8+RRURQMinEXJ0xC9IJw9
        GtmR86SBt34rOE8qtrbL8Q==
X-Google-Smtp-Source: ACHHUZ4gHN5lx1VNqA3lrz/AK7vtmABjF34d3XbtEGB/rEnEY1QOupGofcoS2U+XLPoKgUexzlli/A==
X-Received: by 2002:a5e:8909:0:b0:76c:5ba7:7ef with SMTP id k9-20020a5e8909000000b0076c5ba707efmr8875578ioj.3.1687398620326;
        Wed, 21 Jun 2023 18:50:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s26-20020a5d929a000000b0077e3b1ffb52sm653456iom.12.2023.06.21.18.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:50:19 -0700 (PDT)
Received: (nullmailer pid 40156 invoked by uid 1000);
        Thu, 22 Jun 2023 01:50:17 -0000
Date:   Wed, 21 Jun 2023 19:50:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        dmitry.baryshkov@linaro.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/6] dt-bindings: iommu: qcom,iommu: Add qcom,ctx-num
 property
Message-ID: <20230622015017.GA37013-robh@kernel.org>
References: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
 <20230620095127.96600-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620095127.96600-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:51:22AM +0200, AngeloGioacchino Del Regno wrote:
> Add a new "qcom,ctx-num" property to force an ASID number on IOMMU
> contexts where required.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> index d9fabdf930d9..0446ccc4116e 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> @@ -71,6 +71,11 @@ patternProperties:
>        reg:
>          maxItems: 1
>  
> +      qcom,ctx-num:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The ASID number associated to the context bank.

If the value is ASID, then qcom,ctx-asid would be more descriptive.

> +
>      required:
>        - compatible
>        - interrupts
> -- 
> 2.40.1
> 
