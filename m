Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AAB6DF9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjDLPVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjDLPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:20:58 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608985FDC;
        Wed, 12 Apr 2023 08:20:23 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1842eb46746so14084243fac.4;
        Wed, 12 Apr 2023 08:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681312772; x=1683904772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKxCfL6SruHZgNLTTn9PLrag8agywdXgi/QfGl6O1Nw=;
        b=WkAcrTfay2f4EcehV0zuJ9IZl4eanCCDiR9Zg2Uk2jTY3aGwWazg1ce8AT0EVz+S6q
         tKMDehs30pkYVfEx4ndiGK0M02zh/RvtbbTBWhQ81Ae3bZJgQe+PcrvNYMFTlXCbENXr
         s5+WIZSCNN6tKgtGMmQkK3O9izQH7FPIEAIHKWLsIqMQM4Z4Kd39/c0Gc67rGFZPlvDI
         Z2aFqq0aUaLWl1WewQORc0kmgfzBoZ/RuUcCsDjmEK4yH8+ZBkSCCVQwDmrrqX23K1vL
         vyRekkVZtNVehYmef5yNCt2XAA1nKwwIA6fITZPtZDa0uoarJzNv3FqN4GEq2EZICuHl
         k05w==
X-Gm-Message-State: AAQBX9fRcwgg1uAgIIRvm+w8tGyoV2XZhqAJ5B+pc6Gd1VZmo+iOepQH
        IngmORnOoiAU+k1u53VLSA==
X-Google-Smtp-Source: AKy350Z4J8CElFrPshYTuJwmZJH1wISL1EHX1A+nxTh32ZfS3tSEGu+U0FogB81FgaoTk0uy0wqdoQ==
X-Received: by 2002:a05:6870:b3a2:b0:184:33c:3d96 with SMTP id w34-20020a056870b3a200b00184033c3d96mr3739086oap.2.1681312772256;
        Wed, 12 Apr 2023 08:19:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h42-20020a05687003ea00b0017aafd12843sm6181999oaf.32.2023.04.12.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:19:32 -0700 (PDT)
Received: (nullmailer pid 2454678 invoked by uid 1000);
        Wed, 12 Apr 2023 15:19:31 -0000
Date:   Wed, 12 Apr 2023 10:19:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: qcom: smd-rpm: allow MSM8226 over SMD
Message-ID: <168131276960.2454599.11875851881226051972.robh@kernel.org>
References: <20230410181036.25943-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410181036.25943-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Apr 2023 20:10:36 +0200, Krzysztof Kozlowski wrote:
> The MSM8226 RPM uses SMD, so it must allow qcom,smd-channels:
> 
>   qcom-msm8226-samsung-s3ve3g.dtb: rpm-requests: qcom,smd-channels: False schema does not allow ['rpm_requests']
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

