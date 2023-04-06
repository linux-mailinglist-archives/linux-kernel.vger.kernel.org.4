Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9456D9EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbjDFRiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDFRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:38:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212DD4C16
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:38:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l15so3230498ejq.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680802700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dDJzhnbKBQMuHvDiiHFif0xc5802sYy1aTGQbXP9g0=;
        b=HpZOrqMIw9oc24ohSR9Z5tko8WYI9Oav+4/vftlI69078c+g9LGk/8xLNRbkBu3C5i
         EuBXkMBubCUjv3CaK4ZirEZhdg9H120X/eKqqDfuWe7mux3Io9foKjLEVHYLGlsFxIot
         P6T/dVslsqEbPeASb6kHi4vDzNJvGpzp3xkFq3ffM7rSPxaPzqSFECIhg60c46yIf/NN
         yYDQoV0Mols/K5TU14Re+VnBK5fUIesmcBjZbVV91D9MSVzVie1nMCN+fSCIlG8jmQYy
         t7+LDH3euS9BMSH+XQQCah8b2dem/mz+Z4BOxmh5UPd52CT1o4403UbO0s5npoKalOs3
         oJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dDJzhnbKBQMuHvDiiHFif0xc5802sYy1aTGQbXP9g0=;
        b=ZypF3kjSaNibDDoCOUN+cVZ+vhqxEn/XTAnzbrA70nB2i7M7OoXj9zFl+JtUkAcu3f
         /ELAOnocg+dwEikQF4vwMHabTgz8rwe1eX7Mg4iyZx+9Xk/pXYLOF1ydOj9An6sUlnSa
         6EspB+rWzk6XywyvXLwuJUHPNmIKcoT+y24NPlJicyJ926mGG7YEDSCO87Gm6+t6P9tB
         oB5JEU+BtpfNZKtLCIltlZYvebXfZs8JUN7mlEB52kFgbBgI99yxJgtDTiSOvirk140o
         gVV6ABFGvEaedvm9E7za2W3oc6DPw8t+s/UDkQMuh76Kn96jBnuJqOGs3j32qW04fMlo
         uK9w==
X-Gm-Message-State: AAQBX9cn+Zm5NCXnu9DZ1hrfgwNsOaIEeMIC4iynmsUUa62FfmTtmkfS
        PtyVeIx0AW44gi070LobY/J5JA==
X-Google-Smtp-Source: AKy350akTPYz/xlwi+KmNkAlMPPKYwPFwo6UJntpAWKOvYXwCl4cN34M6VybkX5N3428Pi30ZLpMoA==
X-Received: by 2002:a17:906:9383:b0:8ab:4c4:d0f6 with SMTP id l3-20020a170906938300b008ab04c4d0f6mr7542390ejx.56.1680802700651;
        Thu, 06 Apr 2023 10:38:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id ta14-20020a1709078c0e00b00949c02dcf10sm1078477ejc.6.2023.04.06.10.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:38:20 -0700 (PDT)
Message-ID: <2dc882b7-d09f-dfa0-67a1-3f9e6f1ac457@linaro.org>
Date:   Thu, 6 Apr 2023 19:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: wm8523: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230405203419.5621-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405203419.5621-1-danascape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 22:34, Saalim Quadri wrote:
> Convert the WM8523 audio CODEC bindings to DT schema
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8523.yaml | 40 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8523.txt      | 16 --------
>  2 files changed, 40 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8523.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
> new file mode 100644
> index 000000000000..decc395bb873
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/wlf,wm8523.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: WM8523 audio CODEC
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: wlf,wm8523
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +

Please squash all your three WM bindings (wm8711, wm8580 and wm8523)
into one binding, if they are the same. Probably other WM from your
previous submissions as well. We really do not need binding per each of
this simple codecs. If they ever need to grow, then we can split them.

Best regards,
Krzysztof

