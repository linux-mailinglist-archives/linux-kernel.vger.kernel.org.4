Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CBC6B8EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCNJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCNJap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:30:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833EDAD19;
        Tue, 14 Mar 2023 02:30:44 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E51kFm029417;
        Tue, 14 Mar 2023 09:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kIYBPTtUFnatJytlV5h2C3ESsOYYeJmHcpICh+bwbv8=;
 b=Mj9aJatvH9TpMGBS5erMPpuR8/NrTDBIZK3t8xh+NMR0JOdI6fl0Y+axu/+WjunMYneX
 80nozh/ez6PxnudY5nymNC6+746q8WGt/E08UqEcVAwCj5xmZHVeT8HjK3sVoGvZ4WRf
 70jdj6t8d+PXS7pKcjrtLOtQU9Pr7JLMluxGTpNkw6NlXGE97UprZc0qjjd3izYIkMMt
 0wNO9g+/c4e6MhHsEPiBqPfaqGVrx8sTKVkSGBOhXKUVNQ/PWSC5Lu2Rbo5HMtEvH6zh
 GpbE29D50Isc4bLK12eL7UropsIC/uL3ErgJh9dHf26FEuuG4EpWXVTbFnZ1NfhnNG1A KQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa1qgubyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 09:30:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E9UZ3u017220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 09:30:35 GMT
Received: from [10.206.12.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Mar
 2023 02:30:31 -0700
Message-ID: <eac18156-f5af-0364-151f-46c58e0ed426@quicinc.com>
Date:   Tue, 14 Mar 2023 15:00:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: add initial support for qcom
 sa8775p-ride
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230214092713.211054-1-brgl@bgdev.pl>
 <20230214092713.211054-3-brgl@bgdev.pl>
 <a2cad9e8-53a7-3a1e-1c40-b360ed1c1b08@quicinc.com>
 <CAMRc=Mf=3wuCL4rWYoeWyL8eHe8nuWEB__jTeEPmdO56oVQ46w@mail.gmail.com>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <CAMRc=Mf=3wuCL4rWYoeWyL8eHe8nuWEB__jTeEPmdO56oVQ46w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oWj9SZJgrl8pMr6qWXZblKZ-NmF8m15w
X-Proofpoint-GUID: oWj9SZJgrl8pMr6qWXZblKZ-NmF8m15w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303140081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/2023 1:49 PM, Bartosz Golaszewski wrote:
> On Tue, Mar 14, 2023 at 7:26 AM Shazad Hussain
> <quic_shazhuss@quicinc.com> wrote:
>>
>>
>>
>> On 2/14/2023 2:57 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> This adds basic support for the Qualcomm sa8775p platform and the
>>> reference board: sa8775p-ride. The dt files describe the basics of the
>>> SoC and enable booting to shell.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/Makefile         |   1 +
>>>    arch/arm64/boot/dts/qcom/sa8775p-ride.dts |  47 ++
>>>    arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 805 ++++++++++++++++++++++
>>>    3 files changed, 853 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>    create mode 100644 arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 31aa54f0428c..b63cd1861e68 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -75,6 +75,7 @@ dtb-$(CONFIG_ARCH_QCOM)     += qru1000-idp.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)     += sa8155p-adp.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)     += sa8295p-adp.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)     += sa8540p-ride.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)      += sa8775p-ride.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)     += sc7180-idp.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)     += sc7180-trogdor-coachz-r1.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)     += sc7180-trogdor-coachz-r1-lte.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>> new file mode 100644
>>> index 000000000000..3adf7349f4e5
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>> @@ -0,0 +1,47 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2023, Linaro Limited
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sa8775p.dtsi"
>>> +
>>> +/ {
>>> +     model = "Qualcomm SA8775P Ride";
>>> +     compatible = "qcom,sa8775p-ride", "qcom,sa8775p";
>>> +
>>> +     aliases {
>>> +             serial0 = &uart10;
>>> +     };
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial0:115200n8";
>>> +     };
>>> +};
>>> +
>>> +&qupv3_id_1 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&sleep_clk {
>>> +     clock-frequency = <32764>;
>>> +};
>>> +
>>> +&tlmm {
>>> +     qup_uart10_default: qup-uart10-state {
>>> +             pins = "gpio46", "gpio47";
>>> +             function = "qup1_se3";
>>> +     };
>>> +};
>>
>> Can we keep &tlmm at the end ? As this would be expanding.
>>
> 
> The overridden nodes are ordered alphabetically. Why would expanding
> them be a reason to put it at the end?
> 
> Bart
> 

I agree that it follows alphabetically, but typically the
pin configuration node go last after /* PINCTRL */ delimiter
as this particular section tends to become long.

-Shazad

> [...]
