Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72C605C31
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJTKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiJTKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:21:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5808C1DD89E;
        Thu, 20 Oct 2022 03:21:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K9BUKP008119;
        Thu, 20 Oct 2022 10:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=w9LOjt+T0OVa8yF81h2XN/ZRZu2ej9aA3xstuh+rbMI=;
 b=dHBNzW6IYJ62CXYl+HGfQYFKkuwrHdQJ503uPtlyR0sxMlKlmk63Zl6NIlz3jFRmciDC
 6f7Z5SGplLaqPip8GBuHJvm35PLPH4J35ZAbY7XdSCivCYiN6FyQkJV/0H06Svr4C1hh
 kxquaoDfz4/GndZ4xBCqFi7E7tVQVH0HxaQT1A8DzuZvcLD7Rv7inSihA5f3ymZ5iZ3o
 t+SrMytRi0TU4n8nY4/SDjhFZEwXVg5HjIvAFabKGR2FghoGZmkN02T54lE7ThWUkk9m
 qxwEec3PmJmrp03UW/lKon+plmVdK2B3TlY3UsfNWQ9qSSG8TFTNIPgYReDai3+mzcmZ Jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kawde0ww6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 10:20:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29KAKELn025570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 10:20:14 GMT
Received: from [10.216.18.154] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 03:20:08 -0700
Message-ID: <83e56c43-aa2f-1648-227d-957c4c40d093@quicinc.com>
Date:   Thu, 20 Oct 2022 15:50:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dt-bindings: soundwire: Convert text file to yaml
 format
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1666092240-22008-1-git-send-email-quic_srivasam@quicinc.com>
 <Y0/wm2mOfzjtg4Kq@matsya>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Y0/wm2mOfzjtg4Kq@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2Twm5qEkKD_XipXcnN36Zcz29NlGB8ac
X-Proofpoint-ORIG-GUID: 2Twm5qEkKD_XipXcnN36Zcz29NlGB8ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/2022 6:12 PM, Vinod Koul wrote:
Thanks for your time Vinod!!!
> On 18-10-22, 16:54, Srinivasa Rao Mandadapu wrote:
>> Update soundwire bindings with yaml formats.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
>> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
>> ---
>>
>> This patch depends on:
>>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42801e6185290d63691bd39cf8a3bba6cd5fe520
> why is this dependency for yaml conversion?

Actually this patch is already landed, but getting bot error from Rob's 
repo, due to clock binding macro missing.

So mentioned here the same.

>
>> Changes since V1:
>>    -- Remove the status field in example.
>>    -- Remove interrupt-names property in the required list.
>>    -- Add the wakeup-source property.	
>>   
>>   .../devicetree/bindings/soundwire/qcom,sdw.txt     | 214 ---------------------
>>   .../devicetree/bindings/soundwire/qcom,sdw.yaml    | 186 ++++++++++++++++++
>>   2 files changed, 186 insertions(+), 214 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> deleted file mode 100644
>> index c85c257..0000000
>> --- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> +++ /dev/null
>> @@ -1,214 +0,0 @@
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
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml b/Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml
>> new file mode 100644
>> index 0000000..65bff91
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml
>> @@ -0,0 +1,186 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soundwire/qcom,sdw.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SoundWire Controller
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> +
>> +description:
>> +  This binding describes the Qualcomm SoundWire controller along with its
>> +  board specific bus parameters.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,soundwire-v1.3.0
>> +      - qcom,soundwire-v1.5.0
>> +      - qcom,soundwire-v1.5.1
>> +      - qcom,soundwire-v1.6.0
>> +
>> +  reg:
>> +    items:
>> +      - description: the base address and size of SoundWire controller
>> +                   address space.
>> +
>> +  interrupts:
>> +    items:
>> +      - description: specify the SoundWire controller core and optional
>> +                   wake IRQ.
>> +
>> +  interrupt-names:
>> +    items:
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
>> +  wakeup-source:
>> +    description: specify the Soundwire Controller is wakeup Capable.
>> +    type: boolean
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
>> +    description: size of payload channel sample.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  qcom,ports-sinterval-low:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: sample interval low of each data port.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  qcom,ports-offset1:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: payload transport window offset1 of each data port.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  qcom,ports-offset2:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: payload transport window offset2 of each data port.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  qcom,ports-lane-control:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: identify which data lane the data port uses.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  qcom,ports-block-pack-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: indicate the block packing mode.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  qcom,ports-hstart:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: identifying lowerst numbered coloum in SoundWire frame.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  qcom,ports-hstop:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: identifying highest numbered coloum in SoundWire frame.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +  qcom,ports-block-group-count:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: indicate how many sample intervals are combined into a payload.
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +required:
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - '#sound-dai-cells'
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - qcom,dout-ports
>> +  - qcom,din-ports
>> +  - qcom,ports-word-length
>> +  - qcom,ports-sinterval-low
>> +  - qcom,ports-offset1
>> +  - qcom,ports-offset2
>> +  - qcom,ports-lane-control
>> +  - qcom,ports-block-pack-mode
>> +  - qcom,ports-hstart
>> +  - qcom,ports-block-group-count
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
>> +        interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&lpass_rx_macro>;
>> +        clock-names = "iface";
>> +
>> +        qcom,din-ports = <0>;
>> +        qcom,dout-ports = <5>;
>> +
>> +        resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
>> +        reset-names = "swr_audio_cgcr";
>> +
>> +        qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
>> +        qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
>> +        qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
>> +        qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
>> +        qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
>> +        qcom,ports-block-pack-mode =    /bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
>> +        qcom,ports-hstart =             /bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
>> +        qcom,ports-hstop =              /bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
>> +        qcom,ports-block-group-count =  /bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
>> +
>> +        #sound-dai-cells = <1>;
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +    };
>> -- 
>> 2.7.4
