Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFCC62F05A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbiKRJBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:01:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3D697DD;
        Fri, 18 Nov 2022 01:01:36 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI7q7TU009812;
        Fri, 18 Nov 2022 09:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VB0ghxJc3zS8lgE6Uhoofu3/+rArs3Cpleawb1aPpEM=;
 b=JkKUumlZY0oPrm6TEe9BhqEmSftZ+SMxWokQFpaxZOrfdBruysgmk8zkkNpU2BviVKZk
 X2TWCoPwZYqFMf9n6VBLRTSgd9DEyNwKBYQZ/IRMxm7igKh5T2ASiw/2jL2GSoi/Nm8P
 bwW93EXFaVxR0Hrq6EVNVu8mmreM4pIDdfFiN/B8G3v5Oq7tsNsym1Ly84Ys0/VYQ4EF
 1TUMaFYrGNFR+Gnu6OkiQK+6gaGbAZbhoqDWaEbPgbrh7cqeGsQ6vPLynxAZsZ/w7m1v
 GufUTM4rqHbwOCuDojdS7GiNl5rkdX0tAJyi63J8ZdbEmAFSvIR0KPszkKTnT5wuhyZY 9g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0se931y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 09:01:25 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AI91Otm013175;
        Fri, 18 Nov 2022 09:01:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3kwxakt01s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 09:01:24 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AI91O18013167;
        Fri, 18 Nov 2022 09:01:24 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 2AI91O9x013166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 09:01:24 +0000
