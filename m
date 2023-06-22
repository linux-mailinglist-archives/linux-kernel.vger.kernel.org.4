Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6673A3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjFVOw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjFVOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:52:52 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25C1BD1;
        Thu, 22 Jun 2023 07:52:51 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77b00bb3fd6so16358439f.1;
        Thu, 22 Jun 2023 07:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445570; x=1690037570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2zm8McjBvSHDaGmBgl+/DFbo4FGaTvp/UrUy9Rpg30=;
        b=X+OWdUbEpuq5oC2BTkni3c/V9XXUQ2quevu0zSNUvtr6pNxCnwCkfXw92FTEh7zzoc
         Fo7L/9AplHzL5K1nsi8XgeHltNWl5isWHiW0kgMO+RxITI0XGe7nC4irw0Cj/yqk7yg1
         wI5FVSm08FJiYMlz8nzjRBRjCrpkxkb9qDqU+19DY9UXJ7P1m8pum8/OtypACqB6baz7
         eYyF7DtrfjpGfyomQGBeDCHuq8j/GDDzb1uRaTaulIyffNFk3Vh/ANJj9w8dvV9ZKgxY
         rzkz8V9NnYGQVFycdHNd2J5omAT9a60rm26wbiW5ZpfMv5WDwp20X+/Dqv0ogat7KYVu
         UWgA==
X-Gm-Message-State: AC+VfDykvG6ceITSYWxxUG6qtL8nAajL+XST8wBxiJRPCFR4NP5htTKJ
        mzB2xKAGzWjFQwGH694Qi01frwSbWA==
X-Google-Smtp-Source: ACHHUZ7BssGZaMe2LWzZc7NLHZQSRnh/rv9M54Q4CRtuhN69oQddGV8O5QHBtsyb4/QqnwdeDwMwRg==
X-Received: by 2002:a05:6e02:d03:b0:33f:c2f8:e503 with SMTP id g3-20020a056e020d0300b0033fc2f8e503mr11307806ilj.5.1687445570232;
        Thu, 22 Jun 2023 07:52:50 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id eh16-20020a056638299000b003e8a17d7b1fsm2098979jab.27.2023.06.22.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:52:49 -0700 (PDT)
Received: (nullmailer pid 1686676 invoked by uid 1000);
        Thu, 22 Jun 2023 14:52:46 -0000
Date:   Thu, 22 Jun 2023 08:52:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     andersson@kernel.org, luca@z3ntu.xyz,
        krzysztof.kozlowski+dt@linaro.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, agross@kernel.org,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, will@kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com, dmitry.baryshkov@linaro.org,
        konrad.dybcio@linaro.org, joro@8bytes.org, conor+dt@kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: iommu: qcom,iommu: Add qcom,ctx-asid
 property
Message-ID: <168744556630.1686619.1948595274939844483.robh@kernel.org>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622092742.74819-2-angelogioacchino.delregno@collabora.com>
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


On Thu, 22 Jun 2023 11:27:37 +0200, AngeloGioacchino Del Regno wrote:
> Add a new "qcom,ctx-asid" property to force an ASID number on IOMMU
> contexts where required.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

