Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0516604FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJSS4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJSS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:56:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD5194221;
        Wed, 19 Oct 2022 11:56:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JC0paM017623;
        Wed, 19 Oct 2022 18:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pry4w3Kp43NaKn2WBenanTlyw3GHWVveMdrjLYD30KA=;
 b=Vpl/jcDTa/iinHn+ZyIa97LOdb5McGq7hA9/Gjyu4Q2P86f0SZE0mmdh8OzCP/6tTttK
 P7OuZGI06BC3CN7ZUcG2B3MNA9A5TDaKa1xFsEJXtDozMGCz1qJ11qSVf7t538GXEV7r
 nhHb7GVccdHHDWXpxXMhIJ++mrl7VpltPACV3vYXztiSXv379nhuf4oooH8eEsld2cQo
 pwD8R22jfP5afPvDWSgCuy+54eJwLuHo/G0dcSsKw/zuQPc3H9OeoQ0vW9BaFSP052tE
 FOwiBvUIL3nJQ8nN8wDfCswqCLEEAGuTeP/WZmrtysZwF7Gxv4Vo9vIbLou//Bcp6jRd Xg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kaed8tj1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 18:56:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29JIu90B001016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 18:56:09 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 11:56:09 -0700
Message-ID: <83721f08-c935-4d9d-237e-a25bc8f277b7@quicinc.com>
Date:   Wed, 19 Oct 2022 11:56:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-3-quic_molvera@quicinc.com>
 <d4158329-5a7a-c622-a8f8-ea2508b663c6@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <d4158329-5a7a-c622-a8f8-ea2508b663c6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CkPqNnO_R_qVmncLNrrUQnMppcCnaDmL
X-Proofpoint-GUID: CkPqNnO_R_qVmncLNrrUQnMppcCnaDmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0
 mlxlogscore=835 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2022 3:15 PM, Krzysztof Kozlowski wrote:
> On 14/10/2022 18:11, Melody Olvera wrote:
>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
>> to boot to shell with console on these SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1646 +++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>>  2 files changed, 1673 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> new file mode 100644
>> index 000000000000..777734b30f56
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -0,0 +1,1646 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-qdu1000.h>
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/dma/qcom-gpi.h>
>> +#include <dt-bindings/interconnect/qcom,qdu1000.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> As pointed out by kernel test robot, your patchset is unbuildable and
> unmerge'able, so automated tools cannot test it.
I saw. I will be more explicit about the dependencies on previous patches
in the next patchset.

Thanks,
Melody
