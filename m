Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB462C3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiKPQS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiKPQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:18:10 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA6757B6B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:18:09 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q1so17091791pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+6kofWK+lAk9nYMdFCTFYyZyxlN1y4m9eqx3Qu6bH8=;
        b=J6QmENGbkz8JaelIwNWSJ8l299ttLiHNHQJbCutNLWXPp7HMamJ0nxlXFphKb5OFaC
         cNygK5/QTbSUGOeFzpo0kXYYztKZpAwspryVy6TEKqFcPFI9jDBBSb8CZ5ucaBTQzqom
         w1ckAJmV0OkD0oeTRLj3s8GjRwb7D7gq95HJwGYtjybJzDRUnVPNwr+JSFEBlchYhAvK
         LGJK8+IKVMPEkojNgT7uG9WNA2Iq//VYKMFaCjp/+FFRlT4oge1JJCGlm6t/+2Vq4mvA
         TmEBOpYcrquiRPrwE0C57a3LkkFXOKaDSsxk25BkjvxyXaUlmJXwp8x6Ul39kX8wkHQG
         RMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+6kofWK+lAk9nYMdFCTFYyZyxlN1y4m9eqx3Qu6bH8=;
        b=cF5V7PC84nEEjwICGqCRp1VB8kLdeXOxgsQZa1E+FpuyigwX6ogKEaGQUvuRy6OMR6
         COm/QNld4bN7QgZPwblVCpNe/g62gesLTPSzIKOGc3ugreZ3A3NoUPYygpYNTIO3voez
         y0lDI4tgCgjC7kpDcr939AsGy0kVRJCJl7hwmtE28HYsUMdnhYhmCw2XGn3sJIg1npJF
         tp11YviLxOojOicq24ifooGA5iCo2Ifshna5TbNhrp6Yx2CrJrPEuTBTeKMxiPSYq8rE
         bhHjvduX6WyrFoSwR0ImyhQN0XeQzpWYc0wBcVUQ8Dc3sFf7M2yz8rP7PV7c2hbCypIi
         qfhQ==
X-Gm-Message-State: ANoB5pk1x3redFOgQ5k1dxs1OmiSbYPWPU1Qs+t6nX8GHhLd+vmurjJ3
        9Om25uZHiI/ipB0kRI7m/Wpmx/KRZhGCFeFGvxRp6A==
X-Google-Smtp-Source: AA0mqf7Yk01flNfOp6SxymOc+XEuglm7jqex2dsSPKvWtWPa80gI4EKbAlDuk8r2R4WzOyG+XpbjS2afb54fviVWB8w=
X-Received: by 2002:a63:db03:0:b0:470:4f30:f743 with SMTP id
 e3-20020a63db03000000b004704f30f743mr21500123pgg.434.1668615489044; Wed, 16
 Nov 2022 08:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20221114105043.36698-1-konrad.dybcio@linaro.org> <20221114105043.36698-2-konrad.dybcio@linaro.org>
In-Reply-To: <20221114105043.36698-2-konrad.dybcio@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:30 +0100
Message-ID: <CAPDyKFq391+dvG-R=5S7RkW03hWvP2c+WEAvYLPhaoVUasm1VQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: sdhci-msm: Document the SM6375 compatible
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

On Mon, 14 Nov 2022 at 11:50, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Document the compatible for SDHCI on SM6375.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> No changes in v3.
>
> Changes in v2:
> - pick up rb
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index fc8a6b345d97..12def0f57e3e 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -46,6 +46,7 @@ properties:
>                - qcom,sm6115-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
> +              - qcom,sm6375-sdhci
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
>                - qcom,sm8450-sdhci
> --
> 2.38.1
>
