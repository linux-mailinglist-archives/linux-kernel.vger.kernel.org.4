Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E834E741CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjF2ANt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjF2ANq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:13:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9AF172D;
        Wed, 28 Jun 2023 17:13:44 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SNdEZO028785;
        Thu, 29 Jun 2023 00:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=07Q9n8UY5r3S6q0cTSPNKpRgaZmeE5KxbFtqeXElQ8E=;
 b=M7oIgLJuQCJtoaO0lO3sGDkFGPtSG8jk1gGHBEATpNVHONvPzrL6fMDgCkGtZrMLXLAw
 ZaD5qKamTxkJ9ZrBhFfNMleO6N8Q1YTuuT9vwL0FReStdhidZhPA06lst+lMF4jIje2h
 JZZCPdtNm97YVr1qELodXJRpeO1yGxXMirRDCMq6d4UhfPvPhIxNVf+/p+lqGZ4uAaWw
 sCFL2bcIMtULgt8fwGeeVG58f8wD7d+qHuwLool/LnDIO3wQw2v/k1YeHITyxm+xruQQ
 QQb9UQnPROCC8Rjicn3AzOvlxIyWRNCA7xKnIhBMMu4F50bV8ixuOTO4IVYCm96Df9Vc hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgemk25ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 00:13:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T0DTwk029777
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 00:13:29 GMT
Received: from [10.110.20.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 28 Jun
 2023 17:13:29 -0700
Message-ID: <cb7630b4-4953-31df-faeb-a54f7757c1af@quicinc.com>
Date:   Wed, 28 Jun 2023 17:12:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LUT
 through NVMEM devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-3-quic_amelende@quicinc.com>
 <4ee5f3fc-3376-7421-23cd-8fc905704493@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <4ee5f3fc-3376-7421-23cd-8fc905704493@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oP9YdC0wcfs5EbAMETPNWcLV358QB24U
X-Proofpoint-ORIG-GUID: oP9YdC0wcfs5EbAMETPNWcLV358QB24U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280213
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2023 2:42 AM, Krzysztof Kozlowski wrote:
> On 21/06/2023 20:59, Anjelique Melendez wrote:
>> Update leds-qcom-lpg bindings to support LUT patterns through NVMEM
>> devices.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  .../bindings/leds/leds-qcom-lpg.yaml          | 85 +++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
>> index e6f1999cb22f..c9d53820bf83 100644
>> --- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
>> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
>> @@ -63,6 +63,31 @@ properties:
>>          - description: dtest line to attach
>>          - description: flags for the attachment
>>  
>> +  nvmem:
>> +    description: >
>> +      Phandle(s) of the nvmem device(s) to access the LUT stored in the SDAM module(s).
> 
> It's the first time in this binding the "LUT" appears. Drop redundant
> parts like "Phandle(s) of ...." and describe what do you expect there
> and why the hardware needs it. 

LUT is a "lookup table"(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml?h=v6.4#n14)
and in this case holds pattern data i.e LUT patterns.

Currently, qcom,pm660l-lpg, qcom,pm8150b-lpg, qcom,pm8150l-lpg, qcom,pm8941-lpg, qcom,pm8994-lpg,
qcom,pmc8180c-lpg, qcom,pmi8994-lpg, and qcom,pmi8998-lpg all have an a specific LUT peripheral
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/rgb/leds-qcom-lpg.c?h=v6.4-rc7#n1382)
and this is already being handled in leds-qcom-lpg.

What is new with this patch set is that instead of having a LUT peripheral, some PMICs use nvmem to 
hold LUT pattern and other lpg per channel data.
The use of nvmems to store LUT pattern and lpg data is called PPG.
You can either have a single nvmem PPG (a single nvmem device that holds LUT pattern 
and lpg per channel data) or two-nvmem PPG(1 nvmem for LUT pattern and 1 nvmem for lpg per channel data)

I can update the descritpion for the entire binding to mention PPG and LUT so this is more clear. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml?h=v6.4#n12

 
>> +      This property is required only when LUT mode is supported and the LUT pattern is
>> +      stored in SDAM modules instead of a LUT module.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  nvmem-names:
>> +    description: >
>> +      The nvmem device name(s) for the SDAM module(s) where the LUT pattern data is stored.
>> +      This property is required only when LUT mode is supported with SDAM module instead of
>> +      LUT module.
>> +    minItems: 1
>> +    items:
>> +      - const: lpg_chan_sdam
>> +      - const: lut_sdam
>> +
>> +  qcom,pbs-client:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: >
>> +      Phandle of the PBS client used for sending the PBS trigger. This property is
> 
> 
> You need to explain what is PBS and what this property is doing.
> 
> Phandle of PBS client? This is the PBS client! It does not make sense.
Ack
> 
> 
> 
>> +      required when LUT mode is supported and the LUT pattern is stored in a single
>> +      SDAM module instead of a LUT module.
> 
> Which devices support LUT? Why this is not constrained per variant?
When you say constrained per variant, are you looking for something more like this?
i.e. 
allOf:
  - if: 
      properties:
        compatible:
          contains:
            const: qcom,pmi632-lpg
    then:
      properties:
        nvmem:
          maxItems: 1
        nvmem-names:
          items:
            - const: lpg_chan_sdam
      required:
        - nvmem
        - qcom,pbs-client
  - if: 
      properties:
        compatible:
          contains:
            const: qcom,pm8350c-pwm
    then:
      properties:
        nvmem:
          maxItems: 2
        nvmem-names:
          items:
            - const: lpg_chan_sdam
            - const: lut_sdam
      required:
       - nvmem

> 
>> +
>>    multi-led:
>>      type: object
>>      $ref: leds-class-multicolor.yaml#
>> @@ -191,4 +216,64 @@ examples:
>>        compatible = "qcom,pm8916-pwm";
>>        #pwm-cells = <2>;
>>      };
>> +  - |
>> +    #include <dt-bindings/leds/common.h>
>> +
>> +    led-controller {
>> +      compatible = "qcom,pm8350c-pwm";
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      #pwm-cells = <2>;
>> +      nvmem-names = "lpg_chan_sdam" , "lut_sdam";
> 
> Fix your whitespaces.
Ack
> 
>> +      nvmem = <&pmk8550_sdam_21 &pmk8550_sdam_22>;
> 
> Two entries, not one> 
> Anyway, adding one property does not justify new example. Integrate it
> into existing one.

So we actually cannot integrate these properties into existing examples.
The current examples are for PMICs that use LUT peripherals (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/rgb/leds-qcom-lpg.c?h=v6.4#n1417).
This patch series is adding support for PMICs that do not have a LUT peripheral
and instead store LUT patterns and LPG configurations in either 1 or 2 NVMEM(s). 
> 
>> +
>> +      led@1 {
>> +        reg = <1>;
>> +        color = <LED_COLOR_ID_RED>;
>> +        label = "red";
>> +      };
>> +
>> +      led@2 {
>> +        reg = <2>;
>> +        color = <LED_COLOR_ID_GREEN>;
>> +        label = "green";
>> +      };
>> +
>> +      led@3 {
>> +        reg = <3>;
>> +        color = <LED_COLOR_ID_BLUE>;
>> +        label = "blue";
>> +      };
>> +    };
>> +  - |
>> +    #include <dt-bindings/leds/common.h>
>> +
>> +    led-controller {
>> +      compatible = "qcom,pmi632-lpg";
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      #pwm-cells = <2>;
>> +      nvmem-names = "lpg_chan_sdam";
>> +      nvmem = <&pmi632_sdam7>;
>> +      qcom,pbs-client = <&pmi632_pbs_client3>;
> 
> One more example? Why?
> 
> Why do you have here only one NVMEM cell? Aren't you missing constraints
> in the binding?The use of the qcom,pbs-client is only used when we have a PMIC device that has a single PPG NVMEM, 
which is why this was not included in the above 2 nvmem PPG example. I see how these two PPG examples
are repetitive so I am ok with getting rid of one of them but I do think we should have at least one PPG example.

> 
> Best regards,
> Krzysztof
> 
Thanks,
Anjelique