Received: from [10.216.4.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 18 Nov
 2022 01:01:18 -0800
Message-ID: <7e359c57-253e-ae87-a119-a4bf772b4d55@quicinc.com>
Date:   Fri, 18 Nov 2022 14:31:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <ahalaney@redhat.com>, Harsh Agarwal <quic_harshq@quicinc.com>
References: <1654709787-23686-1-git-send-email-quic_harshq@quicinc.com>
 <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
 <20220609153826.GA3828657-robh@kernel.org>
 <ac3676bf-cd5c-be21-913a-0de6dc55bc7c@quicinc.com>
 <20220610172210.GE1787330-robh@kernel.org>
 <5d2a3a55-ae24-1bbb-2448-e7a23b9debde@quicinc.com>
 <20220706220943.GB572635-robh@kernel.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20220706220943.GB572635-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n91QMShaB_ERTFnP8VdlUKULOt_7g-So
X-Proofpoint-ORIG-GUID: n91QMShaB_ERTFnP8VdlUKULOt_7g-So
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to revive this thread.

Hi Rob,

   Apologies for the delay in pursuing this thread further. Neither 
Harsh nor me were able to pursue this since July because of some other 
work load.

On 7/7/2022 3:39 AM, Rob Herring wrote:
> On Mon, Jun 27, 2022 at 06:36:53PM +0530, Harsh Agarwal wrote:
>>
>> On 6/10/2022 10:52 PM, Rob Herring wrote:
>>> On Fri, Jun 10, 2022 at 05:25:25PM +0530, Harsh Agarwal wrote:
>>>> On 6/9/2022 9:08 PM, Rob Herring wrote:
>>>>> On Wed, Jun 08, 2022 at 11:06:25PM +0530, Harsh Agarwal wrote:
>>>>>> Added support for multiport, mport, num_usb2_phy and num_usb3_phy
>>>>>> properties. These properties are used to support devices having
>>>>>> a multiport controller.
>>>>>>
>>>>>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/usb/snps,dwc3.yaml         | 53 ++++++++++++++++++++++
>>>>>>     1 file changed, 53 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>>> index d41265b..9332fa2 100644
>>>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>>> @@ -343,6 +343,32 @@ properties:
>>>>>>           This port is used with the 'usb-role-switch' property  to connect the
>>>>>>           dwc3 to type C connector.
>>>>>> +  multiport:
>>>>> Again, I don't think this is going to play well if you need to describe
>>>>> USB devices in your DT. For example, a USB hub with additional DT
>>>>> properties.
>>>> Thanks for the review Rob.
>>>> Can you please explain why would one want to describe a USB hub in device
>>>> tree ?
>>> Because someone soldered a hub on the board and then connected extra
>>> things like resets, GPIOs, supplies which are all outside of standard
>>> USB. It's quite common...
>>>
>>> There's some flavors of Beagle boards that have a USB ethernet on board.
>>> Guess what, they skipped out on a eeprom and so the device and a MAC
>>> address has to be described in DT (if you want a stable MAC addr).
>>>
>>>> IF USB hub is attached to a root port , it would be enumerated by the SW. I
>>>> am not clear how DT is coming
>>>> into picture. Even if there was a scenario to add DT properties for a hub,
>>>> then this multiport node would be like a nop
>>>> as it just helps us to get the PHY phandles in a proper way.
>>> It won't be enumerated by the SW if it has to be powered on first using
>>> non-standard resources.
>>>
>>>> Do you feel we still might have a problem with multiport node ?
>>> A board design could have a hub or device on any or all your ports.
>>>
>>>>>> +    description:
>>>>>> +      If a single USB controller supports multiple ports, then it's referred to as
>>>>>> +      a multiport controller. Each port of the multiport controller can support
>>>>>> +      either High Speed or Super Speed or both and have their own PHY phandles. Each
>>>>>> +      port is represented by "mport" node and all the "mport" nodes are grouped
>>>>>> +      together inside the "multiport" node where individual "mport" node defines the
>>>>>> +      PHYs supported by that port.
>>>>>> +
>>>>>> +  num_usb2_phy:
>>>>>> +    description: Total number of HS-PHYs defined by the multiport controller.
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +
>>>>>> +  num_usb3_phy:
>>>>>> +    description: Total number of SS-PHYs defined by the multiport controller.
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +
>>>>>> +  mport:
>>>>>> +    description: Each mport node represents one port of the multiport controller.
>>>>>> +    oneOf:
>>>>>> +      - required:
>>>>>> +        - usb-phy
>>>>> This is deprecated. Why are you adding it?
>>>> Do you mean "usb-phy" is deprecated ?
>>> It is replaced by 'phys'. Any new user should use 'phys'.
>>>
>>>> Internally we use usb-phy with our downstream GLUE driver
>>> Upstream does not care about that.
>>>
>>>>>> +      - required:
>>>>>> +        - phys
>>>>>> +        - phy-names
>>>>> Other multi port USB hosts just have a list of phys. Why can't you just
>>>>> use phy-names to identify each phy:
>>>>>
>>>>> phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs",
>>>>>      "port3-hs";
>>>> With the above method we would have to do some kind of string parsing on the
>>>> phy-names to get the HS and SS PHYs as we need to cater to different
>>>> combinations of Ports ( some support HS+SS , other supports SS only).
>>> You are doing string parsing anyways to get the child nodes and
>>> properties.
>>>
>>>> So one challenge here is with the "usb-phy". There we directly define the
>>>> phy phandles and that might/might-not have proper sub-strings. eg
>>>> USB_QMP_PHY . So extracting PHYS could be tricky if the phy-handle does not
>>>> have proper substring like "SS" "HS" etc.
>>> The schema can and should enforce that you have the proper strings.
>> Hi Rob,
>> Apologies for replying late.
>>
>> I get your concern. Yes we can remove the "multiport" node and instead
>> define the
>> USB phy phandles all in one place. Still I would need to add support for
>> both generic-phy and
>> usb-phy framework as downstream many vendors are using "usb-phy" and it's
>> supported by ACK as well.
> 
> Upstream is not concerned with downstream. The generic PHY has replaced
> usb-phy for many years now.
> 
> Furthermore, if downstream was using documented bindings, then we
> wouldn't be having this conversation.
> 

If we are concentrating only on generic phy's do we need to refrain from 
making any changes to downstream phy part of the driver code in core.c 
as done in this RFC series ? I wanted to update this series after 
addressing review comments. If we don't need to, then I can revert 
changes done to dwc->usb2->phy and dwc->usb3_phy in this series.

>> This would not regress anything with Generic PHY.
>>
>> @Greg can you please comment as ACK has support for usb-phy framework.
>>
>> Now coming to implementation, let's consider a 4 port USB multiport
>> controller having
>> 4 HS PHYs and 2 SS PHYs.  We can have two approaches here
>>
>> #1 -> If we could mandate using "HS" or "SS" as substring in
>> phy-names or usb-phy, then we can calculate number of HS and SS phy and also
>> get
>> corresponding PHY nodes. Only concern here is that downstream vendors might
>> need
>> to change their existing usb-phy names and add proper substring if they are
>> not doing so ;
>>
>> phy = <&usb-hs-phy>,<&usb-ss-phy>,
>>        <&usb-hs-phy1>, <&usb-ss-phy1>,
>>        <&usb-hs-phy2>, <&usb-hs-phy3>;
>>
>> phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs",
>>     "port3-hs";
>>
>>
>> OR
>>
>>
>> #2-> We could mandate defining the USB phy in HS - SS pairs.
>> For ports that has only HS PHY, we would need to define usb_nop_phy in SS
>> place.
>> Then we can calculate the number of HS & SS phys and get corresponding
>> PHY nodes by using simple fact that HS phy would be defined at odd places &
>> SS phy defined at even. Here substrings are not mandated.
>>
>> phy = <&usb-hs-phy>,<&usb-qmp-phy>,
>>        <&usb-hs-phy1>, <&usb-qmp-phy1>,
>>        <&usb-hs-phy2>, <&usb_nop_phy>
>>        <&usb-hs-phy3>, <&usb_nop_phy>;
>>
>> phy-names = "port0-hs", "port0-ss",
>> 	    "port1-hs", "port1-ss",
>> 	    "port2-hs", "usb-nop",
>> 	    "port3-hs", "usb-nop";
> 
> The whole reason for -names is to avoid something like this with filler
> entries. So I prefer #1 as I suggested.
> 
Thanks for the review. How about we do the following:
Assuming we have 3 ports where first port is HS+SS capable and the other 
two are only HS capable. We can implement phys and phy-names as :

phy = <&usb-hs-phy1>,<&usb-ss-phy1>,
	<&usb-hs-phy2>, <&usb-hs-phy3>,

phy-names = "usb2-phy-port0", "usb3-phy-port0",
		"usb2-phy-port1", "usb2-phy-port2";

Since the driver code mandates that the phy-names are supposed to be 
"usb2-phy" and "usb3-phy", we can be sure that the first part of every 
phy name starts with "usb2-phy" or "usb3-phy" and we can append -portX 
at end of each phy name to differentiate them as shown in the above example.

In the driver code we can iterate over each of the phy-names property 
and string compare them with "usb2-phy" and "usb3-phy" to identify 
whether it is HS/SS. That way even if we have only one-port the code 
would still hold good.

Let me know if that approach would be fine.

Once again, sorry for delaying this thread.

Regards,
Krishna,

> Rob
