Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF08073ADAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFWAPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFWAPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:15:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF411FDF;
        Thu, 22 Jun 2023 17:15:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N0AAs9006051;
        Fri, 23 Jun 2023 00:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nMfZvSzRH2TbV9TJZ+CkTmJiIbNVMbcnwxPKyzp9vLc=;
 b=mxWV480hV7wR1oBnCFfKmR8FG1I+EZtu1325ABZTCWy2lJB73cIXu1rVzWQFbwnNcOwy
 UQ+VCpVWp4YKCdOzBXRibfa1NwPjuBqQ6o5aqUOUf+5Yyym461xFwYlpkJiI3Cn8TuU0
 mlYsIwHrge7OxOWHKQchzmSpvlSUlLoYPYHMBOskQl3oBWk34yiECv7XusHYpzmnjCKT
 zuRPQCkropJzlbwdDzdhh195XKVHOM3d6IIifTO+SnMHUjxfMkqMysbvhCllPRUdf3Ia
 jH1LCm9xCdENRPRyYRvD+JOOjtGehpUL2uNTNhDVFpTIHP8a7D+5d2HgqX9dE6WUY/Fg HQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcju8291u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 00:15:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N0FRna025305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 00:15:27 GMT
Received: from [10.110.109.161] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 22 Jun
 2023 17:15:26 -0700
Message-ID: <82734575-4dc4-b65b-533b-6a7d7eebacc9@quicinc.com>
Date:   Thu, 22 Jun 2023 17:15:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 20/28] ASoC: dt-bindings: Add Q6USB backend bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-21-quic_wcheng@quicinc.com>
 <499ee440-0c52-bb21-d04d-086aebc0cf4e@linaro.org>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <499ee440-0c52-bb21-d04d-086aebc0cf4e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fcLlSCXP6j2eCOPTqGENQFjIFwAq7SJO
X-Proofpoint-GUID: fcLlSCXP6j2eCOPTqGENQFjIFwAq7SJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_18,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 phishscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306220207
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 3/10/2023 12:54 AM, Krzysztof Kozlowski wrote:
> On 09/03/2023 00:57, Wesley Cheng wrote:
>> Add a dt-binding to describe the definition of enabling the Q6 USB backend
>> device for audio offloading.  The node carries information, which is passed
>> along to the QC USB SND class driver counterpart.  These parameters will be
>> utilized during QMI stream enable requests.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   .../bindings/sound/qcom,q6usb-dais.yaml       | 49 +++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
>> new file mode 100644
>> index 000000000000..8477abc511dd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm ASoC USB backend DAI
>> +
>> +maintainers:
>> +  - Wesley Cheng <quic_wcheng@quicinc.com>
>> +
>> +description:
>> +  The Q6USB backend is a supported AFE port on the Q6DSP. This backend
>> +  driver will communicate the required settings to the QC USB SND class
> 
> What does the "driver" mean? Linux driver? Then drop and focus on
> hardware/Q6DSP.
> 

Sorry for the late reply, was side tracked on some other priorities, and 
reviving this series again.

The driver here is a Linux ASoC based DPCM backend driver, which will 
interface with the CPU dai (q6afe).

>> +  driver for properly enabling the audio stream.  Parameters defined
>> +  under this node will carry settings, which will be passed along during
>> +  the QMI stream enable request.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,q6usb-dais
> 
> Can q6usb mean anything else? Why "-dais" suffix?
> 

As of now, no...will remove the dai suffix.

>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  "#sound-dai-cells":
>> +    const: 1
>> +
>> +  qcom,usb-audio-intr-num:
>> +    description:
>> +      Desired XHCI interrupter number to use.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Why this should be configurable per board or SoC? It's the first use in
> DT and in the same time sounds generic...
> 

Would depend on which interrupter we want to use.  This should be 
configurable per platform in case the audio DSP decides to work off a 
specific interrupter.

Thanks
Wesley Cheng

>> +
>> +required:
>> +  - compatible
>> +  - "#sound-dai-cells"
>> +  - qcom,usb-audio-intr-num
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    dais {
>> +      compatible = "qcom,q6usb-dais";
>> +      #sound-dai-cells = <1>;
>> +      iommus = <&apps_smmu 0x180f 0x0>;
>> +      qcom,usb-audio-intr-num = <2>;
>> +    };
> 
> Best regards,
> Krzysztof
> 
