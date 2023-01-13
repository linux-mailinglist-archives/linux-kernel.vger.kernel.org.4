Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20C6698B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbjAMNgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbjAMNgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:36:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D11712ACA;
        Fri, 13 Jan 2023 05:28:28 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D9qvX7003681;
        Fri, 13 Jan 2023 13:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xpbeSiXvb2w8H1dieC5+fWqDiKuAQDVe9c/XPLf86Hw=;
 b=mqTmTTEQS9mOv+M6aw0X0ZAu9ml3VfirQTFg8kB47PeQ7Mw2BV4Ooh98YRHSLJbpgAuC
 eMvp/3jHr5FLOnDSgPN5RczKICwx+L40ffV3PHEsGjEEWQAVDXdy0v1O7tihFrSIBI1S
 7GbL5F/j96TYNZQGsdN5hwhtDjBrDPRCb655+cNZJJ8+ajtBd1F2jG0w+M4KXOhyIbP+
 gEMxMibDChGD55izEPrNP/yuKOk3K6PH8WP/5W3c1nhcnixdAK8jZl6OoMM0vouAZz+z
 nn7XjI7tNlujPbX4o+RMzcO+667oC09gL2zH7K/Q2OAtf+5uHqBOlra+Z2uUAjC31mV7 5Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n351f8r7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:27:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DDRhOF010486
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:27:43 GMT
Received: from [10.50.57.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:27:35 -0800
Message-ID: <994879f7-8ece-e98f-da11-6bcfcac82c0e@quicinc.com>
Date:   Fri, 13 Jan 2023 18:57:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable IPQ9574 SoC base configs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-8-quic_devipriy@quicinc.com>
 <a9dfc45a-dc7a-9e39-ccc4-a451ea165bdf@quicinc.com>
 <24461c28-0939-bd37-a6bc-774dc70ed8ed@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <24461c28-0939-bd37-a6bc-774dc70ed8ed@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4dSWU2AjWCD2YRazsoIVeteoI8UjDO1Y
X-Proofpoint-ORIG-GUID: 4dSWU2AjWCD2YRazsoIVeteoI8UjDO1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=766 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130089
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2023 8:33 PM, Krzysztof Kozlowski wrote:
> On 11/01/2023 15:48, Kathiravan Thirumoorthy wrote:
>>
>> On 1/10/2023 5:43 PM, devi priya wrote:
>>> Enables clk & pinctrl related configs
>>>
>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>> ---
>>>    arch/arm64/configs/defconfig | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 851e8f9be06d..e0ae0996d5ad 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -545,6 +545,7 @@ CONFIG_PINCTRL_IMX93=y
>>>    CONFIG_PINCTRL_MSM=y
>>>    CONFIG_PINCTRL_IPQ8074=y
>>>    CONFIG_PINCTRL_IPQ6018=y
>>> +CONFIG_PINCTRL_IPQ9574=y
>> Please move this after IPQ8074, to keep it in ascending order. We can
>> move the IPQ6018 config before IPQ8074.
> 
> This must match savedefconfig order, not alphabetical.
Understood!
> 
> Best regards,
> Krzysztof
> 
Best Regards,
Devi Priya
