Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD6C6002E6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJPS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJPS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:29:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE515827;
        Sun, 16 Oct 2022 11:29:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r17so20468615eja.7;
        Sun, 16 Oct 2022 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7UP8YArGrE2/mPIoJWCPZVedu1lf3R2pIafl4Pd/82E=;
        b=oseeJQ0WVVi0yrP55Q0L/v9g0cxEK0uQOXCF45SU26RmrXetdIr952S4umeet+uStZ
         7pJx+Y8KWVZgV/319f5UxV2jWe9eAiCMOT2vr6HR5gCQBii1b2TuZc0sszMPjEX33wcd
         heE/MJz2SHd3Pl1+AyorrnAUbqzRIvVUZnwdeQrrUufOmuoDCKAhZq/oEv5oeKW+X+/D
         GfCN2CYt9/MKKMSxa8/KQELcm3HSmK9+jprME0WeJ0Z6ware2Vh6a41pRcRYJhCyOce3
         IEED8Wf1ZysaWj9lKz/zOHUdaewvpKJOqURAlKA+Or8uIu0aCruMXP0LWHJMd5s6BFYo
         rRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UP8YArGrE2/mPIoJWCPZVedu1lf3R2pIafl4Pd/82E=;
        b=v5FFHWlmlX4Cn3C7wUO0tGCyCCPsXa0DPk9lL7qV5KE56HbatLWVBFBWghSpEuhsvR
         BsE1qLhEy7MVZJ0GrF43Mi9gO2t6bwA5phz3QkIZCHS6/T7HzUbsRAlXViN9jWTkESDg
         L/zN8yej06Md9sAsIjYWZZbbI1PHXuRK4Ohoex46q+Aax0e1hRSLs1x4OdmLTWrywnOo
         ujpGwhrMBuzSlDUuEgpIHBq/HxtkykqNkNVWtvNExI3Tk2Xm1IoPUrC74dIypCygB81G
         N/JIgAo7crLjshc5N2I3dbH4gXrrA/yIaozgT9B3gMxRA8HCjJm97uG6dw7FSGyeNN26
         paEg==
X-Gm-Message-State: ACrzQf30v1M0Bd+FM6wIsMp+b3avM2mFyV3ITtqQtwvOVtWy9WrwWB03
        lpjeu6L5sHbf3SVT/E/YTuOqjonIYrSSSilQ/Rg=
X-Google-Smtp-Source: AMsMyM6I0Nl9xMjk7IH22SHX5/J01zNrKUUPVFjpmrQuC0dB8Uz60Q9NFvcSZ8D0GkZCaJfLcIEDezZaxc1ts1YvQsY=
X-Received: by 2002:a17:907:d9e:b0:78e:2ff7:72f4 with SMTP id
 go30-20020a1709070d9e00b0078e2ff772f4mr5751681ejc.608.1665944982412; Sun, 16
 Oct 2022 11:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221016173625.53769-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221016173625.53769-1-krzysztof.kozlowski@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Date:   Sun, 16 Oct 2022 21:29:30 +0300
Message-ID: <CAL7jhiddgx2knzH4J+M2FwkFAbFzkFRsWX0XZ2Xh7pMEOZQdUA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom: drop minItems equal to maxItems
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 8:36 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> If minItems are missing, they are implicitly equal to maxItems.
> Dropping redundant minItems simplifies a bit the binding.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>

> ---
>  .../bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml          | 1 -
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml  | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> index 8270debd4f25..f7ec8a4f664f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> @@ -23,7 +23,6 @@ properties:
>      type: boolean
>
>    reg:
> -    minItems: 2
>      maxItems: 2
>
>    gpio-controller: true
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> index 51bae1d3f150..164f24db8b2b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> @@ -18,7 +18,6 @@ properties:
>      const: qcom,sm6115-tlmm
>
>    reg:
> -    minItems: 3
>      maxItems: 3
>
>    reg-names:
> --
> 2.34.1
>
