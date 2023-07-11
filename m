Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6184A74ED6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGKL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGKL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:57:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB47E77;
        Tue, 11 Jul 2023 04:57:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e278e344bso6841322a12.0;
        Tue, 11 Jul 2023 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689076647; x=1691668647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtu2/CgoRIl/GfDrNXXQtNyWvD5J/JtFdms/oxA79BI=;
        b=TUBLXGcABsPloatcWT9UExcx62VVSNEb2Ot7zpEN1DxXKXibv7XE+CrAbSqLD01pNV
         cJSyZ/ZSrOts2czM9Gtj4OXfrXMjqPs4HOSHxB4QrLHVxkfB8FpV447x6gjLjXI6H8d+
         AmCmJTJ3M5Njl3JbiK7jUSes00Zr2x2p9FXH5CFbB/QudVm89Iwxtp/gO2EKqozUYFki
         0MWwmL7I0DHtVsFJCWGRwiID83YR6jkp1DZklhy9MK62jFbDMz9j9CVo2ZURUmYhzRtK
         mcPUZBLV8ApT+QAbVRc+0yV24KsZ+GH0MI6e0PHLu/s6CdOnXdZ0vU87ES/ENHVZVssp
         mM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689076647; x=1691668647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xtu2/CgoRIl/GfDrNXXQtNyWvD5J/JtFdms/oxA79BI=;
        b=FDcB6SPCK4M5R+soi0UkvqtrASC/v6Zh3LL0JhVIdpOq2o1Ze8BqP3WxgpVxOzj4uA
         YOCzNMjsHJQiWBgtY++EokvIXthSrhbc0CEMl5egRyAg9xNTAxGVTIpCV9Tb2tT1J+Gp
         3UpKGa33RgVmKWZHdl1BgQYtfLnfKgon55udwl/9WQFWDpLB/8NNZzV92UDDZs7TE/Um
         GOyoZO4hCp0DwpoVaN0niB5PbuiBn4nXTc9eucz9Nm2OMIfmKOzrNlX5Ou+MS4AUtsxb
         C5yA5PpHVwaE2jFwxzLHdE5DHeED7+chl+QAx3RfdtgO8f29T7SX6mzVSs834uXe21Av
         +a4w==
X-Gm-Message-State: ABy/qLbmvCSVRvOoDRINgTUzdrwljwvQ3WP9tLJ5sEn1Nt02r3JJ4Jn3
        CTiqEe2fCBWQRM+GGzkAig3yQuF7G4VqTjGtRko=
X-Google-Smtp-Source: APBJJlEdNFvUgWXvgxmV/fkg941w/WVsW1reEr/a6y/8wYZFRq5N2xGfxBhDDtIu9KE6VXy+QmhZdF3ECVj7bMW/qBs=
X-Received: by 2002:aa7:da51:0:b0:51e:22dd:5e90 with SMTP id
 w17-20020aa7da51000000b0051e22dd5e90mr10001004eds.4.1689076647042; Tue, 11
 Jul 2023 04:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <1689039286-9706-1-git-send-email-shengjiu.wang@nxp.com> <1689039286-9706-4-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1689039286-9706-4-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 11 Jul 2023 14:57:15 +0300
Message-ID: <CAEnQRZD8vNBUc2POyHkWfcLXDrdKAVOyuW=jmv=fH_FfQSmJQw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] clk: imx: imx8: add audio clock mux driver
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 5:30=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> The Audio Clock Mux (ACM) is a collection of control registers
> and multiplexers that are used to route the audio source clocks
> to the audio peripherals.
>
> Each audio peripheral has its dedicated audio clock mux
> (which differ based on usage) and control register.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v4:
> - fix the error for module build reported by kernel test robot
>
> changes in v3:
> - change compatible string from nxp to fsl
>
> changes in v2:
> - none
>
>  drivers/clk/imx/Makefile       |   3 +-
>  drivers/clk/imx/clk-imx8-acm.c | 477 +++++++++++++++++++++++++++++++++
>  2 files changed, 479 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/imx/clk-imx8-acm.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index ae9d84ef046b..d4b8e10b1970 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -32,11 +32,12 @@ obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
>
>  obj-$(CONFIG_CLK_IMX93) +=3D clk-imx93.o
>
> -obj-$(CONFIG_MXC_CLK_SCU) +=3D clk-imx-scu.o clk-imx-lpcg-scu.o
> +obj-$(CONFIG_MXC_CLK_SCU) +=3D clk-imx-scu.o clk-imx-lpcg-scu.o clk-imx-=
acm.o
>  clk-imx-scu-$(CONFIG_CLK_IMX8QXP) +=3D clk-scu.o clk-imx8qxp.o \
>                                      clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o=
 \
