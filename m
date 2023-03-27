Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE26CA0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjC0J5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjC0J5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:57:49 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD249E9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:57:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i7so9803030ybt.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679911067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k27rtmcwmhq6wgggW/3Sn6Xc8kSRrAZhl+xMeyBeZ1E=;
        b=Z8d2Y5dDY5QbTwfzzRpnpKhSqE2jBF3ZiZvhNAX1EzXonhBTIj6acln5VzZyW0HJy6
         +4Qaqe+zeCbEVHUjDQAw1rHKv/mjL3+OqxSFJUYO0xpDrY2gkbOqvq2ZCO14Xo+usOgo
         WT0rj8QYUxLh1xt+8yrzZuM2KTehS5ONwuYTWPp5UTErgkJiP0GXRFK7ciQRTs4Ro3Ly
         QDlWLCCtC3n5NgCBvyOuVqQti3YqNmECSPmc9PqbpDo+VEQbz/qqWzAU25ZkX21+f05j
         nz7vgBJg8nIiRkfCoHTyxkrgg+9HuVqGEFd+6RGiBnZHFJ0FphrVrV1UPp9p0cR0n5gx
         mYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k27rtmcwmhq6wgggW/3Sn6Xc8kSRrAZhl+xMeyBeZ1E=;
        b=fboSvUx7VxeFLDjwCG4/zl6LSVCmPdWcEjSAAQSdp4wRep++FqH7XMXFfXBoWeArj5
         jPGHEkCBkiJ34mVUBruNpK3EF7k/mpa2lieQHX8NStDvnaJnVXAdqEFcW4J+1L+Pa3DB
         yGJT0ZY/VGyM3RUkmg6RHcGeHcdKNUuthAHbPwMg2Uw4gd4gG3OwXJzANeRtfWORTAZP
         6/ZxEkg57Jl4C8hYzT/BHluOpacyMiwS3rVRe0vqIOlZ6mc1NUJ1Rcw7xdi9KsuUKTQb
         /TFJlqgmJXk54gvha/3aMLhYY7ejvM2XJ66GBWixxBlc+lklMHYUST8JOAEdL/ViE2rk
         aLJA==
X-Gm-Message-State: AAQBX9cJRenO8+2G7SIEUqsH1eFV2pF6J7BYDYbiuRlcDBhK1mwPadsg
        APsui8p0GOMqVqEMVbs2z3nUuCVgdkoA11zuNFhSTQ==
X-Google-Smtp-Source: AKy350bqSZkp2vwHLM2HDg2kTXElzv8K9pxIBAEzotZUwoRAEzYSw1UgG97x5U7K4JqAfAqPvGH0dSiNZYU4olbTJKc=
X-Received: by 2002:a05:6902:a8e:b0:b7c:1144:a729 with SMTP id
 cd14-20020a0569020a8e00b00b7c1144a729mr491732ybb.9.1679911066871; Mon, 27 Mar
 2023 02:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679909245.git.quic_varada@quicinc.com> <b4504cbc87e526de92a423dd21c389b30068761b.1679909245.git.quic_varada@quicinc.com>
In-Reply-To: <b4504cbc87e526de92a423dd21c389b30068761b.1679909245.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 12:57:36 +0300
Message-ID: <CAA8EJpo+1mg74-DbkjDs51LdCRR4Y9KjtUBvA=neNdyZZ34zFw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] phy: qcom: qmp: Update IPQ9574 USB Phy
 initialization Sequence
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 12:32, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Updated USB QMP PHY Init sequence based on HPG for IPQ9574.
> Reused clock and reset list from existing targets.
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v4:
>         - Use qmp_usb_offsets for register space access
>  Changes in v3:
>         - Fix hex captitalization
>  Changes in v2:
>         - Removed unused phy register offsets
>         - Moved the clock entries to the correct place
>         - Maintain sorted order
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 129 ++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index a49711c..ed5f794 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -94,6 +94,7 @@ enum qphy_reg_layout {
>         QPHY_PCS_STATUS,
>         QPHY_PCS_AUTONOMOUS_MODE_CTRL,
>         QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
> +       QPHY_PCS_LFPS_RXTERM_IRQ_STATUS,

This is unused

>         QPHY_PCS_POWER_DOWN_CONTROL,
>         /* Keep last to ensure regs_layout arrays are properly initialized */
>         QPHY_LAYOUT_SIZE
> @@ -139,6 +140,97 @@ static const unsigned int qmp_v5_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
>         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
>  };
>
> +static const unsigned int usb3phy_regs_layout[] = {
> +       [QPHY_SW_RESET]                         = 0x00,
> +       [QPHY_START_CTRL]                       = 0x08,
> +       [QPHY_PCS_STATUS]                       = 0x17c,
> +       [QPHY_PCS_AUTONOMOUS_MODE_CTRL]         = 0x0d4,
> +       [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR]        = 0x0d8,
> +       [QPHY_PCS_POWER_DOWN_CONTROL]           = 0x04,
> +};

This does not look correct. you are yousing QPHY_V3_PCS for the table,
while your register layout corresponds to QPHY_V2_PCS registers.
Please doublecheck this. Also, is there any reason to duplicate
existing qmp_v2_usb3phy_regs_layout or qmp_v3_usb3phy_regs_layout?

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
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0xab),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0xaa),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x09),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0xa0),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xaa),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x29),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> +       /* SSC settings */
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x7d),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0x0a),
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
> @@ -1510,6 +1602,10 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>  }
>
>  /* list of clocks required by phy */
> +static const char * const ipq9574_phy_clk_l[] = {
> +       "aux", "cfg_ahb",

No ref clock?

> +};
> +
>  static const char * const msm8996_phy_clk_l[] = {
>         "aux", "cfg_ahb", "ref",
>  };
> @@ -1558,6 +1654,14 @@ static const char * const qmp_phy_vreg_l[] = {
>         "vdda-phy", "vdda-pll",
>  };
>
> +static const struct qmp_usb_offsets qmp_usb_offsets_ipq9574 = {
> +       .serdes         = 0,
> +       .pcs            = 0x800,
> +       .pcs_usb        = 0x600,

Are you confusing pcs_usb vs pcs_misc? There was no separate pcs_usb on v3 PHYs

> +       .tx             = 0x200,
> +       .rx             = 0x400,
> +};
> +
>  static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
>         .serdes         = 0,
>         .pcs            = 0x0200,
> @@ -1586,6 +1690,28 @@ static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>         .regs                   = qmp_v3_usb3phy_regs_layout,
>  };
>
> +static const struct qmp_phy_cfg ipq9574_usb3phy_cfg = {
> +       .lanes                  = 1,
> +
> +       .offsets                = &qmp_usb_offsets_ipq9574,
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
> +
>  static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
>         .lanes                  = 1,
>
> @@ -2589,6 +2715,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>                 .compatible = "qcom,ipq8074-qmp-usb3-phy",
>                 .data = &ipq8074_usb3phy_cfg,
>         }, {
> +               .compatible = "qcom,ipq9574-qmp-usb3-phy",
> +               .data = &ipq9574_usb3phy_cfg,
> +       }, {
>                 .compatible = "qcom,msm8996-qmp-usb3-phy",
>                 .data = &msm8996_usb3phy_cfg,
>         }, {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
