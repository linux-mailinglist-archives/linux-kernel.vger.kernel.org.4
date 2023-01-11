Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86DE6657B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjAKJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjAKJhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:37:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9053F615B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:36:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso12143238wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agrBGzLEfDLBSaCHOLwWqzPW8aLKgXJ9Qn5pOrzQb5Y=;
        b=L1ew/2SCwJ61mAaiVWmR/o/h0rvj5/f8oWZHWzHzYRw3DibCnHMEDLdOE6f3JibAv4
         TIbFr3b6wleD09DJbyz69vNg50+ZP+SzNowSevdxBHlyMEYmtkEs/cfgpI3fBLmNFK7R
         nj/kwt7wwkxVeqOcx6fTIfreTT7aXZpE185iHv1G3KCJnJjK4GbWVrbx2EC8H+LPLZO4
         cbbthMcG4ULnar4283XFnePmqly+AR2Whbt32lHWAYJi4KAkQCudsQm8EvBNcH5Pn4bV
         LGXG9pwErge9lO8e+ELGjblOWgaA8i8KSoo0pcm6JEtRNmzguwM2yBmgb+xfeuMicRhs
         VcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agrBGzLEfDLBSaCHOLwWqzPW8aLKgXJ9Qn5pOrzQb5Y=;
        b=Bf0NTkezCqRs5gjwSNABGcTAA8DKFhR/NcNoAiKz0UysKAlfl6ovaFOhmfWt/KQQ41
         f2R4EdRO+Aj07cr5AgzSA0UD+zZBsK1zLt7IGVwe4geMCTtTGE749gCnh3eJa7+C4WDI
         sSBEcOdmSZwpPn2O6UCdP/zxsu0Fr1OFkdHtz1LZZBci0XDQD/P8BPf9v5+zRuVS+fLl
         pFM9u4Zx/owWb3v2+qRs/ieAmLo1WXTK9NZ7q/getpaFFRCT6c0hvWfn2SARhxccbICA
         lLsdPSpOdGpEeWrpM3Cw77kRVmpVn4ccBijgW8kZVm7zIw9iQIxOkPmcKFTVJ/I8cGNx
         x8iw==
X-Gm-Message-State: AFqh2kr/0JJ5DId6V2r9JLTwHuStd0bV8a3tZy+scRGCuAGdZDe8L2Ce
        85emOaR2y1AIBbqgzstaGTXCgg==
X-Google-Smtp-Source: AMrXdXur2VYSsIb72rrxWp6CTmFDaeh2Stw30IqyKOpakPOnkVDT29DdV1AQ6EJLmwgaYmiy5MRsiw==
X-Received: by 2002:a05:600c:4d25:b0:3d3:5b7a:1791 with SMTP id u37-20020a05600c4d2500b003d35b7a1791mr62592799wmp.41.1673429776076;
        Wed, 11 Jan 2023 01:36:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id he5-20020a05600c540500b003d9ed40a512sm13601488wmb.45.2023.01.11.01.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:36:15 -0800 (PST)
Message-ID: <603f9c39-3e36-bb44-2305-1d37fe033dd5@linaro.org>
Date:   Wed, 11 Jan 2023 10:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] dt-bindings: arm64: ipq9574: Add binding descriptions
 for clock and reset
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-2-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110121316.24892-2-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 10/01/2023 13:13, devi priya wrote:
> Adding support for the global clock controller found on
> IPQ9574 based devices

Subject: drop second/last, redundant "bindings descriptions for". The
"dt-bindings" prefix is already stating that these are bindings.

> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-other.yaml        |   4 +
>  .../devicetree/bindings/clock/qcom,gcc.yaml   |   9 +-
>  include/dt-bindings/clock/qcom,gcc-ipq9574.h  | 226 ++++++++++++++++++
>  include/dt-bindings/reset/qcom,gcc-ipq9574.h  | 164 +++++++++++++
>  4 files changed, 402 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq9574.h
>  create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq9574.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> index 2e8acca64af1..cc563d640336 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> @@ -18,6 +18,8 @@ description: |
>      include/dt-bindings/clock/qcom,gcc-ipq4019.h
>      include/dt-bindings/clock/qcom,gcc-ipq6018.h
>      include/dt-bindings/reset/qcom,gcc-ipq6018.h
> +    include/dt-bindings/clock/qcom,gcc-ipq9574.h
> +    include/dt-bindings/reset/qcom,gcc-ipq9574.h
>      include/dt-bindings/clock/qcom,gcc-msm8953.h
>      include/dt-bindings/clock/qcom,gcc-mdm9607.h
>      include/dt-bindings/clock/qcom,gcc-mdm9615.h
> @@ -34,6 +36,8 @@ properties:
>        - qcom,gcc-mdm9607
>        - qcom,gcc-msm8953
>        - qcom,gcc-mdm9615
> +      - qcom,gcc-ipq9574

Incorrect order but anyway let's switch to new naming style just like
SM8550 and SA8775p.

> +

Not related change.

>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> index 7129fbcf2b6c..5a71268538e6 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> @@ -24,6 +24,14 @@ properties:
>    '#power-domain-cells':
>      const: 1
>  
> +  clocks:
> +    minItems: 1
> +    maxItems: 8
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 8

This does not look correct, neither related.
> +
>    reg:
>      maxItems: 1
>  
> @@ -35,7 +43,6 @@ required:
>    - reg
>    - '#clock-cells'
>    - '#reset-cells'
> -  - '#power-domain-cells'

Eee? Why? What's this?




Best regards,
Krzysztof

