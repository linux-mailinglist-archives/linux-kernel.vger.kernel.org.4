Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792661A3F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiKDWQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:16:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE477429B8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:16:14 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-37063f855e5so55823057b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1HfnlDnnSIKrpwcWHnYXP8r8LvoFkj8rfyMhrfMoGp0=;
        b=ApHnpmU5I5emdK/HMsrmrUEIrjuO4yn9fHabgnsthQAKfU915KlcEGIu7QZ+YwO5wa
         NT56cTpRGR5EIAFdGP2Fsc69m8i3aJ1/WI4jZ6UdXp5NxNkmVtTGy4R1uKxaC+S0OOXA
         p+WDFascQK6/5siW17cX0Piq/COUWPkV/bY0sgtXU6GBe8iPxQO8oRFTBeAQsYvW86J5
         QBSAqnEVAzMdvbiXC9OWM+gCQbucbA2fzNN3bZFBCAiNS9le6VD+hsTWUBecFKkz1ip4
         hiqVadCffIi3qU+afRWIbsfxx4aNS6pYGAx9ycDyRfYsuDLWoL9sNpQXdbY/MYgy/GAJ
         FWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HfnlDnnSIKrpwcWHnYXP8r8LvoFkj8rfyMhrfMoGp0=;
        b=3XHgDFowLmrXo/lfXHs6yaIUEgpyC2z5rSbG2Ue6JIF75YwIIbrP2Tond+GxnXrXBC
         4KEEimYxxNw5eIMVBnnt+Y7Mu6TQPvKreWAUO0uyte/MtFKtiUujEiZ2zC3Q80pC9B+N
         cji2ChphlihyNN6ZHRk9nQASOq+H1Ba8x8WFtMWgHIir2iVdcvngV5k4GxzHRr33WTvm
         PxgLvQ2Dj3fP9sZq4jaCeoANXJnB0iCbUBKJd9q4glO0mjbUqqFwPAYoT/VEHlRTwYZ+
         QUhWACpCiu6uW7JiVzkvfdpJXNHdslUhYtYjKU9GDdiEpJLfxZgV/JbCY/YiEZfKIIGH
         t9yw==
X-Gm-Message-State: ACrzQf2lklxgnDL2vkfZM4JA9OQOdGAgb0ceyfHWQwAY60f9CGYhIUOb
        A0yoTDjjZH+RLlahG1hHuN/jUVIBjP21fVfktcc+5w==
X-Google-Smtp-Source: AMsMyM49rEgiVcUTJy+cdyuEg6hd6EM//eOAr+kMZq9alNX8TO/7Vyq/uiNRSnHkfSOGpJSjQA+EaWUdSeHruVISaLA=
X-Received: by 2002:a81:9186:0:b0:36f:d191:3b43 with SMTP id
 i128-20020a819186000000b0036fd1913b43mr36804837ywg.132.1667600173967; Fri, 04
 Nov 2022 15:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com> <20221104133506.131316-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221104133506.131316-3-angelogioacchino.delregno@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 5 Nov 2022 01:16:02 +0300
Message-ID: <CAA8EJprQ0v75O1txO0aVuvFpdiRAAzCphLE-sAiUGi_=Kn-ueA@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: Add Qualcomm Ramp Controller driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 16:35, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>
> The Ramp Controller is used to program the sequence ID for pulse
> swallowing, enable sequence and linking sequence IDs for the CPU
> cores on some Qualcomm SoCs.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/soc/qcom/Kconfig           |   9 +
>  drivers/soc/qcom/Makefile          |   1 +
>  drivers/soc/qcom/ramp_controller.c | 330 +++++++++++++++++++++++++++++
>  3 files changed, 340 insertions(+)
>  create mode 100644 drivers/soc/qcom/ramp_controller.c
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 024e420f1bb7..1e681f98bad4 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -95,6 +95,15 @@ config QCOM_QMI_HELPERS
>         tristate
>         depends on NET
>
> +config QCOM_RAMP_CTRL
> +       tristate "Qualcomm Ramp Controller driver"
> +       depends on ARCH_QCOM
> +       help
> +         The Ramp Controller is used to program the sequence ID for pulse
> +         swallowing, enable sequence and linking sequence IDs for the
> +         CPU cores on some Qualcomm SoCs.
> +         Say y here to enable support for the ramp controller.

Generic question. regarding this controller. If it is supposed to work
close to DVCS, etc. Does ramp controller need any programming when
changing speed and/or APC voltage?
Is it necessary to turn ramp on and off during the runtime?

