Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B174F8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGKUMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjGKUMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:12:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15160139;
        Tue, 11 Jul 2023 13:12:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BJvus8023024;
        Tue, 11 Jul 2023 20:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XK8CbwDtingZVZz2UI5lv9/T4CRj46yMkQLDKpZJq/E=;
 b=p4wlZKcbo7BLG8CXcm//xGXNZatpBPCosXRwbPs2db/RMTGo8+5Ulxz7qRP4T/s9sFjt
 wxAue5lpDRUoqqv4DzbtLBJmgim6ZtAW3Br5V1b4tnBrMqajaoS0K2LADRB5DAlfD3A7
 ejEe8REPL49iAiIYstfr/lIBN4TQzgdk4Jjl207mgSiQJKMrLY35yIs9T+aPQM1I9b2v
 VYswbThU6S73mGpUoN9eNhWYSV9Gnr6ReIe9aBsnv9/H9WEMI4BX+w2A56d/xXcteHJV
 J4GJG9erp0KDehp3SUeMNX5ySsX1wKz+cGKDwPOWuG8KuICQPLGNMVTIMgRqHW1pvZwU bQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsct5843x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 20:12:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BKCLsI027435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 20:12:21 GMT
Received: from [10.110.96.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 13:12:21 -0700
Message-ID: <71e1f36f-8fd8-9d61-d563-577d4fb54f10@quicinc.com>
Date:   Tue, 11 Jul 2023 13:12:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
 <20230626135857.GA3118929-robh@kernel.org>
 <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
 <e7298704-5a03-0961-90a3-dab4af60c326@linaro.org>
 <32e9a512-fd74-b2f6-6b8a-fefb9ad5912d@quicinc.com>
 <431faa87-d152-5f7a-40fd-8b6fe26f0bb9@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <431faa87-d152-5f7a-40fd-8b6fe26f0bb9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ctyahuE-8dnZUq7BnQQNZI5HiKd2li5P
X-Proofpoint-ORIG-GUID: ctyahuE-8dnZUq7BnQQNZI5HiKd2li5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110182
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2023 10:58 PM, Krzysztof Kozlowski wrote:
> On 11/07/2023 05:52, Anjelique Melendez wrote:
>>
>>
>> On 7/1/2023 4:03 AM, Krzysztof Kozlowski wrote:
>>> On 29/06/2023 03:19, Anjelique Melendez wrote:
>>>
>>>>>> +examples:
>>>>>> +  - |
>>>>>> +    pmic {
>>>>>> +      #address-cells = <1>;
>>>>>> +      #size-cells = <0>;
>>>>>> +
>>>>>> +      qcom,pbs@7400 {
>>>>>> +        compatible = "qcom,pbs";
>>>>>> +        reg = <0x7400>;
>>>>>> +      };
>>>>>
>>>>> Why do you need a child node for this? Is there more than 1 instance in 
>>>>> a PMIC? Every sub-function of a PMIC doesn't have to have a DT node.
>>>>>
>>>>
>>>> We currently have another downstream driver (which is planned to get upstreamed)
>>>> which also needs a handle to a pbs device in order to properly trigger events. 
>>>
>>> I don't see how does it answer Rob's concerns. Neither mine about
>>> incomplete binding. You don't need pbs node here for that.
>>>
>>> Anyway, whatever you have downstream also does not justify any changes.
>>> Either upstream these so we can see it or drop this binding.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> On PMI632, peripherals are partitioned over 2 different SIDs
>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/pmi632.dtsi?h=v6.5-rc1#n42
>> and https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/pmi632.dtsi?h=v6.5-rc1#n149).
>> Unfortunately, the pbs peripheral and the lpg peripherals are on different
>> PMI632 devices and therefore have different regmaps.
>>  
>> If we get rid of the pbs node we need to get a handle to the proper regmap.
>> I see two possible options, we could either introduce a new client property
>> which points to a peripheral on the same device as pbs.
>>
>> i.e.
>> 	led-controller {
>> 		compatible = "qcom,pmi632-lpg";
>>       		#address-cells = <1>;
>>       		#size-cells = <0>;
>>       		#pwm-cells = <2>;
>>      		nvmem-names = "lpg_chan_sdam";
>>       		nvmem = <&pmi632_sdam7>;
>>       		qcom,pbs-phandle = <&pmi632_gpios>;
>>       		..... 
>> 	};
>> Then when client is probing could do something like the following to get the regmap
>>
>> 	dn = of_parse_phandle(node, "qcom,pbs-phandle", 0);
>> 	pdev = of_find_device_by_node(dn);
>> 	pbs_regmap = dev_get_regmap(&pdev->dev->parent, NULL);
>>
>>
>>
>> Or we could use the nvmem phandle and just have something like this in client's probe
>>
>> 	dn = of_parse_phandle(node, "nvmem", 0);
>> 	pdev = of_find_device_by_node(dn);
>> 	pbs_regmap = dev_get_regmap(&pdev->dev->parent, NULL);
>>
>>
>>
>> Let me know what your thoughts are on this.
> 
> Rob asked you - "Is there more than 1 instance in a PMIC?" - and you did
> not answer positively, just mentioned something about drivers in
> downstream, which do not matter. So is the answer for that question:
> yes, you have two instances of the same PMIC differing by presence of
> PBS and other features"?
> 
Sorry that was a misunderstanding on my part.
Yes, answer to Rob's question should have been "We have two instances of PMI632,
where one instance holds the pbs peripheral and the other holds the lpg
peripherals. The child node for pbs is needed so lpg client can access
the PMI632 regmap which contains the pbs peripheral."

Thanks,
Anjelique 


