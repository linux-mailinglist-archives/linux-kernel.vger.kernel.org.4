Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898ED6698A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbjAMNeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241734AbjAMNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:33:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE445BA26;
        Fri, 13 Jan 2023 05:26:13 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBuSDZ005819;
        Fri, 13 Jan 2023 13:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qd/+Nb4pg8YWTKhNAUyU1pOk7jqhTx4w8n80wei/bD0=;
 b=mv/EtgXuC3Qmzx36Lf+2Zed041+1GD2gkipvGyr/gTiOMpaHCpUPOVEQd0fQ3RFo88UO
 FSE3O57WY3BqtZJxvDG8Wkco05Sq3AnNMeeDrk7030IvXTSkNsfYzIQcpGNN3LjdErdj
 B1mg0uouNGnaPLIibItXWgK6rGypWzKGx4WqpUdauiiKLURSOqDWwbanZG4QdXhK1+vA
 JqBLkrxPj3GhicLfbANMawekk2RQo6hPURYLjF/I4bw6JKpvkFDzkecB8sEZWDd6lIRg
 GE8guoHh7w93cMCtnJurFRSipcfjjSWS6F0RcgZNPCY6fHLVPKHzRzwSQg1fBlOFeU/n Uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2wun1jpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:25:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DDPOOr009153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:25:24 GMT
Received: from [10.50.57.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:25:15 -0800
Message-ID: <5533b3f9-cd09-4e1d-455a-53ee1d39a008@quicinc.com>
Date:   Fri, 13 Jan 2023 18:55:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/7] pinctrl: qcom: Add IPQ9574 pinctrl driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-5-quic_devipriy@quicinc.com>
 <788ddb2a-7c29-cc10-fce2-ca348cd81b65@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <788ddb2a-7c29-cc10-fce2-ca348cd81b65@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dMqb2z9B4hpUuZ7iHdoWdpMhC4hklgeg
X-Proofpoint-GUID: dMqb2z9B4hpUuZ7iHdoWdpMhC4hklgeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=762 classifier=spam adjust=0 reason=mlx scancount=1
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



On 1/11/2023 3:16 PM, Krzysztof Kozlowski wrote:
> On 10/01/2023 13:13, devi priya wrote:
>> Add pinctrl definitions for the TLMM of IPQ9574
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/pinctrl/qcom/Kconfig           |   10 +
>>   drivers/pinctrl/qcom/Makefile          |    1 +
>>   drivers/pinctrl/qcom/pinctrl-ipq9574.c | 1003 ++++++++++++++++++++++++
>>   3 files changed, 1014 insertions(+)
>>   create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index 1378ddca084f..a9b4b07e3de0 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -70,6 +70,16 @@ config PINCTRL_IPQ6018
>>   	  Qualcomm Technologies Inc. IPQ6018 platform. Select this for
>>   	  IPQ6018.
>>   
>> +config PINCTRL_IPQ9574
>> +	tristate "Qualcomm Technologies, Inc. IPQ9574 pin controller driver"
>> +	depends on GPIOLIB && OF
> 
> Look at other entries and use similar style.
Sure, will do!
> 
> Best regards,
> Krzysztof
> 
Best Regards,
Devi Priya
