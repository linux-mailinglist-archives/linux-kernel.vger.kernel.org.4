Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333B962356B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiKIVJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKIVJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:09:11 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6CB12D38;
        Wed,  9 Nov 2022 13:09:10 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13c569e5ff5so167791fac.6;
        Wed, 09 Nov 2022 13:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8s7hI8Zud53E/E/LGzGpSycc8sTlYS9S0JeTQWZw1BE=;
        b=UHhYLXYYLO1vALkxjqk8LTf/bWb4DbFoNd83qCLsc97RTJ7itzyGWBOttTrSf4sTvZ
         0ZORPOanaOShPT7r7KOlh1P4To5VGCSGvtUbAsv3JhvNSeT5RBdoI1E/zSjNAVto1smY
         ljSA3ppVJuK/dYIMtWHPNlHMqTCgNbEMUGkX81lqbeT6xxQyRKuGWrHLxf0ck+huyM/Y
         IfDikbJ4GRiF43J/QJWaP4fqevx0s9tZaE2IlKbARobBysjSde37p9SN81ltrQQsjFvF
         KhiaCqmwm4CcukXukG2jo8DPCjCUuKGCspN+vU6LY1nrk+/nvXQ444sWIm9Bl/eQ12y2
         Brlg==
X-Gm-Message-State: ACrzQf0jpeJBGMM/LMThJREY4aUqUn92dy3uLVgvubj7LLFINIhxS0oV
        0U+greTtCxOdMF+MF+VB4A==
X-Google-Smtp-Source: AMsMyM5pyAb0lxvqFEiih871wsejSy/ryTVCST1bIhwXfBgU1eV0o3m98wEwHeZxJ1wdpmrhvz7RAA==
X-Received: by 2002:a05:6871:401:b0:13b:c222:456 with SMTP id d1-20020a056871040100b0013bc2220456mr47300571oag.234.1668028149580;
        Wed, 09 Nov 2022 13:09:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g20-20020a4ab814000000b00480fd9f311esm4583432oop.13.2022.11.09.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:09:09 -0800 (PST)
Received: (nullmailer pid 2868041 invoked by uid 1000);
        Wed, 09 Nov 2022 21:09:10 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        patches@linaro.org, andersson@kernel.org
In-Reply-To: <20221109111236.46003-2-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
 <20221109111236.46003-2-konrad.dybcio@linaro.org>
Message-Id: <166802788099.2832919.14556738707192792770.robh@kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: arm-smmu: Allow up to 3 power-domains
Date:   Wed, 09 Nov 2022 15:09:10 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 09 Nov 2022 12:12:26 +0100, Konrad Dybcio wrote:
> Some SMMUs require that a vote is held on as much as 3 separate PDs
> (hello Qualcomm). Allow it in bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu.example.dtb: iommu@d00000: power-domains: [[4294967295, 0]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

