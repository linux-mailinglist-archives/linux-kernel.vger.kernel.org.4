Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4E67EA65
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjA0QGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjA0QGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:06:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794237B404;
        Fri, 27 Jan 2023 08:05:54 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFejPX000765;
        Fri, 27 Jan 2023 16:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XgxrgOahCuczz4eXTfNPoySwX33EBdYqksVo82Sl3ss=;
 b=aGbM0hwgJP2aWBESov7DvWQwFiw+2BVYXH8z9Z4tm30SJLrp0Wgf1o3RErkjnelJpB32
 qO+8jndvC5F/uh4+Vg36HjEIDw7ltHKNBCDbino9ZqBRuzYyCZxVj/XiDw2itppOgrmt
 2T2/2z/G/DaGtwv3mznaYBVzwdSfzDFNYtfsw4ftVIGC5Xg1F2PJLdgJrEV83AzWexEW
 Qjw4SjiF+1RLSGcsvJqWRoZqeQUcnKGR1EsMmI/KeA+K2QIZzncRKsNRGUZafeodnKdh
 u3bjzYFonUEBgMPjYw73PHQyuy+gCnFaobt+VPFxCXNUqdWr+nyV1PfBx9m1YQBJEWS8 cA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncavc0ph3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:05:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RG5YCH028188
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:05:34 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 08:05:29 -0800
Message-ID: <11a5fa34-c438-a567-6364-4bf1d0d369e3@quicinc.com>
Date:   Fri, 27 Jan 2023 21:35:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/6] regulator: qcom_smd: Add PMIC compatible for IPQ9574
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-5-quic_devipriy@quicinc.com>
 <20230117183835.GA3427325-robh@kernel.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20230117183835.GA3427325-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OpJib9HjT0AC3SHlMMCU7Pkd9gLAiJS4
X-Proofpoint-ORIG-GUID: OpJib9HjT0AC3SHlMMCU7Pkd9gLAiJS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270148
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 12:08 AM, Rob Herring wrote:
> On Fri, Jan 13, 2023 at 08:33:08PM +0530, devi priya wrote:
>> Add mp5496 PMIC compatible string for IPQ9574 SoC
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml  | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>> index 8c45f53212b1..7907d9385583 100644
>> --- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>> @@ -22,7 +22,7 @@ description:
>>     Each sub-node is identified using the node's name, with valid values listed
>>     for each of the pmics below.
>>   
>> -  For mp5496, s2
>> +  For mp5496, s1, s2
>>   
>>     For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
>>     l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
>> @@ -84,6 +84,7 @@ properties:
>>     compatible:
>>       enum:
>>         - qcom,rpm-mp5496-regulators
>> +      - qcom,rpm-ipq9574-mp5496-regulators
> 
> Is this a different part than just mp5496? Or used in a different,
> incompatible way?
IPQ6018 and IPQ9574 platforms use the same PMIC MP5496 but they have a 
different power layout.So, we plan to update the compatible: 
qcom,rpm-mp5496-regulators to 
qcom,rpm-ipq6018-mp5496-regulators(target-specific) in the next patchset 
as the regulators serve different purposes
> 
>>         - qcom,rpm-pm2250-regulators
>>         - qcom,rpm-pm6125-regulators
>>         - qcom,rpm-pm660-regulators
>> -- 
>> 2.17.1
>>
Best Regards,
Devi Priya
