Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AFA728CD3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjFIBGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFIBGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2347F270F;
        Thu,  8 Jun 2023 18:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D1C6528A;
        Fri,  9 Jun 2023 01:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC84AC4339C;
        Fri,  9 Jun 2023 01:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686272760;
        bh=fnrj8HODEZPuaXfIuvje1guJksw1G513Xiodc8YprVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CnanVOefCZe19tiPP03sOSqtFNcHuMeIG4TL5s/ZhGmQbf/TobM+ilWdjIqTSZGtC
         dYt/2dQIlDJn17FVHvjxBlJSABu0kSVX68bgHK6QdODndv2cMfPvDttGNrGW640Lta
         TQ41obJdEZyoq5AaNHnrvwzDSXRMuxELpdStTIL5iFZXIXnRqI4UNoJf6AN0yKv5QG
         afZfn/GBHtVKwtdOcVgXnI8SYi1dwrvRB4XwH9pe3xEja0m0SE1ZiL/M28ddYx6Gv6
         fNrgf1C+88kxXWz2Ou8UQvWX3PwRcTq17l+rvMgbuHqEfMWHTeEFG//m9+3Mzoyuyp
         aejAq2s2GPelw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so1590704e87.1;
        Thu, 08 Jun 2023 18:06:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDw79SWG1BpHicS9rCTe5h9AoxwXB/6ta14yOjl14IDs57Um9XGR
        RulDa3cL/QaX+EiIGIiwp2pALC+dER4nrMxFrg==
X-Google-Smtp-Source: ACHHUZ6OqexUjRIDLhjygD1zyaTSRKOXCn926L5zqqZ+dXrrEh0r0ELzATK2GNJVppdKRs/fpEhLSyPSr7XcKiwZwQA=
X-Received: by 2002:a19:6753:0:b0:4f6:47a2:7bb4 with SMTP id
 e19-20020a196753000000b004f647a27bb4mr322218lfj.60.1686272758863; Thu, 08 Jun
 2023 18:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230607061121.6732-1-shawn.sung@mediatek.com> <20230607061121.6732-2-shawn.sung@mediatek.com>
In-Reply-To: <20230607061121.6732-2-shawn.sung@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 9 Jun 2023 09:05:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY__LvESsCU74vWwdTKDT6C-xasO7d5sXdzihyssmEaQbYQ@mail.gmail.com>
Message-ID: <CAAOTY__LvESsCU74vWwdTKDT6C-xasO7d5sXdzihyssmEaQbYQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] dt-bindings: display/mediatek: mt8188: Add
 documentations for VDOSYS1
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Fei Shao <fshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsiao-chien:

Separate mmsys part to another patch because it would go through
different maintainer's tree.

Separate padding part to another patch because it's a new device.

Regards,
Chun-Kuang.

Hsiao Chien Sung <shawn.sung@mediatek.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Add device tree documentations for MT8188 VDOSYS1.
>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml |  1 +
>  .../display/mediatek/mediatek,ethdr.yaml      |  5 +-
>  .../display/mediatek/mediatek,mdp-rdma.yaml   |  5 +-
>  .../display/mediatek/mediatek,merge.yaml      |  1 +
>  .../display/mediatek/mediatek,padding.yaml    | 80 +++++++++++++++++++
>  5 files changed, 90 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,padding.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsy=
s.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 536f5a5ebd24..642fa2e4736e 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -32,6 +32,7 @@ properties:
>                - mediatek,mt8183-mmsys
>                - mediatek,mt8186-mmsys
>                - mediatek,mt8188-vdosys0
> +              - mediatek,mt8188-vdosys1
>                - mediatek,mt8192-mmsys
>                - mediatek,mt8195-vdosys1
>                - mediatek,mt8195-vppsys0
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ethdr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,et=
hdr.yaml
> index 801fa66ae615..e3f740ab0564 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.y=
aml
> @@ -23,7 +23,10 @@ description:
>
>  properties:
>    compatible:
> -    const: mediatek,mt8195-disp-ethdr
> +    oneOf:
> +      - enum:
> +        - mediatek,mt8188-disp-ethdr
> +        - mediatek,mt8195-disp-ethdr
>
>    reg:
>      maxItems: 7
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
mdp-rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek=
,mdp-rdma.yaml
> index dd12e2ff685c..07c345fa9178 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdm=
a.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdm=
a.yaml
> @@ -21,7 +21,10 @@ description:
>
>  properties:
>    compatible:
> -    const: mediatek,mt8195-vdo1-rdma
> +    oneOf:
> +      - enum:
> +        - mediatek,mt8188-vdo1-rdma
> +        - mediatek,mt8195-vdo1-rdma
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,me=
rge.yaml
> index 2f8e2f4dc3b8..600f1b4608f8 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> @@ -23,6 +23,7 @@ properties:
>      oneOf:
>        - enum:
>            - mediatek,mt8173-disp-merge
> +          - mediatek,mt8188-disp-merge
>            - mediatek,mt8195-disp-merge
>
>    reg:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
padding.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,=
padding.yaml
> new file mode 100644
> index 000000000000..8a9e74cbf6dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding=
.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,padding.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek PADDING
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description:
> +  MediaTek PADDING provides ability to VDOSYS1 to fill pixels to
> +  width and height of a layer with a specified color.
> +  Since MIXER in VDOSYS1 requires the width of a layer to be 2-pixel-ali=
gn, or
> +  4-pixel-align when ETHDR is enabled, we need PADDING to deal with odd =
width.
> +  Please notice that even if the PADDING is in bypass mode,
> +  settings in the registers must be cleared to 0, otherwise
> +  undeinfed behaviors could happen.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8188-vdo1-padding
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: RDMA Clock
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of display function block to be set by gce. There are=
 4 arguments,
> +      such as gce node, subsys id, offset and register size. The subsys =
id that is
> +      mapping to the register of display function blocks is defined in t=
he gce header
> +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - mediatek,gce-client-reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8188-clk.h>
> +    #include <dt-bindings/power/mt8188-power.h>
> +    #include <dt-bindings/gce/mt8188-gce.h>
> +    #include <dt-bindings/memory/mt8188-memory-port.h>
> +
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        vdo1_padding0: vdo1_padding0@1c11d000 {
> +            compatible =3D "mediatek,mt8188-vdo1-padding";
> +            reg =3D <0 0x1c11d000 0 0x1000>;
> +            clocks =3D <&vdosys1 CLK_VDO1_PADDING0>;
> +            power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
> +            mediatek,gce-client-reg =3D
> +                <&gce0 SUBSYS_1c11XXXX 0xd000 0x1000>;
> +        };
> +    };
> --
> 2.18.0
>
