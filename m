Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E197864C850
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiLNLpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiLNLon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:44:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E92F25C7A;
        Wed, 14 Dec 2022 03:44:42 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEB8Uor012535;
        Wed, 14 Dec 2022 11:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SW5iqd+KDcgWcYcEwbk23fdI3WvkO5WeEgdmPPrepJk=;
 b=o52Trk8fLWDnagUhts7IcteOqEt1GHa73az7/g0rJLcC0vLxyHVyviZEMHT4w//+pYrW
 IdJnk4X43NyybkJnYpimquzzF2QO+73swjC3YwJVW1Qz1CuhygVMWvvEzgPluvzEzbZO
 4LjUPOKIZkg7RZeT35m1oUpXdGaX+XOroXmt08tt5zQPiRWhFmYjx+E9cCxTReCySwJ9
 cmppYh9KUfK8E+2s6DPYerDWqTDI0f0/KQWjqK9FDLCC489AOZd9tCmngaEwu/1E/4Rj
 BiLp4Z4r8Ri0Foba4tYyMFQ0OC0VtFqVATqLE70X+i/ftIRdwhNEmYElfBzySqmPDPzQ yg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rd127n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 11:44:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEBiQ6p006803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 11:44:26 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 03:44:21 -0800
Message-ID: <72fc8328-6e15-3a83-ad0b-905b2cc7a560@quicinc.com>
Date:   Wed, 14 Dec 2022 17:14:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] arm64: dts: qcom: Introduce a carveout for modem
 metadata
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-2-quic_sibis@quicinc.com>
 <f23f3db8-08a7-78a9-a516-de211c53b6f4@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <f23f3db8-08a7-78a9-a516-de211c53b6f4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IGITdU3h6r3P2BDkK9fgadS7wc_TNPSo
X-Proofpoint-ORIG-GUID: IGITdU3h6r3P2BDkK9fgadS7wc_TNPSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_04,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=791 suspectscore=0
 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/22 16:57, Krzysztof Kozlowski wrote:
> On 13/12/2022 15:07, Sibi Sankar wrote:
>> Introduce a new carveout for modem metadata. This will serve as a
>> replacement for the memory region used by MSA to authenticate modem
>> ELF headers.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi    | 6 ++++++
>>   arch/arm64/boot/dts/qcom/msm8996.dtsi                  | 9 +++++++++
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi                  | 9 +++++++++
>>   arch/arm64/boot/dts/qcom/sc7180-idp.dts                | 7 ++++++-
>>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi           | 7 ++++++-
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 7 ++++++-
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi                   | 9 +++++++++
>>   7 files changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
>> index 5b47b8de69da..4242f8587c19 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
>> @@ -127,6 +127,12 @@
>>   			reg = <0x0 0xf6f00000 0x0 0x100000>;
>>   			no-map;
>>   		};
>> +
>> +		/delete-node/ memory@91700000;
>> +		mdata_mem: memory@f7100000 {
>> +			reg = <0x0 0xf7100000 0x0 0x4000>;
>> +			no-map;
>> +		};
>>   	};
>>   
>>   	vph_pwr: vph-pwr-regulator {
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index cc65f52bb80f..3f5fb08e2341 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -462,6 +462,11 @@
>>   			reg = <0x0 0x91500000 0x0 0x200000>;
>>   			no-map;
>>   		};
>> +
>> +		mdata_mem: memory@91700000 {
>> +			reg = <0x0 0x91700000 0x0 0x4000>;
>> +			no-map;
>> +		};
>>   	};
>>   
>>   	rpm-glink {
>> @@ -2458,6 +2463,10 @@
>>   				memory-region = <&mpss_mem>;
>>   			};
>>   
>> +			metadata {
> 
> Does it pass dtbs_check?

^^ portion of the bindings aren't in yaml yet please see patch 3.

> 
> Best regards,
> Krzysztof
> 
