Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27A46C42C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCVGPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCVGPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:15:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E22CC7D;
        Tue, 21 Mar 2023 23:15:10 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M5bIHG025015;
        Wed, 22 Mar 2023 06:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=x/KyG+AlAKViqwbgemS0gkIfLnWmcVSWFz+IXfbcjyk=;
 b=PjUWTS1SbK0OK2QN8QWBBw9pmzq0q/lEOlghhYs7ljFI11G1o3UyyoREYZb6TgjhofGR
 iqH0Uws4KQeGqfKLEE1Y36qAdN7MPvNDtKcXdWTFRqYs0ja/4bLbYV1QpRpxogeel/9W
 2jbbxDFtC9MU6qHmkZ1ra68KZ0cjbr3xWKye4YSsJUjodKsjsyXu8ajfbWEK3lSRkt5O
 JVNO6MeTsatPdQIFDbP6CYw0YjwofmMZTnmRcjfgfx7obhNin+Ntvok0/BtmkMVqZk2C
 o5hF+QTE4QiPaRALoXfaFCkSCee+UqHNrCmoMEgIywkF0lM5Oy8Mk83F1+5YByNHcV/+ 9g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfdm4j4y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 06:15:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32M6F0CC026705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 06:15:00 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 23:14:54 -0700
Date:   Wed, 22 Mar 2023 11:44:50 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v2 6/8] phy: qcom: qmp: Update IPQ9574 USB Phy
 initialization Sequence
Message-ID: <20230322061449.GB12808@varda-linux.qualcomm.com>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <cover.1679388632.git.quic_varada@quicinc.com>
 <aaa7a5d3b067e09367d691431fd777a794e4a974.1679388632.git.quic_varada@quicinc.com>
 <219769bf-fd1b-f83d-2cb2-1ce90983d8e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <219769bf-fd1b-f83d-2cb2-1ce90983d8e5@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aR6w93dqZNk8AlurKlPc0kT6MrZ5vlEe
X-Proofpoint-GUID: aR6w93dqZNk8AlurKlPc0kT6MrZ5vlEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220044
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 01:07:02PM +0100, Konrad Dybcio wrote:
>
>
> On 21.03.2023 09:54, Varadarajan Narayanan wrote:
> > Updated USB QMP PHY Init sequence based on HPG for IPQ9574.
> > Reused clock and reset list from existing targets.
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >
> > ---
> >  Changes in v2:
> > 	- Removed unused phy register offsets
> > 	- Moved the clock entries to the correct place
> > 	- Maintain sorted order
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 119 ++++++++++++++++++++++++++++++++
> >  1 file changed, 119 insertions(+)
> >
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> > index a49711c..51894b9 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> > @@ -94,6 +94,7 @@ enum qphy_reg_layout {
> >  	QPHY_PCS_STATUS,
> >  	QPHY_PCS_AUTONOMOUS_MODE_CTRL,
> >  	QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
> > +	QPHY_PCS_LFPS_RXTERM_IRQ_STATUS,
> >  	QPHY_PCS_POWER_DOWN_CONTROL,
> >  	/* Keep last to ensure regs_layout arrays are properly initialized */
> >  	QPHY_LAYOUT_SIZE
> > @@ -139,6 +140,97 @@ static const unsigned int qmp_v5_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> >  	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> >  };
> >
> > +static const unsigned int usb3phy_regs_layout[] = {
> > +	[QPHY_SW_RESET]				= 0x00,
> > +	[QPHY_START_CTRL]			= 0x08,
> > +	[QPHY_PCS_STATUS]			= 0x17c,
> > +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]		= 0x0d4,
> > +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR]	= 0x0d8,
> > +	[QPHY_PCS_POWER_DOWN_CONTROL]		= 0x04,
> > +};
> > +
> > +static const struct qmp_phy_init_tbl ipq9574_usb3_serdes_tbl[] = {
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
> > +	/* PLL and Loop filter settings */
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x68),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0xAB),
> Please be consistent with hex captitalization.
>
> Konrad

Will fix this.

Thanks
Varada

> > +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0xAA),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x02),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x09),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0xA0),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xAA),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x29),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> > +	/* SSC settings */
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x7D),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0x0A),
> > +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x05),
> > +};
> > +
> > +static const struct qmp_phy_init_tbl ipq9574_usb3_tx_tbl[] = {
> > +	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
> > +	QMP_PHY_INIT_CFG(QSERDES_TX_RCV_DETECT_LVL_2, 0x12),
> > +	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
> > +};
> > +
> > +static const struct qmp_phy_init_tbl ipq9574_usb3_rx_tbl[] = {
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_GAIN, 0x06),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x6c),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0xb8),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x03),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
> > +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_ENABLES, 0x0c),
> > +};
> > +
> > +static const struct qmp_phy_init_tbl ipq9574_usb3_pcs_tbl[] = {
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0e),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
> > +};
> > +
> >  static const struct qmp_phy_init_tbl ipq8074_usb3_serdes_tbl[] = {
> >  	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
> >  	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> > @@ -1510,6 +1602,10 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
> >  }
> >
> >  /* list of clocks required by phy */
> > +static const char * const ipq9574_phy_clk_l[] = {
> > +	"aux", "cfg_ahb",
> > +};
> > +
> >  static const char * const msm8996_phy_clk_l[] = {
> >  	"aux", "cfg_ahb", "ref",
> >  };
> > @@ -1586,6 +1682,26 @@ static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
> >  	.regs			= qmp_v3_usb3phy_regs_layout,
> >  };
> >
> > +static const struct qmp_phy_cfg ipq9574_usb3phy_cfg = {
> > +	.lanes			= 1,
> > +
> > +	.serdes_tbl		= ipq9574_usb3_serdes_tbl,
> > +	.serdes_tbl_num		= ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
> > +	.tx_tbl			= ipq9574_usb3_tx_tbl,
> > +	.tx_tbl_num		= ARRAY_SIZE(ipq9574_usb3_tx_tbl),
> > +	.rx_tbl			= ipq9574_usb3_rx_tbl,
> > +	.rx_tbl_num		= ARRAY_SIZE(ipq9574_usb3_rx_tbl),
> > +	.pcs_tbl		= ipq9574_usb3_pcs_tbl,
> > +	.pcs_tbl_num		= ARRAY_SIZE(ipq9574_usb3_pcs_tbl),
> > +	.clk_list		= ipq9574_phy_clk_l,
> > +	.num_clks		= ARRAY_SIZE(ipq9574_phy_clk_l),
> > +	.reset_list		= msm8996_usb3phy_reset_l,
> > +	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
> > +	.vreg_list		= qmp_phy_vreg_l,
> > +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> > +	.regs			= usb3phy_regs_layout,
> > +};
> > +
> >  static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
> >  	.lanes			= 1,
> >
> > @@ -2589,6 +2705,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
> >  		.compatible = "qcom,ipq8074-qmp-usb3-phy",
> >  		.data = &ipq8074_usb3phy_cfg,
> >  	}, {
> > +		.compatible = "qcom,ipq9574-qmp-usb3-phy",
> > +		.data = &ipq9574_usb3phy_cfg,
> > +	}, {
> >  		.compatible = "qcom,msm8996-qmp-usb3-phy",
> >  		.data = &msm8996_usb3phy_cfg,
> >  	}, {
