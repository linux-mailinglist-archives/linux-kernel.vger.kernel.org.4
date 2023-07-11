Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BA74EA86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjGKJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjGKJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:29:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB4268D;
        Tue, 11 Jul 2023 02:27:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6WRka024175;
        Tue, 11 Jul 2023 09:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P1DzIeaHbZjKT8vDIwdToIf7z+e56X/46Y7Grqx2h+k=;
 b=etkotjq5C+ZA+JI+n4wR6CJyvb4ugYcgdvQXQecvSZ6H5fyodv92M9CDmUXOIuYjL3KA
 TyjuDConS0OMs52km4nM0Vjl6jw6snqKhEGkE3Z4rrV11Ah1f/7x3c5oqKA2Pd5PFkEq
 HSFOZVm/3HjI5/UMCUs38rgXf1wKhOfN/6dXcrjdwgtn1yO9pHODAcSn0I+cLuxaH5oH
 dP+W2hIntTjYGrPOHKE8wmYlFxCOtq3M10m29Kanl88jbK2nCdpano9eMnRfmxtIBIFx
 tWNgvOPNEAm142mU/c8QWd7brVdMEPnnH83t/oNwpzCHYp+V8iCORfavvVaupwwvvJw0 dg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs1hw8c4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:27:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B9RBkC019069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:27:11 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 02:27:06 -0700
Message-ID: <7926d192-3831-dfac-6a39-85dd56d9441d@quicinc.com>
Date:   Tue, 11 Jul 2023 14:57:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] arm64: dts: qcom: ipq5332: Add tsens node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-5-quic_ipkumar@quicinc.com>
 <ee0db4bc-ec28-513a-bd39-b526a6ee805c@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <ee0db4bc-ec28-513a-bd39-b526a6ee805c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0PZuro7WjTYyf6SyCqEEZCx-jKqbKEwX
X-Proofpoint-ORIG-GUID: 0PZuro7WjTYyf6SyCqEEZCx-jKqbKEwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxlogscore=866 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110083
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/2023 1:37 AM, Krzysztof Kozlowski wrote:
> On 10/07/2023 12:37, Praveenkumar I wrote:
>> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
>> node with nvmem cells for calibration data.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 113 ++++++++++++++++++++++++++
>>   1 file changed, 113 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index 8bfc2db44624..a1e3527178c0 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -150,6 +150,91 @@ qfprom: efuse@a4000 {
>>   			reg = <0x000a4000 0x721>;
>>   			#address-cells = <1>;
>>   			#size-cells = <1>;
>> +
>> +			tsens_mode: mode@3e1 {
>> +				reg = <0x3e1 0x1>;
>> +				bits = <0 3>;
>> +			};
>> +
>> +			tsens_base0: base0@3e1 {
>> +				reg = <0x3e1 0x2>;
>> +				bits = <3 10>;
>> +			};
>> +
>> +			tsens_base1: base1@3e2 {
>> +				reg = <0x3e2 0x2>;
>> +				bits = <5 10>;
>> +			};
>> +
>> +			s0_offset: s0_offset@3e4 {
> Underscores are not allowed in node names.
Sure, will change it to hyphen.

--
Thanks,
Praveenkumar


>
> Best regards,
> Krzysztof
>
