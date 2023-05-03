Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A616F56AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjECLAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjECLAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:00:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8153649DE;
        Wed,  3 May 2023 03:59:59 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3439oQNL020511;
        Wed, 3 May 2023 10:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=61I/qHVeaDrVGfByyTdO3IToeDPjIKC0Vq4EoJrP05g=;
 b=aJfdyJNgbkxy6juGv76E1/HoyOSfscT8VtxNa48kp4ElG6qu9ELD/BTDALw3qPxycn3V
 GoAHIZChwwxfIKiDhBz7Ht7pfR/9k4jJVxPidWYrATNhNCuLxkl/6XXih82riQu6MstP
 F4wKHIwEnT2ovYGtrKjW48BmmIx/hJQpAY9sAgvISv0P3dPJ/X31MPGAr8c5jSiTNcif
 G61Q1dpbxJpLQdVoJCWtzksSPMKS8b0wn3YmvU9h9+L0w0bEgXaRJr1gdSUqMZEn/Rsm
 PY+4aHhLx4j79oxTe2Au0DNdtCig7SsoqOKfcSDlO+FCz+6zn00sFi9EDuN1JuMresmT BA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbeb2s512-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 10:59:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343AxKsq022293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 10:59:20 GMT
Received: from [10.242.242.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 03:59:09 -0700
Message-ID: <9de5629f-0a69-7b5b-c312-ab6fe19d60f8@quicinc.com>
Date:   Wed, 3 May 2023 16:29:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
To:     Rob Herring <robh@kernel.org>
CC:     <quic_sjaganat@quicinc.com>, <quic_gurus@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>, <jassisinghbrar@gmail.com>,
        <konrad.dybcio@linaro.org>, <quic_eberman@quicinc.com>,
        <quic_poovendh@quicinc.com>, <robimarko@gmail.com>,
        <mturquette@baylibre.com>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <quic_arajkuma@quicinc.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <loic.poulain@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_kathirav@quicinc.com>, <agross@kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
 <167819522915.3831.12765243745569076133.robh@kernel.org>
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <167819522915.3831.12765243745569076133.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -1i42SqUw0sue0zOijKvfEfpXK-YxAtg
X-Proofpoint-GUID: -1i42SqUw0sue0zOijKvfEfpXK-YxAtg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=962 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305030092
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 6:53 PM, Rob Herring wrote:
> 
> On Tue, 07 Mar 2023 10:11:27 +0530, Manikanta Mylavarapu wrote:
>> Add new binding document for multipd model remoteproc.
>> IPQ5018, IPQ9574 follows multipd model.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++++++++++++
>>   1 file changed, 282 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.example.dts:22:18: fatal error: dt-bindings/clock/qcom,gcc-ipq5018.h: No such file or directory
>     22 |         #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1512: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com
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

I mentioned dependency link 
(https://lore.kernel.org/linux-arm-msm/20220621161126.15883-1-quic_srichara@quicinc.com/) 
in cover page patch because it's required for entire series. I will add 
dependency link's and raise new patchset.

Thanks & Regards,
Manikanta.

