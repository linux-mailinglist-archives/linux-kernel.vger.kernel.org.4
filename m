Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98A5FBA64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJKSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJKSbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:31:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D22543D8;
        Tue, 11 Oct 2022 11:31:15 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BIMn1J000719;
        Tue, 11 Oct 2022 18:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LdlPJjUMuqtqZvwO9QM8/pk55gzXxoC9vNpl+NH9mRA=;
 b=dB1r4NpAfW951nF8Xth3WzNVmMZIm/qDbEbcpLTJWqLksph+f5P9FJ6ATx3IHysX7XaJ
 1e/iOvTUBvexrSk8qnVICaAB+IxG5h9qcu+/Iw9N6GWgwcwXYDMkk+FHakyiF0ChYv66
 X3jw5Ymy7asTvBziPf+lTeRZD18GixzB9pRGiE6VmQRqg6fJ5vEOG6cbzBe3NPLri17c
 cQv6oOHIt0X4fvtSIBUvDxhWJ6rNNVbBtP2agoc+iMsuzY20YC5D6i/MjQ5xyieTCDXG
 4+ULtQNdFj69Mqn6Py3ZanjtJMvNjQpbJhAL2VWlR1DbA8L7LI9pOi7Tb6HicHWNN5BD og== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rxkk15g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:31:11 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BIVAue004070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:31:10 GMT
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 11:31:09 -0700
Message-ID: <e4ea85f0-8167-ba78-ad42-0fc22ef9f96c@quicinc.com>
Date:   Tue, 11 Oct 2022 11:31:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/19] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-3-quic_molvera@quicinc.com>
 <2887c49c-434a-cc1b-b078-1506416e583f@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <2887c49c-434a-cc1b-b078-1506416e583f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jCtH7kNLdfumEHFQPVvmR-jkziE9XQzZ
X-Proofpoint-GUID: jCtH7kNLdfumEHFQPVvmR-jkziE9XQzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110107
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 2:12 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
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
>> @@ -152,3 +152,5 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) += qdu1000-idp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) += qru1000-idp.dtb
> List is ordered by name.
>
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
>> +	model = "Qualcomm Technologies, Inc. QDU1000 IDP";
>> +	compatible = "qcom,qdu1000-idp", "qcom,qdu1000";
> Undocumented compatibles. You need bindings for these.
Will make sure these are documented.
>
>> +	qcom,board-id = <0x22 0x0>;
>> +
>> +	aliases {
>> +		serial0 = &uart7;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart7 {
>> +	status = "okay";
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
>> +	model = "Qualcomm Technologies, Inc. QRU1000 IDP";
>> +	compatible = "qcom,qru1000-idp", "qcom,qru1000";
> Same problem.
Ack.
>
>> +	qcom,board-id = <0x22 0x0>;
> Undocumented compatible. Drop it.
Will drop.
>
> Best regards,
> Krzysztof
>
Thanks,
Melody
