Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E576A85FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCBQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCBQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:16:41 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA9155049
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:16:37 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i6so4069777ybu.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6bTl116Kr1XU6F/NPToEFfhk6YODIOIDxPIctTgjztw=;
        b=aqneeDam4oaMg/I69ISFEDq36Kcr0ynFogW33oVzz4qRxVQlx7hMZRBqDckfi2j1P7
         VI7+1r+P3n1tia6NALtbh3fn4DbzRHc8jPv3UjB1T6NZK0xCZXn4w+2SM0vOUSmvf0/m
         R3bS75JfuJTr5JWPPavms9fdRS/vC5jddPqA9waL27zc2Xvw12EMcGFKqk1CvV+j6JrJ
         wQk+xrr3tpx++ElVzwsAFYl84D4Z2J5ajJUyH2Ai6rs9JtxdPCIKuTrNcyg/m0iiXgzW
         EIYwQBcjKqhlC079wZSAFemnbwKneuq1tuwl6sKNqFubsY7DkWpz4JJzSZrKx2QnEM5E
         c/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bTl116Kr1XU6F/NPToEFfhk6YODIOIDxPIctTgjztw=;
        b=vI7ueZK74glJHgeWsCHTJf6HjZwJVtG8RhaG/QhDsXzNba7FbA2oQ/tLZjmpQ1OxdS
         FRmUH5/oM0I6FlLJXhHwZXPPrskOrHs6/5PsOukJI844ipNFg47MxNBbxeMA8jo11w+4
         4YZds0tdNI3Gzc4xLgLoMp/UtP6+fqPre7sLWZ2QnlPMDbDrq4l4I1W2pjRqFF1UY3zA
         wHGBvBXuZERUyKblKWQO8uFDOuVJn2ght2VmuCfn49D8WBynVHm2hvM9LYgaQnDcjpHN
         dlL/rXMoj8kQFZWWg6sVTSSwsEhrPJKzgL4zKghs72HI0GfTNwnKnikqiWj+yzUfUTpN
         Yzzw==
X-Gm-Message-State: AO0yUKXQDXpVd4/F8+ybRpZX0n2oqxHKrPkCSFrcnK73fGEljbZyt/ow
        19gIoYWGpm1qFiHZXMzRW/HLw9tThSBmTIxETK2A12Iv/5v2Ag==
X-Google-Smtp-Source: AK7set/vmR+e+9jyiR1auQAC0vDaQhK6yUPCuQUCwZ9Hwji+EyQge/IQD95mrwgA78UuzE2CSIZPtDUADuzTHnPlIw4=
X-Received: by 2002:a05:6902:10d:b0:a4a:a708:2411 with SMTP id
 o13-20020a056902010d00b00a4aa7082411mr5709951ybh.10.1677773796324; Thu, 02
 Mar 2023 08:16:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677749625.git.quic_varada@quicinc.com> <b0f93b77e059791f6fe51a6c42535644cec90d70.1677749625.git.quic_varada@quicinc.com>
