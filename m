Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A25634016
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiKVPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiKVPXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:23:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333D20F42;
        Tue, 22 Nov 2022 07:23:43 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMDjBxO001933;
        Tue, 22 Nov 2022 15:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q7ZjNfTJzfwKzx48mpBS6iFDtNLUI7sNoo3WFNK1EI8=;
 b=RkoX7f5AMlEJiz/WOH3bRVxqOOcSr0cCgnbDpqXehlz8lTfEohXf8yL5aa8m3UDIZIQS
 TXushe1Qe4GSti+8Q61lM4ceeM7u1YaYPBfkWfEnnTHIiUYWzcqqMrE1fbUc/1MPcCx/
 wn5TnBbFJsGFGfwvo6FkD76UdRVW5dHmNLjZRX9ovvrB6//Qt6o97UkxUPz/L4clejrJ
 3M+o+L5YD3U/k4lbaUoyfCyhPgQLxmcQ/ob29qvQR6HsI9nMKovfEaKcTBEKPMJIabJ6
 91N9rxRvxoLi37Cv/vrekG+XfYpbiYiZ3GoSGe5g/XdOkcDdBCCZyBtA6R2E6kZdSiWM oQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m0hwpa2mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 15:23:38 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AMFNbOT008091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 15:23:37 GMT
Received: from [10.110.15.183] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 22 Nov
 2022 07:23:36 -0800
Message-ID: <2a50b68f-d2dd-bae5-29b3-f608813d5a3f@quicinc.com>
Date:   Tue, 22 Nov 2022 09:23:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
 <20221118182039.29236-2-quic_molvera@quicinc.com>
 <528648f2-17df-ab19-8ad4-76423bbc0ae4@linaro.org>
 <faf2d137-efab-93ab-f325-1fa507f166a7@quicinc.com>
 <03174a04-440d-a840-1e54-fbdbdfe296c3@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <03174a04-440d-a840-1e54-fbdbdfe296c3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Un3uGb_kciHmoMf7AZDU0lFkBTTBcM31
X-Proofpoint-ORIG-GUID: Un3uGb_kciHmoMf7AZDU0lFkBTTBcM31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_09,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211220115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/2022 1:48 AM, Krzysztof Kozlowski wrote:
> On 21/11/2022 21:38, Melody Olvera wrote:
>>
>> On 11/20/2022 4:58 AM, Krzysztof Kozlowski wrote:
>>> On 18/11/2022 19:20, Melody Olvera wrote:
>>>> Add device tree bindings for QDU1000 and QRU1000 TLMM devices.
>>>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
>>>>  .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 134 ++++++++++++++++++
>>>>  1 file changed, 134 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>> new file mode 100644
>>>> index 000000000000..cb0c496d8666
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>> @@ -0,0 +1,134 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
>>>> +
>>>> +maintainers:
>>>> +  - Melody Olvera <quic_molvera@quicinc.com>
>>>> +
>>>> +description: |
>>>> +  This Top Level Mode Multiplexer block (TLMM) is found in the QDU1000 and
>>>> +  QRU1000 platforms.
>>> It's better to keep consistent style which allows to do easy
>>> search/replace, than to have new files using their own sentences. So
>>> keep it the same as was unified in few recent commits.
>> Ok... Just making sure that's what you want. Last PS you gave comments to change
>> the wording of this description to remove "This binding describes..." as we've done
>> in all the other qcom pinctrl/tlmm bindings. I can change the wording back to the
>> original, just want to be clear here.
> I propose to have the same wording as other Qualcomm TLMM bindings,
> however you changed it to something not the same. Therefore I wonder -
> why having here different wording than all other bindings?
>
> By going back to original - what do you mean? If it matches all others,
> then yes, but I doubt it.
>
> Just to be sure - are you working on proper (recent) trees or something old?

Original matched how it was done on other Qualcomm TLMM bindings. Feedback
was to drop "This binding describes..." from [1], but all the Qualcomm TLMM
bindings start with "This binding describes...". I'm looking at qcom tree for-next
branch; should be recent, no?

[1] https://lore.kernel.org/all/37c53d8c-2810-509a-7404-7ca24d79fed8@linaro.org/

Thanks,
Melody

>
> Best regards,
> Krzysztof
>

