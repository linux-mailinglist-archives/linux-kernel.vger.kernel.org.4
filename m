Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC51C661910
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjAHUJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjAHUJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:09:07 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F36DFAA;
        Sun,  8 Jan 2023 12:09:05 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id o13so3935590ilc.7;
        Sun, 08 Jan 2023 12:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfwqBRbWF4QGSOeq7B7ZiYF19MZ4nKf7KZnTsmW4rms=;
        b=lmpvODzch1wwyIyGjyQykc8VFnJ2piQfPzvKtDPWE6wXSGd7MipCI+3fCRjl4f51G3
         vdiDo02/UUefMkM/Y9zuhoc8yGt5q1ORPTL0KVjXQTtena8nmY/MlsdV9tItHGXkOgzP
         d3lRiExuVS8YVVtPz88M2avFS04QdEleYVb93n4akQhkpnR+WqBUCXMwxc87touK/7Ts
         U99edVXdXbUWDJie32sXX5V9OxYwa5UlcgDMGGwu7Hs960QCg8MbUpJrnsym0osxZZIU
         hWkPqo43WxfVUNnfpLYm6xEAAIP7gz6bCXuAKkTjanWzTr4wAUZ8BjIYZlfWEmnPKjbU
         BqoA==
X-Gm-Message-State: AFqh2kqtDC0lzc6cLNooKfxLOo6tA/hb080t/MRjvx5Zsg89WeIZMrL5
        iwzs1vvX1+EYMzuIX5cGFg==
X-Google-Smtp-Source: AMrXdXuaxcaqi/XXAx9sVL0SN5gGGLgmBuavDeVrREi9OKkltviMXZGnMi11q2xZAkgd/YYXHyqZmA==
X-Received: by 2002:a92:ce41:0:b0:303:1468:4c59 with SMTP id a1-20020a92ce41000000b0030314684c59mr43762146ilr.25.1673208544755;
        Sun, 08 Jan 2023 12:09:04 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id o36-20020a027424000000b0038a13e116a1sm2213464jac.61.2023.01.08.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:09:04 -0800 (PST)
Received: (nullmailer pid 213174 invoked by uid 1000);
        Sun, 08 Jan 2023 20:08:45 -0000
Date:   Sun, 8 Jan 2023 14:08:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: add
 input-enable and bias-bus-hold
Message-ID: <20230108200845.GA212886-robh@kernel.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
 <20221230135645.56401-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230135645.56401-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 02:56:38PM +0100, Krzysztof Kozlowski wrote:
> Allow bias-bus-hold and input-enable properties (already used in
> SC8280XP LPASS LPI nodes):
> 
>   sa8540p-ride.dtb: pinctrl@33c0000: tx-swr-default-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
>     'bias-bus-hold' does not match any of the regexes: 'pinctrl-[0-9]+'
>     'gpio2' does not match '^gpio([0-1]|1[0-8])$'

Wrong warning?

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
> index 309d3dd9013b..9a3f1fb8c2f7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
> @@ -94,14 +94,12 @@ $defs:
>            2: Lower Slew rate (slower edges)
>            3: Reserved (No adjustments)
>  
> +      bias-bus-hold: true
>        bias-pull-down: true
> -
>        bias-pull-up: true
> -
>        bias-disable: true
> -
> +      input-enable: true
>        output-high: true
> -
>        output-low: true
>  
>      required:
> -- 
> 2.34.1
> 
> 
