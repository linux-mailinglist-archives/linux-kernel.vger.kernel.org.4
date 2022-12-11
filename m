Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D7A649635
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiLKUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiLKUZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:25:22 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C9BB4A4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:25:21 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f16so10536372ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvnmBg+wjEMu6Ecd13n5hlBuTm6xRu0psM5TCiPShP8=;
        b=CPPTttF3veuPhl+0OsZn4g4JA8R+ZeE+v1onuxOUkHgU/z9LXrMOUBvipedpP1bjeD
         oMtIHSeChW65Pe5PwYGD+T39PLzztauNN9+7PW8S0wBifPoAbOamhUp76gAQDOYGCj39
         GPDf9z7DKZeis/v/0Y7wRgQKSLYMRFTAJSH3/fDjNmjVwvesbk86CvCBXA1MZi0dVmM3
         8VDIE4M7645XS9tV4b54LWiQlaRFb37FVCb2H2PGtTTGUzx3ItZP3V+5WUv0X6QDvN/d
         HJxMoWFO6bthgiOmvFwKoKHa7iDVMG2yOXnpPPgmTRQr9D5eHGKeU3ibdyr2Y72iz74V
         srrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvnmBg+wjEMu6Ecd13n5hlBuTm6xRu0psM5TCiPShP8=;
        b=6cC85hXl5cli8Y+CaLmw2WgnIV+8DBSa8bKS3ZYdrZxybeOilVP4ZVqKhN47LBtM2F
         YMwm5zo9rvgoyi8kpzmG7iybJ9YYAd4OA0pep6tyiq8lvdV8h4PTTimLx5sVuFg8wzZV
         dOE1Q9aB01PINfz3luS1f3WdxCRa5ZnQ8oJRApfnNTEB4VqYCxvmMp5mbCZL625C7Suk
         X1vaRK3FJjb6qNWONtWr0zuG+nrhcmXoYEgQqrb1rN1WQDnlWVlNd320LpK261FqnG9k
         MFv2r2epE/D0+EPj+fNV3qgTtXMAFX2+ZXBnvlGDSX2PXGYeqioFgJ6lFJ2fAggNoO7X
         a2BQ==
X-Gm-Message-State: ANoB5plXxIVXNQMWohUEfqgRDvUd/zpJUWLhOuzqM9VxuWFqkemxDN6Z
        b9Kycf18vH7G7nUdM6tT8UCVJA==
X-Google-Smtp-Source: AA0mqf7cWzVZVXM2E9MCbIPzvU1Uelu5QcnCtkZVtNsg4DfR+yjzo8eAGsT/GGyl8RSukfjo7cZGHg==
X-Received: by 2002:a2e:b634:0:b0:27a:131:2649 with SMTP id s20-20020a2eb634000000b0027a01312649mr3404577ljn.35.1670790319807;
        Sun, 11 Dec 2022 12:25:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f1-20020a05651c02c100b002799d981c0esm1013104ljo.118.2022.12.11.12.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 12:25:19 -0800 (PST)
Message-ID: <34e5b0c4-3ca8-5008-46cc-38c60f69cd95@linaro.org>
Date:   Sun, 11 Dec 2022 21:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom,adsp: Add SM6375 MPSS
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210135807.10688-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221210135807.10688-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2022 14:58, Konrad Dybcio wrote:
> Add entries for SM6375 MPSS. Unlike most other modems, this one only
> expects a single (cx) power domain.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> index a9219c7c8349..434d34578fc5 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> @@ -42,6 +42,7 @@ properties:
>        - qcom,sm6350-mpss-pas
>        - qcom,sm6375-adsp-pas
>        - qcom,sm6375-cdsp-pas

There is no such entry... Do you base on some other patchset?

> +      - qcom,sm6375-mpss-pas

I propose to rebase it on my series:
https://lore.kernel.org/all/20221124184333.133911-1-krzysztof.kozlowski@linaro.org/

and then either add it as new file or maybe it will fit to one of the
device schemas.

Best regards,
Krzysztof

