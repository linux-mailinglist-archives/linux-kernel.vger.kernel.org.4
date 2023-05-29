Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84339714411
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjE2GQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjE2GQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:16:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448BBD2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:16:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso30590095e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685340967; x=1687932967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LA0lZXIZyfreSy6UzrDrMm0pLQo6QMWpJJ8ip5ZSwRM=;
        b=fwnJI2MHpqMgPEusIsDf6dCdGxxELVhkY6rqbFk3lB4f3VkRWgTwc3I9XPPoRSqIA/
         +i0QzKhrmmpRP8fjyyir1WVPKrQ98bNCt5TfkxeZuaHjnQ4Q0UH1E2fk0maaS1G/Af/T
         5kmHjNCc6v3dS2RssRi1X2x+yLqBwXQipQpzvOqkkXosU47sMFUEQX4hNMTSWSHQizBI
         lRAQ6Vl+b9fJlYCWbfZIlbeowumqYxk5TKyEtLN33xTzT5vvfPp2inLsnoLcGkUHlitZ
         Wk4QVRfCuOPybeD3s3Q5IWrbRSYkQk+XISzzyii2gYRMKrB5MqeQPS/kBEGsK6qmcS0z
         0AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685340967; x=1687932967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA0lZXIZyfreSy6UzrDrMm0pLQo6QMWpJJ8ip5ZSwRM=;
        b=QrE+YyvYM+Ol8pHC0RCeED5szBiiuXh2ixPeftuONOmjDb/s/nwLHDmtro0g0KE9ZI
         ORi5MZvNq3nc11UK0jgVIzyPvjFSSNTNIhnPmpPpaSzRtagFb9dGiMOAkwr08Y6vTo2A
         n/39EYgOIYrihCEeS394in0eJKfkuR32DOUvdiHkGE7BGGRKmI3Ylzq8i4PzrDNVS+7z
         VZ5zMoipDN8V+kNqkJSuSLp9fwVNTg+9ePNplF/J36pFNi/tlrrb8789PA8Q9xlsA4tw
         XQfnLi8TYUKNNwMhX/d1gSij0bNhPVpph+fgisboQz+yUkW3/wFEV/ipOf1OFw+6ypdu
         GTCQ==
X-Gm-Message-State: AC+VfDwd8owuKG4AKDisf7E4B5+WV2zu1lcnNP5D3+OCiqms7qxYJGkz
        Hzn0qxFVLyCVHhJAXWAYTiOdKWbtFRg+Sm+r81sRLg==
X-Google-Smtp-Source: ACHHUZ4ueNV2gTUYIfOuOR4I8nBjLUyiMggWa2AaJkdjCQz68pX+xZH4y3Da4ZNKMrsDlhdFfcW6KtA7o9jw9fnmtHc=
X-Received: by 2002:a7b:cd99:0:b0:3f6:41f:8e66 with SMTP id
 y25-20020a7bcd99000000b003f6041f8e66mr8079474wmj.5.1685340967640; Sun, 28 May
 2023 23:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org> <20230526192210.3146896-6-bhupesh.sharma@linaro.org>
In-Reply-To: <20230526192210.3146896-6-bhupesh.sharma@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 29 May 2023 11:45:54 +0530
Message-ID: <CAH=2NtwPhspRXD1g390c79+w1CFc19m+RcrzcCEtnGxomumhMQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/11] dt-bindings: qcom-qce: Fix compatible
 combinations for SM8150 and IPQ4019 SoCs
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org, stephan@gerhold.net,
        Rob Herring <robh@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Sat, 27 May 2023 at 00:53, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Currently the compatible list available in 'qce' dt-bindings does not
> support SM8150 and IPQ4019 SoCs directly which may lead to potential
> 'dtbs_check' error(s).
>
> Fix the same.
>
> Fixes: 00f3bc2db351 ("dt-bindings: qcom-qce: Add new SoC compatible strings for Qualcomm QCE IP")
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> index e375bd981300..90ddf98a6df9 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> @@ -24,6 +24,12 @@ properties:
>          deprecated: true
>          description: Kept only for ABI backward compatibility
>
> +      - items:
> +          - enum:
> +              - qcom,ipq4019-qce
> +              - qcom,sm8150-qce
> +          - const: qcom,qce
> +
>        - items:
>            - enum:
>                - qcom,ipq6018-qce
> --
> 2.38.1

Bjorn has applied the dts patches from this series to his tree.
As suggested by him, can you please pick patches [PATCH 5/11] and
[PATCH 6/11] from this series via the 'crypto' tree.

Seems some Cc fields got messed up while sending the patchset, so
Cc'ing the list(s) again.

Thanks,
Bhupesh
