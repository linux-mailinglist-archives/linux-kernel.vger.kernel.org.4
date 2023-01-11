Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A78665E52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjAKOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjAKOt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:49:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2629F5B8;
        Wed, 11 Jan 2023 06:49:26 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BEmZ56027078;
        Wed, 11 Jan 2023 14:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Uz3f8J9YNsaXsO2z23IyKDJUxb/Y0lz+mQRpOBG6Sf0=;
 b=gE3F5oo1bipRUsRMqvWNsr69Q1oKU6HF5J/LaiJOaxpuyL/eG4ZlkC/F4rIrBv/Phw97
 NaSGYocE6iBdQHKzHdnEjrVaMYakQ+SOS+H07ykx6aMssSQXTSQTpsFJLyffMkMVBD+N
 OqrnD+zEkhkisjI4w85FHSj9LlpxmSsAlG1vI4HVtM+fswKgoBMwIyLp2GN23O8RkfSy
 yqukhVUgvcnKmFOZAW3dWTPWrWutZEfnZDwSQUTTMCeBmstRtNw9B7wSCllAjEnxfPX5
 sePtPI95WuB3fUG28j37yIDOvl28SeaT55kb2iqrAxOQYRPQp2dMJSl34hKKCp52fSpa Ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k9j1gx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 14:48:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BEmXNV024726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 14:48:33 GMT
Received: from [10.50.23.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 06:48:20 -0800
Message-ID: <a9dfc45a-dc7a-9e39-ccc4-a451ea165bdf@quicinc.com>
Date:   Wed, 11 Jan 2023 20:18:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable IPQ9574 SoC base configs
To:     devi priya <quic_devipriy@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <marcel.ziswiler@toradex.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <tdas@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-8-quic_devipriy@quicinc.com>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20230110121316.24892-8-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uZCZL2UYKO4OyakHQC9ROqoy9dMmB43n
X-Proofpoint-ORIG-GUID: uZCZL2UYKO4OyakHQC9ROqoy9dMmB43n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_07,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 mlxlogscore=846 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/2023 5:43 PM, devi priya wrote:
> Enables clk & pinctrl related configs
>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 851e8f9be06d..e0ae0996d5ad 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -545,6 +545,7 @@ CONFIG_PINCTRL_IMX93=y
>   CONFIG_PINCTRL_MSM=y
>   CONFIG_PINCTRL_IPQ8074=y
>   CONFIG_PINCTRL_IPQ6018=y
> +CONFIG_PINCTRL_IPQ9574=y
Please move this after IPQ8074, to keep it in ascending order. We can 
move the IPQ6018 config before IPQ8074.
>   CONFIG_PINCTRL_MSM8916=y
>   CONFIG_PINCTRL_MSM8953=y
>   CONFIG_PINCTRL_MSM8976=y
> @@ -1093,6 +1094,7 @@ CONFIG_QCOM_CLK_SMD_RPM=y
>   CONFIG_QCOM_CLK_RPMH=y
>   CONFIG_IPQ_GCC_6018=y
>   CONFIG_IPQ_GCC_8074=y
> +CONFIG_IPQ_GCC_9574=y
>   CONFIG_MSM_GCC_8916=y
>   CONFIG_MSM_GCC_8994=y
>   CONFIG_MSM_MMCC_8996=y