> +
>  config QCOM_RMTFS_MEM
>         tristate "Qualcomm Remote Filesystem memory driver"
>         depends on ARCH_QCOM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index d66604aff2b0..6e02333c4080 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_OCMEM)      += ocmem.o
>  obj-$(CONFIG_QCOM_PDR_HELPERS) += pdr_interface.o
>  obj-$(CONFIG_QCOM_QMI_HELPERS) += qmi_helpers.o
>  qmi_helpers-y  += qmi_encdec.o qmi_interface.o
> +obj-$(CONFIG_QCOM_RAMP_CTRL)   += ramp_controller.o
>  obj-$(CONFIG_QCOM_RMTFS_MEM)   += rmtfs_mem.o
>  obj-$(CONFIG_QCOM_RPMH)                += qcom_rpmh.o
>  qcom_rpmh-y                    += rpmh-rsc.o
> diff --git a/drivers/soc/qcom/ramp_controller.c b/drivers/soc/qcom/ramp_controller.c
> new file mode 100644
> index 000000000000..e28679b545d1
> --- /dev/null
> +++ b/drivers/soc/qcom/ramp_controller.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm Ramp Controller driver
> + * Copyright (c) 2022, AngeloGioacchino Del Regno
> + *                     <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#define RC_UPDATE_EN           BIT(0)
> +#define RC_ROOT_EN             BIT(1)
> +
> +#define RC_REG_CFG_UPDATE      0x60
> + #define RC_CFG_UPDATE_EN      BIT(8)
> + #define RC_CFG_ACK            GENMASK(31, 16)
> +
> +#define RC_DCVS_CFG_SID                2
> +#define RC_LINK_SID            3
> +#define RC_LMH_SID             6
> +#define RC_DFS_SID             14
> +
> +#define RC_UPDATE_TIMEOUT_US   500
> +
> +/**
> + * struct qcom_ramp_controller_desc - SoC specific parameters
> + * @cfg_dfs_sid:      Dynamic Frequency Scaling SID configuration
> + * @cfg_link_sid:     Link SID configuration
> + * @cfg_lmh_sid:      Limits Management hardware SID configuration
> + * @cfg_ramp_pre_en:  Ramp Controller pre-enable sequence
> + * @cfg_ramp_en:      Ramp Controller enable sequence
> + * @cfg_ramp_post_en: Ramp Controller post-enable sequence
> + * @cfg_ramp_dis:     Ramp Controller disable sequence
> + * @cmd_reg:          Command register offset
> + * @num_dfs_sids:     Number of DFS SIDs (max 8)
> + * @num_link_sids:    Number of Link SIDs (max 3)
> + * @num_lmh_sids:     Number of LMh SIDs (max 8)
> + */
> +struct qcom_ramp_controller_desc {
> +       struct reg_sequence *cfg_dfs_sid;
> +       struct reg_sequence *cfg_link_sid;
> +       struct reg_sequence *cfg_lmh_sid;
> +       struct reg_sequence *cfg_ramp_pre_en;
> +       struct reg_sequence *cfg_ramp_en;
> +       struct reg_sequence *cfg_ramp_post_en;
> +       struct reg_sequence *cfg_ramp_dis;
> +       u8 cmd_reg;
> +       u8 num_dfs_sids;
> +       u8 num_link_sids;
> +       u8 num_lmh_sids;
> +};
> +
> +/**
> + * struct qcom_ramp_controller - Main driver structure
> + * @regmap: Regmap handle
> + * @desc:   SoC specific parameters
> + */
> +struct qcom_ramp_controller {
> +       struct regmap *regmap;
> +       const struct qcom_ramp_controller_desc *desc;
> +};
> +
> +/**
> + * rc_wait_for_update() - Wait for Ramp Controller root update
> + * @qrc: Main driver structure
> + *
> + * Return: Zero for success or negative number for failure
> + */
> +static int rc_wait_for_update(struct qcom_ramp_controller *qrc)
> +{
> +       const struct qcom_ramp_controller_desc *d = qrc->desc;
> +       struct regmap *r = qrc->regmap;
> +       u32 val;
> +       int ret;
> +
> +       ret = regmap_set_bits(r, d->cmd_reg, RC_ROOT_EN);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_read_poll_timeout(r, d->cmd_reg, val, !(val & RC_UPDATE_EN),
> +                                       1, RC_UPDATE_TIMEOUT_US);
> +}
> +
> +/**
> + * rc_set_cfg_update() - Ramp Controller configuration update
> + * @qrc: Main driver structure
> + * @ce: Configuration entry to update
> + *
> + * Return: Zero for success or negative number for failure
> + */
> +static int rc_set_cfg_update(struct qcom_ramp_controller *qrc, u8 ce)
> +{
> +       const struct qcom_ramp_controller_desc *d = qrc->desc;
> +       struct regmap *r = qrc->regmap;
> +       u32 ack, val;
> +       int ret;
> +
> +       /* The ack bit is between bits 16-31 of RC_REG_CFG_UPDATE */
> +       ack = FIELD_PREP(RC_CFG_ACK, BIT(ce));
> +
> +       /* Write the configuration type first... */
> +       ret = regmap_set_bits(r, d->cmd_reg + RC_REG_CFG_UPDATE, ce);
> +       if (ret)
> +               return ret;
> +
> +       /* ...and after that, enable the update bit to sync the changes */
> +       ret = regmap_set_bits(r, d->cmd_reg + RC_REG_CFG_UPDATE, RC_CFG_UPDATE_EN);
> +       if (ret)
> +               return ret;
> +
> +       /* Wait for the changes to go through */
> +       ret = regmap_read_poll_timeout(r, d->cmd_reg + RC_REG_CFG_UPDATE, val,
> +                                      val & ack, 1, RC_UPDATE_TIMEOUT_US);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Configuration update success! The CFG_UPDATE register will not be
> +        * cleared automatically upon applying the configuration, so we have
> +        * to do that manually in order to leave the ramp controller in a
> +        * predictable and clean state.
> +        */
> +       ret = regmap_write(r, d->cmd_reg + RC_REG_CFG_UPDATE, 0);
> +       if (ret)
> +               return ret;
> +
> +       /* Wait for the update bit cleared ack */
> +       return regmap_read_poll_timeout(r, d->cmd_reg + RC_REG_CFG_UPDATE,
> +                                       val, !(val & RC_CFG_ACK), 1,
> +                                       RC_UPDATE_TIMEOUT_US);
> +}
> +
> +/**
> + * rc_write_cfg - Send configuration sequence
> + * @qrc: Main driver structure
> + * @seq: Register sequence to send before asking for update
> + * @ce: Configuration SID
> + * @nsids: Total number of SIDs
> + *
> + * Returns: Zero for success or negative number for error
> + */
> +static int rc_write_cfg(struct qcom_ramp_controller *qrc, struct reg_sequence *seq,
> +                       u16 ce, u8 nsids)
> +{
> +       int ret;
> +       u8 i;
> +
> +       /* Check if, and wait until the ramp controller is ready */
> +       ret = rc_wait_for_update(qrc);
> +       if (ret)
> +               return ret;
> +
> +       /* Write the sequence */
> +       ret = regmap_multi_reg_write(qrc->regmap, seq, nsids);
> +       if (ret)
> +               return ret;
> +
> +       /* Pull the trigger: do config update starting from the last sid */
> +       for (i = 0; i < nsids; i++) {
> +               ret = rc_set_cfg_update(qrc, (u8)ce - i);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * rc_ramp_ctrl_enable() - Enable Ramp up/down Control
> + * @qrc: Main driver structure
> + *
> + * Return: Zero for success or negative number for error
> + */
> +static int rc_ramp_ctrl_enable(struct qcom_ramp_controller *qrc)
> +{
> +       const struct qcom_ramp_controller_desc *d = qrc->desc;
> +       int ret;
> +
> +       ret = rc_write_cfg(qrc, d->cfg_ramp_pre_en, RC_DCVS_CFG_SID, 1);
> +       if (ret)
> +               return ret;
> +
> +       ret = rc_write_cfg(qrc, d->cfg_ramp_en, RC_DCVS_CFG_SID, 1);
> +       if (ret)
> +               return ret;
> +
> +       return rc_write_cfg(qrc, d->cfg_ramp_post_en, RC_DCVS_CFG_SID, 1);
> +}
> +
> +/**
> + * qcom_ramp_controller_start() - Initialize and start the ramp controller
> + * @qrc: Main driver structure
> + *
> + * The Ramp Controller needs to be initialized by programming the relevant
> + * registers with SoC-specific configuration: once programming is done,
> + * the hardware will take care of the rest (no further handling required).
> + *
> + * Return: Zero for success or negative number for error
> + */
> +static int qcom_ramp_controller_start(struct qcom_ramp_controller *qrc)
> +{
> +       const struct qcom_ramp_controller_desc *d = qrc->desc;
> +       int ret;
> +
> +       /* Program LMH, DFS, Link SIDs */
> +       ret = rc_write_cfg(qrc, d->cfg_lmh_sid, RC_LMH_SID, d->num_lmh_sids);
> +       if (ret)
> +               return ret;
> +
> +       ret = rc_write_cfg(qrc, d->cfg_dfs_sid, RC_DFS_SID, d->num_dfs_sids);
> +       if (ret)
> +               return ret;
> +
> +       ret = rc_write_cfg(qrc, d->cfg_link_sid, RC_LINK_SID, d->num_link_sids);
> +       if (ret)
> +               return ret;
> +
> +       /* Everything is ready! Enable the ramp up/down control */
> +       return rc_ramp_ctrl_enable(qrc);
> +}
> +
> +static const struct regmap_config qrc_regmap_config = {
> +       .reg_bits = 32,
> +       .reg_stride = 4,
> +       .val_bits = 32,
> +       .max_register = 0x68,
> +       .fast_io = true,
> +};
> +
> +static const struct qcom_ramp_controller_desc msm8976_rc_cfg = {
> +       .cfg_dfs_sid = (struct reg_sequence[]) {
> +               { 0x10, 0xfefebff7 },
> +               { 0x14, 0xfdff7fef },
> +               { 0x18, 0xfbffdefb },
> +               { 0x1c, 0xb69b5555 },
> +               { 0x20, 0x24929249 },
> +               { 0x24, 0x49241112 },
> +               { 0x28, 0x11112111 },
> +               { 0x2c, 0x8102 },

Does the vendor kernel contain register names for these items? If so,
it might be good to include them here.

> +       },
> +       .cfg_link_sid = (struct reg_sequence[]) {
> +               { 0x40, 0xfc987 },
> +       },
> +       .cfg_lmh_sid = (struct reg_sequence[]) {
> +               { 0x30, 0x77706db },
> +               { 0x34, 0x5550249 },
> +               { 0x38, 0x111 },
> +       },
> +       .cfg_ramp_pre_en = (struct reg_sequence[]) {
> +               { 0x50, 0x800 },
> +       },
> +       .cfg_ramp_en = (struct reg_sequence[]) {
> +               { 0x50, 0xc00 },
> +       },
> +       .cfg_ramp_post_en = (struct reg_sequence[]) {
> +               { 0x50, 0x400 },
> +       },
> +       .cfg_ramp_dis = (struct reg_sequence[]) {
> +               { 0x50, 0x0 },
> +       },
> +       .cmd_reg = 0x0,
> +
> +       .num_dfs_sids = 8,
> +       .num_lmh_sids = 3,
> +       .num_link_sids = 1,

I see. It might be better to have this as ARRAY_SIZE of the corresponding item.

> +};
> +
> +static int qcom_ramp_controller_probe(struct platform_device *pdev)
> +{
> +       struct qcom_ramp_controller *qrc;
> +       void __iomem *base;
> +
> +       base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       qrc = devm_kmalloc(&pdev->dev, sizeof(*qrc), GFP_KERNEL);
> +       if (!qrc)
> +               return -ENOMEM;
> +
> +       qrc->desc = device_get_match_data(&pdev->dev);
> +       if (!qrc)
> +               return -EINVAL;
> +
> +       qrc->regmap = devm_regmap_init_mmio(&pdev->dev, base, &qrc_regmap_config);
> +       if (IS_ERR(qrc->regmap))
> +               return PTR_ERR(qrc->regmap);
> +
> +       platform_set_drvdata(pdev, qrc);
> +
> +       return qcom_ramp_controller_start(qrc);
> +}
> +
> +static int qcom_ramp_controller_remove(struct platform_device *pdev)
> +{
> +       struct qcom_ramp_controller *qrc = platform_get_drvdata(pdev);
> +
> +       return rc_write_cfg(qrc, qrc->desc->cfg_ramp_dis, RC_DCVS_CFG_SID, 1);
> +}
> +
> +static const struct of_device_id qcom_ramp_controller_match_table[] = {
> +       { .compatible = "qcom,msm8976-ramp-controller", .data = &msm8976_rc_cfg },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_ramp_controller_match_table);
> +
> +static struct platform_driver qcom_ramp_controller_driver = {
> +       .driver = {
> +               .name = "qcom-ramp-controller",
> +               .of_match_table = qcom_ramp_controller_match_table,
> +               .suppress_bind_attrs = true,
> +       },
> +       .probe  = qcom_ramp_controller_probe,
> +       .remove = qcom_ramp_controller_remove,
> +};
> +
> +static int __init qcom_ramp_controller_init(void)
> +{
> +       return platform_driver_register(&qcom_ramp_controller_driver);
> +}
> +arch_initcall(qcom_ramp_controller_init);
> +
> +MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
> +MODULE_DESCRIPTION("Qualcomm Ramp Controller driver");
> +MODULE_LICENSE("GPL");
> --
> 2.37.2
>


-- 
With best wishes
Dmitry
