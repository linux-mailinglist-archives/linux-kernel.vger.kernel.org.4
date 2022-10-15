Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581885FFAE2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJOPQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJOPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:16:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2ADEE3C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:16:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d13so4281833qko.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKv2Neqe+SMtTTaijkh7FooflaU4DtlHbUVwh4pOmRs=;
        b=dcZZqpG1ymU7in9PwT8w96vP85gCCag0+LTF/F+enSV5ZYsYpc5KImoUFpR05+0/0x
         VN7iKgkvgTN1fv3uvlOpEcU2vbVNHKWvfTPNnLQJdsEMpqd+bddrLfH2caIBqEXhzEiz
         4WH9O+zEMQv74ORexScnUaCMdf9dcQIITr522qUfVPb+dhifTchRm9jIPXQeTQMZxJ2t
         W4RZmOWlhfRXKoAVRcdY0IhFwQCXFnmJF38FSjmnzWjLR+qTL7AkIOaUwK8GWoSP4wAm
         FUwlrFag7IYp5Mk9PzKzSKOThZhGh5vQJSVb1N3frmXCOFpVofIK8pY3RZgdYZpHR3Y/
         fBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKv2Neqe+SMtTTaijkh7FooflaU4DtlHbUVwh4pOmRs=;
        b=IDOo4oldpR4PeB9mXQsfkClOemMjeYJzNFpmCmKg5gEs2uLGSryGnjVBGT0cdX8XQ9
         DCD6/SyDfj7OYMB/J1KEH3lzfIfeFEmcywUu5FtuE24Eyi+hoDy6GZ67U1Ut5uQMFVMB
         WC9dzyWI2RnuqJKKDYArU29W20R2aaPVrpwgaBOnzxkujd1qgxk2U2i9u4lnaAwV+ww0
         l2yhWrGCdFNx2VMMFp13zes1SOcB+pwq0ZFmowfL5naieUO/i0o4ssmGKiyecrm1te4D
         0lFXLP4kc/bnQkcK8GL+lzT+9FA4r4GRXWsgIQ4Jl1cfIvYHEn+722ilxawzSHngihA4
         SGSA==
X-Gm-Message-State: ACrzQf3cp9bNTQZc/QSYGhuIgxxpbPHPvmo11yTFVynqSpGGy5USODZ0
        2KMI2VpaGbHZno2w4P58JzoAjepKr6mCww==
X-Google-Smtp-Source: AMsMyM4mPw863JV4jFsOwm4iIwTcWvBxioxfHu1/Ugvy7rmvL6ArxQWzrw7RToxMuGaVpm7WZz+jmA==
X-Received: by 2002:a05:620a:29d2:b0:6ee:cdf4:c141 with SMTP id s18-20020a05620a29d200b006eecdf4c141mr2126155qkp.236.1665847001702;
        Sat, 15 Oct 2022 08:16:41 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9477:c2f0:ddea:ea08? ([2601:42:0:3450:9477:c2f0:ddea:ea08])
        by smtp.gmail.com with ESMTPSA id h16-20020a37de10000000b006a6ebde4799sm4607619qkj.90.2022.10.15.08.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 08:16:41 -0700 (PDT)
Message-ID: <fd36ae9b-2f15-43a1-51dd-bed475f12e5b@linaro.org>
Date:   Sat, 15 Oct 2022 11:16:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/2] dt-bindings: arm-smmu: Add compatible bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221014221051.7434-1-quic_molvera@quicinc.com>
 <20221014221051.7434-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221051.7434-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:10, Melody Olvera wrote:
> Add compatible bindings for Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9066e6df1ba1..ae314436eddb 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -34,6 +34,8 @@ properties:
>          items:
>            - enum:
>                - qcom,qcm2290-smmu-500
> +              - qcom,qdu1000-smmu-500
> +              - qcom,qru1000-smmu-500

No. You sent entirely different DTS.

Best regards,
Krzysztof

