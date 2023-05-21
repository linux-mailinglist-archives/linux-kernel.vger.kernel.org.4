Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660F270AF8B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEUScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjEURu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 13:50:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48921720;
        Sun, 21 May 2023 10:44:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LHcPAL017651;
        Sun, 21 May 2023 17:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ztr/IrR1R/TohKTPGnGacnHC39isrkFF359v/DkDe8w=;
 b=NcHUn/ehjZuieWfTQGG6vdUs5zHJbxI6HOjsSnsNQwzxwVN6kNYuw6kr0mWBXshuGily
 +UUQ3gkrFXbHeLZZmWauL4RwxlxPDtwg4pYVY6ulNC/tfnk7v7KnS3gJvogVs/JPopHn
 9gCV4eO8TniX9dtjOZYOLzFQkrCy5KfIQa1BZJrTq6qZhW5LWTWZ4dP2YUPF/D9/c8wm
 O4cL22IJT18cJTWlZj01QlU5o3VYIjpQfYLgBH3VNr6CfNx9hHEv9nlis6W3ZdkbWuM+
 ozvTKAlXfUh0xQZ+S5PbT0XxrSfSffvuEWG0Taf1lWU8lq+VE3l07B/gCrHmfUVPMja6 cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpqctsy02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 17:44:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LHidtL030413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 17:44:39 GMT
Received: from [10.216.45.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 10:44:31 -0700
Message-ID: <202568ee-5bf0-1726-820a-5fb747969893@quicinc.com>
Date:   Sun, 21 May 2023 23:14:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
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
 <9de5629f-0a69-7b5b-c312-ab6fe19d60f8@quicinc.com>
 <fdb8e5a9-d8a0-1881-894f-1202ceefcc21@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <fdb8e5a9-d8a0-1881-894f-1202ceefcc21@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BvZwTcxkdB5K8xursqQddjOTT8QXNbi9
X-Proofpoint-GUID: BvZwTcxkdB5K8xursqQddjOTT8QXNbi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=740 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210158
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/2023 9:57 PM, Krzysztof Kozlowski wrote:
> On 03/05/2023 12:59, Manikanta Mylavarapu wrote:
>>
>>
>> On 3/7/2023 6:53 PM, Rob Herring wrote:
>>>
>>> On Tue, 07 Mar 2023 10:11:27 +0530, Manikanta Mylavarapu wrote:
>>>> Add new binding document for multipd model remoteproc.
>>>> IPQ5018, IPQ9574 follows multipd model.
>>>>
>>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>>> ---
>>>>    .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++++++++++++
>>>>    1 file changed, 282 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.example.dts:22:18: fatal error: dt-bindings/clock/qcom,gcc-ipq5018.h: No such file or directory
>>>      22 |         #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>>         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> compilation terminated.
>>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.example.dtb] Error 1
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [Makefile:1512: dt_binding_check] Error 2
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com
>>>
>>> The base for the series is generally the latest rc1. A different dependency
>>> should be noted in *this* patch.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit after running the above command yourself. Note
>>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>>> your schema. However, it must be unset to test all examples with your schema.
>>>
>>
>> I mentioned dependency link
>> (https://lore.kernel.org/linux-arm-msm/20220621161126.15883-1-quic_srichara@quicinc.com/)
>> in cover page patch because it's required for entire series. I will add
>> dependency link's and raise new patchset.
> 
> Is the dependency merged for v6.4-rc1? Looks not, so this means the
> patch cannot be merged for next three months.
> 
> Why do you need any dependency here in this binding?
> 
> Best regards,
> Krzysztof
> 

Since i removed gcc clocks from DTS nodes, dt-bindings are not required.
I will remove it.

Thanks & Regards,
Manikanta.
