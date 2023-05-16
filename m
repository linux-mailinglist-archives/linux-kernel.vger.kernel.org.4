Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC7B705088
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjEPOZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjEPOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:25:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE4E3AAC;
        Tue, 16 May 2023 07:25:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GCsb0f024518;
        Tue, 16 May 2023 14:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KpRE1csAVuXzEj5oc+bxW0enVxw63SFFuPVKJiVWLLQ=;
 b=Tfo1Af8XaaG0r2hzo5zE3nb2SV0GaYMp1cQDKnTuXl87IIDyik61JsGp/naFTBknDZYa
 lNEYA9deZBG1XzGhi5u1wXJMAExGbFDQFVCra64zkkk8j/9ONE8ySnnXeIuyPlZpYDtn
 X5fF4iqfzNOYuri3DTXeIxkZgLP5p2dcpHfcrLXWytreEU/Lem/2kBXgOaO1IbCoPRNE
 q1hFmdyBalyYqgtryqHrpHKyIUt9cXiajhdoM3hEY0weYZ5Lt7NOsmvzqx1j7sFtNuBU
 WEli9Q7FymBhlLjSC02zCugcqu4mC9iutvllwIp2sIDkfrQ2MiGoZ1x4V7QpjByRYFYr 8Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjr03c3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 14:24:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GEOBZg017798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 14:24:11 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 07:24:04 -0700
Message-ID: <a22a3fe6-7bb1-9b47-9a14-41d957f178f3@quicinc.com>
Date:   Tue, 16 May 2023 19:54:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
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
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZGNgyo8ZRcC26W5l@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uZWQqd-1KyYXCuNO1nPojX54hMLRsWcK
X-Proofpoint-GUID: uZWQqd-1KyYXCuNO1nPojX54hMLRsWcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_07,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=344 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160121
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 4:24 PM, Johan Hovold wrote:
> On Mon, May 15, 2023 at 09:02:13PM +0530, Krishna Kurapati PSSNV wrote:
>> On 5/15/2023 7:56 PM, Johan Hovold wrote:
>>> On Sun, May 14, 2023 at 11:19:15AM +0530, Krishna Kurapati wrote:
> 
>>>> @@ -3133,6 +3133,72 @@ usb_1_role_switch: endpoint {
>>>>    			};
>>>>    		};
>>>>    
>>>> +		usb_2: usb@a4f8800 {
>>>
>>> As I believe someone already pointed out, this node is not in sort order
>>> (i.e. it should go before usb@a6f8800).
> 
>>     I missed that message, but since I named it usb_2, so I placed it in
>> order after usb_1. Hope that is fine !!
> 
> No, the nodes should be sorted by unit address so you need to move it.
> 

Sure, in that case will put it in between usb_0 and usb_1 nodes.

>>>> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
>>>> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
>>>> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
>>>> +					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>>>> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
>>>> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
>>>> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
>>>> +
>>>> +			interrupt-names = "dp_hs_phy_irq",
>>>> +					  "dm_hs_phy_irq",
>>>> +					  "ss_phy_irq",
>>>> +					  "pwr_event_1",
>>>> +					  "pwr_event_2",
>>>> +					  "pwr_event_3",
>>>> +					  "pwr_event_4";
> 
>>>> +			interconnect-names = "usb-ddr", "apps-usb";
>>>
>>> Looks like 'wakeup-source' is missing here too.
>>>
>>
>> I believe this property was added to enable wakeup from system suspend
>> in host mode. I didn't add this property as currently I don't need to
>> support wakeup. If any requirement comes in future, then I might need to
>> add dp/dm interrupts (if any) for other ports as well and then need to
>> change driver code to enable/disable them on suspend/resume.
> 
> If there are dp/dm/ss interrupts per ports then those need to be defined
> in the binding and devicetree from the start.
> 
> Similar for 'wakeup-source' which indicates that the controller *can* be
> used to wakeup the system from suspend (which those pdc interrupts
> indicates).
> 
> Remember that the devicetree is supposed to describe the hardware, and
> which features are currently supported in some version of software is
> mostly irrelevant.
> 
> Johan

Can I take this up as a separate series (Wakeup support for multiport) 
once this series is merged. If I am adding interrupts for other ports, I 
can add driver code to handle those interrupts as well.

Regards,
Krishna,
