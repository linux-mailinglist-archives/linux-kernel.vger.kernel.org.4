Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C96B2F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjCIUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCIUwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:52:32 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037DDF753
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 12:51:54 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536b7ffdd34so58288957b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 12:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678395099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVyH5Scagmn8M2FdEHJJzRQ2otfZzX/LecF/bU29usc=;
        b=ewFOH5yb72RmNHDiCx2HOTeujA5fnIty0yxunY0lGAcd5g7kjRh4En8fmjKnQJNym0
         d7XYzGg57wrG7c71v5pe1yCYRuyBjZYBzfU0N1rgVETVgzgkDgSuj940AjslAexq/OxV
         D+/pVLl83zJw6ZZVh97KLNX3ZcAlf6X23uQ6yIhbyveXNg7TzBfrmfrVlxwy/yt5xPqB
         Fx22rHLXWeQJRYnnTC0cmuhXSxpf4Ax+4wEralzv5ROXr4qO8X/QseDHTUJh0pyxAXMa
         7OoBzsW3GE+AlpADzjE+4a+O8VkrcAbcADtbqe2xQBO0vJxWjA/U5TpbD64WQSvuSpIa
         pzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678395099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVyH5Scagmn8M2FdEHJJzRQ2otfZzX/LecF/bU29usc=;
        b=APu39Q81yp9bzmjYg/QAssCU4PhrEqB+o+zsZXYAemK7iGTKm7gSs6d8r2BHwFPQ8I
         q2E2ZuVLxg/0TJK0dpV/LCjjR1YdqIBnhVIePuU70bF0oUptbpstHVSRw2+me4XBbx7A
         ZMd/2GCBTn7hA3HEZ37hNNaY4LT4AaIFMT+053xiLegtXjjQQIdcF31hWl3TQvfGEzTA
         T9ed+OzUhJmnZ+qLJbkc7nU78lzCdQ8tPUCFKCIH83D1yrTDyK72kiJjEeC8SRZ91RPt
         4No7B2YPzROmu3ELQ1lhg+Fx+RR3kCcT/5+bZUJThkJjfGTWBf823G95ckZ9RlX3gr/b
         tppw==
X-Gm-Message-State: AO0yUKWP/NlDgtLqa3VLDAR9ZkdG1P5aIqr1t4790uPIH4n8HkD9xM8u
        2BEW+1yuEFp3pkBBk+qG/xrn99dp95KcdvBrSGi3tQ==
X-Google-Smtp-Source: AK7set+IGWJTWMpcZhF0FcDlsEsg14MwUcebqHQCLXHDdzScK2lva1JI9YbEyAFi319Z87T+SK2+6OFgE1BOX9ELMLA=
X-Received: by 2002:a81:b285:0:b0:533:99bb:c296 with SMTP id
 q127-20020a81b285000000b0053399bbc296mr14235206ywh.5.1678395099441; Thu, 09
 Mar 2023 12:51:39 -0800 (PST)
MIME-Version: 1.0
References: <20230309185049.170878-1-danila@jiaxyga.com> <20230309185049.170878-3-danila@jiaxyga.com>
In-Reply-To: <20230309185049.170878-3-danila@jiaxyga.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Mar 2023 22:51:28 +0200
Message-ID: <CAA8EJpq14e0+-d4m8bZTsQGiOifPr6HU7WNRL+FKGVMDx6YDQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: qcom-qmp-ufs: Add SM7150 support
To:     Danila Tikhonov <danila@jiaxyga.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davidwronek@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 20:51, Danila Tikhonov <danila@jiaxyga.com> wrote:
>
> From: David Wronek <davidwronek@gmail.com>
>
> Add the tables and constants for init sequences for UFS QMP phy found in
> SM7150 SoC.
>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 57 +++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 994ddd5d4a81..b4f2d6c63beb 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -349,6 +349,36 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs[] = {
>         QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>  };
>
> +static const struct qmp_phy_init_tbl sm7150_ufsphy_rx[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1b),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5b),

It is a pity to duplicate the whole table just for the single register
difference.

> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
> +};
> +
> +static const struct qmp_phy_init_tbl sm7150_ufsphy_pcs[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2, 0x6f),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SYM_RESYNC_CTRL, 0x03),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL1, 0x0f),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xFF),

s/0xFF/0xff/ , please

> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> +};)
> +
>  static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
>         QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
> @@ -911,6 +941,30 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>         .no_pcs_sw_reset        = true,
>  };
>
> +static const struct qmp_phy_cfg sm7150_ufsphy_cfg = {

Please add offsets here. With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +       .lanes                  = 1,
> +
> +       .tbls = {
> +               .serdes         = sdm845_ufsphy_serdes,
> +               .serdes_num     = ARRAY_SIZE(sdm845_ufsphy_serdes),
> +               .tx             = sdm845_ufsphy_tx,
> +               .tx_num         = ARRAY_SIZE(sdm845_ufsphy_tx),
> +               .rx             = sm7150_ufsphy_rx,
> +               .rx_num         = ARRAY_SIZE(sm7150_ufsphy_rx),
> +               .pcs            = sm7150_ufsphy_pcs,
> +               .pcs_num        = ARRAY_SIZE(sm7150_ufsphy_pcs),
> +       },
> +       .tbls_hs_b = {
> +               .serdes         = sdm845_ufsphy_hs_b_serdes,
> +               .serdes_num     = ARRAY_SIZE(sdm845_ufsphy_hs_b_serdes),
> +       },
> +       .clk_list               = sdm845_ufs_phy_clk_l,
> +       .num_clks               = ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> +       .regs                   = ufsphy_v3_regs_layout,

sdm845 has .no_pcs_sw_reset set to true. Do we need to set it for this PHY?

> +};
> +
>  static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>         .lanes                  = 2,
>
> @@ -1560,6 +1614,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
>         }, {
>                 .compatible = "qcom,sm6350-qmp-ufs-phy",
>                 .data = &sdm845_ufsphy_cfg,
> +       }, {
> +               .compatible = "qcom,sm7150-qmp-ufs-phy",
> +               .data = &sm7150_ufsphy_cfg,
>         }, {
>                 .compatible = "qcom,sm8150-qmp-ufs-phy",
>                 .data = &sm8150_ufsphy_cfg,
> --
> 2.39.2
>


-- 
With best wishes
Dmitry
