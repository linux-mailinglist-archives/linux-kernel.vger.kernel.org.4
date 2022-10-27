Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF9060FCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiJ0QRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiJ0QRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:17:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC1F181CAA;
        Thu, 27 Oct 2022 09:17:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RFKlX5018412;
        Thu, 27 Oct 2022 16:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RBZCC6G8ERwNbA38K8u8HBs61MikUan4bfhNGgb5WeY=;
 b=eeFKWhd0rzBd+CbQg4uAsSscNXtCIJC8gSg48BTZGwYLLLJgPqVwbHYrUSm+R6vdbuUx
 nYXmieWXvNnoTAR/La0dp7YxQhGNdmqk3RiVUDBkd5Qa/3Vlx8ATERuEMh7AJ3mQA9iL
 l30iF3YxuJitg6RgsgR+Va1mEWugckgefpGco03TQJ5jndI5akOn7QVL8nUnyTfQ1Bex
 VDXHDFOzUaAHqxDaXglBfXO8B780P3Sizk89p17KAiSTr0VOnVp1/TEH5q6VwU2/04cD
 qkI232OIGQBY3YB8r4qQag4RlU38hq2Xrz1B88ZsaGdVd17+fYwmE/CSr0N0M0Nzlk5O hw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfaj1amc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 16:17:16 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29RGHFVB008181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 16:17:15 GMT
Received: from [10.110.54.85] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 09:17:14 -0700
Message-ID: <75ef3cc5-3b19-9eab-b3eb-56fa254d92bd@quicinc.com>
Date:   Thu, 27 Oct 2022 09:17:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 02/13] dt-bindings: Add binding for gunyah hypervisor
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-3-quic_eberman@quicinc.com>
 <20221012155645.GA2173829-robh@kernel.org>
 <ca13eb92-9b5b-19fd-27a5-f91f5048b142@quicinc.com>
 <CAL_Jsq+cR5AEa5i1u-_L6sP6nYXS6qgaVWZ=KwxpUbxV3ZW-BA@mail.gmail.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CAL_Jsq+cR5AEa5i1u-_L6sP6nYXS6qgaVWZ=KwxpUbxV3ZW-BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mygc-R9Eu-uIu0M5bs6K3wMWg97ZzIfb
X-Proofpoint-ORIG-GUID: mygc-R9Eu-uIu0M5bs6K3wMWg97ZzIfb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270090
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 10/26/2022 2:16 PM, Rob Herring wrote:
> On Thu, Oct 13, 2022 at 6:59 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>
>>
>> On 10/12/2022 8:56 AM, Rob Herring wrote:
>>> On Mon, Oct 10, 2022 at 05:08:29PM -0700, Elliot Berman wrote:
>>>> When Linux is booted as a guest under the Gunyah hypervisor, the Gunyah
>>>> Resource Manager applies a devicetree overlay describing the virtual
>>>> platform configuration of the guest VM, such as the message queue
>>>> capability IDs for communicating with the Resource Manager. This
>>>> information is not otherwise discoverable by a VM: the Gunyah hypervisor
>>>> core does not provide a direct interface to discover capability IDs nor
>>>> a way to communicate with RM without having already known the
>>>> corresponding message queue capability ID. Add the DT bindings that
>>>> Gunyah adheres for the hypervisor node and message queues.
>>>>
>>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>>> ---
>>>>    .../bindings/firmware/gunyah-hypervisor.yaml  | 87 +++++++++++++++++++
>>>>    MAINTAINERS                                   |  1 +
>>>>    2 files changed, 88 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>>> new file mode 100644
>>>> index 000000000000..f0a14101e2fd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>>> @@ -0,0 +1,87 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/firmware/gunyah-hypervisor.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Gunyah Hypervisor
>>>> +
>>>> +maintainers:
>>>> +  - Murali Nalajala <quic_mnalajal@quicinc.com>
>>>> +  - Elliot Berman <quic_eberman@quicinc.com>
>>>> +
>>>> +description: |+
>>>> +  On systems which support devicetree, Gunyah generates and overlays a deviceetree overlay which
>>>
>>> How you end up with the node (applying an overlay) is not relavent to
>>> the binding.
>>>
>>>> +  describes the basic configuration of the hypervisor. Virtual machines use this information to determine
>>>> +  the capability IDs of the message queues used to communicate with the Gunyah Resource Manager.
>>>
>>> Wrap at 80. That is the coding standard still though 100 is deemed
>>> allowed. And yamllint only complains at 110 because I didn't care to fix
>>> everyones lines over 100.
>>>
>>>> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - const: gunyah-hypervisor-1.0
>>>> +      - const: gunyah-hypervisor
>>>
>>> 2 compatibles implies a difference between the 2. What's the difference?
>>> Where does '1.0' come from?
>>>
>>
>> There's no difference. I thought the convention was to have
>> device-specific compatible and the generic compatible. "device-specific"
>> here would be specific to version of Gunyah since it's software.
> 
> No, that's just what people do because "vendor,new-soc",
> "vendor,old-soc" seems to bother them for some reason. At the end of
> the day, it's just a string identifier that means something. If
> there's no difference in that 'something', then there is no point in
> having more than one string.
> 
> You only need something specific enough to discover the rest from the
> firmware. When that changes, then you add a new compatible. Of course,
> if you want existing OSs to work, then better not change the
> compatible.
> 

Thanks for the info, I'll drop the "-1.0" suffix.

