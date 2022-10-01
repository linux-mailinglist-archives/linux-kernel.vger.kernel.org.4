Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE035F1B59
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJAJbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJAJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:31:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC943ECE1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:31:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j5so2521519lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OPfl25g/giEEq6/URj/gnsIrrRKtqhe3mYHzko5cpxQ=;
        b=TRclEY31FpPbHNaYO30tTXK2AvTBa3TrAgGkSgOOHwrPokwhXdBz+eOek0rGKxsn7X
         1oag1oKaop3aolqbv0e4VqMMfc/aPYp41y0KLbE8Lsim0clZCqECM6/d79A8ZmxAGUn9
         G74lhKvnJ27amIX45kaC3nvXb1jZdZgGAdXXTbuemBC6u9G6mi9/DijmacxSCre/xleX
         2i6ihQ30Jmg0LRZbOb88TD2JJ5lOQ6PshHMKj1PFcUzF/MOBelXuRyDmuZiZGavGwzs9
         oaxpln9hMlpwgiNmCw60yvlp3VuB0vNGYJjWJlwK7iPKyj4RJwjijsgmg20kbNCnL6oc
         /cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OPfl25g/giEEq6/URj/gnsIrrRKtqhe3mYHzko5cpxQ=;
        b=zkZfK3GtUnXRaXbb9lKUUZvW498MLtUmdopLB4vU+nbUdrFJakdWBFik7WFvj5dM97
         M7N7NDkj4N1we4EByEXfMWXa59vpWA60r4w5Be9QBjSfp7fFNPDkQDFNsesRsPMIpb+d
         q22dtDkYIfNfj2MHRGgGH97RNatQxM2EBmWSO8LL3kTc0A6VtpE8Sc7HSTsM9z4jGOS+
         t75nR1hNrDGn3uek4ZmwAtTH6cRCxn6d/jwZRvwiBQvQl4f61v8xzlJ3C9KsTaKTaBi2
         teTo03t4TgUHNOwMEs0de8g2KBYDfLCvCBrygnGvifOvtXh7M5KtmJHOTWS1m34CZIyV
         NdOQ==
X-Gm-Message-State: ACrzQf3k32updCrAu1/8ZOtXqTrYS2uFMUEq1BLfbdQfKF11qZsFgUeo
        Q7yFZQFmMU0YDmlS26f5TF6GS9iXT1OBrA==
X-Google-Smtp-Source: AMsMyM4wmKBDRMvXcYVlSQLO4nVAqLejQwyddTgajyuQ/AgZxXDj4YjCOpSikKhzYVKh2x3t2jhY6w==
X-Received: by 2002:a2e:a801:0:b0:261:91a3:bc44 with SMTP id l1-20020a2ea801000000b0026191a3bc44mr3822189ljq.497.1664616698192;
        Sat, 01 Oct 2022 02:31:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512308d00b004946bec4e7fsm707140lfd.41.2022.10.01.02.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:31:37 -0700 (PDT)
Message-ID: <8e63f6a7-a133-1f20-403a-5b0965cee107@linaro.org>
Date:   Sat, 1 Oct 2022 11:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030615.29135-1-quic_molvera@quicinc.com>
 <20221001030615.29135-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030615.29135-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> Add compatible bindings for Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9066e6df1ba1..681035b6e991 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -47,6 +47,8 @@ properties:
>                - qcom,sm8250-smmu-500
>                - qcom,sm8350-smmu-500
>                - qcom,sm8450-smmu-500
> +              - qcom,qdu1000-smmu-500
> +              - qcom,qru1000-smmu-500

Wrong order.

Best regards,
Krzysztof

