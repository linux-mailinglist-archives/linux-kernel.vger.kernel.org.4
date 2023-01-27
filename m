Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF067E079
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjA0JkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjA0JkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:40:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A8E1B9;
        Fri, 27 Jan 2023 01:40:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9d96D010411;
        Fri, 27 Jan 2023 09:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cF9X9aJaof3C7DGX2sN20O3SfOpV4IsVdaLAM8Ot6ME=;
 b=aQWi2f1kPBe5Y7XRcPQd9jP5fy3MzFbytqMKsI38nwwquFGJkwzGtYrvq94hNm8/NDSu
 PNd5XZjQ2sx/zxvqVkFgQB5GwC4iTrCqvYyW6nze+eWOvj8ojW8f0Ofbxg+cc+1vpFd5
 zCvadahCOdEcE6OYMxMELXZkLXgSAvj4+bQtbldysPvHx+VZevSeNn/5l6rbT4iFhxS8
 0J7CEv3KLGevhPbz6/xYxl5lntl++EvxD+J2VFeLVRX8jjpFwFS8NQWn0sZO6tr5+AnK
 RAkjx2fWGZF717/Qiir55JLYnHLhh7zu1WxxFlHxAEmzSQ7Ue4GSCGhPsnDibwGGItSW Hg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nc956r8q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 09:39:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30R9d8Rf002113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 09:39:08 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 01:38:57 -0800
Message-ID: <d39a5965-3320-c7f7-d936-93467b141e10@quicinc.com>
Date:   Fri, 27 Jan 2023 15:08:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V1 7/8] arm64: dts: qcom: Add ipq9574 SoC and AL02 board
 support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <marcel.ziswiler@toradex.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <tdas@codeaurora.org>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230124141541.8290-1-quic_devipriy@quicinc.com>
 <20230124141541.8290-8-quic_devipriy@quicinc.com>
 <adb66162-6ff3-184e-fe92-109bdef8ed1c@linaro.org>
 <9cce23e9-bb1e-b49e-b771-f61ac6d12933@quicinc.com>
 <41efc16a-8b6d-e6c1-efe1-4e0b4ce43533@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <41efc16a-8b6d-e6c1-efe1-4e0b4ce43533@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jw2_O0OrDSvr_c2M2GM6qfsn17Y93L0T
X-Proofpoint-ORIG-GUID: jw2_O0OrDSvr_c2M2GM6qfsn17Y93L0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 mlxlogscore=894 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270091
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2023 5:10 AM, Konrad Dybcio wrote:
> 
> 
> On 25.01.2023 12:12, Devi Priya wrote:
>>
>>
>> On 1/24/2023 8:44 PM, Krzysztof Kozlowski wrote:
>>> On 24/01/2023 15:15, devi priya wrote:
>>>> From: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>>>
>>>> Add initial device tree support for Qualcomm IPQ9574 SoC
>>>> and AL02 board
>>>>
>>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Co-developed-by: devi priya <quic_devipriy@quicinc.com>
>>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/Makefile            |   1 +
>>>>    arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  78 +++++
>>>>    arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 285 +++++++++++++++++++
>>>>    3 files changed, 364 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>>> index 3e79496292e7..872c62028a0b 100644
>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += ipq6018-cp01-c1.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk01.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk10-c1.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)    += ipq8074-hk10-c2.dtb
>>>> +dtb-$(CONFIG_ARCH_QCOM)    += ipq9574-al02-c7.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)    += msm8916-alcatel-idol347.dtb
>>>
>>> This does not match current tree, so I could not apply it for tests. I
>>> think you based it on a bit older version.
>>>
>> The patch series is based on Linux 6.2-rc1 and not the qcom/for-next branch.
> Linux 6.2-rc1 is very old already and Bjorn has already picked
> tens of patches atop it, so yours will not apply unless you
> base it on qcom/for-next (or just linux-next for that matter).
> 
Sure got it. Will post V3 based on linux-next
> Konrad
>>> Best regards,
>>> Krzysztof
>>>
>> Best Regards,
>> Devi Priya
