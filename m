Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6885FBA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJKSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJKSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:30:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525421DA6E;
        Tue, 11 Oct 2022 11:30:00 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BH0pcf023171;
        Tue, 11 Oct 2022 18:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jCRR4W2uRvl9Z0JsyhO5LLiCwUXH82vXRjUf9rTa/hk=;
 b=g49RRvFM5XCnzJYPY/kh3stVgbFdgkQ8VuuxvCtaX8Xfxkplq9OtbIRBM8ZhH/Mw6ZBj
 LyuzsafIw/atUnPHwfcUetKkyVTeYDdULmE54nGV3EM2O0a+w9hJQDp57191WgJCnVTA
 N/anwh18IX7RwYv61kbcVpMaA/prE2y6TkFaGzzpCgbyBm4Cbtw28Pn87PSvul+re4tn
 Os+B5vS/CeqW/4UifVP+RBp4jJZxVDENqECkCOZ1TOwLPo1Na3WXZNhx0IKG43KN1vuX
 4r/ejsF8k7lZQCGZDqRUzeq+hUYIEMg/mn3aSwSkygwxwxxxHNuUM8CGgA/oWPeHO9Vr Ag== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx2kux2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:29:57 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BITu4t019189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:29:57 GMT
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 11:29:56 -0700
Message-ID: <8d22eb07-4b8d-237f-fc5e-93eeb842a8e9@quicinc.com>
Date:   Tue, 11 Oct 2022 11:29:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/19] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-3-quic_molvera@quicinc.com>
 <CAA8EJpqS7pHpuXDeeD_TOus=WAJuFE5sWrjeGH0VQdyTJf2uhA@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJpqS7pHpuXDeeD_TOus=WAJuFE5sWrjeGH0VQdyTJf2uhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7IRrz8_PlCRnMaYYlhZ1m5KOLqjovUtR
X-Proofpoint-ORIG-GUID: 7IRrz8_PlCRnMaYYlhZ1m5KOLqjovUtR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210110107
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 12:28 AM, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:09, Melody Olvera <quic_molvera@quicinc.com> wrote:
>> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
>> SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile        |  2 ++
>>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 30 ++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 30 ++++++++++++++++++++++++
>>  3 files changed, 62 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 1d86a33de528..398920c530b0 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -152,3 +152,5 @@ dtb-$(CONFIG_ARCH_QCOM)     += sm8350-sony-xperia-sagami-pdx214.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += sm8350-sony-xperia-sagami-pdx215.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += sm8450-hdk.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += sm8450-qrd.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) += qdu1000-idp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) += qru1000-idp.dtb
> These two lines stand out. Please fix the indentation and move them to
> the proper place.
Ack.
>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> new file mode 100644
>> index 000000000000..0ecf9a7c41ec
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: BSD-3-Clause-Clear
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "qdu1000.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. QDU1000 IDP";
>> +       compatible = "qcom,qdu1000-idp", "qcom,qdu1000";
>> +       qcom,board-id = <0x22 0x0>;
>> +
>> +       aliases {
>> +               serial0 = &uart7;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +};
>> +
>> +&qupv3_id_0 {
>> +       status = "okay";
>> +};
>> +
>> +&uart7 {
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> new file mode 100644
>> index 000000000000..ddb4ea17f7d2
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: BSD-3-Clause-Clear
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "qru1000.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. QRU1000 IDP";
>> +       compatible = "qcom,qru1000-idp", "qcom,qru1000";
>> +       qcom,board-id = <0x22 0x0>;
>> +
>> +       aliases {
>> +               serial0 = &uart7;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +};
>> +
>> +&qupv3_id_0 {
>> +       status = "okay";
>> +};
>> +
>> +&uart7 {
>> +       status = "okay";
>> +};
>> --
>> 2.37.3
>>
Thanks,
Melody
