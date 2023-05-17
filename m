Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A844D7067E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjEQMTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEQMTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:19:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED3193;
        Wed, 17 May 2023 05:19:34 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HC9x7w009630;
        Wed, 17 May 2023 12:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FqSv7NcPjktzI3uBQkiT5C2WLNkil+DmlEhAu9oahhw=;
 b=K3gguYJL87v/8ErKKdKYPeFqTZAu/nzbtP1vNttDtawi+7kbCuW07jRCUboU5t5PVkIr
 bUpkIQdAkt3s+8j7avAwkqc6gC0bavS+UaQUBwm0nQoyFwKGTFRqewcdscSvBmKiNOmK
 GjRKad2s9Etoc2aKke/sW1tIvbIG808rGCtzs35n308FVJO8cAlpOwOpF6Zc3DOk8Jau
 YKv9eNrmKvtX20EULs1jwKv0Oi54nEl2ONsCXX4mb9A/1nM/9OcKHg0avkdemMR57co0
 ucyrCb3wxgPI+Mx2znpo/rVH9hQ2nMtbgH5v3413JdYj7R6nZ3jFDOOLs7qv44jLi5fH PQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmt5grp2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:19:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HCJNMt014576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:19:23 GMT
Received: from [10.216.29.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 17 May
 2023 05:19:16 -0700
Message-ID: <fc6e3e2c-1573-c9e6-0aa1-b14aa18ac393@quicinc.com>
Date:   Wed, 17 May 2023 17:49:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 1/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-2-quic_kriskura@quicinc.com>
 <ZGNiDVq1duvyZBUB@hovoldconsulting.com>
 <f2f8c7bf-6d1d-7890-a8b1-0e27969e63f6@quicinc.com>
 <ZGS-FymhdA_zOQmj@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZGS-FymhdA_zOQmj@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -0sqXLtGUL1e4ouP1TzO1POBd9bSKW9E
X-Proofpoint-ORIG-GUID: -0sqXLtGUL1e4ouP1TzO1POBd9bSKW9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170100
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2023 5:14 PM, Johan Hovold wrote:
> On Wed, May 17, 2023 at 04:40:11PM +0530, Krishna Kurapati PSSNV wrote:
>> On 5/16/2023 4:29 PM, Johan Hovold wrote:
>>> On Sun, May 14, 2023 at 11:19:09AM +0530, Krishna Kurapati wrote:
> 
>>>> +        interrupts:
>>>> +          maxItems: 7
>>>> +        interrupt-names:
>>>> +          items:
>>>> +            - const: dp_hs_phy_irq
>>>> +            - const: dm_hs_phy_irq
>>>> +            - const: ss_phy_irq
>>>
>>> I assume that these are only for the first port, and that you need to
>>> define these interrupts also for ports 2-4.
> 
>>    I wanted to add them when wakeup-source is enabled but since you
>> mentioned that these must be added now and driver support can be added
>> later, I will make a patch separately for this in v9.
> 
>>    Can I use the following notation for the new interrupts ?
>>
>> dp_hs_port2_irq
>> dm_hs_port2_irq
>> dp_hs_port3_irq
>> dm_hs_port3_irq
>> dp_hs_port4_irq
>> dm_hs_port4_irq
>>
>>
>> That way the interrupt names for first port will be same as ones for
>> single port.
> 
> For consistency, I'd say: use the same scheme also for port1. Perhaps
> "port" is unnecessary too.
> 
> And since these are getting new names, you can drop the redundant "_irq"
> suffix as you did for the power-event lines.
> 
Hi Johan,

   The reason I wanted to mark it as dp_hs_portX_irq is to keep code 
changes to driver simple. The existing code to read current IRQ's can 
stay as it. Only need to add changes for reading IRQ's of new ports.

> For example:
> 
> 	pwr_event_1
> 	dp_hs_phy_1
> 	dm_hs_phy_1
> 	ss_phy_1
> 	...
> 
>> Wanted to clarify this before I make a formal patch.
> 
> Note that I have some more comments on the remaining patches in the
> series that you may want to wait for before posting v9.
> 
> Johan

Sure, Will wait till end of week for all comments and push v9 next week.

Regards,
Krishna,
