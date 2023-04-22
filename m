Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00C6EB828
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 11:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDVJG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVJGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 05:06:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5189B1BD2;
        Sat, 22 Apr 2023 02:06:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33M93TGR013863;
        Sat, 22 Apr 2023 09:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+2/ST1Lxv+CtUD9ffYdh3fus57UXdLn9I+Hs7hAVToE=;
 b=AjImX3oh3pvbTmsHwzgcG8LB+OyUFYNIHgcQoQbYZ/4gcYkwpgfplZ4aMuxPvQDlXzEg
 bM73EtfWKrKj9B3v9mijySQ23+b0NMSpojGiFG1Oj6wS5XYNA3jQq1HrnS2qHSa/4kqA
 3KKUireu+scIwCTiSNX4a+3hxp56zc82R6gCy/bOXhp0Boupj42C9hO7+oy2hfa9r3hq
 jq5mdw3jUIf8RhSOJO9PmRdjnmZc8v6VpQjYQi1yt6KBPWKA0sQlVYGG8HOF4cmDkKiQ
 bLBp+Osra1372s8OVAhcDag7Lsnt/BobsYADpoJYIwNCVNCfbWib3gXDSLPuzbW0VtKb xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48bxr8sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 09:06:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33M96g2c000769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 09:06:42 GMT
Received: from [10.216.25.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 22 Apr
 2023 02:06:36 -0700
Message-ID: <cca09408-6c09-919f-c49c-ca794575de52@quicinc.com>
Date:   Sat, 22 Apr 2023 14:36:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] phy: qcom-qmp-pcie: Add support for IPQ9574 g3x1 and
 g3x2 PCIEs
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230421124150.21190-1-quic_devipriy@quicinc.com>
 <20230421124150.21190-3-quic_devipriy@quicinc.com>
 <9f234b53-89f6-bfd1-211f-d1f55295c321@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <9f234b53-89f6-bfd1-211f-d1f55295c321@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U5w_li48hwyldMBE86WTFpnoHuaPgjqQ
