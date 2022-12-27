Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B1656C85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiL0P1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiL0P05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:26:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB2BE29;
        Tue, 27 Dec 2022 07:26:15 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRFHU7i008363;
        Tue, 27 Dec 2022 15:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cQuov8Lsh/tXQZFD39e9xtjcqLKxIfKQlLX3E4n7Biw=;
 b=XXGFz2Q/iZ2aKDdAXYwp9BAWjCdh8+kDJLQj5v1DhXuURLtcD1V+abkFYmVNhXcT+cZc
 +SbmfvEHCU1vp9bdbXBnczc0EmxC3UmsgaMZEqi9hgeY5R5Oe2fw1T28tm7qVVD6BFFY
 TreRgCL7xAul4+u1ZNCv56RwR8RAIf1Penv7k3etzXqVqxd0UfqUYwsQdVB+xlb3W/QD
 w+jaZy7nOqS/guaAGsoWnBKy/OCt5x9PgHGhaZ+ICZnjdN2YTxgX5myTsVn8kaU4kGxq
 hP0qSAYD0VBaPK14JDanCktEciYf4WjtpktYKPaUsITUbwV5GA0sYkoA55QbuGvkhxL+ Aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnrrrwesj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 15:26:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRFQ26Q016618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 15:26:02 GMT
Received: from [10.50.35.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 07:25:56 -0800
Message-ID: <18bf4ed9-bb12-aed8-4746-e7c7549769d3@quicinc.com>
Date:   Tue, 27 Dec 2022 20:55:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V20 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1672068481.git.quic_schowdhu@quicinc.com>
 <fd3b99b07bd40612a76313429635026471d273ef.1672068481.git.quic_schowdhu@quicinc.com>
 <38352fbb-663f-71f7-b7ef-d539b98fc423@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <38352fbb-663f-71f7-b7ef-d539b98fc423@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hT04q8f8EPGySm3XWtJeXpOC9gCuiou7
X-Proofpoint-ORIG-GUID: hT04q8f8EPGySm3XWtJeXpOC9gCuiou7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_11,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270126
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/27/2022 1:51 PM, Krzysztof Kozlowski wrote:
> On 26/12/2022 17:52, Souradeep Chowdhury wrote:
>> Documentation for Data Capture and Compare(DCC) device tree bindings
>> in yaml format.
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
> 
> Subject: drop second, redundant "bindings". Drop "yaml" (also unrelated).
> 
> Use proper imperative mode.
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Ack

> 
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,dcc.yaml     | 44 ++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
>> new file mode 100644
>> index 0000000..ac3b51b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/qcom/qcom,dcc.yaml#
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
>> +      - description: DCC base
>> +      - description: DCC RAM base
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
>> +        compatible = "qcom,sm8150-dcc","qcom,dcc";
> 
> Missing space between compatibles.

Ack

> 
> Best regards,
> Krzysztof
> 
