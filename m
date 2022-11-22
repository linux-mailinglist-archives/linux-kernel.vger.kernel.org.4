Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5138163431F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiKVR6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiKVR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:58:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B00E5F;
        Tue, 22 Nov 2022 09:57:33 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMHcrOl018112;
        Tue, 22 Nov 2022 17:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QC+M5hYOgPISCcR+K8EBr4ak/FF/squ8OZ69sQubXS0=;
 b=ERhGTWhPnrCayuyQ/TXvDsyNmDGMcm4/GCOFB3jM+EiTKIInA0qEjBIqM4BoZCtSwgB1
 z0518aQSTFRdk/9pnEyANFBMmUCfFqFToD3qe5+BXN9lwcCEFgsMX6sVToU85IS6kHgk
 XiVxKgVRCzsJFHPNXoRzLnHwxQhXoYb924S4SUHEEpeof5QanxUk63ZY7fj7Xs+iTcHV
 eNSzS9jkoua4+nv8240gwR8o+rioaJ85j3xOKU8+DXv/x+FehlXVbfnB+CzV/WOKPBBC
 fTptL4aq903UnpGwvRIysf/r9D/JDUv9mutzVcoHCe0pTV1ZGNS6s9cAEtbm1QAFdHN/ kA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m0twq9965-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 17:57:23 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AMHvMGJ032066
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 17:57:22 GMT
Received: from [10.110.109.32] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 22 Nov
 2022 09:57:21 -0800
Message-ID: <e6ae7c01-47ca-f1da-3b0b-1f17d9e862bf@quicinc.com>
Date:   Tue, 22 Nov 2022 11:57:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: Add rpmh virt devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-2-quic_molvera@quicinc.com>
 <536af0d9-aa00-ddf1-753d-670ec2adef91@linaro.org>
 <3ada611b-96e0-5cf0-d79d-b90ca4202ddb@quicinc.com>
 <b7cc4f5d-c1d6-919c-9604-7855ea802d17@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <b7cc4f5d-c1d6-919c-9604-7855ea802d17@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RVBrSxMnNV_hb3ZYQ5poZWgop4M6XRe8
X-Proofpoint-ORIG-GUID: RVBrSxMnNV_hb3ZYQ5poZWgop4M6XRe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211220138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/2022 1:50 AM, Krzysztof Kozlowski wrote:
> On 21/11/2022 18:39, Melody Olvera wrote:
>>
>> On 11/20/2022 5:13 AM, Krzysztof Kozlowski wrote:
>>> On 18/11/2022 19:22, Melody Olvera wrote:
>>>> Add documentation for virtual rpmh devices. These interconnects
>>>> are not controlled by the application processor and thus
>>>> require separate bindings. Also, move compatibles for sm8450 to
>>>> this document and add them for QDU1000/QRU1000 platforms.
>>>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
>>>>  .../bindings/interconnect/qcom,rpmh-virt.yaml | 55 +++++++++++++++++++
>>>>  .../bindings/interconnect/qcom,rpmh.yaml      |  2 -
>>>>  2 files changed, 55 insertions(+), 2 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>>>> new file mode 100644
>>>> index 000000000000..5cbaa51df863
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>>>> @@ -0,0 +1,55 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-virt.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm RPMh Virtual Network-On-Chip Interconnect
>>>> +
>>>> +maintainers:
>>>> +  - Georgi Djakov <georgi.djakov@linaro.org>
>>>> +  - Odelu Kukatla <quic_okukatla@quicinc.com>
>>>> +
>>>> +description: |
>>>> +   RPMh interconnect providers support system bandwidth requirements through
>>>> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>>>> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
>>>> +   associated with each execution environment. Provider nodes must point to at
>>>> +   least one RPMh device child node pertaining to their RSC and each provider
>>>> +   can map to multiple RPMh resources. Virtual interconnect providers are not
>>>> +   controlled by AP and do not support QoS; they should not have associated
>>>> +   register regions.
>>>> +
>>>> +allOf:
>>>> +  - $ref: qcom,rpmh-common.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - qcom,qdu1000-clk-virt
>>>> +      - qcom,qdu1000-mc-virt
>>>> +      - qcom,sm8450-clk-virt
>>>> +      - qcom,sm8450-mc-virt
>>> You should also move qcom,sdx65-mc-virt, qcom,sc8280xp-mc-virt,
>>> qcom,sc8280xp-clk-virt and more.
>> Ok. I wasn't sure since some of these entries don't seem to conform to
>> these bindings, even though it seems they should.
> I have impression that devices I listed conform to these bindings, this
> is why I listed them. But if you are sure that they do not, then they
> should not be moved.

You're correct; those you listed do conform to the new bindings and should be moved.
I also caught qcom,sc7280-clk-virt which needs to be moved. I'll add to the new bindings.

Thanks,
Melody
>
> Best regards,
> Krzysztof
>

