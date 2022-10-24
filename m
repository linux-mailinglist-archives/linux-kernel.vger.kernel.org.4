Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A260BA2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiJXU16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiJXU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:26:57 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FCFBBF3D;
        Mon, 24 Oct 2022 11:40:06 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id g130so11706516oia.13;
        Mon, 24 Oct 2022 11:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciAUyFR+42a1vYSLsFy+yot8yqPlPhT53zC6CUWjbC4=;
        b=q1LVHhE+LeQ3mT9+4UlP+J0/kp7Ejxj3IQWwnLIbhg09MDdDotnkkFz62N2YRBKi8d
         PmcTRm1Nf8sjaYJw3VOoWBrJiTfdSdVU7EfulZdUebSULbThZqCdb5viKOB8xxuwpyeO
         WNeCHW0Jvqwb15QpKXPiGtIWoE5y7MNigDKiJOfk/Q4hcOMBP8LwQ8fTvAS2RdOlQmIp
         h0D7RCFkWglbgz4gwTfspsamztxZC+VcMUhrnq/Jz/lamR8kdx+KJxU99cwaJ7SWQAu0
         CjiyyLNOmI1X1XT+42UecbA7rjdriAmemjP2oX6KAB2QcV+hIB8oKnNW+N7CEBZPNm4/
         l6Cg==
X-Gm-Message-State: ACrzQf0oAmv0985yWnv7i5vBwQqXZheTjHF31txoRpT3CZYUHyU01Ct1
        OPbB5prs8UONYVJkd3X87w==
X-Google-Smtp-Source: AMsMyM7TPrZafIdws9bZJlUf5Wc3/2fjYb4Lmh/WsftciJEci6PPdMXQKHLrxishbgh6ZRsM1v4DMQ==
X-Received: by 2002:aca:aa8f:0:b0:354:fc38:aeb6 with SMTP id t137-20020acaaa8f000000b00354fc38aeb6mr27714978oie.224.1666636696900;
        Mon, 24 Oct 2022 11:38:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x52-20020a9d37b7000000b00661c3846b4csm89315otb.27.2022.10.24.11.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:38:16 -0700 (PDT)
Received: (nullmailer pid 2023578 invoked by uid 1000);
        Mon, 24 Oct 2022 18:38:17 -0000
Date:   Mon, 24 Oct 2022 13:38:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 12/12] dt-bindings: mediatek: mt8188: add
 mt8188-mt6359 document
Message-ID: <20221024183817.GA2019162-robh@kernel.org>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
 <20221021082719.18325-13-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021082719.18325-13-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:27:19PM +0800, Trevor Wu wrote:
> Add document for mt8188 board with mt6359.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8188-mt6359.yaml         | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> new file mode 100644
> index 000000000000..9c493a6101ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8188-mt6359.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT8188 ASoC sound card driver

Drop 'driver'

> +
> +maintainers:
> +  - Trevor Wu <trevor.wu@mediatek.com>
> +
> +description:
> +  This binding describes the MT8188 sound card.

Drop, the description doesn't add anything the title didn't say.

> +
> +properties:
> +  compatible:
> +    enum:

Only 1 entry, use 'const'

> +      - mediatek,mt8188_mt6359_evb

s/_/-/

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
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 ASoC platform.
> +
> +  mediatek,dptx-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 Display Port Tx codec node.
> +
> +  mediatek,hdmi-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 HDMI codec node.
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
> +        compatible = "mediatek,mt8188_mt6359_evb";
> +        mediatek,platform = <&afe>;
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