>                                      clk-imx8dxl-rsrc.o
>  clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) +=3D clk-lpcg-scu.o clk-imx8qxp-l=
pcg.o
> +clk-imx-acm-$(CONFIG_CLK_IMX8QXP) =3D clk-imx8-acm.o
>
>  obj-$(CONFIG_CLK_IMX8ULP) +=3D clk-imx8ulp.o
>
> diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-ac=
m.c
> new file mode 100644
> index 000000000000..eb4eacba267a
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8-acm.c
> @@ -0,0 +1,477 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright 2018-2023 NXP
> +//
> +
> +#include <dt-bindings/clock/imx8-clock.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +/**
> + * struct clk_imx_acm_pm_domains: structure for multi power domain
> + * @pd_dev: power domain device
> + * @pd_dev_link: power domain device link
> + * @num_domains: power domain nummber
> + */
> +struct clk_imx_acm_pm_domains {
> +       struct device **pd_dev;
> +       struct device_link **pd_dev_link;
> +       int    num_domains;
> +};
> +
> +/**
> + * struct clk_imx8_acm_sel: for clock mux
> + * @name: clock name
> + * @clkid: clock id
> + * @parents: clock parents
> + * @num_parents: clock parents number
> + * @reg: register offset
> + * @shift: bit shift in register
> + * @width: bits width
> + */
> +struct clk_imx8_acm_sel {
> +       const char                      *name;
> +       int                             clkid;
> +       const struct clk_parent_data    *parents;       /* For mux */
> +       int                             num_parents;
> +       u32                             reg;
> +       u8                              shift;
> +       u8                              width;
> +};
> +
> +/**
> + * struct imx8_acm_soc_data: soc specific data
> + * @sels: pointer to struct clk_imx8_acm_sel
> + * @num_sels: numbers of items
> + */
> +struct imx8_acm_soc_data {
> +       struct clk_imx8_acm_sel *sels;
> +       unsigned int num_sels;
> +};
> +
> +/**
> + * struct imx8_acm_priv: private structure
> + * @dev_pm: multi power domain
> + * @soc_data: pointer to soc data
> + * @reg: base address of registers
> + * @regs: save registers for suspend
> + */
> +struct imx8_acm_priv {
> +       struct clk_imx_acm_pm_domains dev_pm;
> +       const struct imx8_acm_soc_data *soc_data;
> +       void __iomem *reg;
> +       u32 regs[IMX_ADMA_ACM_CLK_END];
> +};
> +
> +static const struct clk_parent_data imx8qm_aud_clk_sels[] =3D {
> +       {.fw_name =3D "aud_rec_clk0_lpcg_clk", .name =3D "aud_rec_clk0_lp=
cg_clk" },
> +       {.fw_name =3D "aud_rec_clk1_lpcg_clk", .name =3D "aud_rec_clk1_lp=
cg_clk" },
> +       {.fw_name =3D "mlb_clk", .name =3D "mlb_clk" },
> +       {.fw_name =3D "hdmi_rx_mclk", .name =3D "hdmi_rx_mclk" },
> +       {.fw_name =3D "ext_aud_mclk0", .name =3D "ext_aud_mclk0" },
> +       {.fw_name =3D "ext_aud_mclk1", .name =3D "ext_aud_mclk1" },
> +       {.fw_name =3D "esai0_rx_clk", .name =3D "esai0_rx_clk" },
> +       {.fw_name =3D "esai0_rx_hf_clk", .name =3D "esai0_rx_hf_clk" },
> +       {.fw_name =3D "esai0_tx_clk", .name =3D "esai0_tx_clk" },
> +       {.fw_name =3D "esai0_tx_hf_clk", .name =3D "esai0_tx_hf_clk" },
> +       {.fw_name =3D "esai1_rx_clk", .name =3D "esai1_rx_clk" },
> +       {.fw_name =3D "esai1_rx_hf_clk", .name =3D "esai1_rx_hf_clk" },
> +       {.fw_name =3D "esai1_tx_clk", .name =3D "esai1_tx_clk" },
> +       {.fw_name =3D "esai1_tx_hf_clk", .name =3D "esai1_tx_hf_clk" },
> +       {.fw_name =3D "spdif0_rx", .name =3D "spdif0_rx" },
> +       {.fw_name =3D "spdif1_rx", .name =3D "spdif1_rx" },
> +       {.fw_name =3D "sai0_rx_bclk", .name =3D "sai0_rx_bclk" },
> +       {.fw_name =3D "sai0_tx_bclk", .name =3D "sai0_tx_bclk" },
> +       {.fw_name =3D "sai1_rx_bclk", .name =3D "sai1_rx_bclk" },
> +       {.fw_name =3D "sai1_tx_bclk", .name =3D "sai1_tx_bclk" },
> +       {.fw_name =3D "sai2_rx_bclk", .name =3D "sai2_rx_bclk" },
> +       {.fw_name =3D "sai3_rx_bclk", .name =3D "sai3_rx_bclk" },
> +       {.fw_name =3D "sai4_rx_bclk", .name =3D "sai4_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8qm_mclk_out_sels[] =3D {
> +       {.fw_name =3D "aud_rec_clk0_lpcg_clk", .name =3D "aud_rec_clk0_lp=
cg_clk" },
> +       {.fw_name =3D "aud_rec_clk1_lpcg_clk", .name =3D "aud_rec_clk1_lp=
cg_clk" },
> +       {.fw_name =3D "mlb_clk", .name =3D "mlb_clk" },
> +       {.fw_name =3D "hdmi_rx_mclk", .name =3D "hdmi_rx_mclk" },
> +       {.fw_name =3D "spdif0_rx", .name =3D "spdif0_rx" },
> +       {.fw_name =3D "spdif1_rx", .name =3D "spdif1_rx" },
> +       {.fw_name =3D "sai4_rx_bclk", .name =3D "sai4_rx_bclk" },
> +       {.fw_name =3D "sai6_rx_bclk", .name =3D "sai6_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8qm_mclk_sels[] =3D {
> +       {.fw_name =3D "aud_pll_div_clk0_lpcg_clk", .name =3D "aud_pll_div=
_clk0_lpcg_clk" },
> +       {.fw_name =3D "aud_pll_div_clk1_lpcg_clk", .name =3D "aud_pll_div=
_clk1_lpcg_clk" },
> +       {.fw_name =3D "acm_aud_clk0_sel", .name =3D "acm_aud_clk0_sel" },
> +       {.fw_name =3D "acm_aud_clk1_sel", .name =3D "acm_aud_clk1_sel" },
> +};
> +
> +static const struct clk_parent_data imx8qm_asrc_mux_clk_sels[] =3D {
> +       {.fw_name =3D "sai4_rx_bclk", .name =3D "sai4_rx_bclk" },
> +       {.fw_name =3D "sai5_tx_bclk", .name =3D "sai5_tx_bclk" },
> +       {.name =3D "dummy" },
> +       {.fw_name =3D "mlb_clk", .name =3D "mlb_clk" },
> +
> +};
> +
> +static struct clk_imx8_acm_sel imx8qm_sels[] =3D {
> +       {"acm_aud_clk0_sel", IMX_ADMA_ACM_AUD_CLK0_SEL, imx8qm_aud_clk_se=
ls, ARRAY_SIZE(imx8qm_aud_clk_sels), 0x000000, 0, 5},
> +       {"acm_aud_clk1_sel", IMX_ADMA_ACM_AUD_CLK1_SEL, imx8qm_aud_clk_se=
ls, ARRAY_SIZE(imx8qm_aud_clk_sels), 0x010000, 0, 5},
> +       {"acm_mclkout0_sel", IMX_ADMA_ACM_MCLKOUT0_SEL, imx8qm_mclk_out_s=
els, ARRAY_SIZE(imx8qm_mclk_out_sels), 0x020000, 0, 3},
> +       {"acm_mclkout1_sel", IMX_ADMA_ACM_MCLKOUT1_SEL, imx8qm_mclk_out_s=
els, ARRAY_SIZE(imx8qm_mclk_out_sels), 0x030000, 0, 3},
> +       {"acm_asrc0_mclk_sel", IMX_ADMA_ACM_ASRC0_MUX_CLK_SEL, imx8qm_asr=
c_mux_clk_sels, ARRAY_SIZE(imx8qm_asrc_mux_clk_sels), 0x040000, 0, 2},
> +       {"acm_esai0_mclk_sel", IMX_ADMA_ACM_ESAI0_MCLK_SEL, imx8qm_mclk_s=
els, ARRAY_SIZE(imx8qm_mclk_sels), 0x060000, 0, 2},
> +       {"acm_esai1_mclk_sel", IMX_ADMA_ACM_ESAI1_MCLK_SEL, imx8qm_mclk_s=
els, ARRAY_SIZE(imx8qm_mclk_sels), 0x070000, 0, 2},
> +       {"acm_sai0_mclk_sel", IMX_ADMA_ACM_SAI0_MCLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x0E0000, 0, 2},
> +       {"acm_sai1_mclk_sel", IMX_ADMA_ACM_SAI1_MCLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x0F0000, 0, 2},
> +       {"acm_sai2_mclk_sel", IMX_ADMA_ACM_SAI2_MCLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x100000, 0, 2},
> +       {"acm_sai3_mclk_sel", IMX_ADMA_ACM_SAI3_MCLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x110000, 0, 2},
> +       {"acm_sai4_mclk_sel", IMX_ADMA_ACM_SAI4_MCLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x120000, 0, 2},
> +       {"acm_sai5_mclk_sel", IMX_ADMA_ACM_SAI5_MCLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x130000, 0, 2},
> +       {"acm_sai6_mclk_sel", IMX_ADMA_ACM_SAI6_MCLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x140000, 0, 2},
> +       {"acm_sai7_mclk_sel", IMX_ADMA_ACM_SAI7_MCLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x150000, 0, 2},
> +       {"acm_spdif0_mclk_sel", IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL, imx8qm_mc=
lk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x1A0000, 0, 2},
> +       {"acm_spdif1_mclk_sel", IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL, imx8qm_mc=
lk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x1B0000, 0, 2},
> +       {"acm_mqs_mclk_sel", IMX_ADMA_ACM_MQS_TX_CLK_SEL, imx8qm_mclk_sel=
s, ARRAY_SIZE(imx8qm_mclk_sels), 0x1C0000, 0, 2},
> +};
> +
> +static const struct clk_parent_data imx8qxp_aud_clk_sels[] =3D {
> +       {.fw_name =3D "aud_rec_clk0_lpcg_clk", .name =3D "aud_rec_clk0_lp=
cg_clk" },
> +       {.fw_name =3D "aud_rec_clk1_lpcg_clk", .name =3D "aud_rec_clk1_lp=
cg_clk" },
> +       {.fw_name =3D "ext_aud_mclk0", .name =3D "ext_aud_mclk0" },
> +       {.fw_name =3D "ext_aud_mclk1", .name =3D "ext_aud_mclk1" },
> +       {.fw_name =3D "esai0_rx_clk", .name =3D "esai0_rx_clk" },
> +       {.fw_name =3D "esai0_rx_hf_clk", .name =3D "esai0_rx_hf_clk" },
> +       {.fw_name =3D "esai0_tx_clk", .name =3D "esai0_tx_clk" },
> +       {.fw_name =3D "esai0_tx_hf_clk", .name =3D "esai0_tx_hf_clk" },
> +       {.fw_name =3D "spdif0_rx", .name =3D "spdif0_rx" },
> +       {.fw_name =3D "sai0_rx_bclk", .name =3D "sai0_rx_bclk" },
> +       {.fw_name =3D "sai0_tx_bclk", .name =3D "sai0_tx_bclk" },
> +       {.fw_name =3D "sai1_rx_bclk", .name =3D "sai1_rx_bclk" },
> +       {.fw_name =3D "sai1_tx_bclk", .name =3D "sai1_tx_bclk" },
> +       {.fw_name =3D "sai2_rx_bclk", .name =3D "sai2_rx_bclk" },
> +       {.fw_name =3D "sai3_rx_bclk", .name =3D "sai3_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8qxp_mclk_out_sels[] =3D {
> +       {.fw_name =3D "aud_rec_clk0_lpcg_clk", .name =3D "aud_rec_clk0_lp=
cg_clk" },
> +       {.fw_name =3D "aud_rec_clk1_lpcg_clk", .name =3D "aud_rec_clk1_lp=
cg_clk" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +       {.fw_name =3D "spdif0_rx", .name =3D "spdif0_rx" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +       {.fw_name =3D "sai4_rx_bclk", .name =3D "sai4_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8qxp_mclk_sels[] =3D {
> +       {.fw_name =3D "aud_pll_div_clk0_lpcg_clk", .name =3D "aud_pll_div=
_clk0_lpcg_clk" },
> +       {.fw_name =3D "aud_pll_div_clk1_lpcg_clk", .name =3D "aud_pll_div=
_clk1_lpcg_clk" },
> +       {.fw_name =3D "acm_aud_clk0_sel", .name =3D "acm_aud_clk0_sel" },
> +       {.fw_name =3D "acm_aud_clk1_sel", .name =3D "acm_aud_clk1_sel" },
> +};
> +
> +static struct clk_imx8_acm_sel imx8qxp_sels[] =3D {
> +       {"acm_aud_clk0_sel", IMX_ADMA_ACM_AUD_CLK0_SEL, imx8qxp_aud_clk_s=
els, ARRAY_SIZE(imx8qxp_aud_clk_sels), 0x000000, 0, 5},
> +       {"acm_aud_clk1_sel", IMX_ADMA_ACM_AUD_CLK1_SEL, imx8qxp_aud_clk_s=
els, ARRAY_SIZE(imx8qxp_aud_clk_sels), 0x010000, 0, 5},
> +       {"acm_mclkout0_sel", IMX_ADMA_ACM_MCLKOUT0_SEL, imx8qxp_mclk_out_=
sels, ARRAY_SIZE(imx8qxp_mclk_out_sels), 0x020000, 0, 3},
> +       {"acm_mclkout1_sel", IMX_ADMA_ACM_MCLKOUT1_SEL, imx8qxp_mclk_out_=
sels, ARRAY_SIZE(imx8qxp_mclk_out_sels), 0x030000, 0, 3},
> +       {"acm_esai0_mclk_sel", IMX_ADMA_ACM_ESAI0_MCLK_SEL, imx8qxp_mclk_=
sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x060000, 0, 2},
> +       {"acm_sai0_mclk_sel", IMX_ADMA_ACM_SAI0_MCLK_SEL, imx8qxp_mclk_se=
ls, ARRAY_SIZE(imx8qxp_mclk_sels), 0x0E0000, 0, 2},
> +       {"acm_sai1_mclk_sel", IMX_ADMA_ACM_SAI1_MCLK_SEL, imx8qxp_mclk_se=
ls, ARRAY_SIZE(imx8qxp_mclk_sels), 0x0F0000, 0, 2},
> +       {"acm_sai2_mclk_sel", IMX_ADMA_ACM_SAI2_MCLK_SEL, imx8qxp_mclk_se=
ls, ARRAY_SIZE(imx8qxp_mclk_sels), 0x100000, 0, 2},
> +       {"acm_sai3_mclk_sel", IMX_ADMA_ACM_SAI3_MCLK_SEL, imx8qxp_mclk_se=
ls, ARRAY_SIZE(imx8qxp_mclk_sels), 0x110000, 0, 2},
> +       {"acm_sai4_mclk_sel", IMX_ADMA_ACM_SAI4_MCLK_SEL, imx8qxp_mclk_se=
ls, ARRAY_SIZE(imx8qxp_mclk_sels), 0x140000, 0, 2},
> +       {"acm_sai5_mclk_sel", IMX_ADMA_ACM_SAI5_MCLK_SEL, imx8qxp_mclk_se=
ls, ARRAY_SIZE(imx8qxp_mclk_sels), 0x150000, 0, 2},
> +       {"acm_spdif0_mclk_sel", IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL, imx8qxp_m=
clk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x1A0000, 0, 2},
> +       {"acm_mqs_mclk_sel", IMX_ADMA_ACM_MQS_TX_CLK_SEL, imx8qxp_mclk_se=
ls, ARRAY_SIZE(imx8qxp_mclk_sels), 0x1C0000, 0, 2},
> +};
> +
> +static const struct clk_parent_data imx8dxl_aud_clk_sels[] =3D {
> +       {.fw_name =3D "aud_rec_clk0_lpcg_clk", .name =3D "aud_rec_clk0_lp=
cg_clk" },
> +       {.fw_name =3D "aud_rec_clk1_lpcg_clk", .name =3D "aud_rec_clk1_lp=
cg_clk" },
> +       {.fw_name =3D "ext_aud_mclk0", .name =3D "ext_aud_mclk0" },
> +       {.fw_name =3D "ext_aud_mclk1", .name =3D "ext_aud_mclk1" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +
> +       {.fw_name =3D "spdif0_rx", .name =3D "spdif0_rx" },
> +       {.fw_name =3D "sai0_rx_bclk", .name =3D "sai0_rx_bclk" },
> +       {.fw_name =3D "sai0_tx_bclk", .name =3D "sai0_tx_bclk" },
> +       {.fw_name =3D "sai1_rx_bclk", .name =3D "sai1_rx_bclk" },
> +       {.fw_name =3D "sai1_tx_bclk", .name =3D "sai1_tx_bclk" },
> +       {.fw_name =3D "sai2_rx_bclk", .name =3D "sai2_rx_bclk" },
> +       {.fw_name =3D "sai3_rx_bclk", .name =3D "sai3_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8dxl_mclk_out_sels[] =3D {
> +       {.fw_name =3D "aud_rec_clk0_lpcg_clk", .name =3D "aud_rec_clk0_lp=
cg_clk" },
> +       {.fw_name =3D "aud_rec_clk1_lpcg_clk", .name =3D "aud_rec_clk1_lp=
cg_clk" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +       {.fw_name =3D "spdif0_rx", .name =3D "spdif0_rx" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +};
> +
> +static const struct clk_parent_data imx8dxl_mclk_sels[] =3D {
> +       {.fw_name =3D "aud_pll_div_clk0_lpcg_clk", .name =3D "aud_pll_div=
_clk0_lpcg_clk" },
> +       {.fw_name =3D "aud_pll_div_clk1_lpcg_clk", .name =3D "aud_pll_div=
_clk1_lpcg_clk" },
> +       {.fw_name =3D "acm_aud_clk0_sel", .name =3D "acm_aud_clk0_sel" },
> +       {.fw_name =3D "acm_aud_clk1_sel", .name =3D "acm_aud_clk1_sel" },
> +};
> +
> +static struct clk_imx8_acm_sel imx8dxl_sels[] =3D {
> +       {"acm_aud_clk0_sel", IMX_ADMA_ACM_AUD_CLK0_SEL, imx8dxl_aud_clk_s=
els, ARRAY_SIZE(imx8dxl_aud_clk_sels), 0x000000, 0, 5},
> +       {"acm_aud_clk1_sel", IMX_ADMA_ACM_AUD_CLK1_SEL, imx8dxl_aud_clk_s=
els, ARRAY_SIZE(imx8dxl_aud_clk_sels), 0x010000, 0, 5},
> +       {"acm_mclkout0_sel", IMX_ADMA_ACM_MCLKOUT0_SEL, imx8dxl_mclk_out_=
sels, ARRAY_SIZE(imx8dxl_mclk_out_sels), 0x020000, 0, 3},
> +       {"acm_mclkout1_sel", IMX_ADMA_ACM_MCLKOUT1_SEL, imx8dxl_mclk_out_=
sels, ARRAY_SIZE(imx8dxl_mclk_out_sels), 0x030000, 0, 3},
> +       {"acm_sai0_mclk_sel", IMX_ADMA_ACM_SAI0_MCLK_SEL, imx8dxl_mclk_se=
ls, ARRAY_SIZE(imx8dxl_mclk_sels), 0x0E0000, 0, 2},
> +       {"acm_sai1_mclk_sel", IMX_ADMA_ACM_SAI1_MCLK_SEL, imx8dxl_mclk_se=
ls, ARRAY_SIZE(imx8dxl_mclk_sels), 0x0F0000, 0, 2},
> +       {"acm_sai2_mclk_sel", IMX_ADMA_ACM_SAI2_MCLK_SEL, imx8dxl_mclk_se=
ls, ARRAY_SIZE(imx8dxl_mclk_sels), 0x100000, 0, 2},
> +       {"acm_sai3_mclk_sel", IMX_ADMA_ACM_SAI3_MCLK_SEL, imx8dxl_mclk_se=
ls, ARRAY_SIZE(imx8dxl_mclk_sels), 0x110000, 0, 2},
> +       {"acm_spdif0_mclk_sel", IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL, imx8dxl_m=
clk_sels, ARRAY_SIZE(imx8dxl_mclk_sels), 0x1A0000, 0, 2},
> +       {"acm_mqs_mclk_sel", IMX_ADMA_ACM_MQS_TX_CLK_SEL, imx8dxl_mclk_se=
ls, ARRAY_SIZE(imx8dxl_mclk_sels), 0x1C0000, 0, 2},
> +};
> +
> +/**
> + * clk_imx_acm_attach_pm_domains: attach multi power domains
> + * @dev: device pointer
> + * @dev_pm: power domains for device
> + */
> +static int clk_imx_acm_attach_pm_domains(struct device *dev,
> +                                        struct clk_imx_acm_pm_domains *d=
ev_pm)
> +{
> +       int ret;
> +       int i;
> +
> +       dev_pm->num_domains =3D of_count_phandle_with_args(dev->of_node, =
"power-domains",
> +                                                        "#power-domain-c=
ells");
> +       if (dev_pm->num_domains <=3D 1)
> +               return 0;
> +
> +       dev_pm->pd_dev =3D devm_kmalloc_array(dev, dev_pm->num_domains,
> +                                           sizeof(*dev_pm->pd_dev),
> +                                           GFP_KERNEL);
> +       if (!dev_pm->pd_dev)
> +               return -ENOMEM;
> +
> +       dev_pm->pd_dev_link =3D devm_kmalloc_array(dev,
> +                                                dev_pm->num_domains,
> +                                                sizeof(*dev_pm->pd_dev_l=
ink),
> +                                                GFP_KERNEL);
> +       if (!dev_pm->pd_dev_link)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < dev_pm->num_domains; i++) {
> +               dev_pm->pd_dev[i] =3D dev_pm_domain_attach_by_id(dev, i);
> +               if (IS_ERR(dev_pm->pd_dev[i]))
> +                       return PTR_ERR(dev_pm->pd_dev[i]);
> +
> +               dev_pm->pd_dev_link[i] =3D device_link_add(dev,
> +                                                        dev_pm->pd_dev[i=
],
> +                                                        DL_FLAG_STATELES=
S |
> +                                                        DL_FLAG_PM_RUNTI=
ME |
> +                                                        DL_FLAG_RPM_ACTI=
VE);
> +               if (IS_ERR(dev_pm->pd_dev_link[i])) {
> +                       dev_pm_domain_detach(dev_pm->pd_dev[i], false);
> +                       ret =3D PTR_ERR(dev_pm->pd_dev_link[i]);
> +                       goto detach_pm;
> +               }
> +       }
> +       return 0;
> +
> +detach_pm:
> +       while (--i >=3D 0) {
> +               device_link_del(dev_pm->pd_dev_link[i]);
> +               dev_pm_domain_detach(dev_pm->pd_dev[i], false);
> +       }
> +       return ret;
> +}
> +
> +/**
> + * clk_imx_acm_detach_pm_domains: detach multi power domains
> + * @dev: deivice pointer
> + * @dev_pm: multi power domain for device
> + */
> +static int clk_imx_acm_detach_pm_domains(struct device *dev,
> +                                        struct clk_imx_acm_pm_domains *d=
ev_pm)
> +{
> +       int i;
> +
> +       if (dev_pm->num_domains <=3D 1)
> +               return 0;
> +
> +       for (i =3D 0; i < dev_pm->num_domains; i++) {
> +               device_link_del(dev_pm->pd_dev_link[i]);
> +               dev_pm_domain_detach(dev_pm->pd_dev[i], false);
> +       }
> +
> +       return 0;
> +}
> +
> +static int imx8_acm_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       struct device *dev =3D &pdev->dev;
> +       struct clk_imx8_acm_sel *sels;
> +       struct imx8_acm_priv *priv;
> +       struct resource *res;
> +       struct clk_hw **hws;
> +       void __iomem *base;
> +       int ret;
> +       int i;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap(dev, res->start, resource_size(res));
> +       if (!base)
> +               return -ENOMEM;
> +
> +       priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->reg =3D base;
> +       priv->soc_data =3D of_device_get_match_data(dev);
> +       platform_set_drvdata(pdev, priv);
> +
> +       clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
> +                                         IMX_ADMA_ACM_CLK_END), GFP_KERN=
EL);

Should we also use devm_kzalloc here?
