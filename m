Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA3874E585
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGKDxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGKDxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:53:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7F2E40;
        Mon, 10 Jul 2023 20:53:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B2eLjI000866;
        Tue, 11 Jul 2023 03:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y51Rb3xBFKSWbNiAFhFAaKy6yZ/VFaiLjuxQF6NMt+Q=;
 b=Ni9igqJFTJMgTLZaMVnDqL+F/omHGJqjUpMTLJb8iO78pl+PtpW1D0fYTvbrdwyqLuz+
 GMsVGPAasuQ0lW2W7YR+dMcMPl7tIbmjX5ZXdkdn0hCWramo+a79gTHotkzFACbwWx2D
 KBjvks+Wqh/9UN099KTETm13KkI4a913HHUL1ycUARviyrA5TBrgRwcnGq29gFcRwNTN
 4aZQPnZ7XAgCqjq3lpsPwSzG8MVMDfjNiNlXQ5Z8E57FbOSsIbpsHOq5nLl6v0tsCUAa
 MGCZG1vMvlyl5S04MfqDyOkijUSAzaLfpU+1fkqYDiVIQ+wjVDnnVD+hzeT9AYlHBmHN Yw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rrwk0r5uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 03:53:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B3rGSw002770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 03:53:16 GMT
Received: from [10.110.35.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 20:53:15 -0700
Message-ID: <32e9a512-fd74-b2f6-6b8a-fefb9ad5912d@quicinc.com>
Date:   Mon, 10 Jul 2023 20:52:48 -0700
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
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <e7298704-5a03-0961-90a3-dab4af60c326@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gZGUOrXrM8rBPOSYsejZsCbBX1Ykjj12
X-Proofpoint-ORIG-GUID: gZGUOrXrM8rBPOSYsejZsCbBX1Ykjj12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_18,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=832 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110033
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2023 4:03 AM, Krzysztof Kozlowski wrote:
> On 29/06/2023 03:19, Anjelique Melendez wrote:
> 
>>>> +examples:
>>>> +  - |
>>>> +    pmic {
>>>> +      #address-cells = <1>;
>>>> +      #size-cells = <0>;
>>>> +
>>>> +      qcom,pbs@7400 {
>>>> +        compatible = "qcom,pbs";
>>>> +        reg = <0x7400>;
>>>> +      };
>>>
>>> Why do you need a child node for this? Is there more than 1 instance in 
>>> a PMIC? Every sub-function of a PMIC doesn't have to have a DT node.
>>>
>>
>> We currently have another downstream driver (which is planned to get upstreamed)
>> which also needs a handle to a pbs device in order to properly trigger events. 
> 
> I don't see how does it answer Rob's concerns. Neither mine about
> incomplete binding. You don't need pbs node here for that.
> 
> Anyway, whatever you have downstream also does not justify any changes.
> Either upstream these so we can see it or drop this binding.
> 
> Best regards,
> Krzysztof
> 

On PMI632, peripherals are partitioned over 2 different SIDs
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/pmi632.dtsi?h=v6.5-rc1#n42
and https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/pmi632.dtsi?h=v6.5-rc1#n149).
Unfortunately, the pbs peripheral and the lpg peripherals are on different
PMI632 devices and therefore have different regmaps.
 
If we get rid of the pbs node we need to get a handle to the proper regmap.
I see two possible options, we could either introduce a new client property
which points to a peripheral on the same device as pbs.

i.e.
	led-controller {
		compatible = "qcom,pmi632-lpg";
      		#address-cells = <1>;
      		#size-cells = <0>;
      		#pwm-cells = <2>;
     		nvmem-names = "lpg_chan_sdam";
      		nvmem = <&pmi632_sdam7>;
      		qcom,pbs-phandle = <&pmi632_gpios>;
      		..... 
	};
Then when client is probing could do something like the following to get the regmap

	dn = of_parse_phandle(node, "qcom,pbs-phandle", 0);
	pdev = of_find_device_by_node(dn);
	pbs_regmap = dev_get_regmap(&pdev->dev->parent, NULL);



Or we could use the nvmem phandle and just have something like this in client's probe

	dn = of_parse_phandle(node, "nvmem", 0);
	pdev = of_find_device_by_node(dn);
	pbs_regmap = dev_get_regmap(&pdev->dev->parent, NULL);



Let me know what your thoughts are on this.

Thanks,
Anjelique
