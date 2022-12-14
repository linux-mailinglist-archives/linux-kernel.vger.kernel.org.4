Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817B564C40F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 07:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLNGuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 01:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbiLNGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 01:50:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160335582;
        Tue, 13 Dec 2022 22:50:12 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BE6nvnP001784;
        Wed, 14 Dec 2022 06:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4CAMOAoT1vKR8K7w6oaD0wYZOnCGRfFMwebmU+kI0qM=;
 b=S1N3ZcNS8rqU0GE9E3h/o4PsNeImQh7gfzFpKQxCuLCG5BtNNsKrG6r4r9faWR90Dvpq
 tbccth34Uy4X6dP+WJVmLy5Osq1s8DKMXK6WQXvSQMzQXphEDnhQiMbTS8n720gBMicf
 a+JIqeeCwYMoW3LIBGCcwZKdZBA8h475U14k2TeMz5nJg0e21gfmj85fFbpcvRMU/sdb
 9KwM6wb4C5Lth7Gb1r16P13RG2tqYb70H4n05COzYJ89jDvka7r8NGq69KKYRI+iRSW0
 eFI2oSZRes+bG1anQ9e6Zl/g2tm12blJ/mNP6BvMJLS+U3JpYW2IUH9+0dcOGRZDTzpv JQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rvr9y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 06:49:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BE6nuhI026386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 06:49:56 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 22:49:51 -0800
Message-ID: <96c1e60d-de12-5e60-4c06-70ea4b9c49f8@quicinc.com>
Date:   Wed, 14 Dec 2022 12:19:48 +0530
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
 <7ea03855-4806-f4ca-e0c3-4044e1095d6b@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <7ea03855-4806-f4ca-e0c3-4044e1095d6b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nSoDid_FslDSpaeZjubIm-cUJMoWkhNY
X-Proofpoint-ORIG-GUID: nSoDid_FslDSpaeZjubIm-cUJMoWkhNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_02,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

Thanks for taking time to review the series.

On 12/14/22 01:10, Krzysztof Kozlowski wrote:
> On 13/12/2022 15:07, Sibi Sankar wrote:
>> Introduce a new carveout for modem metadata. This will serve as a
>> replacement for the memory region used by MSA to authenticate modem
>> ELF headers.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>>   
>>   	aliases {
>> @@ -865,7 +870,7 @@ hp_i2c: &i2c9 {
>>   	clock-names = "iface", "bus", "nav", "snoc_axi", "mnoc_axi", "xo";
>>   
>>   	iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
>> -	memory-region = <&mba_mem &mpss_mem>;
>> +	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
>>   
>>   	/* This gets overridden for SKUs with LTE support. */
>>   	firmware-name = "qcom/sc7180-trogdor/modem-nolte/mba.mbn",
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>> index bf522a64b172..bda0495aa0b5 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>> @@ -17,6 +17,11 @@
>>   			reg = <0x0 0x9c700000 0x0 0x200000>;
>>   			no-map;
>>   		};
>> +
>> +		mdata_mem: memory@9d100000 {
>> +			reg = <0x0 0x9d100000 0x0 0x4000>;
>> +			no-map;
>> +		};
>>   	};
>>   };
>>   
>> @@ -32,7 +37,7 @@
>>   
>>   	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
>>   	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
>> -	memory-region = <&mba_mem>, <&mpss_mem>;
>> +	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
> 
> Only two memory regions are allowed by bindings... unless you fix it in
> further patchset. If so, please re-order to have the bindings first. It
> helps reviewers not to have such questions. :)

I felt that Rob's dt_bindings check bot might report an error
if the dt changes weren't placed before the bindings changes.
But since you asked for the logical order I guess the bindings
check are done only after the entire series is applied. I'll
change the order in the next re-spin.

- Sibi
> 
> 
> Best regards,
> Krzysztof
> 
