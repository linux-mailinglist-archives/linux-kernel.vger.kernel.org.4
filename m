Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179B5E99CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiIZGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiIZGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:47:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA320379
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:47:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x21so7599777edd.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=88T3QSCNULaKDxiPghKPnQRDxL4OOovXa9Ho2BaB7s8=;
        b=g/e0p3noU5zZHf8DNPX1uUNnyjvgmp+4LVsZB5fu7/mc2jlvplhjx063ltZa5zgJ/t
         ZNg0JoMxFk3t4OnZqyT2rZZi1ax70PwFNx94dxy0Ot56HFvX+8/4o1rxumpbjqinMzSK
         JZtOnVTsXaocMtLpSHrOsP3HdSmTOl3yh+ObM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=88T3QSCNULaKDxiPghKPnQRDxL4OOovXa9Ho2BaB7s8=;
        b=KTNDE0jgmv0T53LHb78/A9mRelDmYGfb8e7g2vvbifUCENx14HhoJ+YGRPJmSEuV2l
         xsOaPgeh0XQj1/O3Ksz8Q3kuHko87vA3ZL3HqNSBDXiyFRAuw4WCzcV8C+nLfl7Thay+
         g/k7QOFjE9NrhPu0+T6QwbFG5O98okNcreKmbPQUAqmKpK1rA1aebdK+y06ip669vDMM
         L9QbodpHfr577FjOUYrllkygpx1+bb1KZR/f15YT4VmshHgm6fhSa6M3XnUhs2CSl7Oh
         QGY1UEMSIQOqbXQR/bV1EwWtMYwKWATbowZUtnE5L/AlRHjG3svKHqiA1JmeYh5SAXl7
         SqUQ==
X-Gm-Message-State: ACrzQf2mi8T29Ws/qm/DEZXo2h0blom1YJLf0nRmSNzmKMhyE0aptQIS
        jqqeOb3w2q9ZAzo1JoOW9mba3qSyousuaZi+Bt3DVw==
X-Google-Smtp-Source: AMsMyM6RbECMtGrbbPAST+i21qjBet8HNCxVGnIE11peeASsQM5EtaznB/yehtxnAh9MTAiy9ZNvfVmi7qNk5dmne1A=
X-Received: by 2002:a05:6402:90e:b0:443:ec4b:2b03 with SMTP id
 g14-20020a056402090e00b00443ec4b2b03mr20513160edz.71.1664174853143; Sun, 25
 Sep 2022 23:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220923114658.8286-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220923114658.8286-1-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 14:47:21 +0800
Message-ID: <CAGXv+5Hx31PWVU-uz0araW+jYX-s+_HXph-ZAPa6eMPn0LQ+Bg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8192: Add vcodec lat and core nodes
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 7:47 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> Add vcodec lat and core nodes for mt8192 SoC.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
> This patch is based on matthias.bgg/linux.git, v6.0-next/dts64
> [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> ---
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60 ++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6b20376191a7..aa6524948e7c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1449,6 +1449,66 @@
>                         power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
>                 };
>
> +               vcodec_dec: vcodec-dec@16000000 {

The device node name should be generic, so maybe "video-codec@"?

> +                       compatible = "mediatek,mt8192-vcodec-dec";
> +                       reg = <0 0x16000000 0 0x1000>;
> +                       mediatek,scp = <&scp>;
> +                       iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> +                       dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges = <0 0 0 0x16000000 0 0x26000>;
> +
> +                       vcodec_lat: vcodec-lat@10000 {

Same here.

> +                               compatible = "mediatek,mtk-vcodec-lat";
> +                               reg = <0x0 0x10000 0 0x800>;
> +                               interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
> +                               iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
> +                               clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +                                        <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> +                                        <&vdecsys_soc CLK_VDEC_SOC_LAT>,
> +                                        <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
> +                                        <&topckgen CLK_TOP_MAINPLL_D4>;
> +                               clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
> +                               assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
> +                               assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
> +                               power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
> +                       };
> +
> +                       vcodec_core: vcodec-core@25000 {

Same here.

ChenYu
