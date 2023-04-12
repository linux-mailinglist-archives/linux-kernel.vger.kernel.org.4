Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4916DF71F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjDLNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjDLNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:24:51 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899259ED0;
        Wed, 12 Apr 2023 06:24:23 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w13so28228580oik.2;
        Wed, 12 Apr 2023 06:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681305786; x=1683897786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7nW6mawiUuyYszKT+ZrkBThDfGBOABkC1FpPQVvJWI=;
        b=XcT9DruApjzDiS139B4vZXzxQ2d/u4KE8o8WqcnOhetJ4P2o/23swtdE647D9AiSFN
         cSkQZh6Z+lzgzKdGpkxeMRRbbbWexlA5bDqNuhFIr0uSd8eVqrieUmbjIocaH7C5UjH8
         eK0HHldjlxWM958Tleh2nVDUjTq+VWypkAhR3CJKKhf4i8QTz0GwDviTpGp9IEmto5T1
         aOmhkInlkM4TyGlk6W9l7BayBQAWmJ7XUo6IjA4gHm65h8xN+/5vKBiPmXUUPZanDGBm
         DCnEVEaVRxv9bWn+HJ1vDQCFZYafIi4hyQ3IrGCxseT83RCIRYu0OehvSPMWMlSAtPXa
         96dg==
X-Gm-Message-State: AAQBX9enuxb3l1CMWGrIMzzsHITjRJnC8y9Mx/RIQCOiB85ZuoVw7xB1
        8fnO6uQHJc89ZnxHU8ZpJ2xh3VxkuA==
X-Google-Smtp-Source: AKy350Ze5ahkO+i51YqIaIv90DMIyhWWgOpcR5PQ65mfFvNAEbx1vXIzAmE9jG1S0P8ZzwcVpdix5g==
X-Received: by 2002:a05:6808:3a7:b0:389:2d2b:4b05 with SMTP id n7-20020a05680803a700b003892d2b4b05mr6088608oie.5.1681305784977;
        Wed, 12 Apr 2023 06:23:04 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fe6-20020a0568082b0600b00387372f548asm6562499oib.16.2023.04.12.06.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:23:04 -0700 (PDT)
Received: (nullmailer pid 2007502 invoked by uid 1000);
        Wed, 12 Apr 2023 13:23:03 -0000
Date:   Wed, 12 Apr 2023 08:23:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski@linaro.org,
        neil.armstrong@linaro.org, djakov@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, rfoss@kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vladimir.zapolskiy@linaro.org, konrad.dybcio@linaro.org,
        bhupesh.linux@gmail.com
Subject: Re: [PATCH v6 05/11] dt-bindings: qcom-qce: Fix compatible
 combinations for SM8150 and IPQ4019 SoCs
Message-ID: <168130578228.2007207.11606069055162808337.robh@kernel.org>
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230405072836.1690248-6-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405072836.1690248-6-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Apr 2023 12:58:30 +0530, Bhupesh Sharma wrote:
> Currently the compatible list available in 'qce' dt-bindings does not
> support SM8150 and IPQ4019 SoCs directly which may lead to potential
> 'dtbs_check' error(s).
> 
> Fix the same.
> 
> Fixes: 00f3bc2db351 ("dt-bindings: qcom-qce: Add new SoC compatible strings for Qualcomm QCE IP")
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

