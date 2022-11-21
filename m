Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58FB632B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiKURil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKURij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:38:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB726321;
        Mon, 21 Nov 2022 09:38:38 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGmAb9006091;
        Mon, 21 Nov 2022 17:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iKJ1+VaYR1MdhFNUFPa6qE5TM94xohJmtN9FFeR/poo=;
 b=MPve2WOZ6VYSELO/qKFgvdNnlSuXDaPoEntMLR7i+uPKj+8AnbvlyrF+E4aSnx1Ljxs0
 PBM6OMNUGm0sU2Rlz8rozEd5W9GpQ4ftOZdAACdHFoai9PfKQLuuBLj4a5bMhRXdhGvS
 Gug9vEDWtCh1VapUYckH9eRQJfgim7qUmat1VJGcbrLlXdHsU0XVVSo05iM5Ky/807zp
 xWi/M3Ef0JuiPCx7ve+uCo+w/ceN+dEu6O1piMiTyonypoH/CkgUE/IN5lYNwe+Y/c/P
 gHd16bRDsyyX3IyVrXLFOogY3jMk5AxKs6YlO/d0H+hP0Sm1QY9Tiwhp6lkZmfUlsJpW eg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrpb520v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 17:38:28 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALHcRaH021333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 17:38:27 GMT
Received: from [10.110.33.239] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 09:38:26 -0800
Message-ID: <07461501-775f-805e-01ba-dd927df57075@quicinc.com>
Date:   Mon, 21 Nov 2022 11:38:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: Add rpmh virt devices
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-2-quic_molvera@quicinc.com>
 <3bc11449-bd5f-f4c4-98da-ebc0d7c8b309@kernel.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <3bc11449-bd5f-f4c4-98da-ebc0d7c8b309@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kJ_1_NB7RnLQ-lXtjVe0kdIcX-pRFFzt
X-Proofpoint-GUID: kJ_1_NB7RnLQ-lXtjVe0kdIcX-pRFFzt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211210134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2022 9:23 AM, Georgi Djakov wrote:
> Hi Melody,
>
> On 18.11.22 20:22, Melody Olvera wrote:
>> Add documentation for virtual rpmh devices. These interconnects
>> are not controlled by the application processor and thus
>> require separate bindings. Also, move compatibles for sm8450 to
>> this document and add them for QDU1000/QRU1000 platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   .../bindings/interconnect/qcom,rpmh-virt.yaml | 55 +++++++++++++++++++
>>   .../bindings/interconnect/qcom,rpmh.yaml      |  2 -
>>   2 files changed, 55 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>> new file mode 100644
>> index 000000000000..5cbaa51df863
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>> @@ -0,0 +1,55 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-virt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm RPMh Virtual Network-On-Chip Interconnect
>> +
>> +maintainers:
>> +  - Georgi Djakov <georgi.djakov@linaro.org>
>
> This email is not valid anymore, so please replace it with djakov@kernel.org.

Sounds good.

Melody
>
> Thanks,
> Georgi
>
>> +  - Odelu Kukatla <quic_okukatla@quicinc.com>
>> +
>> +description: |
>> +   RPMh interconnect providers support system bandwidth requirements through
>> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
>> +   associated with each execution environment. Provider nodes must point to at
>> +   least one RPMh device child node pertaining to their RSC and each provider
>> +   can map to multiple RPMh resources. Virtual interconnect providers are not
>> +   controlled by AP and do not support QoS; they should not have associated
>> +   register regions.
>> +
>> +allOf:
>> +  - $ref: qcom,rpmh-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qdu1000-clk-virt
>> +      - qcom,qdu1000-mc-virt
>> +      - qcom,sm8450-clk-virt
>> +      - qcom,sm8450-mc-virt
>> +
>> +  '#interconnect-cells': true
>> +
>> +required:
>> +  - compatible
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +      #include <dt-bindings/interconnect/qcom,sm8450.h>
>> +
>> +      clk_virt: interconnect-0 {
>> +             compatible = "qcom,sm8450-clk-virt";
>> +             #interconnect-cells = <2>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      mc_virt: interconnect-1 {
>> +             compatible = "qcom,sm8450-mc-virt";
>> +             #interconnect-cells = <2>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
>> index a429a1ed1006..bd474f49deb0 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
>> @@ -123,11 +123,9 @@ properties:
>>         - qcom,sm8350-system-noc
>>         - qcom,sm8450-aggre1-noc
>>         - qcom,sm8450-aggre2-noc
>> -      - qcom,sm8450-clk-virt
>>         - qcom,sm8450-config-noc
>>         - qcom,sm8450-gem-noc
>>         - qcom,sm8450-lpass-ag-noc
>> -      - qcom,sm8450-mc-virt
>>         - qcom,sm8450-mmss-noc
>>         - qcom,sm8450-nsp-noc
>>         - qcom,sm8450-pcie-anoc
>

