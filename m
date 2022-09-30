Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCFD5F056C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiI3G7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiI3G7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:59:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E0015310E;
        Thu, 29 Sep 2022 23:59:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U5tNs5011884;
        Fri, 30 Sep 2022 06:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=o+YszxrPx9l4f74GsAYZWD0dsHTxUJWQjCh1lHQqfFc=;
 b=T+j5QXGN/ahUcol6/eYJFJUF5yWwayAKfUi8m8q8vd1F7jLE4rxfwVFeO14x8Qr91khU
 j5tmmMRZa62ShC1A5zlcKEqlllIcscxd1/j+PBOS+xdsB4yty6RXbwgI0LgCSkVcM48n
 1vcygy/1Ye0M0qrRkr9lNfwke+V6u8UUqk64wzk+LBneEYxfa6M/en40k8Gi2B2RNWlm
 ZxkTozn/ri0J10gGLWLeGLhj0xzwLMAIvXc/s3Ev1XyANShiGMRw6qB5TzPynS3gpBH4
 8ln2sUTqosGSubjUpKhCp+cxIajhdpo6f0j3TljoxZ4sDN/s/LrRUEMZ7eaTwNUoo7dQ dA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwqj68qa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 06:59:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28U6xJ8g015802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 06:59:19 GMT
Received: from [10.110.86.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 23:59:14 -0700
Message-ID: <78b42aab-164a-7fe6-fec5-77f52199c641@quicinc.com>
Date:   Fri, 30 Sep 2022 12:29:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V14 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1664383851.git.quic_schowdhu@quicinc.com>
 <e320555b2075c94946ef3f9c78732dc84ba39449.1664383851.git.quic_schowdhu@quicinc.com>
 <4d0f7a01-1995-1b1e-40b9-125c3447b8c7@kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <4d0f7a01-1995-1b1e-40b9-125c3447b8c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gBPrds6aJzH4vM4amIIV640m0R1GTelu
X-Proofpoint-ORIG-GUID: gBPrds6aJzH4vM4amIIV640m0R1GTelu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_03,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300042
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/2022 11:00 PM, Krzysztof Kozlowski wrote:
> On 28/09/2022 19:11, Souradeep Chowdhury wrote:
>> Documentation for Data Capture and Compare(DCC) device tree bindings
>> in yaml format.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> I asked last time and there was just partial improvement, so let me be
> clear: you must rebase on latest kernel and use scripts/get_maintainers.pl.
>
> I am repeating myself, which should not be actually needed... but then
> maybe my comment was not accurate? If so, please post the output of `git
> describe` and `scripts/get_maintainers.pl __on_your_patches__` and let's
> go line by line...

Apologies for the incomplete list.

I had re-based this patch on top of "for-next" branch of the kernel 
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git.

My git describe shows something like as follows

qcom-arm64-for-6.1-173-gd92bd73

Also the ./script/maintainers.pl gives the below output

Souradeep Chowdhury <quic_schowdhu@quicinc.com> (maintainer:DCC QTI 
DRIVER,in file)
Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED 
DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN 
FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-arm-msm@vger.kernel.org (open list:DCC QTI DRIVER)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE 
TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)

Will send out the next version accordingly, let me know in case of any 
further concerns.

>
>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,dcc.yaml     | 44 ++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
>> new file mode 100644
>> index 0000000..8396b0c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/msm/qcom,dcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Data Capture and Compare
>> +
>> +maintainers:
>> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +
>> +description: |
>> +    DCC (Data Capture and Compare) is a DMA engine which is used to save
>> +    configuration data or system memory contents during catastrophic failure
>> +    or SW trigger. DCC is used to capture and store data for debugging purpose
>> +
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
> odd indentation. Use 4 spaces for example indentation.
Ack
>
>> +                reg = <0x010a2000 0x1000>,
>> +                      <0x010ad000 0x2000>;
>> +    };
> Best regards,
> Krzysztof
>
