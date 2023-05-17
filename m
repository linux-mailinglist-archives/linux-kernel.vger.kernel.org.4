Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65370663C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjEQLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEQLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:11:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105661B6;
        Wed, 17 May 2023 04:10:58 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H97Rgl032303;
        Wed, 17 May 2023 11:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mL3f2MJE/PUQ3GiBfA6zOVgtNjLXqq0M9yCh/XNWMhU=;
 b=ZUITHX00nE9X2XHKn5pdO/27p4TWYOhfWJMyAwo4w30+rkwgKbbkNfojKz1H5yv7yLi+
 xGdjPcAWy4Qd6dXC36/ItH34fPo326aL3Golb9uqeaoD9iCugpXpNgdyw69dTyrLilNs
 hvYPmBCYktfsXIYof9Szgve7pFqAT6bQtAlrcbuAjrfoDVUsJS8UVa5xmj87BzuIxFtn
 5jRIRV/BXfYIPIzN+2CzMS/B1NaRYPYBTyiCFDoYT5rBKe/n5nYAMp8CC2D3HWXhi/a5
 rEV34XVI3meEWcTUvuYkdypo/wLhFMqkubjWQuw/0fdRZTMv7HYlVMPGUx4PfTGgIzjn 9w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmbk7a943-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 11:10:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HBAc2Y000601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 11:10:38 GMT
Received: from [10.216.29.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 17 May
 2023 04:10:14 -0700
Message-ID: <f2f8c7bf-6d1d-7890-a8b1-0e27969e63f6@quicinc.com>
Date:   Wed, 17 May 2023 16:40:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 1/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
To:     Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-2-quic_kriskura@quicinc.com>
 <ZGNiDVq1duvyZBUB@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZGNiDVq1duvyZBUB@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1mc-c92g0RVsIcGtcXrRUd0BbSg6wQQX
X-Proofpoint-ORIG-GUID: 1mc-c92g0RVsIcGtcXrRUd0BbSg6wQQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxlogscore=988 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170091
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 4:29 PM, Johan Hovold wrote:
> On Sun, May 14, 2023 at 11:19:09AM +0530, Krishna Kurapati wrote:
>> Add the compatible string for SC8280 Multiport USB controller from
>> Qualcomm.
>>
>> There are 4 power event irq interrupts supported by this controller
>> (one for each port of multiport). Added all the 4 as non-optional
>> interrupts for SC8280XP-MP
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   .../devicetree/bindings/usb/qcom,dwc3.yaml    | 22 +++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sc8280xp-dwc3-mp
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          maxItems: 7
>> +        interrupt-names:
>> +          items:
>> +            - const: dp_hs_phy_irq
>> +            - const: dm_hs_phy_irq
>> +            - const: ss_phy_irq
> 
> I assume that these are only for the first port, and that you need to
> define these interrupts also for ports 2-4.
> 

Hi Johan,

  I wanted to add them when wakeup-source is enabled but since you 
mentioned that these must be added now and driver support can be added 
later, I will make a patch separately for this in v9.

Hi Krzysztof,

  Can I use the following notation for the new interrupts ?

dp_hs_port2_irq
dm_hs_port2_irq
dp_hs_port3_irq
dm_hs_port3_irq
dp_hs_port4_irq
dm_hs_port4_irq


That way the interrupt names for first port will be same as ones for 
single port.

Wanted to clarify this before I make a formal patch.

Regards,
Krishna,
