Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9C6BE303
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCQIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCQIVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:21:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3622CC79;
        Fri, 17 Mar 2023 01:20:46 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7ak6S022063;
        Fri, 17 Mar 2023 08:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Odofb5S5iKcbSwRiPERtF/5jDQN1KT0/kHOd9jsZRgU=;
 b=iYR+q1WYoEz/YDSqifHS0+uJM+A/ikf1sVGG6KF85wZXCX3CjS8WcxwyLonsLqeodyMO
 Vkx0Yenv2N3VkTkdvj6UpfwfvX5uw2XsFFioYBiJD9SHF4UfZDJCMFRXx41Gw7UhOJkz
 rDK7xqOShKaQdQ5sDM/lJuQIiyYBMVbjnnrF0qC22xdTU8q0wLSX4zj09n5mcRRWCrFr
 4DGh4pj7jRTa9DPad9ralBHrE7Mbs8Sj3FGrefmg3BXq4Rn9rfcNPt913OZCskZ9CnZO
 8YSmBmR92b4wVKWffQwQ2ygb2FHbF4TDqT2mgqonriIFaGX2Y4Hrpekge7tmdMCrtJR6 /Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pcbas9972-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:19:39 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32H8JcYl029041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:19:38 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Mar
 2023 01:19:32 -0700
Message-ID: <d2ecff94-e608-fcca-f82c-e8e488f4288d@quicinc.com>
Date:   Fri, 17 Mar 2023 16:19:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML
 schema
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, <linux-doc@vger.kernel.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        <coresight@lists.linaro.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, <devicetree@vger.kernel.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20230316032005.6509-1-quic_hazha@quicinc.com>
 <20230316032005.6509-3-quic_hazha@quicinc.com>
 <167897435275.2729718.16512739524975963906.robh@kernel.org>
Content-Language: en-US
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <167897435275.2729718.16512739524975963906.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KT0SzSRxfq3sZW8Zt9NQP-Gm5Hd8OwZ9
X-Proofpoint-ORIG-GUID: KT0SzSRxfq3sZW8Zt9NQP-Gm5Hd8OwZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=777 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 9:53 PM, Rob Herring wrote:
> 
> On Thu, 16 Mar 2023 11:20:04 +0800, Hao Zhang wrote:
>> Add new coresight-dummy.yaml file describing the bindings required
>> to define coresight dummy trace in the device trees.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   .../bindings/arm/qcom,coresight-dummy.yaml    | 129 ++++++++++++++++++
>>   1 file changed, 129 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml:91:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml: required:4: {'oneOf': ['qcom,dummy-sink', 'qcom,dummy-source']} is not of type 'string'
> 	from schema $id: http://json-schema.org/draft-07/schema#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml: ignoring, error in schema: required: 4
> Documentation/devicetree/bindings/arm/qcom,coresight-dummy.example.dtb: /example-0/dummy_sink: failed to match any schema with compatible: ['qcom,dummy']
> Documentation/devicetree/bindings/arm/qcom,coresight-dummy.example.dtb: /example-1/dummy_source: failed to match any schema with compatible: ['qcom,dummy']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230316032005.6509-3-quic_hazha@quicinc.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Hi Rob,

Thanks for your check.
I have checked it and didn't see the above errors, will follow your 
steps and change this in the next version of patch.

Thanks,
Hao