In-Reply-To: <b0f93b77e059791f6fe51a6c42535644cec90d70.1677749625.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Mar 2023 18:16:25 +0200
Message-ID: <CAA8EJpqn2gVcUiELAgGofZ9DS-L1BYU-WBir8NovQCUQ-7wWLQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] phy: qcom: qmp: Update IPQ9574 USB Phy initialization Sequence
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Praveenkumar I <ipkumar@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Updated USB QMP PHY Init sequence based on HPG for IPQ9574.
> Reused clock and reset list from existing targets.
>
> Signed-off-by: Praveenkumar I <ipkumar@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 130 ++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index a49711c..a44c15b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -91,9 +91,15 @@ enum qphy_reg_layout {
>         /* PCS registers */
>         QPHY_SW_RESET,
>         QPHY_START_CTRL,
> +       QPHY_FLL_CNTRL1,
> +       QPHY_FLL_CNTRL2,
> +       QPHY_FLL_CNT_VAL_L,
> +       QPHY_FLL_CNT_VAL_H_TOL,
> +       QPHY_FLL_MAN_CODE,

You don't seem to be using indirect register addressing for these
registers, so these bits are unused and can be dropped.

>         QPHY_PCS_STATUS,
>         QPHY_PCS_AUTONOMOUS_MODE_CTRL,
>         QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
> +       QPHY_PCS_LFPS_RXTERM_IRQ_STATUS,
>         QPHY_PCS_POWER_DOWN_CONTROL,
>         /* Keep last to ensure regs_layout arrays are properly initialized */
>         QPHY_LAYOUT_SIZE
> @@ -139,6 +145,103 @@ static const unsigned int qmp_v5_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
>         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
>  };
>
> +static const unsigned int usb3phy_regs_layout[] = {
> +       [QPHY_FLL_CNTRL1]                       = 0xc0,
> +       [QPHY_FLL_CNTRL2]                       = 0xc4,
> +       [QPHY_FLL_CNT_VAL_L]                    = 0xc8,
> +       [QPHY_FLL_CNT_VAL_H_TOL]                = 0xcc,
> +       [QPHY_FLL_MAN_CODE]                     = 0xd0,
> +       [QPHY_SW_RESET]                         = 0x00,
> +       [QPHY_START_CTRL]                       = 0x08,
> +       [QPHY_PCS_STATUS]                       = 0x17c,
> +       [QPHY_PCS_AUTONOMOUS_MODE_CTRL]         = 0x0d4,
> +       [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR]        = 0x0d8,
> +       [QPHY_PCS_LFPS_RXTERM_IRQ_STATUS]       = 0x178,
> +       [QPHY_PCS_POWER_DOWN_CONTROL]           = 0x04,
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_usb3_serdes_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
> +       /* PLL and Loop filter settings */
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x68),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0xAB),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0xAA),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x09),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0xA0),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xAA),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x29),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> +       /* SSC settings */
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x7D),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0x0A),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x05),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_usb3_tx_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
> +       QMP_PHY_INIT_CFG(QSERDES_TX_RCV_DETECT_LVL_2, 0x12),
> +       QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_usb3_rx_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_GAIN, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x6c),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0xb8),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x03),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_ENABLES, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_usb3_pcs_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0e),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
> +};
> +
>  static const struct qmp_phy_init_tbl ipq8074_usb3_serdes_tbl[] = {
>         QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
>         QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> @@ -1558,6 +1661,10 @@ static const char * const qmp_phy_vreg_l[] = {
>         "vdda-phy", "vdda-pll",
>  };
>
> +static const char * const ipq9574_phy_clk_l[] = {

Please move clocks to the clocks section.

> +       "aux", "cfg_ahb",
> +};
> +
>  static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
>         .serdes         = 0,
>         .pcs            = 0x0200,
> @@ -1939,6 +2046,26 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>         .regs                   = qmp_v3_usb3phy_regs_layout,
>  };
>
> +static const struct qmp_phy_cfg ipq9574_usb3phy_cfg = {

Please keep the data sorted.

> +       .lanes                  = 1,
> +
> +       .serdes_tbl             = ipq9574_usb3_serdes_tbl,
> +       .serdes_tbl_num         = ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
> +       .tx_tbl                 = ipq9574_usb3_tx_tbl,
> +       .tx_tbl_num             = ARRAY_SIZE(ipq9574_usb3_tx_tbl),
> +       .rx_tbl                 = ipq9574_usb3_rx_tbl,
> +       .rx_tbl_num             = ARRAY_SIZE(ipq9574_usb3_rx_tbl),
> +       .pcs_tbl                = ipq9574_usb3_pcs_tbl,
> +       .pcs_tbl_num            = ARRAY_SIZE(ipq9574_usb3_pcs_tbl),
> +       .clk_list               = ipq9574_phy_clk_l,
> +       .num_clks               = ARRAY_SIZE(ipq9574_phy_clk_l),
> +       .reset_list             = msm8996_usb3phy_reset_l,
> +       .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> +       .regs                   = usb3phy_regs_layout,
> +};

You will get an undefined symbol error here.

> +
>  static void qmp_usb_configure_lane(void __iomem *base,
>                                         const struct qmp_phy_init_tbl tbl[],
>                                         int num,
> @@ -2607,6 +2734,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>                 .compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
>                 .data = &sc8280xp_usb3_uniphy_cfg,
>         }, {
> +               .compatible = "qcom,ipq9574-qmp-usb3-phy",
> +               .data = &ipq9574_usb3phy_cfg,
> +       }, {

Please choose a less random place for your driver data. The match
table is sorted, please keep it this way.

>                 .compatible = "qcom,sdm845-qmp-usb3-phy",
>                 .data = &qmp_v3_usb3phy_cfg,
>         }, {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
