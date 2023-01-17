Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A363966DFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjAQOCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjAQOCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:02:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CA038B7F;
        Tue, 17 Jan 2023 06:02:09 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HCQlBq010581;
        Tue, 17 Jan 2023 14:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VviILnZyVWkGxvkGB1/dVn87wzu/osCf11Yk7kCwkMo=;
 b=dQN0MIYdrFJR+v6Xzi+4YSPticDFUQ93W+5IEbdr57zCFDOw5g5LjiZBNlEpcNER45IR
 NPkDQ9Xl+dwMBYU4WsPir0WUwEZ7RaYquPu4L+Zq8SkgEGyDYtF9mr5Hl7od+W+ZvjMw
 j412BGPnBbieGJ+Dk2XVRXqRUocj3U7SexMqNL9PKp5zdjO6OSXsKJcn1boPhtcDul6X
 Fu/PtUMyYoUr7mmzQVS19qfQtPVrObP6dQ4eWmWS0NlOs1MmWIMVj+NrNdwZMg0t/sSs
 SNUJZL2T8HN7HJVAq8Cx62ZZrkQzi7nFDXSZK3UJnmGwtW2IIWkF2RJwgOvxYPxL0tt/ /g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n53172ktu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:01:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HE1rOx029557
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:01:53 GMT
Received: from [10.216.62.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 06:01:47 -0800
Message-ID: <9671cade-1820-22e1-9db9-5c9836414908@quicinc.com>
Date:   Tue, 17 Jan 2023 19:31:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC v4 1/5] dt-bindings: usb: Add bindings to support multiport
 properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-2-quic_kriskura@quicinc.com>
 <20230116163401.GA2371990-robh@kernel.org>
 <4eb26a54-148b-942f-01c6-64e66541de8b@quicinc.com>
 <ca729f62-672e-d3de-4069-e2205c97e7d8@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ca729f62-672e-d3de-4069-e2205c97e7d8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DlY7iCIXBOyekOeOjf2G53_x7XDfiqtZ
