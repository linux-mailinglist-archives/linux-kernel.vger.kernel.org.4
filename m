Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD2F5F33B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJCQjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJCQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:38:54 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3863255A4;
        Mon,  3 Oct 2022 09:38:53 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id h1-20020a4aa741000000b004756c611188so7107128oom.4;
        Mon, 03 Oct 2022 09:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/z8QKfMMd+WonlTY8n0DPm8aF8FNJazKFMMzbtj3WIs=;
        b=mrb2Behz1V26meOhA5JAxn9EojUCMuslpyUwhz3pWta30a+z5K8nEDjL3T6TQpRjmf
         C1lESN37I5ND8exOtMHfFc3DyVycNUB8lU6H/B/Ad9fTpxVh4wS+666CpxXyO38/rK79
         Lts41eQEmyR8wzKYhmOuCqva8dBt0kfLECrGW1okjrgG3UB2NGppCqNIaj0yJOaIUKUx
         qOpa2chZkQb95FVLZDEoFdqJ4SECxSubtDjSrGi3Bd5bm66uiCwDezdaYPhmcVY/DXgy
         IcryJjdoRpQFwAOXcOAfh3XC/grPs+nv1kcCnHmO4nnjopIxrRYhwmLpEsjFy7ShO3yF
         5DqQ==
X-Gm-Message-State: ACrzQf0XZjMDl7iU0dx/pDMaf9dvsyMzWvK1dbZXC6MfbAGJEkGgEtzz
        DE1CABfTJSsRlRbs4rTOSw==
X-Google-Smtp-Source: AMsMyM4lszwFBCq6xZtL8Y5wePiwpGG3IHD7bBaryZPr5QpC4yM9+bd2vnHC3Cb5CLrmbhQmc34z8A==
X-Received: by 2002:a9d:4c83:0:b0:655:f666:801d with SMTP id m3-20020a9d4c83000000b00655f666801dmr8543844otf.303.1664815132666;
        Mon, 03 Oct 2022 09:38:52 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a056871068600b0011e37fb5493sm3089089oao.30.2022.10.03.09.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:38:52 -0700 (PDT)
Received: (nullmailer pid 2422556 invoked by uid 1000);
        Mon, 03 Oct 2022 16:38:51 -0000
Date:   Mon, 3 Oct 2022 11:38:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Message-ID: <20221003163851.GA2414624-robh@kernel.org>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
 <20220930145701.18790-13-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930145701.18790-13-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:57:01PM +0800, Trevor Wu wrote:
> Add document for mt8188 board with mt6359.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8188-mt6359.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> new file mode 100644
> index 000000000000..57c7c5ceef8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8188-mt6359.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT8188 ASoC sound card driver
> +
> +maintainers:
> +  - Trevor Wu <trevor.wu@mediatek.com>
> +
> +description:
> +  This binding describes the MT8188 sound card.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8188-sound
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      sink/source pair of strings. Valid names could be the input or output
> +      widgets of audio components, power supplies, MicBias of codec and the
> +      software switch.
> +
> +  mediatek,platform:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

Don't need quotes.

> +    description: The phandle of MT8188 ASoC platform.
> +
> +  mediatek,dptx-codec:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: The phandle of MT8188 Display Port Tx codec node.
> +
> +  mediatek,hdmi-codec:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: The phandle of MT8188 HDMI codec node.
> +
> +  mediatek,dai-link:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      A list of the desired dai-links in the sound card. Each entry is a
> +      name defined in the machine driver.

Names have to be defined here.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - mediatek,platform
> +
> +examples:
> +  - |
> +
> +    sound: mt8188-sound {
> +        compatible = "mediatek,mt8188-sound";
> +        mediatek,platform = <&afe>:
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&aud_pins_default>;
> +        audio-routing =
> +            "Headphone", "Headphone L",
> +            "Headphone", "Headphone R",
> +            "AIN1", "Headset Mic";
> +    };
> +
> +...
> -- 
> 2.18.0
> 
> 
