Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712E9705125
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjEPOpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjEPOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:45:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97E83DF;
        Tue, 16 May 2023 07:45:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDKPAI007867;
        Tue, 16 May 2023 14:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a66RdhzMiuCQlbgmd3Rn1qanxZdGGnJc62BISmsrkTA=;
 b=ArbyPhLi1cUCATlWlyiHj7oCFuzB0T/7eT7wCcz4yCUwPsu+JEowMovapbNL342teOju
 dFKb8j5f2SbrW7cV8npe/TTGWgUKJA2NDEWA1HX4ExeSHQVlEHBUpYnB376OeHeKinYc
 CsUHtCTx58swALbJGwPTcxVjnqPSWPZJeGFj3QEJ/mKpnU/Hqs9Kcce1vPiXcLHOC+/U
 CEI0ltjC0qDsLR4ybAWaxEutsCKI7pgzVb2iJ55/gTrYvH4oMfzJLysvBs4OFrdN+iel
 EDWDUVMmfDbYs6T4CQzHT1EO6YG7oXKjqWhXyhltjyNqZj5yKU/GIK6D5pgt2X0NOrxa Xw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qm74p8psj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 14:44:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GEipSI020927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 14:44:51 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 07:44:44 -0700
Message-ID: <0ef2018d-6747-bf41-0cce-002dcb4bc369@quicinc.com>
Date:   Tue, 16 May 2023 20:14:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
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
 <20230514054917.21318-8-quic_kriskura@quicinc.com>
 <ZGJBLUsPcbsxj989@hovoldconsulting.com>
 <d14567fd-0576-55bb-40c0-442e060c28ba@quicinc.com>
 <ZGNgyo8ZRcC26W5l@hovoldconsulting.com>
 <a22a3fe6-7bb1-9b47-9a14-41d957f178f3@quicinc.com>
 <ZGOWayVsjhR2Y0cN@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZGOWayVsjhR2Y0cN@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1nROiWRbNECSjQ70YuNnF8CTQUBMNI7S
X-Proofpoint-ORIG-GUID: 1nROiWRbNECSjQ70YuNnF8CTQUBMNI7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_07,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=439 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160123
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 8:12 PM, Johan Hovold wrote:
> On Tue, May 16, 2023 at 07:54:00PM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 5/16/2023 4:24 PM, Johan Hovold wrote:
>>> On Mon, May 15, 2023 at 09:02:13PM +0530, Krishna Kurapati PSSNV wrote:
>>>> On 5/15/2023 7:56 PM, Johan Hovold wrote:
>>>>> On Sun, May 14, 2023 at 11:19:15AM +0530, Krishna Kurapati wrote:
>>>
>>>>>> @@ -3133,6 +3133,72 @@ usb_1_role_switch: endpoint {
>>>>>>     			};
>>>>>>     		};
>>>>>>     
>>>>>> +		usb_2: usb@a4f8800 {
>>>>>
>>>>> As I believe someone already pointed out, this node is not in sort order
>>>>> (i.e. it should go before usb@a6f8800).
>>>
>>>>      I missed that message, but since I named it usb_2, so I placed it in
>>>> order after usb_1. Hope that is fine !!
>>>
>>> No, the nodes should be sorted by unit address so you need to move it.
>>>
>>
>> Sure, in that case will put it in between usb_0 and usb_1 nodes.
> 
> No, it goes before usb_0 on sc8280xp.
> 
>             usb_2: usb@a4f8800 {
>             usb_0: usb@a6f8800 {
>             usb_1: usb@a8f8800 {
> 
>>>>>> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
>>>>>> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
>>>>>> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +
>>>>>> +			interrupt-names = "dp_hs_phy_irq",
>>>>>> +					  "dm_hs_phy_irq",
>>>>>> +					  "ss_phy_irq",
>>>>>> +					  "pwr_event_1",
>>>>>> +					  "pwr_event_2",
>>>>>> +					  "pwr_event_3",
>>>>>> +					  "pwr_event_4";
>>>
>>>>>> +			interconnect-names = "usb-ddr", "apps-usb";
>>>>>
>>>>> Looks like 'wakeup-source' is missing here too.
>>>>>
>>>>
>>>> I believe this property was added to enable wakeup from system suspend
>>>> in host mode. I didn't add this property as currently I don't need to
>>>> support wakeup. If any requirement comes in future, then I might need to
>>>> add dp/dm interrupts (if any) for other ports as well and then need to
>>>> change driver code to enable/disable them on suspend/resume.
>>>
>>> If there are dp/dm/ss interrupts per ports then those need to be defined
>>> in the binding and devicetree from the start.
>>>
>>> Similar for 'wakeup-source' which indicates that the controller *can* be
>>> used to wakeup the system from suspend (which those pdc interrupts
>>> indicates).
>>>
>>> Remember that the devicetree is supposed to describe the hardware, and
>>> which features are currently supported in some version of software is
>>> mostly irrelevant.
> 
>> Can I take this up as a separate series (Wakeup support for multiport)
>> once this series is merged. If I am adding interrupts for other ports, I
>> can add driver code to handle those interrupts as well.
> 
> Nope. You can possibly add driver support later, but the binding and
> dtsi need to be correct from the start (and it may be easier to do it
> all at once).
> 

Ok, will add this in v9.

Regards,
Krishna,
