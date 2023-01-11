Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D4665919
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjAKKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjAKKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:33:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C446321;
        Wed, 11 Jan 2023 02:33:07 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B8wwxd006816;
        Wed, 11 Jan 2023 10:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1oF420EDxAicWGUXE/uXSiSuvzCuEmIK+W0MR2J+zgY=;
 b=jIJ0tJQ0PF1PJ9qmhGGKUSakG1ihGRz7ii85luuFSf63p06XejrXXN2Kb98KRFqLY0uT
 6Vkpr9nz445QwIU+KGGiQmnbpj8ZJb3NroQguokKcfu+fK1Pv/b2v8jhV0vqDjBkMdLm
 v+dDaP21YxJxqBtW9BVSv10sjZP016MC/Bx6SqinrIpINO3RyO3hfyzgzaX3VA1v9U2f
 TXSdzhpRvMAPsojRKLgSXUbea+ZCNX86/EZZi/EpQcEE83fPeeUVM33UBHGnJF0VK36s
 RJnPp4ZyOtfAkFph4uXJHQBApMDWohEsqJeEua5q681dFTdnkCoDCjMeuPUTtB75JAhS SQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k6a0yeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 10:33:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BAX3aX008255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 10:33:03 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 02:33:00 -0800
Message-ID: <d7f9a6be-ced8-b3b1-7940-580e71c6cb06@quicinc.com>
Date:   Wed, 11 Jan 2023 16:02:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Add TCSR halt register space
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1673428818-26112-1-git-send-email-quic_mojha@quicinc.com>
 <ab6a99da-e91b-20de-3126-3f1f94ce277b@linaro.org>
 <c5dc8042-717b-22eb-79f6-d18ab10d6685@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <c5dc8042-717b-22eb-79f6-d18ab10d6685@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rB1f-Es52DChQWHHcSfLcnNu_tjCx04-
X-Proofpoint-GUID: rB1f-Es52DChQWHHcSfLcnNu_tjCx04-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=901 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/11/2023 3:30 PM, Krzysztof Kozlowski wrote:
> On 11/01/2023 10:59, Krzysztof Kozlowski wrote:
>> On 11/01/2023 10:20, Mukesh Ojha wrote:
>>> Add TCSR register space and refer it from scm node, so that
>>> it can be used by SCM driver.
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> index 5704750..e0fa733 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> @@ -270,6 +270,7 @@
>>>   	firmware {
>>>   		scm: scm {
>>>   			compatible = "qcom,scm-sm8450", "qcom,scm";
>>> +			qcom,dload-mode = <&tcsr 0x13000>;
>>>   			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
>>>   			#reset-cells = <1>;
>>>   		};
>>> @@ -1986,6 +1987,11 @@
>>>   			#hwlock-cells = <1>;
>>>   		};
>>>   
>>> +		tcsr: syscon@1fc0000 {
>>> +			compatible = "syscon";
>>
>> This is not allowed by itself.
> 
> Eh, that was not proper English... I wanted to say: This is not allowed
> on its own. You need specific compatible. ALWAYS.

Sorry, it was my first DT patch, I did not run dtbs_check.
Thanks for correcting.

I think, i have missed adding qcom,tcsr-sm8450 in
Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
also need to add qcom,tcsr-sm8450 in above compatible.

-Mukesh
> 
>> You should have warnings when running
>> dtbs_check.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Best regards,
> Krzysztof
> 
