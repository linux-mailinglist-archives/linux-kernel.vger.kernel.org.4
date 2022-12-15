Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE764DD81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLOPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiLOPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:13:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E931EF8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:12:42 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id x11so10210339ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rn0RaW15PCbv1iZnOn7lxQD1NhmhYoptHXukfEvlnlc=;
        b=x0ru9/MG7H41Yo1GvyZQ9Uuy5hFJQZ/0bS/Z6cgyMoizdorRbA/8LxLgiqGbgv6xKe
         f/Nd8nLPv4AraPILAZqiGBCZycLVXz/3Mn9VeUML/hFHdA8Q28+U6JJuvl295mkjZooP
         nOEF5+6keQ9w2zmT4gOdWuLHSKYSzfGi1J7+m6R0/zHVT+lTYcqRUVKVVKCDmK7bbzrC
         CcHaBkp91EYZM7Vug5hmtKtEPfsl2QqCnmd1V5dijy1y3Nf01/qooMucYRh/krCeZFZM
         2Mlsuwo7/IvJa8DweXvlynyFsyPvnslfkVjsj0YPoJRdN0288r4HQ5c9IXaawcBN1OrU
         ONrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rn0RaW15PCbv1iZnOn7lxQD1NhmhYoptHXukfEvlnlc=;
        b=NMdWxZjWMtcxxPNP+yVPNU31VmZFiVbX3+RIDzm7MIS7Z19ilMOtp8WO+mPL2JoonA
         tK0kD2YQFOXRG4soA911Q+3hj7/kLJTw9W0m1p+3f2fRsJxUGFH4rc8VIZAoKehXwt/f
         OnUX6AdpMdFwEue6bMuglHAW/zsHOieUIEzrTlFNGLPYFK5zjidtK+mH5TAStidpC+l4
         NZacjrUaLb3CQ99CGmo6A6o3rapTW3XpBsPDV5AV6zOMsokFvfxX5ltW0pdzBdc8nIGo
         paZzigRLDdOnyvAmygowYEIlkPCIOzjumm7EDHSuQqJtbp+4wutqY0Rgk2hox8O0mCi4
         US3g==
X-Gm-Message-State: ANoB5pksWPdfqkZ2wNxe+jTBltVyodxehU1NvWxS1YOZnJyd9SqU09eH
        XMx5onpGGESZaa3tw17flvGg1w==
X-Google-Smtp-Source: AA0mqf450ET8qyKL5V67vM4NujcATbDhymaDU8EkzcrVkIqi6ho8k0R6oYRIKx/hFZAOzih3RrEBbQ==
X-Received: by 2002:a2e:95cc:0:b0:27b:65e3:3e93 with SMTP id y12-20020a2e95cc000000b0027b65e33e93mr2883452ljh.45.1671117160247;
        Thu, 15 Dec 2022 07:12:40 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f13-20020a2eb5ad000000b00279cbcfd7dbsm861184ljn.30.2022.12.15.07.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:12:39 -0800 (PST)
Message-ID: <2e613245-26a1-c51c-cbb3-b34a88f178f9@linaro.org>
Date:   Thu, 15 Dec 2022 17:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 4/8] dt-bindings: arm-smmu: Add compatible for Qualcomm
 SM6115
Content-Language: en-GB
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-5-iskren.chernev@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221030094258.486428-5-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2022 11:42, Iskren Chernev wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
> DeviceTree binding.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9066e6df1ba1..71f8f638a1f8 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -41,6 +41,7 @@ properties:
>                 - qcom,sdm845-smmu-500
>                 - qcom,sdx55-smmu-500
>                 - qcom,sdx65-smmu-500
> +              - qcom,sm6115-smmu-500
>                 - qcom,sm6350-smmu-500
>                 - qcom,sm6375-smmu-500
>                 - qcom,sm8150-smmu-500

Please rebase on top of linux-next and use a generic compatible + SoC 
specific compatible.

-- 
With best wishes
Dmitry

