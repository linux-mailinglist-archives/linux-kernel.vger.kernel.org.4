Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57796D94AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbjDFLEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbjDFLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:04:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA91703;
        Thu,  6 Apr 2023 04:04:25 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336B4KCZ019975;
        Thu, 6 Apr 2023 11:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YYcev94yQdsqVZnRqJnBM1uuqYiJhHnnxfI5yles50E=;
 b=LLfE6rQu4eBtAkWY2KlhevqrvueFGgvVxmFfVC2/dtaxT9s9jR15jgDRk1eMigYhZmlh
 m/N4C95zkrOSFe8ADsYKhgC87xZNPhcVds3x6s4zKbHDfMf3p3GIZU5e2ToF47WsPglG
 JJOpgJh74s1cX4kPvCcWFxVqBZBUKZqr/Jesq+HiBK0q4LmTAp52busFum2dlhZi26XK
 zngcY01lg5/m+9EFFUxh0IF56onOTnho/iGcizKU1/4kzFbSbAq4x6uCRJQPM7FnV2Tu
 9u4UajnCaU07BLFqAkHk0Jpf7j/K8Oh3nss0IfL4epoon1xD0LFBXGE25xTzzTNPksNo qA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psnmj0ya7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:04:21 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336B44OQ013696
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 11:04:04 GMT
Received: from [10.216.2.94] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 04:03:59 -0700
Message-ID: <54e8f7b6-12ae-aac5-9092-7d1fef300db8@quicinc.com>
Date:   Thu, 6 Apr 2023 16:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: msm: Add bindings for multi
 channel DDR in LLCC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
 <20230313124040.9463-3-quic_kbajaj@quicinc.com>
 <2b3e39b9-ea70-db9b-89f7-09054df363c3@linaro.org>
 <20230315134814.GA98488@thinkpad>
 <c8f3499f-d927-6657-c7c6-732ed2222525@quicinc.com>
 <f9728472-0dda-2fb2-1753-e9c039afa4c1@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <f9728472-0dda-2fb2-1753-e9c039afa4c1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LruhRa6HfjYKtX6uWzwHewu6Jd5GizGq
X-Proofpoint-ORIG-GUID: LruhRa6HfjYKtX6uWzwHewu6Jd5GizGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_05,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060097
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/2023 3:04 PM, Krzysztof Kozlowski wrote:
> On 06/04/2023 11:19, Komal Bajaj wrote:
>>
>>>>>    
>>>>>      interrupts:
>>>>>        maxItems: 1
>>>>>    
>>>>> +  multi-ch-bit-off:
>>>>> +    items:
>>>>> +      - description: Specifies the offset in bits into the multi_channel_register
>>>>> +                     and the number of bits used to decide which LLCC configuration
>>>>> +                     to use
>>>> There are here few issues.
>>>> First, I don't fully understand the property. What is an LLCC
>>>> configuration? Like some fused values?
>>
>> There are different configuration for LLCC based on the number of
>> DDR channel it uses. Here, we are basically trying to get information
>> about the same.
>>
>>>>
>>>> Second, don't make it a register specific, it will not scale easily to
>>>> any new version of this interface. Although how this should look like
>>>> depends on what is it.
>>
>> LLCC driver can only get DDR channel information from the register.

Actually, any one can read this property there is no boundation to that.
However, some of the bits information of this register only matters to 
LLCC to make decision.

> And why would that exactly matter to DT? How does it solve my concern
> that your approach does not scale?

I understand your concern about not making it register specific, however 
this register is a secure fuse register where the interested bits are
known to us and should only be used by llcc to select right slice 
configuration table to apply.

How about something like this,

Add another property like qcom,tcsr_feature_config under qcom,scm
and read this property under qcom_scm driver and expose
read exported symbol for LLCC driver. LLCC driver can use API and
apply bit offset/bit size to get right value inside the target driver 
data(e.g .data = &XXXX_cfg }) or maintain it inside same 
tcsr_feature_config DT (this can be discussed)
Also, we can have a yaml file for tcsr_feature_config.

e.g..


scm: scm {
         compatible = "qcom,scm-sm8450", "qcom,scm";
         qcom,dload-mode = <&tcsr 0x13000>;
         ...
	qcom,tcsr_feature_config = <&tcsr_feature_config>
};

tcsr_feature_config: syscon@fd484000 {
	compatible = "qcom, XXXX", qcom,tcsr-featureconfig";
	reg = <0xXXXXXXXX 0xYYYY>;
};


-- Mukesh

> 
> Best regards,
> Krzysztof
> 
