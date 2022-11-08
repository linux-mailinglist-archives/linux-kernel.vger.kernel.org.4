Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29BC6209A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiKHGmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiKHGms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:42:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03C1BE9F;
        Mon,  7 Nov 2022 22:42:46 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A86NqHS030677;
        Tue, 8 Nov 2022 06:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rccwM7Sp0HsNq0oa9pJgw0v9wFdRXRpWq59zQyF0x3A=;
 b=f2BT2lPSvAWTcAs7cNESlZ0lZ/e51ivXnBvwDxh1wbS9nMPAoZNrMLYSi5HViPD9JdoP
 zmKjhZt7BjFBRMsqsHGHrvYe0aZDaAUNFiH229AlGoKb3hyTQQTsqytJRrq2LkvjzRLR
 8c8jsIA7zV2GEd+r7CW9Y+jEMMwOO0qUllRfPRVO0RhSDV+OXmygJI6AIVOlBxm7cDvm
 2xTsS1/amO2FOk6NhUL8zo3/uHYaukICS3iNNm0XZJGuOafGSSv8LgRmSu3mBOQN2l5C
 D0XESJljpN8US5L4sTME0biYqnFQGzi6gCDRAV9HBD1MN2i3/LRuw1rLeFp6xB1dams1 Lg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqht881sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 06:42:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A86gUwe016866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 06:42:30 GMT
Received: from [10.216.10.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 22:42:24 -0800
Message-ID: <2a6b68df-54e0-28b4-2eb2-fd8c1ad7ed60@quicinc.com>
Date:   Tue, 8 Nov 2022 12:12:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/3] dt-bindings: soundwire: Convert text bindings to
 DT Schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667830844-31566-1-git-send-email-quic_srivasam@quicinc.com>
 <1667830844-31566-4-git-send-email-quic_srivasam@quicinc.com>
 <7abbac13-3a2b-2ea7-98d2-8bcace52c3de@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <7abbac13-3a2b-2ea7-98d2-8bcace52c3de@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cCuta8TT4h_rpDUqdzDHuN8bWLTYiAQB
X-Proofpoint-GUID: cCuta8TT4h_rpDUqdzDHuN8bWLTYiAQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/7/2022 8:41 PM, Krzysztof Kozlowski wrote:
Thanks for Your time Krzysztof!!!
> On 07/11/2022 15:20, Srinivasa Rao Mandadapu wrote:
>> Convert soundwire text bindings to DT Schema format.
>>
>> Update interrupt property items as per device tree,
>> as it is not appropriately described in text file.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
>> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
>> ---
>> This patch depends on:
>>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42801e6185290d63691bd39cf8a3bba6cd5fe520
> Hi,
>
> This is a bit surprising. You pointed to Linus' repo, so what does this
> dependency mean? The Linus' repo is the mainline, there is nothing else,
> so all its commits are already in every tree... unless this is an RC
> fix? If so, you should rather say which RC is needed.

Yeah. Will remove it. Actually in initial version, when used different 
repo, got bot errors.

So to fix that, mentioned this dependency and continued the same in next 
versions.

