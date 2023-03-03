Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFBD6A9441
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCCJhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCCJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:37:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277794D62F;
        Fri,  3 Mar 2023 01:37:17 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323558ev031104;
        Fri, 3 Mar 2023 09:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lheN9skkunuL5x9zbUp2Cg+HoAU+Wq/RNkcIWKh77RQ=;
 b=hO5MqkGSMLsHaGelrNRJ3dIqwZihLQmVdZzVOwtJxE/EDnZ6NIJkQbQ7SEJzToDGzqv5
 AdPwl2yk3TG4rJfQhRV4OWJl4GFnyWjRAzdh0QMQT3MxwwEYopyBy8xUNGfMx458G3rv
 ztJuKN0wLxag9Cf5YJKVUZYlpn0r1MepRvN6u92YHdVpsTgonW6kKbP19kvFYDriFDW9
 9C5/T4Pruhe5ZIgVEdrgdw4lb29VpJnX8owElR9dykLABafX3Y3VZFBMcZmD59Hm6WxM
 lzQbRC13WQ0J5B9B12kJNO0oRMtKEtb1xHlZwO/DJDFTUkIehGlexgSAQ3G9fvnkrNFc 9g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2rbgbggu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:36:46 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3239ajSc011367
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 09:36:45 GMT
Received: from [10.50.35.127] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 01:36:42 -0800
Message-ID: <862dc7eb-d599-ec1c-4c53-37898b1db906@quicinc.com>
Date:   Fri, 3 Mar 2023 15:06:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/8] phy: qcom: qmp: Update IPQ9574 USB Phy initialization
 Sequence
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Praveenkumar I <ipkumar@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <b0f93b77e059791f6fe51a6c42535644cec90d70.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJpqn2gVcUiELAgGofZ9DS-L1BYU-WBir8NovQCUQ-7wWLQ@mail.gmail.com>
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <CAA8EJpqn2gVcUiELAgGofZ9DS-L1BYU-WBir8NovQCUQ-7wWLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gr0GDPkBW9e2sH2MxQo3TXWuZuOg5NhL
X-Proofpoint-ORIG-GUID: Gr0GDPkBW9e2sH2MxQo3TXWuZuOg5NhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030084
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/2023 9:46 PM, Dmitry Baryshkov wrote:
> On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
>> Updated USB QMP PHY Init sequence based on HPG for IPQ9574.
>> Reused clock and reset list from existing targets.
>>
>> Signed-off-by: Praveenkumar I <ipkumar@codeaurora.org>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 130 ++++++++++++++++++++++++++++++++
>>   1 file changed, 130 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> index a49711c..a44c15b 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> @@ -91,9 +91,15 @@ enum qphy_reg_layout {
>>          /* PCS registers */
>>          QPHY_SW_RESET,
>>          QPHY_START_CTRL,
>> +       QPHY_FLL_CNTRL1,
>> +       QPHY_FLL_CNTRL2,
>> +       QPHY_FLL_CNT_VAL_L,
>> +       QPHY_FLL_CNT_VAL_H_TOL,
>> +       QPHY_FLL_MAN_CODE,
> You don't seem to be using indirect register addressing for these
> registers, so these bits are unused and can be dropped.
>
>>          QPHY_PCS_STATUS,
>>          QPHY_PCS_AUTONOMOUS_MODE_CTRL,
>>          QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
>> +       QPHY_PCS_LFPS_RXTERM_IRQ_STATUS,
>>          QPHY_PCS_POWER_DOWN_CONTROL,
>>          /* Keep last to ensure regs_layout arrays are properly initialized */
>>          QPHY_LAYOUT_SIZE
>> @@ -139,6 +145,103 @@ static const unsigned int qmp_v5_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
>>          [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
>>   };
>>
>> +static const unsigned int usb3phy_regs_layout[] = {
>> +       [QPHY_FLL_CNTRL1]                       = 0xc0,
>> +       [QPHY_FLL_CNTRL2]                       = 0xc4,
>> +       [QPHY_FLL_CNT_VAL_L]                    = 0xc8,
>> +       [QPHY_FLL_CNT_VAL_H_TOL]                = 0xcc,
>> +       [QPHY_FLL_MAN_CODE]                     = 0xd0,
>> +       [QPHY_SW_RESET]                         = 0x00,
>> +       [QPHY_START_CTRL]                       = 0x08,
>> +       [QPHY_PCS_STATUS]                       = 0x17c,
>> +       [QPHY_PCS_AUTONOMOUS_MODE_CTRL]         = 0x0d4,
>> +       [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR]        = 0x0d8,
>> +       [QPHY_PCS_LFPS_RXTERM_IRQ_STATUS]       = 0x178,
>> +       [QPHY_PCS_POWER_DOWN_CONTROL]           = 0x04,
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_usb3_serdes_tbl[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
>> +       /* PLL and Loop filter settings */
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x68),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0xAB),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0xAA),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x02),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x09),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0xA0),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xAA),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x29),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
>> +       /* SSC settings */
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x7D),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0x0A),
>> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x05),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_usb3_tx_tbl[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
>> +       QMP_PHY_INIT_CFG(QSERDES_TX_RCV_DETECT_LVL_2, 0x12),
>> +       QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_usb3_rx_tbl[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_GAIN, 0x06),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x6c),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0xb8),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x03),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
>> +       QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_ENABLES, 0x0c),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_usb3_pcs_tbl[] = {
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0e),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
>> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
>> +};
>> +
>>   static const struct qmp_phy_init_tbl ipq8074_usb3_serdes_tbl[] = {
>>          QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
>>          QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
>> @@ -1558,6 +1661,10 @@ static const char * const qmp_phy_vreg_l[] = {
>>          "vdda-phy", "vdda-pll",
>>   };
>>
>> +static const char * const ipq9574_phy_clk_l[] = {
> Please move clocks to the clocks section.
>
>> +       "aux", "cfg_ahb",
>> +};
>> +
>>   static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
>>          .serdes         = 0,
>>          .pcs            = 0x0200,
>> @@ -1939,6 +2046,26 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>>          .regs                   = qmp_v3_usb3phy_regs_layout,
>>   };
>>
>> +static const struct qmp_phy_cfg ipq9574_usb3phy_cfg = {
> Please keep the data sorted.
>
>> +       .lanes                  = 1,
>> +
>> +       .serdes_tbl             = ipq9574_usb3_serdes_tbl,
>> +       .serdes_tbl_num         = ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
>> +       .tx_tbl                 = ipq9574_usb3_tx_tbl,
>> +       .tx_tbl_num             = ARRAY_SIZE(ipq9574_usb3_tx_tbl),
>> +       .rx_tbl                 = ipq9574_usb3_rx_tbl,
>> +       .rx_tbl_num             = ARRAY_SIZE(ipq9574_usb3_rx_tbl),
>> +       .pcs_tbl                = ipq9574_usb3_pcs_tbl,
>> +       .pcs_tbl_num            = ARRAY_SIZE(ipq9574_usb3_pcs_tbl),
>> +       .clk_list               = ipq9574_phy_clk_l,
>> +       .num_clks               = ARRAY_SIZE(ipq9574_phy_clk_l),
>> +       .reset_list             = msm8996_usb3phy_reset_l,
>> +       .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
>> +       .vreg_list              = qmp_phy_vreg_l,
>> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>> +       .regs                   = usb3phy_regs_layout,
>> +};
> You will get an undefined symbol error here.
>
>> +
>>   static void qmp_usb_configure_lane(void __iomem *base,
>>                                          const struct qmp_phy_init_tbl tbl[],
>>                                          int num,
>> @@ -2607,6 +2734,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>>                  .compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
>>                  .data = &sc8280xp_usb3_uniphy_cfg,
>>          }, {
>> +               .compatible = "qcom,ipq9574-qmp-usb3-phy",
>> +               .data = &ipq9574_usb3phy_cfg,
>> +       }, {
> Please choose a less random place for your driver data. The match
> table is sorted, please keep it this way.
>
>>                  .compatible = "qcom,sdm845-qmp-usb3-phy",
>>                  .data = &qmp_v3_usb3phy_cfg,
>>          }, {
>> --
>> 2.7.4

Thanks for the feedback. Will make the corrections and post a revised patch.

Thanks

Varada

