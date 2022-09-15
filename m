Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84835B9A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiIOLpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiIOLlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD796883DE;
        Thu, 15 Sep 2022 04:40:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FBK146024541;
        Thu, 15 Sep 2022 11:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E3MrDkTHmuBCy5QlsMQnKlQbZ/dFxx5N9QFPDhXjej0=;
 b=RXfJVwol+a9je09F5RRAn6LzMT8X2h23l9d/aDmENpb0bEhimZ0tgxTMVEy1u3zC0nFH
 q8NtUE5e0trizJY3f2GhU6pec7qxdEe70IJqu//Pyjqmn0xGbeTfg2rwKC8PqEFnZsgE
 tLObLIK0qqY8M6vFkvvnrUtE/KDhHGAiLbJ6IQPF4mfNHxcATcgdRvCb+94zbFasmJnk
 QMXjAx4fsWwA+UYtuwl5WVGu9whlROhZjLwDExbnafS8uow0VtqiXKxNN7pCkLnbKi4n
 Y/0DQKw45ZTjVzbbbx7Gi6Hg75m3YRkqm+8k0+GHimBqfTzOZOLd0eZIg3KP1OjSst3E AA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm334r214-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 11:40:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28FBZHWk011027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 11:35:17 GMT
Received: from [10.79.142.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 04:35:13 -0700
Message-ID: <85b71c83-feba-bfd8-a60e-585474239485@quicinc.com>
Date:   Thu, 15 Sep 2022 17:05:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V9 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1663173477.git.quic_schowdhu@quicinc.com>
 <41b94746e1560d63f16fb5dc965042ec496aeaf1.1663173478.git.quic_schowdhu@quicinc.com>
 <20220915033540.jb4q4bjd3oomsfl4@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20220915033540.jb4q4bjd3oomsfl4@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UDbo3yZYEYeawnwLo4ziq7TcuFZcdKTg
X-Proofpoint-GUID: UDbo3yZYEYeawnwLo4ziq7TcuFZcdKTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150065
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/15/2022 9:05 AM, Bjorn Andersson wrote:
> On Wed, Sep 14, 2022 at 10:31:11PM +0530, Souradeep Chowdhury wrote:
>> Documentation for Data Capture and Compare(DCC) device tree bindings
>> in yaml format.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 43 ++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
>> new file mode 100644
>> index 0000000..b7a6619
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/msm/qcom,dcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Data Capture and Compare
>> +
>> +maintainers:
>> +  - Souradeep Chowdhury <schowdhu@codeaurora.org>
> Please update your email address.
Ack
>
>> +
>> +description: |
>> +    DCC (Data Capture and Compare) is a DMA engine which is used to save
>> +    configuration data or system memory contents during catastrophic failure
>> +    or SW trigger. DCC is used to capture and store data for debugging purpose
> An empty line inbetween description and properties would be nice.
Ack
>
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,sm8150-dcc
>> +          - qcom,sc7280-dcc
>> +          - qcom,sc7180-dcc
>> +          - qcom,sdm845-dcc
>> +      - const: qcom,dcc
>> +
>> +  reg:
>> +    items:
>> +      - description: DCC base register region
>> +      - description: DCC RAM base register region
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    dma@10a2000{
>> +                compatible = "qcom,sm8150-dcc","qcom,dcc";
>> +                reg = <0x010a2000  0x1000>,
>> +                      <0x010ad000  0x2000>;
> Please remove the double space between address and size.
Ack
>
> Regards,
> Bjorn
>
>
>> +    };
>> -- 
>> 2.7.4
>>