>
>> Changes since V3:
>>    -- Remove subnode description and add appropriate pattern properties.
>>    -- Add interrput names in example.
>>    -- update some properties description.
>>    -- Revert minIteams change in previous version.
>>    -- Rebase to latest code base.
>> Changes since V2:
>>    -- Update commit message.
>>    -- Add child node property.
>>    -- Change file name.
>>    -- Remove minIteams for few properties.
>>    -- Remove redundant required properties.
>>    -- Remove redundant description for wakeup-source property.
>>    -- Update interrupt property items.
>> Changes since V1:
>>    -- Remove the status field in example.
>>    -- Remove interrupt-names property in the required list.
>>    -- Add the wakeup-source property.	
>>   
>>   .../devicetree/bindings/soundwire/qcom,sdw.txt     | 215 ------------------
>>   .../bindings/soundwire/qcom,soundwire.yaml         | 241 +++++++++++++++++++++
>>   2 files changed, 241 insertions(+), 215 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> deleted file mode 100644
>> index e0faed8..0000000
>> --- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> +++ /dev/null
>> @@ -1,215 +0,0 @@
>> -Qualcomm SoundWire Controller Bindings
>> -
>> -
>> -This binding describes the Qualcomm SoundWire Controller along with its
>> -board specific bus parameters.
>> -
>> -- compatible:
>> -	Usage: required
>> -	Value type: <stringlist>
>> -	Definition: must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
>> -		    Example:
>> -			"qcom,soundwire-v1.3.0"
>> -			"qcom,soundwire-v1.5.0"
>> -			"qcom,soundwire-v1.5.1"
>> -			"qcom,soundwire-v1.6.0"
>> -			"qcom,soundwire-v1.7.0"
>> -- reg:
>> -	Usage: required
>> -	Value type: <prop-encoded-array>
>> -	Definition: the base address and size of SoundWire controller
>> -		    address space.
>> -
>> -- interrupts:
>> -	Usage: required
>> -	Value type: <prop-encoded-array>
>> -	Definition: should specify the SoundWire Controller core and optional
>> -		    wake IRQ
>> -
>> -- interrupt-names:
>> -	Usage: Optional
>> -	Value type: boolean
>> -	Value type: <stringlist>
>> -	Definition: should be "core" for core and "wakeup" for wake interrupt.
>> -
>> -- wakeup-source:
>> -	Usage: Optional
>> -	Value type: boolean
>> -	Definition: should specify if SoundWire Controller is wake up capable.
>> -
>> -- clock-names:
>> -	Usage: required
>> -	Value type: <stringlist>
>> -	Definition: should be "iface" for SoundWire Controller interface clock
>> -
>> -- clocks:
>> -	Usage: required
>> -	Value type: <prop-encoded-array>
>> -	Definition: should specify the SoundWire Controller interface clock
>> -
>> -- #sound-dai-cells:
>> -	Usage: required
>> -	Value type: <u32>
>> -	Definition: must be 1 for digital audio interfaces on the controller.
>> -
>> -- qcom,dout-ports:
>> -	Usage: required
>> -	Value type: <u32>
>> -	Definition: must be count of data out ports
>> -
>> -- qcom,din-ports:
>> -	Usage: required
>> -	Value type: <u32>
>> -	Definition: must be count of data in ports
>> -
>> -- qcom,ports-offset1:
>> -	Usage: required
>> -	Value type: <prop-encoded-array>
>> -	Definition: should specify payload transport window offset1 of each
>> -		    data port. Out ports followed by In ports.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,ports-offset2:
>> -	Usage: required
>> -	Value type: <prop-encoded-array>
>> -	Definition: should specify payload transport window offset2 of each
>> -		    data port. Out ports followed by In ports.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,ports-sinterval-low:
>> -	Usage: required
>> -	Value type: <prop-encoded-array>
>> -	Definition: should be sample interval low of each data port.
>> -		    Out ports followed by In ports. Used for Sample Interval
>> -		    calculation.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,ports-word-length:
>> -	Usage: optional
>> -	Value type: <prop-encoded-array>
>> -	Definition: should be size of payload channel sample.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,ports-block-pack-mode:
>> -	Usage: optional
>> -	Value type: <prop-encoded-array>
>> -	Definition: should be 0 or 1 to indicate the block packing mode.
>> -		    0 to indicate Blocks are per Channel
>> -		    1 to indicate Blocks are per Port.
>> -		    Out ports followed by In ports.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,ports-block-group-count:
>> -	Usage: optional
>> -	Value type: <prop-encoded-array>
>> -	Definition: should be in range 1 to 4 to indicate how many sample
>> -		    intervals are combined into a payload.
>> -		    Out ports followed by In ports.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,ports-lane-control:
>> -	Usage: optional
>> -	Value type: <prop-encoded-array>
>> -	Definition: should be in range 0 to 7 to identify which	data lane
>> -		    the data port uses.
>> -		    Out ports followed by In ports.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,ports-hstart:
>> -	Usage: optional
>> -	Value type: <prop-encoded-array>
>> -	Definition: should be number identifying lowerst numbered coloum in
>> -		    SoundWire Frame, i.e. left edge of the Transport sub-frame
>> -		    for each port. Values between 0 and 15 are valid.
>> -		    Out ports followed by In ports.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,ports-hstop:
>> -	Usage: optional
>> -	Value type: <prop-encoded-array>
>> -	Definition: should be number identifying highest numbered coloum in
>> -		    SoundWire Frame, i.e. the right edge of the Transport
>> -		    sub-frame for each port. Values between 0 and 15 are valid.
>> -		    Out ports followed by In ports.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- qcom,dports-type:
>> -	Usage: optional
>> -	Value type: <prop-encoded-array>
>> -	Definition: should be one of the following types
>> -		    0 for reduced port
>> -		    1 for simple ports
>> -		    2 for full port
>> -		    Out ports followed by In ports.
>> -		    Value of 0xFF indicates that this option is not implemented
>> -		    or applicable for the respective data port.
>> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -- reset:
>> -	Usage: optional
>> -	Value type: <prop-encoded-array>
>> -	Definition: Should specify the SoundWire audio CSR reset controller interface,
>> -		    which is required for SoundWire version 1.6.0 and above.
>> -
>> -- reset-names:
>> -	Usage: optional
>> -	Value type: <stringlist>
>> -	Definition: should be "swr_audio_cgcr" for SoundWire audio CSR reset
>> -		    controller interface.
>> -
>> -Note:
>> -	More Information on detail of encoding of these fields can be
>> -found in MIPI Alliance SoundWire 1.0 Specifications.
>> -
>> -= SoundWire devices
>> -Each subnode of the bus represents SoundWire device attached to it.
>> -The properties of these nodes are defined by the individual bindings.
>> -
>> -= EXAMPLE
>> -The following example represents a SoundWire controller on DB845c board
>> -which has controller integrated inside WCD934x codec on SDM845 SoC.
>> -
>> -soundwire: soundwire@c85 {
>> -	compatible = "qcom,soundwire-v1.3.0";
>> -	reg = <0xc85 0x20>;
>> -	interrupts = <20 IRQ_TYPE_EDGE_RISING>;
>> -	clocks = <&wcc>;
>> -	clock-names = "iface";
>> -	resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
>> -	reset-names = "swr_audio_cgcr";
>> -	#sound-dai-cells = <1>;
>> -	qcom,dports-type = <0>;
>> -	qcom,dout-ports	= <6>;
>> -	qcom,din-ports	= <2>;
>> -	qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
>> -	qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
>> -	qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
>> -
>> -	/* Left Speaker */
>> -	left{
>> -		....
>> -	};
>> -
>> -	/* Right Speaker */
>> -	right{
>> -		....
>> -	};
>> -};
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
>> new file mode 100644
>> index 0000000..b0590cb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
>> @@ -0,0 +1,241 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SoundWire Controller
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> +
>> +description:
>> +  The Qualcomm SoundWire controller along with its board specific bus parameters.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,soundwire-v1.3.0
>> +      - qcom,soundwire-v1.5.0
>> +      - qcom,soundwire-v1.5.1
>> +      - qcom,soundwire-v1.6.0
>> +      - qcom,soundwire-v1.7.0
> Missing blank line.
Okay. will add it.
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    items:
>> +      - description: specify the SoundWire controller core.
>> +      - description: specify the Soundwire controller wake IRQ.
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    items:
>> +      - const: core
>> +      - const: wakeup
>> +
>> +  clocks:
>> +    items:
>> +      - description: iface clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +
>> +  resets:
>> +    items:
>> +      - description: SWR_AUDIO_CGCR RESET
>> +
>> +  reset-names:
>> +    items:
>> +      - const: swr_audio_cgcr
>> +
>> +  '#sound-dai-cells':
>> +    const: 1
>> +
>> +  '#address-cells':
>> +    const: 2
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  wakeup-source: true
>> +
>> +  qcom,din-ports:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: count of data in ports
>> +
>> +  qcom,dout-ports:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: count of data out ports
>> +
>> +  qcom,ports-word-length:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Size of payload channel sample.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 5
>> +
>> +  qcom,ports-sinterval-low:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Sample interval low of each data port.
>> +                 Out ports followed by In ports. Used for Sample Interval
>> +                 calculation.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 8
>> +
>> +  qcom,ports-offset1:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Payload transport window offset1 of each
>> +                 data port. Out ports followed by In ports.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 8
>> +
>> +  qcom,ports-offset2:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Payload transport window offset2 of each
>> +                 data port. Out ports followed by In ports.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 8
>> +
>> +  qcom,ports-lane-control:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Identify which data lane the data port uses.
>> +                 Out ports followed by In ports.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 5
>> +
>> +  qcom,ports-block-pack-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Indicate the block packing mode.
>> +                 0 to indicate Blocks are per Channel
>> +                 1 to indicate Blocks are per Port.
>> +                 Out ports followed by In ports.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 8
>> +
>> +  qcom,ports-hstart:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Identifying lowerst numbered coloum in
>> +                 SoundWire Frame, i.e. left edge of the Transport sub-frame
>> +                 for each port. Values between 0 and 15 are valid.
>> +                 Out ports followed by In ports.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 5
>> +
>> +  qcom,ports-hstop:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Identifying highest numbered coloum in
>> +                 SoundWire Frame, i.e. the right edge of the Transport
>> +                 sub-frame for each port. Values between 0 and 15 are valid.
>> +                 Out ports followed by In ports.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 5
>> +
>> +  qcom,ports-block-group-count:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: In range 1 to 4 to indicate how many sample
>> +                 intervals are combined into a payload.
>> +                 Out ports followed by In ports.
>> +                 Value of 0xFF indicates that this option is not implemented
>> +                 or applicable for the respective data port.
>> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +    minItems: 3
>> +    maxItems: 5
>> +
>> +  label:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^.*@[0-9a-f],[0-9a-f]$":
>> +    type: object
> You should have here a description.

Bit confusion Here. In any of examples there is no description for 
patternProperties.

You mean, description for below compatible property?

>
>> +    properties:
>> +      compatible:
>> +        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - '#sound-dai-cells'
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - qcom,dout-ports
>> +  - qcom,din-ports
>> +  - qcom,ports-sinterval-low
>> +  - qcom,ports-offset1
>> +  - qcom,ports-offset2
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
>> +
>> +    soundwire@3210000 {
>> +        compatible = "qcom,soundwire-v1.6.0";
>> +        reg = <0x03210000 0x2000>;
>> +
>> +        interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +        interrupt-names = "core";
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
Tested bindings and didn't see any issues on my setup. will do cross check.
>
> Best regards,
> Krzysztof
>
