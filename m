Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C87966716A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjALL50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjALL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:56:47 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60A45B497
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:49:10 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id f5so1865345ual.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc90MP0lO5NabKtarT67wAhel1LbFD1g72FNi8Kcmco=;
        b=Yl4EI4pWEgqt9ywJRpKAJkTPHZ/G6JZI899Id1waManNh6rr1948RRx9EqT9tgD5H5
         0Fh1H+AMG/3VsmPENHCYilSRmFW9feZyBn9DyRxWOJekUc37VM1yMiKwAkJgmtkmC9vv
         SFwU4AGjhBQ/CuWHa32sVYMCkfQ6ktX28hCF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc90MP0lO5NabKtarT67wAhel1LbFD1g72FNi8Kcmco=;
        b=MarLb+sjEiNa45i1fKue6fwPlcf4FBHDEWH01rrs4Bfth9HmhNHCd3XtasGXowQhu1
         aQxITLpdKWCw0wm5F8AyV9nVt/mjPEnXtIymsXppyNiqglihixdgtNXvrdjZX8u/8BYD
         gmkK7+HcQkYjlWJi+ljiuYE8Vjf9VBhIQZMOm2Z6+F1FnhwhJI1mvXBUKqbCApreiW7j
         HG5LnCp7xUW20Ce1N8waHd45h6Mi/lhf7596vWH6RvV1qeXwwUnGNSbsXfscPGegTlRX
         adwz9V3hwXGEpuWbwyc3E7vX8xxclC3zQlkywYtAGh3SY4I0tgl8oUDIx15fNBq74ZyI
         scvA==
X-Gm-Message-State: AFqh2korO7Os+KeBMng8J+C7DEyXC7muWiVPDMZhB6mlXl9d+/C9Xo4K
        ddxqpRSr7hdxs+G4NVvpQ+ORaJxbfcglQ+BHnsR5yw==
X-Google-Smtp-Source: AMrXdXuItCuiLhRlSwBuSQxSx2uJ8oOcDFtg4BL5xBWj9NfAfa5/6Fit2CP85TF5iq9Cpoxi5wxTi1BTvSSFUBclgq0=
X-Received: by 2002:ab0:738b:0:b0:469:f0ea:c1f7 with SMTP id
 l11-20020ab0738b000000b00469f0eac1f7mr7626458uap.0.1673524149333; Thu, 12 Jan
 2023 03:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20230111123711.32020-1-allen-kh.cheng@mediatek.com> <20230111123711.32020-8-allen-kh.cheng@mediatek.com>
In-Reply-To: <20230111123711.32020-8-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 12 Jan 2023 19:48:58 +0800
Message-ID: <CAGXv+5EDW9jZxWZW-9nYeK+2UnMR6UE28wASNFZ8MfdDhVKhxg@mail.gmail.com>
Subject: Re: [PATCH 7/9] arm64: dts: mediatek: mt8186: Add DPI node
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 8:37 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> Add DPI node for MT8186 SoC.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index c52f9be1e750..eab30ab01572 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -1230,6 +1230,23 @@
>                         power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
>                 };
>
> +               dpi0: dpi@1400a000 {

You could drop the trailing 0 in the label, since there is only one
instance.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> +                       compatible = "mediatek,mt8186-dpi";
> +                       reg = <0 0x1400a000 0 0x1000>;
> +                       clocks = <&topckgen CLK_TOP_DPI>,
> +                                <&mmsys CLK_MM_DISP_DPI>,
> +                                <&apmixedsys CLK_APMIXED_TVDPLL>;
> +                       clock-names = "pixel", "engine", "pll";
> +                       assigned-clocks = <&topckgen CLK_TOP_DPI>;
> +                       assigned-clock-parents = <&topckgen CLK_TOP_TVDPLL_D2>;
> +                       interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_LOW 0>;
> +                       status = "disabled";
> +
> +                       port {
> +                               dpi_out: endpoint { };
> +                       };
> +               };
> +
>                 dsi0: dsi@14013000 {
>                         compatible = "mediatek,mt8186-dsi";
>                         reg = <0 0x14013000 0 0x1000>;
> --
> 2.18.0
>
