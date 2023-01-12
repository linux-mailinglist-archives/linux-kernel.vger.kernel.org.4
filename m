Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521CB666EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjALKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbjALKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:01:09 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7929E79
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:00:53 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id l185so5315775vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4i06mppGYiXhN0gX/mC8nb9SL6Y8d9Zg4Osy3GV9SYg=;
        b=dJJzcYTvtPtZKZ4Oo6YyvU+v7YG1bh5MFh5fAmIWm8cSjzoLbPKfvnvSgb40a1ncK1
         3SK1jAOygeZJ+JoEVrIXG1GZg0QjdenjPGpBmGmC74dJNfyvpLkyKEktPDiWxxTXo3iW
         rcuznjSZTCQVEIaAMeNCGIOUz3heRijTYPsXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4i06mppGYiXhN0gX/mC8nb9SL6Y8d9Zg4Osy3GV9SYg=;
        b=k+kIUYypC3621e6kWa6YcdhvrujRtYCGk/jw+uk1GrFoHAr2kcnrnTzixuFbqCtM+/
         Qhb2GmDKojUSrBf78zU9a4I4x1j3ZIcFoPxU149i4OToqWllHTkJRHQBsPdOTcG4lyq8
         iCdJzuau3QxpVjzLLeJwsNLDd8OLttS3Tevte/XoRduTMVBwrluGy54im3HtRsiTjJ10
         SRnZN5DRwzact7bySlFw+x0Iy32fLV8tUuZT9uIcf0hyPGyLDVMaz2ON+63hepjvG9tc
         1tXtpKNgknMiKAQtqJWMs0i4DOGH5HTg5pQBVkmZW90ggpAI81wjqPggz2XwNR/N99tG
         BsNQ==
X-Gm-Message-State: AFqh2krvN2W3UbQX+xBVc8ccGfPuXFdbIvArvfKK0hyB/PLOdAATm3GZ
        g9hTIy2MGvgKxOUE+mrf2AIl3PoXLh+pJslgGUPA8MpiC6dt/w==
X-Google-Smtp-Source: AMrXdXuwd6kfa03Fjf9jlTXF89gVtVV+1AhRmAg6v5vIaOgGq1AZS2BQHeGXdFJEDzUutm8EX+I3gEp529jY5uCS4Gs=
X-Received: by 2002:a1f:2795:0:b0:3d8:df4c:cfc4 with SMTP id
 n143-20020a1f2795000000b003d8df4ccfc4mr3797463vkn.18.1673517652955; Thu, 12
 Jan 2023 02:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20230111123711.32020-1-allen-kh.cheng@mediatek.com> <20230111123711.32020-10-allen-kh.cheng@mediatek.com>
In-Reply-To: <20230111123711.32020-10-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 12 Jan 2023 18:00:41 +0800
Message-ID: <CAGXv+5HbTzyWqvn=iJDnWdWS-MM+wyc0w7F-vPXJN489eGYotQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] arm64: dts: mediatek: mt8186: Add display nodes
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 11, 2023 at 8:37 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> Add display nodes and GCE info for MT8186 SoC. Also, add GCE
> (Global Command Engine) properties to the display nodes in order to
> enable the usage of the CMDQ (Command Queue), which is required for
> operating the display.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 128 +++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index eab30ab01572..8670d37970ef 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -5,6 +5,7 @@
>   */
>  /dts-v1/;
>  #include <dt-bindings/clock/mt8186-clk.h>
> +#include <dt-bindings/gce/mt8186-gce.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/memory/mt8186-memory-port.h>
> @@ -632,6 +633,15 @@
>                         clocks = <&clk13m>;
>                 };
>
> +               gce: mailbox@1022c000 {
> +                       compatible = "mediatek,mt8186-gce";
> +                       reg = <0 0X1022c000 0 0x4000>;
> +                       interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       #mbox-cells = <2>;
> +                       clocks = <&infracfg_ao CLK_INFRA_AO_GCE>;
> +                       clock-names = "gce";
> +               };
> +
>                 scp: scp@10500000 {
>                         compatible = "mediatek,mt8186-scp";
>                         reg = <0 0x10500000 0 0x40000>,
> @@ -1197,6 +1207,20 @@
>                         reg = <0 0x14000000 0 0x1000>;
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
> +                       mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +                                <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
> +               };
> +
> +               mutex: mutex@14001000 {
> +                       compatible = "mediatek,mt8186-disp-mutex";
> +                       reg = <0 0x14001000 0 0x1000>;
> +                       clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +                       interrupts = <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
> +                       mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
> +                                             <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
> +                       power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
>                 };
>
>                 smi_common: smi@14002000 {
> @@ -1230,6 +1254,49 @@
>                         power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
>                 };
>
> +               ovl0: ovl@14005000 {

If there's only one instance, you could drop the trailing zero. Same
for all the other nodes.

> +                       compatible = "mediatek,mt8186-disp-ovl",
> +                                    "mediatek,mt8192-disp-ovl";
> +                       reg = <0 0x14005000 0 0x1000>;
> +                       clocks = <&mmsys CLK_MM_DISP_OVL0>;
> +                       interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       iommus = <&iommu_mm IOMMU_PORT_L0_OVL_RDMA0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
> +                       power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +               };
> +
> +               ovl0_2l: ovl@14006000 {

I think this should be "ovl_2l0" or "ovl_2l" instead?

> +                       compatible = "mediatek,mt8186-disp-ovl-2l",
> +                                    "mediatek,mt8192-disp-ovl-2l";
> +                       reg = <0 0x14006000 0 0x1000>;
> +                       power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +                       clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
> +                       interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       iommus = <&iommu_mm IOMMU_PORT_L1_OVL_2L_RDMA0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
> +               };

Also, this patch is missing the aliases for ovl* and rdma*. Without them
the display driver doesn't properly detect the second pipeline, and only
one CRTC is generated.

ChenYu