X-Proofpoint-ORIG-GUID: DlY7iCIXBOyekOeOjf2G53_x7XDfiqtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170115
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2023 4:32 PM, Krzysztof Kozlowski wrote:
> On 17/01/2023 10:01, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 1/16/2023 10:04 PM, Rob Herring wrote:
>>> On Sun, Jan 15, 2023 at 05:11:42PM +0530, Krishna Kurapati wrote:
>>>> Add bindings to indicate properties required to support multiport
>>>> on Snps Dwc3 controller.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>>    .../devicetree/bindings/usb/snps,dwc3.yaml    | 53 ++++++++++++++++---
>>>>    1 file changed, 47 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> index 6d78048c4613..3ea051beb2f8 100644
>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> @@ -81,15 +81,26 @@ properties:
>>>>    
>>>>      phys:
>>>>        minItems: 1
>>>> -    maxItems: 2
>>>> +    maxItems: 8
>>>>    
>>>>      phy-names:
>>>>        minItems: 1
>>>> -    maxItems: 2
>>>> -    items:
>>>> -      enum:
>>>> -        - usb2-phy
>>>> -        - usb3-phy
>>>> +    maxItems: 8
>>>> +    oneOf:
>>>> +    - items:
>>>> +        enum:
>>>> +          - usb2-phy
>>>> +          - usb3-phy
>>>> +    - items:
>>>> +        enum:
>>>> +          - usb2-phy_port0
>>>> +          - usb2-phy_port1
>>>> +          - usb2-phy_port2
>>>> +          - usb2-phy_port3
>>>> +          - usb3-phy_port0
>>>> +          - usb3-phy_port1
>>>> +          - usb3-phy_port2
>>>> +          - usb3-phy_port3
>>>
>>> usbN-portM
>>>
>>>>    
>>>>      resets:
>>>>        minItems: 1
>>>> @@ -360,6 +371,22 @@ properties:
>>>>        description:
>>>>          Enable USB remote wakeup.
>>>>    
>>>> +  num-ports:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      This property indicates the number of ports present on the target that
>>>> +      are to be serviced by the DWC3 controller.
>>>> +    minimum: 1
>>>> +    maximum: 4
>>>> +
>>>> +  num-ss-ports:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      This property indicates the number of SS capable ports present on the
>>>> +      target that are to be serviced by the DWC3 controller.
>>>> +    minimum: 1
>>>> +    maximum: 4
>>>
>>> This information is redundant. 'phy-names' tells you how many ports of
>>> each.
>>>
>> Hi Rob,
>>
>>    Thanks for the review. The reason I wanted to introduce two more
>> variables is to get info on number of ports  and ss-capable ports
>> present on hardware whether or not the user provides them in DTSI file.
>>
>> In the code there are two types of per port / per phy operations:
>> a) Modifying GUSB2PFYCFG and GUSB3PIPECTL registers per phy.
>> b) Generic Phy operations - per phy.
>>
>> In today's code, if someone doesn't mention the SSPHY in DTSI,
>> dwc->usb3_generic_phy will be NULL and any call to phy operations will
>> just bail out. And irrespective of whether we provide SS Phy in DTSI or
>> not, we still configure GUSB3PIPECTL register.
>>
>> Consider the following cases:
>>
>> 1. There are 3 ports and 2 of them are SS capable and all phy's are
>> mentioned in DTSI.
>>
>> phy-names= "usb2-port0", "usb3-port0", "usb2-port1", "usb3-port1",
>> "usb2-port2"
>>
>> When we count them in the driver, we get num ports as 3 (presuming
>> num-ports = num of hs ports) and num-ss-ports = 2.
>>
>> Since there is no ambiguity in which all ports to configure, we can
>> modify GUSB2PHYCFG registers for all 3 HS Phy's and GUSB3PIPECTL for
>> both SS Phy's.
>> This is a proper scenario.
>>
>> 2. If the user skips providing SS Phy on Port-0, then:
>>
>> phy-names= "usb2-port0", "usb2-port1", "usb3-port1", "usb2-port2"
>>
>> If we count the phys, we end up getting num-ports=3 and num-ss-ports=1.
>>
>> Since in the driver code, we are not keeping track of which ports are SS
>> capable and which ones are not, we end up configuring
>> GUSB2PIPECTL(port-0) instead of port-1  as the num-ss-ports is "1" which
>> is incorrect.
>>
>> 3. If the user skips providing one complete port, in this case port-1 is
>> skipped, then:
>>
>> phy-names= "usb2-port0", "usb3-port0", "usb2-port2"
>>
>> If we count the phys, we end up getting num-ports=2 and num-ss-ports=1.
>>
>> Since in the driver code, we are not keeping track of which ports are SS
>> capable and which ones are not, we end up configuring
>> GUSB2PHYCFG(port-0) and GUSB2PHYCFG(port-1) instead of port-2 which is
>> incorrect.
> 
> Why? You know you have port-2 from the phy name, so why would you ignore
> this information?
> 
Hi Krzysztof,

Thanks for the review,

   The concern I had with that approach is that, we need to keep track 
of per port supported speeds in some array /flags and check them 
whenever we are modifying the dwc3-phy registers. This makes the code a 
little unreadable.
>>
>> To avoid these scenarios, if we can get the exact number of SS Ports and
>> Ports in total present on the HW, we can configure all the registers
>> whether the phy's are provided in DTSI or not. (This is of no harm I
>> believe as it still works in today's code)
> 
> Doesn't the driver know how many phys it has in such case through
> respective compatible?
> 
The core driver has only one compatible currently "snps,dwc3".

Are you suggesting to add new compatible to driver core in case any 
multiport device is being used and get this info from there ?

>>
>> Incase the 2nd and 3rd scenarios are not allowed and user *MUST* declare
>> all the phy's in the DTSI, then I can go ahead and remove these
>> properties and count them in the driver code.
> 
> 
> Why you cannot then configure all phys in the driver all ports as some
> safe default and then customize it depending on the actual port used?
> 
To do this, we still need to get info on number of hs/ss phy's present 
on hardware and currently there is no register I believe in DWC3 core 
global address space that can give this info. I see that HCSPARAMS1 Reg 
gives some info but that is not accessible from driver core.

According to databook:

"Number of Ports (MaxPorts)
-> Number of ports implemented is defined by the parameter
(`DWC_USB3_HOST_NUM_U2_ROOT_PORTS +
`DWC_USB3_HOST_NUM_U3_ROOT_PORTS)
-> Number of ports enabled is controlled by the core input signals
host_num_u2_port[3:0]+host_num_u3_port[3:0]"
Regards,
Krishna,

