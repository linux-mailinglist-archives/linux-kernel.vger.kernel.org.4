Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7150666B8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjAPIKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjAPIKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:10:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B56172B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:10:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx13so7778381ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zms17SHseS3wAoavooLT/19S/3viSn8s+o0NzNuVEiU=;
        b=h5Sj63KXGKJ6mTUFmnOoksQZFRd0wz0/9nKYmTFIxVovnq8T/KiMMHhMmv/YX/kO2d
         +d/hw+HaA53PTT1rJma1PlfP69+vcM9CadbwgE2yzurhYx/4KXcCFN2mRR41bzabVb4c
         sy6pvuXMaf7/9MNYHWQgZMyObKeSv25F1+zHPIQzPpvqAn5+sAYLrHcQEM0sDE7DVSFZ
         7KlgjqHiXG+qZaWlD0JWhoUv+0gsqXjd3q6gHl4H5QKJsxBCvM5AjBkmWESZz5Uh86GM
         MP1dSaDM4YuaoQNJ9DAHklVpcu96FXpdNUXT18aMH3PJ8YJ6scB2CkeQZ3/fi4AeivH0
         hrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zms17SHseS3wAoavooLT/19S/3viSn8s+o0NzNuVEiU=;
        b=1JyjnsgyWJtLsdWZ15oke7a5STVubz1ps2AnbXy6TG1z1m4GfjbQmjI+v3aiOU3Hgj
         A9uGRNXzDfyybfHGP1hnO+y2B75w91wUaj5s+v9PiHcEll0V48TCuq7YLeA9njbsXF68
         TzdAzQRhte4CUFr79VDfcqG2dcEJMvESiZHfVbdxpFMg/SlKWReZ3KEj6yzq9As90arP
         c8y+9Yh/7iPtdP1ai+bTmRLqPHy6KHf6rfBuTva0T+oS+jbmmz/s5uAhEDSiaFYcTkCm
         IyuntyapgCuJCYMKr74deju306nJ3BaqjU9v11vKDzbkaUSB5uzuz5x7gWKJwXJ6CdoF
         RX8Q==
X-Gm-Message-State: AFqh2ko3g1GvRuLDTOFClfB/9mh/FJliXgCVfNpi0ut8djbiXGqYUWJn
        SeBfmxXQSVzLFkeshxK2RCFobQ==
X-Google-Smtp-Source: AMrXdXsoQ8RZgHiEi0DjL+X9OpgWoZTiwWDn4sfC2Q/QMHAv5AT27GqlyXu1cVT+1PPwqX/xmaiOow==
X-Received: by 2002:a17:906:eb88:b0:870:7e7d:97a7 with SMTP id mh8-20020a170906eb8800b008707e7d97a7mr3021202ejb.72.1673856609899;
        Mon, 16 Jan 2023 00:10:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j3-20020a170906474300b0084d4cb08f27sm8551169ejs.104.2023.01.16.00.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:10:09 -0800 (PST)
Message-ID: <f24a54f1-2720-3345-9596-bb8d388ba16f@linaro.org>
Date:   Mon, 16 Jan 2023 09:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND v3 01/13] dt-binding: mediatek: add bindings for MediaTek
 mt8195 MDP3 components
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
 <20230116032147.23607-2-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230116032147.23607-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 04:21, Moudy Ho wrote:
> This patch adds support for MT8195 MDP3 RDMA, and introduce more
> MDP3 components present in MT8195.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-aal.yaml     | 63 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-color.yaml   | 63 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-fg.yaml      | 63 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-hdr.yaml     | 62 +++++++++++++++
>  .../bindings/media/mediatek,mdp3-merge.yaml   | 63 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-ovl.yaml     | 63 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-pad.yaml     | 63 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 30 +++++---
>  .../bindings/media/mediatek,mdp3-rsz.yaml     | 11 ++-
>  .../bindings/media/mediatek,mdp3-split.yaml   | 75 +++++++++++++++++++
>  .../bindings/media/mediatek,mdp3-stitch.yaml  | 63 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-tcc.yaml     | 62 +++++++++++++++
>  .../bindings/media/mediatek,mdp3-tdshp.yaml   | 63 ++++++++++++++++
>  13 files changed, 731 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
> new file mode 100644
> index 000000000000..d2e1b5245778
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml

Filename should match compatible, unless you already expect this binding
will cover other devices. If so, why not adding them now?

> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-aal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Media Data Path 3 AAL
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Moudy Ho <moudy.ho@mediatek.com>
> +
> +description:
> +  One of Media Data Path 3 (MDP3) components is responsible for backlight
> +  power saving and sunlight visibility improving.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-mdp3-aal
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of client driver can be configured by gce with 4 arguments
> +      defined in this property, such as phandle of gce, subsys id,
> +      register offset and size.
> +      Each subsys id is mapping to a base address of display function blocks
> +      register which is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1

items with items syntax instead:

https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42

> +
> +  clocks:
> +    minItems: 1

Nope, maxItems.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - clocks
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/gce/mt8195-gce.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    mdp3-aal0@14005000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Definitelly "3" and "0" are not generic suffixes.

All comments above apply to your other files here.

> +        compatible = "mediatek,mt8195-mdp3-aal";
> +        reg = <0x14005000 0x1000>;
> +        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x5000 0x1000>;
> +        clocks = <&vppsys0 CLK_VPP0_MDP_AAL>;
> +        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
> new file mode 100644
> index 000000000000..1d8aa5dc76b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-color.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Media Data Path 3 COLOR
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Moudy Ho <moudy.ho@mediatek.com>
> +
> +description:
> +  One of Media Data Path 3 (MDP3) components used to adjust hue, luma and
> +  saturation to get better picture quality.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-mdp3-color

This is exactly the same as previous file. Why do you split the binding?
It really looks unnecessary.

Probably all other files should be also squashed.

> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of client driver can be configured by gce with 4 arguments
> +      defined in this property, such as phandle of gce, subsys id,
> +      register offset and size.
> +      Each subsys id is mapping to a base address of display function blocks
> +      register which is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h.

Full, real path please, so it could be validated with tools.


Best regards,
Krzysztof

