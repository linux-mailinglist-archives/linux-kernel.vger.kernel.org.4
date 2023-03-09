Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047DA6B2EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCIUox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCIUov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:44:51 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96A4F2480
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 12:44:47 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536cb25982eso57357207b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678394686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zsg12oEDEiCGQizPiB6v1VIIN7ssVMwVI7Jn0aroOOo=;
        b=ZCLScd7RtY51SvqL7NHWLqy4Glcw6iBOxfIAay6Bv5sSfTGNVrMhIwU8/UGS+AxbUc
         41OyUUhJb8BcpdDcxFLsHJl7NhO8VYM8821xQXifPwRfcAS1bSr6sIUKxOJDB/qmONT7
         RrwOOknXTK6hxA5T9x5K/64JBOeM4YlTIg4qQNljLRVEn4j3voI+y/niVOmvi2QRkpfc
         Y5HM6y0UerdnWMhoXM3IiDiRcx8a/3HwaRR+ThZfWJz4RYD+wD+yTAFDcrPgMBDOgPCK
         ZAaL+IMiuRdipHgvzv3b5MvojXm+YiY3kOMNqKo9kwyYhp+iRQPhKDhDSFjPfzbvtNlA
         V2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678394686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsg12oEDEiCGQizPiB6v1VIIN7ssVMwVI7Jn0aroOOo=;
        b=z1MHcP8Gk4TqHoqFj6bezjM3LBipWdcmeSFOpeu1vExMIgAzBy46k3GGnHZ4gGpETK
         aiReX8XCecUyv2b8uMXVd6t0x9mToZoxOeoUi7nQHzsLXpUjANEhmrmr+2JyML31N3Ia
         ymnuwja09GaA53/C61+O0CxaUI82twJz37+xlO1+3y11YgFGocUunSyyHXI6LrtGYBlF
         zth8ls2hgBajiGtQHq0KscVNMYvH9AoWMQkneoSmA4VtfcIREfY2JQUlHRTEfBWLij/c
         iqfOzg9VqFZc6VpuCcF9MX9gWuZEtMhU0y7u2GAcm1ZP4nJkS4C+E7QwZ3dQpQnWYl5P
         k8WA==
X-Gm-Message-State: AO0yUKVoj/rDmf7tc/s9VOCjeopaqYRviZQsJQbvWRESxYtpL9oITOF+
        vWSMEfzDKhLxrRuamSPYsZv7sSfioDrNJiglGELmNg==
X-Google-Smtp-Source: AK7set8N216joVB3r3L/ek5sz4l8MebjRQuwEsbDMvXnhoeYi2e66BnSt5ysXC+4If5k5wgiHNaCZIFLJZo+xq9gy1U=
X-Received: by 2002:a81:b285:0:b0:533:99bb:c296 with SMTP id
 q127-20020a81b285000000b0053399bbc296mr14224207ywh.5.1678394686599; Thu, 09
 Mar 2023 12:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20230309185049.170878-1-danila@jiaxyga.com> <20230309185049.170878-2-danila@jiaxyga.com>
In-Reply-To: <20230309185049.170878-2-danila@jiaxyga.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Mar 2023 22:44:35 +0200
Message-ID: <CAA8EJpr866ejThuXkqEABST_awZkbuk+vtPAW_WAn3CoyYhfRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for SM7150
To:     Danila Tikhonov <danila@jiaxyga.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davidwronek@gmail.com
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

On Thu, 9 Mar 2023 at 20:51, Danila Tikhonov <danila@jiaxyga.com> wrote:
>
> From: David Wronek <davidwronek@gmail.com>
>
> Document the QMP UFS PHY compatible for SM7150.

Please switch to using new bindings (see
Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml).

>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml      | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
> index 80a5348dbfde..da223abaa3a2 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
> @@ -25,6 +25,7 @@ properties:
>        - qcom,sdm845-qmp-ufs-phy
>        - qcom,sm6115-qmp-ufs-phy
>        - qcom,sm6350-qmp-ufs-phy
> +      - qcom,sm7150-qmp-ufs-phy
>        - qcom,sm8150-qmp-ufs-phy
>        - qcom,sm8250-qmp-ufs-phy
>        - qcom,sm8350-qmp-ufs-phy
> @@ -127,6 +128,7 @@ allOf:
>                - qcom,sdm845-qmp-ufs-phy
>                - qcom,sm6115-qmp-ufs-phy
>                - qcom,sm6350-qmp-ufs-phy
> +              - qcom,sm7150-qmp-ufs-phy
>                - qcom,sm8150-qmp-ufs-phy
>                - qcom,sm8250-qmp-ufs-phy
>      then:
> @@ -162,6 +164,7 @@ allOf:
>                - qcom,msm8998-qmp-ufs-phy
>                - qcom,sdm845-qmp-ufs-phy
>                - qcom,sm6350-qmp-ufs-phy
> +              - qcom,sm7150-qmp-ufs-phy
>                - qcom,sm8150-qmp-ufs-phy
>                - qcom,sm8250-qmp-ufs-phy
>                - qcom,sm8350-qmp-ufs-phy
> --
> 2.39.2
>


-- 
With best wishes
Dmitry
