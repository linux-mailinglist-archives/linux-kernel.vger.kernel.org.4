Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E586F1A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbjD1N7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjD1N7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:59:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF851735;
        Fri, 28 Apr 2023 06:59:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S8WERM030672;
        Fri, 28 Apr 2023 13:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sXgCvAqReI9c/G7x++MikQU7zyYHVvzEj4BLpnZ95vs=;
 b=BZtgEM2Wd+iRqqSBZ3I8lwxG1KsFuz7BM/yFBEebC5/e93kmn8N9Y4ySc878FW39AvdN
 lBocCXPxNdb2mc5r0z7wfRScS5eOSP0+cIquQ/KpOt+HeAZHj2cg62KCrbtA+UdZT4yv
 +K58qsB3ELNPpmQ09L3kXMJn+V4u1H/ABPz0lNo4WhnJw8wTlhKuarUZwv8tIzjWZX05
 yMWKzLy253iO8wdysGIZ03Vm+NLhWvTzhiZoCRiZRAhTOiP7SAFgZgoGVNmGF7yTmXiw
 27/1F/dMoEOl8g8FuLouuIpS10Qg/pAr30QLvUr5J1gMN1VbnVHfnFdXMXmJDlPgSbx0 Xg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7xdyagg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:59:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33SDxFNV025719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:59:15 GMT
Received: from [10.216.44.214] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 28 Apr
 2023 06:59:09 -0700
Message-ID: <3fe4ff88-4640-a348-e88f-ef7d8bcbef19@quicinc.com>
Date:   Fri, 28 Apr 2023 19:29:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/6] dt-bindings: usb: qcom,dwc3: Add bindings for
 SA8775P
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmitry.baryshkov@linaro.org>, <athierry@redhat.com>,
        <robh@kernel.org>, <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20230428130824.23803-1-quic_shazhuss@quicinc.com>
 <20230428130824.23803-2-quic_shazhuss@quicinc.com>
 <4b690859-be5a-c331-8243-b875136d4807@linaro.org>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <4b690859-be5a-c331-8243-b875136d4807@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZoZMd2WWWcv0frsVlMOGPDzxgLeb-BuF
X-Proofpoint-ORIG-GUID: ZoZMd2WWWcv0frsVlMOGPDzxgLeb-BuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxlogscore=390 clxscore=1015 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280115
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 4/28/2023 6:57 PM, Krzysztof Kozlowski wrote:
> On 28/04/2023 15:08, Shazad Hussain wrote:
>> Add the compatible string for SA8775P SoC from Qualcomm.
>>
>> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
>> ---
> 
> (...)
> 
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sa8775p-dwc3
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          minItems: 3
>> +          maxItems: 4
>> +        interrupt-names:
>> +          minItems: 3
>> +          items:
>> +            - const: pwr_event
>> +            - const: dp_hs_phy_irq
>> +            - const: dm_hs_phy_irq
>> +            - const: ss_phy_irq
> 
> Why the last interrupt line is optional? Is it really optional?
> 

Third usb controller i.e usb_2 supports only high speed, so I believe
ss_phy_irq is not required for that instance.

> Best regards,
> Krzysztof
> 

-Shazad
