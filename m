Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167A06F3F31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjEBIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjEBIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:36:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BD53C0C;
        Tue,  2 May 2023 01:36:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3425sB1B026504;
        Tue, 2 May 2023 08:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=en/rqbzVDVFW3N4jmBnPEFVCyRAdO2t3jK2BNMgSnT4=;
 b=fCIM3+m8T2rVdO6zyvyBpQtX1RCG8JyBZ048tsSnEOnZkuw5+nt7d/H6K7Gmpn5gcMyF
 wVmYkqkrABBIQWGMARUwAh7R38l/b5HIyagcq08Bz8R/hbrR5WiPtfRZvqCt2avFxloy
 kPOCWxDMPK7F9jANVKEG0cZDQC7ONW23vreh0bNvS1ZFom2gmpe552p7ZO5yH5Jfy6/l
 NfFQdD2vl36TeRl4VBBwZAdr9hLRDUm1s+7vNjOL/opst1eYXOyxmJ6p8DYXnOjLN6vZ
 B1IZzAj2wCRsaK/MuehS6Uxi0rYki83QGLnAO/hVepvYpE7bu247OZwCXlwS1jcsFDkG bA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qaj3whejd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 08:35:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3428ZRdu017247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 May 2023 08:35:27 GMT
Received: from [10.216.63.8] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 2 May 2023
 01:35:21 -0700
Message-ID: <a001c9c0-f186-f125-daab-e646790badfe@quicinc.com>
Date:   Tue, 2 May 2023 14:05:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 1/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-2-quic_kriskura@quicinc.com>
 <df24efb2-8279-ef15-a118-2a24885288c8@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <df24efb2-8279-ef15-a118-2a24885288c8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J0WQoSAGcmx7nxtxjsXEi25MzVRR-PSP
X-Proofpoint-ORIG-GUID: J0WQoSAGcmx7nxtxjsXEi25MzVRR-PSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=954 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020075
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2023 1:18 PM, Krzysztof Kozlowski wrote:
> On 01/05/2023 16:34, Krishna Kurapati wrote:
>> Add the compatible string for SC8280 Multiport USB controller from
>> Qualcomm.
>>
>> There are 4 power event irq interrupts supported by this controller
>> (one for each port of multiport). Added all the 4 as non-optional
>> interrupts for SC8280XP-MP
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   .../devicetree/bindings/usb/qcom,dwc3.yaml    | 21 +++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> index d84281926f10..2c96da1ce5b8 100644
>> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> @@ -26,6 +26,7 @@ properties:
>>             - qcom,sc7180-dwc3
>>             - qcom,sc7280-dwc3
>>             - qcom,sc8280xp-dwc3
>> +          - qcom,sc8280xp-dwc3-mp
> 
> SC8280xp comes with two USB controllers: one single-port and one multi-port?

Hi Krzysztof,

   SC8280XP comes with 3 controllers. The first two are single port 
controller and the third one is a multiport controller. In DTSI:
usb_0 / usb1: have compatible set to : "qcom,sc8280xp-dwc3"

And multiport controller has it set to "qcom,sc8280xp-dwc3-mp"


>>             - qcom,sdm660-dwc3
>>             - qcom,sdm670-dwc3
>>             - qcom,sdm845-dwc3
>> @@ -455,6 +456,26 @@ allOf:
>>               - const: dm_hs_phy_irq
>>               - const: ss_phy_irq
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sc8280xp-dwc3-mp
> 
> You miss entries for all other constraints.
>
Let me add the clock properties as well.

Regards,
Krishna,
