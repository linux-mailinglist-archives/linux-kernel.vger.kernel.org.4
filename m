Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926215F1B5B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJAJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJAJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:31:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406D6053B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:31:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o7so2953254lfk.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aii+1xRQiFdmSud1Epdrtmy2A14HX4EldZ4/DuVxcqA=;
        b=Ww0npKCPlLN9z7TCf10hqTFnY5Y/SrVYnPKePOZzAye4KvJCScPpURYT77pK3aFZ/s
         rE8C7cJMXKC80v9o6UXxkW0Ip06ykdS+bq4jXD9Gk3SWOtrcCcgrQPXsoSu2QoVKaBb2
         9tL6cC1WOJkUah5ueERHBH1xeVSsaqSWnIN2uU5ToXVXVAcr4Zb1bjcCNMqVvVyGh+US
         7VflkgcHUkZyrT4atXN+1xVDAdFM8LHCqI3vUY3Jk4FU3pWiIHpmaxKSCijmdk1D8npC
         iLOPWn53J7iRUEOJ2yPmWo3bYabpzselP4DJ//M1M2vgCAH60KQN7jKb/cQDzqO+PCGU
         TI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aii+1xRQiFdmSud1Epdrtmy2A14HX4EldZ4/DuVxcqA=;
        b=nlKVbE0+0HRpMB7zJfSTEtVW5JljahAzbxx3hKTlkPOpmAIKJPcMPRHn2kJPn33bd7
         wvxqNBO5vmcNaGy8sefdsKmEK8Q/8rjjyKOCQNyACowNnD0kZYXD5LzQPHu6ac/+foac
         IVPMiRitETIaj/R+7jHPZF8zP3DG57UigGLbcLzUmchoNN21RKzr0bUl4LR8rcW0l1bj
         TOlm7L1cNUGShLIvGbJ3NBWSy4xrCqdic73zI0Vl4vT67yYqNnSFu2DDeKu3ykTSLxl3
         PmlcUAWL/RJtD6p5Kkz5p5Wl7uOk6E10vpMCuq5Slg6Cm/SO900ReAdpMYf9M8HTUuCa
         3mgw==
X-Gm-Message-State: ACrzQf3DB21KBPtcjzYCqzUgjsDZSl57QdwwR/ZQHugLa6epie+vIx8J
        d4czjvMiW/JS/3HvzfUrmq/5dg==
X-Google-Smtp-Source: AMsMyM4KxhgR//pVV35Y1++UWyWkt0ioN/B6mDDINOeGKg0Atww/SjKTrdSsjScFs3bonah11z2u5Q==
X-Received: by 2002:a05:6512:3116:b0:49f:4eca:fe07 with SMTP id n22-20020a056512311600b0049f4ecafe07mr4324067lfb.442.1664616711437;
        Sat, 01 Oct 2022 02:31:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651210d000b0049f53d53235sm707224lfg.50.2022.10.01.02.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:31:50 -0700 (PDT)
Message-ID: <4ea2b04a-c328-ec24-1231-33895607233e@linaro.org>
Date:   Sat, 1 Oct 2022 11:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu
 implementation
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030615.29135-1-quic_molvera@quicinc.com>
 <20221001030615.29135-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030615.29135-3-quic_molvera@quicinc.com>
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
> Add compatible for Qualcomm QDU1000 and QRU1000 SoCs to add iommu
> support for them.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index b2708de25ea3..2b9a3c917aae 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -439,6 +439,8 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sm8250-smmu-500" },
>  	{ .compatible = "qcom,sm8350-smmu-500" },
>  	{ .compatible = "qcom,sm8450-smmu-500" },
> +	{ .compatible = "qcom,qdu1000-smmu-500" },
> +	{ .compatible = "qcom,qru1000-smmu-500" },

Again wrong order...

Best regards,
Krzysztof

