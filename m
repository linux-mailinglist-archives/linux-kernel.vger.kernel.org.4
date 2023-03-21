Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AC06C3CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCUVbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCUVbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:31:42 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AABF979;
        Tue, 21 Mar 2023 14:31:41 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1755e639b65so17660957fac.3;
        Tue, 21 Mar 2023 14:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6EMbcpDu9bwoFOMVQ7b9hqITsnjtD+Slk1Wg1A5A4k=;
        b=p8u9unjItuOVdKQYs+FDNRz0bRKC780dwnsG0F3HDz5Tng1JDgWv6WlIMuFYL56xkH
         xqYakR57+4wrJOyRuSqRjfsVMfIWJcESw2lGCwW54RnxUBRx3CG7GkTE+2/Oowqbp1cq
         5ohb+e6wed2mVIidEEMAtY0GmVGBNhG60SAnnOcW6v3FD04tuyN5H2fq3YN9wocVSRhu
         64pgsDR2R7HZHyyz14tEY5SkW3t67NRR4y0aFP/ncpjcipvN2pNoSAHltgEEAEz45DzR
         5uOoYibwn+48Y5hCtBrGjgUnVzGdc9YtJ50eCz2kZkO1jJnhjcsziVbpT9BZ8xhakxeG
         o7iQ==
X-Gm-Message-State: AO0yUKUCykFukhmjrjzvYU0zmtS28CTkyuDILRbL1SQgSNVi6aZRHBjg
        qLNQuynF2BCBMicIILZWzQ==
X-Google-Smtp-Source: AK7set+uBxVWDvvha2L0vKeucagDGgBaYKqeww399SevYlJwvqqx22YAAJzLiI5Pc2uOUFu/Sq7KQw==
X-Received: by 2002:a05:6871:72c:b0:177:c2bd:3f70 with SMTP id f44-20020a056871072c00b00177c2bd3f70mr266082oap.54.1679434301131;
        Tue, 21 Mar 2023 14:31:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id vd21-20020a0568708f9500b0017ae1aede32sm4539991oab.46.2023.03.21.14.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 14:31:40 -0700 (PDT)
Received: (nullmailer pid 1647773 invoked by uid 1000);
        Tue, 21 Mar 2023 21:31:39 -0000
Date:   Tue, 21 Mar 2023 16:31:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        linux-crypto@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org
Subject: Re: [PATCH 1/1] dt-bindings: qcom-qce: Add compatibles for SM6115
 and QCS2290
Message-ID: <20230321213139.GA1646917-robh@kernel.org>
References: <20230320073816.3012198-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320073816.3012198-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:08:16PM +0530, Bhupesh Sharma wrote:
> Crypto Engine block on Qualcomm SoCs SM6115 and QCS2290
> do not require clocks strictly, so add compatibles for these
> SoCs, indicating that they are similar to the flavour
> found on SM8150.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> index e375bd981300..e6840d124af3 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> @@ -35,10 +35,12 @@ properties:
>  
>        - items:
>            - enum:
> +              - qcom,sm6115-qce
>                - qcom,sm8250-qce
>                - qcom,sm8350-qce
>                - qcom,sm8450-qce
>                - qcom,sm8550-qce
> +              - qcom,qcs2290-qce

'q' goes before 's'

>            - const: qcom,sm8150-qce
>            - const: qcom,qce
>  
> -- 
> 2.38.1
> 
