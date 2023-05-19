Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FC7096AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjESLjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjESLjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:39:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58C1B0;
        Fri, 19 May 2023 04:39:40 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J9DQFZ007174;
        Fri, 19 May 2023 11:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eeQWFoNUG3iVp0gKDbp6/d9ic7+cwuVI2OVMfXfYih4=;
 b=c5rOljuS0WHCfdwNShVHzDwZNyGKQQbPWeCSS/lNm1Fden8Nli8ZihbcH/czfFsIJENf
 SposCV8Gx8NT0dhvhqVl8CGbAd17Tso8wzQz3m5CiJhzlssw4G3nwG1SecMbvUMwNLA5
 gQvppKR8+I7NrKwgcar6wI3Fv84kp/ywtsyFDpuv0oudgLHudmBbk4RDJxNxGVXMcmvK
 l2yolkNh8dvVJv6FtHaJENU/lbk797B0e02plUz2CxBPFZT6duv/2FyvWr7opIV96a5d
 9yZiRZtMyWxhv7SNFGXlo8uVk0zUqyYn6oaonRrhITrdEw+89TgxF3saWrLPpV+7b50A fA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp69u07u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:39:31 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JBdUXr010051
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:39:30 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 04:39:26 -0700
Message-ID: <94a7a26d-ddb6-81ba-d44a-da23cfb60b2f@quicinc.com>
Date:   Fri, 19 May 2023 17:09:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the
 QDU1000/QRU1000 compatible
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-2-quic_kbajaj@quicinc.com>
 <94e1e91d-e36a-215e-2395-6212c1694dd3@linaro.org>
Content-Language: en-US
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <94e1e91d-e36a-215e-2395-6212c1694dd3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HJ7tC3e_M_k9t-0PP2SD3itSP9DeV6Sj
X-Proofpoint-GUID: HJ7tC3e_M_k9t-0PP2SD3itSP9DeV6Sj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190097
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2023 3:37 PM, Bhupesh Sharma wrote:
>
> On 5/19/23 2:21 PM, Komal Bajaj wrote:
>> Document the compatible for SDHCI on QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml 
>> b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> index 4f2d9e8127dd..f51a38b12d6f 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>> @@ -55,6 +55,7 @@ properties:
>>                 - qcom,sm8350-sdhci
>>                 - qcom,sm8450-sdhci
>>                 - qcom,sm8550-sdhci
>> +              - qcom,qdu1000-sdhci
>
> Please add new entries in alphabetical order.
Noted.
>
> Thanks,
> Bhupesh
>
>>             - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>>
>>     reg:
>> -- 
>> 2.17.1
>>

