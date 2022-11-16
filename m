Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C841562C3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiKPQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiKPQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:18:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757158010
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:18:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h14so16966317pjv.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BnBRD6c/pX6ypoX/gi2HqNrM2T85pThvuR/lc4jGdSg=;
        b=TrRAuR3v3tTbZUGEzzZ/YO6UxjEY81sW+W+VOJq+UMPXHSLD+DGLqizA7d2+a8/aNL
         TXZapSk/36WNFP0oueYZERI8SWx6b3ab/XH5+Mj00Kz6L1WZEwKOYxaN/2IDmm6jzX6G
         2Mek7dgBIaiaxIW84Svq7E/NfKo1hL9c0VF5suVsynd1QCyFcS0ooYep+4+2Medt+NBj
         kGGqoYpqBuD32u/4ET/MGD1gxW3J6ZWIe+WFjaPptTwfRReni5R8Q5Q+f0AyJASye9MJ
         nX4Ugs6UDHQh5lmu2+2f1lLvLTsnopbkMf3OiNBfotKupC2IOwCIf4QZZ+P0GuHO+M0w
         l6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnBRD6c/pX6ypoX/gi2HqNrM2T85pThvuR/lc4jGdSg=;
        b=VkuPR2BiKE3PSKtEgnM8dlBZ/AmufvgXnUmR9LmNtVRF3e8ZxeMHlkPqgAP5KRN9aD
         XhvGtCaynDk2Yi/Sm2OmnMpLteo6+IBzzIocWJXqrpUzJdGs23teNW3X0c389etlGUj4
         8aVzvo+a+iXqhlvpWyOOcSKor24vRYnKqxU81yGhiF9Vzna5ynLTfQpRU5eDbv/dJIGf
         9LAS9NSSP6KIMDVULXSxYVOJxGCX/UIUJbEEbmJsw8Xjz5EVr8JraY1kNiRtgVtNC/Sd
         4WGnHMyKdZeqgpMVmv/SHYY6XfutfuARZypDIWeCj+qJu7OK1IMFVgEQE1kmnCIifMhK
         Apgg==
X-Gm-Message-State: ANoB5pn0O78m26Tp5qx5O44nmcuE89JlhD1vQUDZjGoiS8+N5Tu25r7y
        Mil/XnkJW/+suY2e532e576x2nKp2G9M7n1vJvGdhA==
X-Google-Smtp-Source: AA0mqf7PJW5No74LXA6sbNp+iJwm+715AipBaRsV47cbYNcn8gQrbUMiuhJEQMrbnYx0p8yIg1zCYwgJWn4swwZUvds=
X-Received: by 2002:a17:902:a584:b0:186:be05:798e with SMTP id
 az4-20020a170902a58400b00186be05798emr9543290plb.37.1668615491711; Wed, 16
 Nov 2022 08:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20221116123612.34302-1-konrad.dybcio@linaro.org>
In-Reply-To: <20221116123612.34302-1-konrad.dybcio@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:33 +0100
Message-ID: <CAPDyKFryt+oF=Yymv+8sP1j0se6eAz7rMYiRpxA1oPwSN_XoRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: sdhci-msm: Document SM8350 SDHCI
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patch@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 13:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Document the SDHCI on SM8350.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - pick up a-b
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 12def0f57e3e..31dfaff0048d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -49,6 +49,7 @@ properties:
>                - qcom,sm6375-sdhci
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
> +              - qcom,sm8350-sdhci
>                - qcom,sm8450-sdhci
>            - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
> --
> 2.38.1
>