X-Proofpoint-ORIG-GUID: U5w_li48hwyldMBE86WTFpnoHuaPgjqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304220079
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2023 2:30 AM, Dmitry Baryshkov wrote:
> On 21/04/2023 15:41, Devi Priya wrote:
>> Add support for a single-lane and two-lane PCIe PHYs
>> found on Qualcomm IPQ9574 platform.
>> Also, add the definitions for missing register offsets.
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V1:
>>     - Updated the hex values to lowercase
>>
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 332 ++++++++++++++++++
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  26 +-
>>   .../phy/qualcomm/phy-qcom-qmp-qserdes-pll.h   |   3 +
>>   3 files changed, 355 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index df505279edfd..ff92b121b113 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -515,6 +515,250 @@ static const struct qmp_phy_init_tbl 
>> ipq8074_pcie_gen3_pcs_misc_tbl[] = {
>>       QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
>>   };
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x1_pcie_serdes_tbl[] 
>> = {
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0f),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0f),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xff),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3f),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xaa),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xab),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xd4),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xa0),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x20),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xaa),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xa0),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xb4),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_EN_CENTER, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7d),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER1, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER2, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_serdes_tbl[] 
>> = {
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0f),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0f),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xff),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3f),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xaa),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xab),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xd4),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xa0),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xaa),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xa0),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xb4),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_EN_CENTER, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7d),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER1, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER2, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
>> +    QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_pcie_tx_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_TX_HIGHZ_DRVR_EN, 0x10),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x06),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_pcie_rx_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x03),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_ENABLES, 0x1c),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x14),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x61),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1e),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0c),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x70),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x73),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x80),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x09),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xc8),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x09),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb1),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0xf0),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0x2f),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0xd3),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x40),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x1_pcie_pcs_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_DCC_CAL_CONFIG, 0x01),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0d),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB, 0x10),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl 
>> ipq9574_gen3x1_pcie_pcs_misc_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2, 0x0d),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 
>> 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 
>> 0x01),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 
>> 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 
>> 0x01),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG1, 0x14),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG1, 0x10),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG2, 0x0b),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_PRE, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_POST, 0x58),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x50),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x1a),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x06),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_pcs_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0d),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB, 0x10),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_DCC_CAL_CONFIG, 0x01),
>> +    QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl 
>> ipq9574_gen3x2_pcie_pcs_misc_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2, 0x1d),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 
>> 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 
>> 0x01),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 
>> 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 
>> 0x01),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x14),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x10),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG2, 0x0b),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_PRE, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_POST, 0x58),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4, 0x19),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x49),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x2a),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x02),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
>> +    QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
>> +};
> 
> So, it uses QSERDES registers from allegedly v2, TX and RX of v4 and 
> then PCS_PCIE from v5. This doesn't sound correct.
> 
>> +
>>   static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
>>       QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>>       QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
>> @@ -2042,6 +2286,10 @@ static const char * const 
>> ipq8074_pciephy_clk_l[] = {
>>       "aux", "cfg_ahb",
>>   };
>> +static const char * const ipq9574_pciephy_clk_l[] = {
>> +    "aux", "cfg_ahb", "anoc_lane", "snoc_lane",
>> +};
>> +
>>   static const char * const msm8996_phy_clk_l[] = {
>>       "aux", "cfg_ahb", "ref",
>>   };
>> @@ -2072,6 +2320,24 @@ static const char * const 
>> sdm845_pciephy_reset_l[] = {
>>       "phy",
>>   };
>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_3x1_ipq9574 = {
>> +    .serdes         = 0,
>> +    .tx             = 0x0200,
>> +    .rx             = 0x0400,
>> +    .pcs            = 0x0800,
>> +    .pcs_misc       = 0x0c00,
>> +};
>> +
>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_3x2_ipq9574 = {
>> +    .serdes        = 0,
>> +    .tx        = 0x0200,
>> +    .rx        = 0x0400,
>> +    .tx2        = 0x0600,
>> +    .rx2        = 0x0800,
>> +    .pcs        = 0x1000,
>> +    .pcs_misc    = 0x1400,
>> +};
>> +
>>   static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
>>       .serdes        = 0,
>>       .pcs        = 0x0200,
>> @@ -2174,6 +2440,66 @@ static const struct qmp_phy_cfg 
>> ipq6018_pciephy_cfg = {
>>       .phy_status        = PHYSTATUS,
>>   };
>> +static const struct qmp_phy_cfg ipq9574_gen3x1_pciephy_cfg = {
>> +    .lanes            = 1,
>> +
>> +    .offsets        = &qmp_pcie_offsets_3x1_ipq9574,
>> +
>> +    .tbls = {
>> +        .serdes        = ipq9574_gen3x1_pcie_serdes_tbl,
>> +        .serdes_num    = ARRAY_SIZE(ipq9574_gen3x1_pcie_serdes_tbl),
>> +        .tx        = ipq9574_pcie_tx_tbl,
>> +        .tx_num        = ARRAY_SIZE(ipq9574_pcie_tx_tbl),
>> +        .rx        = ipq9574_pcie_rx_tbl,
>> +        .rx_num        = ARRAY_SIZE(ipq9574_pcie_rx_tbl),
>> +        .pcs        = ipq9574_gen3x1_pcie_pcs_tbl,
>> +        .pcs_num    = ARRAY_SIZE(ipq9574_gen3x1_pcie_pcs_tbl),
>> +        .pcs_misc    = ipq9574_gen3x1_pcie_pcs_misc_tbl,
>> +        .pcs_misc_num    = ARRAY_SIZE(ipq9574_gen3x1_pcie_pcs_misc_tbl),
>> +    },
>> +    .clk_list        = ipq9574_pciephy_clk_l,
>> +    .num_clks        = ARRAY_SIZE(ipq9574_pciephy_clk_l),
>> +    .reset_list        = ipq8074_pciephy_reset_l,
>> +    .num_resets        = ARRAY_SIZE(ipq8074_pciephy_reset_l),
>> +    .vreg_list        = NULL,
>> +    .num_vregs        = 0,
>> +    .regs            = pciephy_v4_regs_layout,
>> +
>> +    .pwrdn_ctrl        = SW_PWRDN | REFCLK_DRV_DSBL,
>> +    .phy_status        = PHYSTATUS,
>> +    .pipe_clock_rate    = 250000000,
>> +};
>> +
>> +static const struct qmp_phy_cfg ipq9574_gen3x2_pciephy_cfg = {
>> +    .lanes            = 2,
>> +
>> +    .offsets        = &qmp_pcie_offsets_3x2_ipq9574,
>> +
>> +    .tbls = {
>> +        .serdes        = ipq9574_gen3x2_pcie_serdes_tbl,
>> +        .serdes_num    = ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
>> +        .tx        = ipq9574_pcie_tx_tbl,
>> +        .tx_num        = ARRAY_SIZE(ipq9574_pcie_tx_tbl),
>> +        .rx        = ipq9574_pcie_rx_tbl,
>> +        .rx_num        = ARRAY_SIZE(ipq9574_pcie_rx_tbl),
>> +        .pcs        = ipq9574_gen3x2_pcie_pcs_tbl,
>> +        .pcs_num    = ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_tbl),
>> +        .pcs_misc    = ipq9574_gen3x2_pcie_pcs_misc_tbl,
>> +        .pcs_misc_num    = ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
>> +    },
>> +    .clk_list        = ipq9574_pciephy_clk_l,
>> +    .num_clks        = ARRAY_SIZE(ipq9574_pciephy_clk_l),
>> +    .reset_list        = ipq8074_pciephy_reset_l,
>> +    .num_resets        = ARRAY_SIZE(ipq8074_pciephy_reset_l),
>> +    .vreg_list        = NULL,
>> +    .num_vregs        = 0,
>> +    .regs            = pciephy_v4_regs_layout,
>> +
>> +    .pwrdn_ctrl        = SW_PWRDN | REFCLK_DRV_DSBL,
>> +    .phy_status        = PHYSTATUS,
>> +    .pipe_clock_rate    = 250000000,
>> +};
>> +
>>   static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>>       .lanes            = 1,
>> @@ -3374,6 +3700,12 @@ static const struct of_device_id 
>> qmp_pcie_of_match_table[] = {
>>       }, {
>>           .compatible = "qcom,ipq8074-qmp-pcie-phy",
>>           .data = &ipq8074_pciephy_cfg,
>> +    }, {
>> +        .compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy",
>> +        .data = &ipq9574_gen3x1_pciephy_cfg,
>> +    }, {
>> +        .compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy",
>> +        .data = &ipq9574_gen3x2_pciephy_cfg,
>>       }, {
>>           .compatible = "qcom,msm8998-qmp-pcie-phy",
>>           .data = &msm8998_pciephy_cfg,
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h 
>> b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
>> index a469ae2a10a1..5f002b150cea 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
>> @@ -8,11 +8,25 @@
>>   #define QCOM_PHY_QMP_PCS_PCIE_V5_H_
>>   /* Only for QMP V5 PHY - PCS_PCIE registers */
>> -#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2        0x0c
>> -#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4        0x14
>> -#define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE        0x20
>> -#define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1        0x54
>> -#define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS        0x94
>> -#define QPHY_V5_PCS_PCIE_EQ_CONFIG2            0xa8
> 
> This is not reviewable. Please do not mix changing alignment of existing 
> registers together with adding new names.
Okay, got it.

Thanks,
Devi Priya
> 
>> +#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2            0x0c
>> +#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4            0x14
>> +#define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE            0x20
>> +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L        0x44
>> +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H        0x48
>> +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L        0x4c
>> +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H        0x50
>> +#define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1            0x54
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1            0x5c
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2            0x60
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4            0x68
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2            0x7c
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4            0x84
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5            0x88
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6            0x8c
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS            0x94
>> +#define QPHY_V5_PCS_PCIE_EQ_CONFIG1                0xa4
>> +#define QPHY_V5_PCS_PCIE_EQ_CONFIG2                0xa8
>> +#define QPHY_V5_PCS_PCIE_PRESET_P10_PRE                0xc0
>> +#define QPHY_V5_PCS_PCIE_PRESET_P10_POST            0xe4
>>   #endif
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h 
>> b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
>> index ad326e301a3a..231e59364e31 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
>> @@ -8,6 +8,9 @@
>>   /* QMP V2 PHY for PCIE gen3 ports - QSERDES PLL registers */
>>   #define QSERDES_PLL_BG_TIMER                0x00c
>> +#define QSERDES_PLL_SSC_EN_CENTER            0x010
>> +#define QSERDES_PLL_SSC_ADJ_PER1            0x014
>> +#define QSERDES_PLL_SSC_ADJ_PER2            0x018
>>   #define QSERDES_PLL_SSC_PER1                0x01c
>>   #define QSERDES_PLL_SSC_PER2                0x020
>>   #define QSERDES_PLL_SSC_STEP_SIZE1_MODE0        0x024
> 
