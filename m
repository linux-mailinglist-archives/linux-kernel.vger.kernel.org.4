Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEDB5FC8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiJLQL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJLQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:11:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915EDA033F;
        Wed, 12 Oct 2022 09:11:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qw20so38431670ejc.8;
        Wed, 12 Oct 2022 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B17w69Iz2NdYtUdmzCUWZNwrLTOOl7h6wkcqw6Cxh6Y=;
        b=nnmYhgT6yHUjLg00VqhHteLb5AO8Pdjt/70ZiPO1TpGKF8Ig4Dpf1Tstm3q96mNDeG
         YbB+YCO5g/au6QhZIkNblqIPL2ltJdNgUg+p+VeJYDYPDoKilk088OIIOSxXYL/afPWp
         ekwTzNNdx6rvRXNp+eoKwF0zH50fjbQ+pyKxJNquzDMK0YA1vJa4bevNF8gCrq9w/xQp
         VNl5NKACtAFkEzoDWNGOcqE5kUhIarG24q1o0d/5wjl6L8DWNa/ijd2FzMj5PJ4dHOVa
         koS/wTN6shEZRFyuhRwqvQCTjTYOM2AqglTtnEYzGuEnv/jED3y1ocZHWOWKsosM/zjC
         zXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B17w69Iz2NdYtUdmzCUWZNwrLTOOl7h6wkcqw6Cxh6Y=;
        b=sjnibrLD/mTm7ML7JmXDG68bJ9XUsPbXhytQqgSCJholNd/eJrKBFicPRmuKQUpwQW
         aPy33a//fMvEaxag5xx+GR4LYAh4B9TPzFJ+7I5wmRQPMP/Ql2n3rDwMRMlrsvxz5S5e
         HZyy5sIirzRJ+bufM9GS/8zgGuSLz15Z10A1tacg0mRNZOWygtZw5GzzunQ7GCsviTnx
         nBsDzHXm3alE7vfRx6mUwIekxyBycwOW+MbTNTi8gYACgwjH66OAJhslczcHy04gDrYm
         nGZC+IyEYKJFPwYGIUhjTjnLTyWNTJQugIglTs/Le7HtfL1i1YDIXTxCAOoyJDtVIy2/
         S62A==
X-Gm-Message-State: ACrzQf1ljsBwgYKGwAxZnGIm8Drz/Q7j+G2NWhs6zrxomk99VzBW27VH
        VUmZ+EQ7JJ3tAbS9HRQA6PcrcgY92OKyGSRO/YKVfXPdlWVQjw==
X-Google-Smtp-Source: AMsMyM6TEL6eeZKt8sdOki9RvQU7WssLXUhEdZuXfciNBAxs+hiMJqvFhMHxQS02jfK1Jhm5S7yAUYuA/DK1kFA+j48=
X-Received: by 2002:a17:906:cc56:b0:78d:98c3:8714 with SMTP id
 mm22-20020a170906cc5600b0078d98c38714mr17354646ejb.445.1665591078973; Wed, 12
 Oct 2022 09:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org> <20221011172358.69043-24-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011172358.69043-24-krzysztof.kozlowski@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Date:   Wed, 12 Oct 2022 19:11:06 +0300
Message-ID: <CAL7jhicvj2mH6eMG0q=YcUW99ngz7tedQO0U4HsHkAuVKhrJrw@mail.gmail.com>
Subject: Re: [PATCH v2 23/34] dt-bindings: pinctrl: qcom,sm6115-tlmm: minor
 style cleanups
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

On Tue, Oct 11, 2022 at 8:26 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently, drop redundant
> quotes and rename file to match compatible (to match coding convention).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>

>  ...qcom,sm6115-pinctrl.yaml => qcom,sm6115-tlmm.yaml} | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6115-pinctrl.yaml => qcom,sm6115-tlmm.yaml} (95%)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> similarity index 95%
> rename from Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> rename to Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> index 3f5f5229a86c..ed68c4ee032f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/pinctrl/qcom,sm6115-pinctrl.yaml#
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sm6115-tlmm.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Qualcomm Technologies, Inc. SM6115, SM4250 TLMM block
> @@ -10,8 +10,8 @@ maintainers:
>    - Iskren Chernev <iskren.chernev@gmail.com>
>
>  description:
> -  This binding describes the Top Level Mode Multiplexer block found in the
> -  SM4250/6115 platforms.
> +  Top Level Mode Multiplexer pin controller in Qualcomm SM4250 and SM6115
> +  SoCs.
>
>  properties:
>    compatible:
> @@ -36,9 +36,8 @@ properties:
>    gpio-reserved-ranges: true
>    wakeup-parent: true
>
> -#PIN CONFIGURATION NODES
>  patternProperties:
> -  '-state$':
> +  "-state$":
>      oneOf:
>        - $ref: "#/$defs/qcom-sm6115-tlmm-state"
>        - patternProperties:
> @@ -46,7 +45,7 @@ patternProperties:
>              $ref: "#/$defs/qcom-sm6115-tlmm-state"
>          additionalProperties: false
>
> -'$defs':
> +$defs:
>    qcom-sm6115-tlmm-state:
>      type: object
>      description:
> --
> 2.34.1
>
