Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDAF6E2328
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDNMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDNMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:24:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF371A5FF;
        Fri, 14 Apr 2023 05:24:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E9lFO7022994;
        Fri, 14 Apr 2023 12:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pqyS/E+fAXfmZ5w2wnzFquSznzpHBl4xOf1s85tuNzQ=;
 b=Qk4q5RmBr9UK9/0IRWOpAMKuTBYKZyf4xLQ7+7CTJMebAQFkTNflrOpVCyU+GTxziTr7
 K5+AC4DMYPQVp3MeQPepHErDqFsN1uLR3Q88MWJU3e1emiwGCU6+PgXqrhAUjkL6C4rC
 69EXfk80kup67Nx4S+kUGxF1pwR+cZisF+NKZ0flNIBgJwiX06DZ+svIH2LkqSYvAmAz
 qpV5b4+iqU6UncKDmo2NqPr9R5Y2BSX5ZJ3JCCOGVPi+f+OkWAlEe97E8qRF+RFkT7y4
 hzyJjVGP7ovrgeejGF3Uwlw+QDRROKit++qJKrISxr8eW7DhAmuAeSizI9wZLdJZmiMI DA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py4ghr84g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 12:24:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ECO2OV025138
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 12:24:02 GMT
Received: from [10.131.117.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 05:23:59 -0700
Message-ID: <b44bedcf-2272-9f9f-0f11-ca9894567e9a@quicinc.com>
Date:   Fri, 14 Apr 2023 17:53:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681375949.git.quic_schowdhu@quicinc.com>
 <0e48ef5a9558c0bab5c2918af3c15ed4425b07be.1681375949.git.quic_schowdhu@quicinc.com>
 <58bf68b4-dad4-64dc-6eee-9f6cc154c1ca@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <58bf68b4-dad4-64dc-6eee-9f6cc154c1ca@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KdxEp5ixl-SpNqg15kkJ5P4feSJgacFy
X-Proofpoint-ORIG-GUID: KdxEp5ixl-SpNqg15kkJ5P4feSJgacFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=739 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304140112
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2023 10:11 PM, Krzysztof Kozlowski wrote:
> On 13/04/2023 11:28, Souradeep Chowdhury wrote:
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +  "^stats@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Imem region dedicated for storing timestamps related
>> +      information regarding bootstats.
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - enum:
>> +              - qcom,sm8450-bootstats
>> +          - const: qcom,imem-bootstats
>> +
>> +      reg:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +
>> +    additionalProperties: false
> 
> The feedback about additionalProperties was given in different place. On
> purpose, because it is easier to read when it is placed before
> properties for indented cases. Therefore move it after description, how
> I originally asked.

Ack

> 
>> +
>>   required:
>>     - compatible
>>     - reg
> 
> Best regards,
> Krzysztof
> 
