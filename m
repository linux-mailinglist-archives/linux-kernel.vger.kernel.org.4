Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FA639D45
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiK0V0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiK0V0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:26:12 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1D8DECA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:26:11 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 189so10481582ybe.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HgkwP5Gr80kx+eoGWhH3ysjp0qUkMA9X8iHdrpzsq2s=;
        b=OKJQqp4VyiAfqlu0X5PXSQ7tpF2LJEPqnDmcSV4+/9rQHlkzRgaRCFw04przmQqUQM
         7+lA5rG1+pKUHVZLEexCqV2RTWphTRQPnDu+03bYgismKtCixMntR1a3HhgT8Mg0QyHC
         z275aSefj99qRFPPmsDk/ExOf/+dkzGNgTsyxVkvR3R6NbDCfUIFbCZ+7+K6SrDEXeq2
         Juj69zzXZR0ha78JwDjocolxL0zYruk0oQm71Qz+CQiBYOxA77y+fP/4DtztvBtcR8v9
         hvAq0Xk7us+CM+h7aw9JteVSfizcXqvU5dH6eBjfxMVLTIuBYj2Td44kCppeIYOjBXil
         bnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgkwP5Gr80kx+eoGWhH3ysjp0qUkMA9X8iHdrpzsq2s=;
        b=P3cdm+VkRlOWlP+BFDx46ycvvgXLGY7yLA6MSzY0SlW6+bEGsxIxjHayO94WJ1tYVE
         zoXcJaMX2kGP1xzq4FVYsz+3/Y7ppYKks97vPpZumEWofcGIfMDUd0xdg77JClyA6bF4
         vLHYlfAxvfoQOgriQHUdqKZW55oTus4AkWmZqSiVpL1LxgnDYuvY0FWd5bY1c0LeLmTD
         YqQMvoO2SAmsFFqO9gje1Hns9mEagFm+EjodU6TtOfRqz995TClfaJmfcv0hq2vGIKC5
         AQsQJKCvDC8pZRgFh5WnRgmceZH9qAei0urP5XCt9ZCc9D4XzUzjkovDLew5+5Juw2WE
         bshA==
X-Gm-Message-State: ANoB5pmAFQafhbBiWceRNDlGuCYLUethSqQXDHODpuNtlsL7RUYIR4ND
        yVOjGJB4VP95VT0quHsjp6OveEbdu+zPjXF70eSlKg==
X-Google-Smtp-Source: AA0mqf64g3pQHzizACdiWdG2+InatoZLEaDSdZ1QJS+X5/UwYFgxeO/dIIfDAWFCQz4vo1LXrEjab31B7HV8jsb7a68=
X-Received: by 2002:a25:4282:0:b0:6f2:7d57:e51b with SMTP id
 p124-20020a254282000000b006f27d57e51bmr14291337yba.15.1669584370695; Sun, 27
 Nov 2022 13:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20221127181835.806410-1-luca@z3ntu.xyz>
In-Reply-To: <20221127181835.806410-1-luca@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 27 Nov 2022 23:25:59 +0200
Message-ID: <CAA8EJpoe09FZcfVXuknmFWO5qg-iYDOBVN3=qr=DeJjvHw56Mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document oneplus,bacon device
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2022 at 20:19, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Document the OnePlus One ("bacon") which is a smartphone based on the
> Snapdragon 801 SoC.
>
> Also allow msm8974 devices to use qcom,msm-id and qcom,board-id.

The patch itself is good. However it raised a broader question for me.
Up to now all msm8974pro devices use qcom,msm8974 as a top-level
compatibility string. Should it be changed to use pro-specific one
(e.g. qcom,msm8974pro)?

For the patch itself:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 463509f0f23a..3d2cc8ae34d8 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -167,6 +167,7 @@ properties:
>            - enum:
>                - fairphone,fp2
>                - lge,hammerhead
> +              - oneplus,bacon
>                - samsung,klte
>                - sony,xperia-amami
>                - sony,xperia-castor
> @@ -896,6 +897,7 @@ allOf:
>                - qcom,apq8026
>                - qcom,apq8094
>                - qcom,apq8096
> +              - qcom,msm8974
>                - qcom,msm8992
>                - qcom,msm8994
>                - qcom,msm8996
> --
> 2.38.1
>


-- 
With best wishes
Dmitry
