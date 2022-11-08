Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53A621138
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiKHMqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiKHMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:46:02 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9B451C2A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:45:58 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t10so20994748ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRLn+q2Sr6az32MM0KNfnzB5vk15Q8nQydm2qP/MZnI=;
        b=NRhHfzYPM/8JsY9WF4Cpl0wqLHWUBlAWGDAmeDuewOxIvlLC/1ea9VRPVZBYSL+ZOJ
         OvvmEFnOtaaU/zUrdBK1IhcNs5rneNi98QfMys0U8jW06rO4Ui3Lfyf8yCPn+7GZF5RG
         t/l1MQiADzVP68f3MvurVSekSClUs4xioMRf/a3Hz/TUo4XGw4rcc6FE4Cb+R5bCLgdw
         GKmP2maNDcvhJQBHcPJiSoeLsvjj1PiNJ4/0CdCqG9iBXOVx9qOI/ArArKUIXcGZ/KVy
         24c8heBd0zHQxrsD4vKR3MFQ29iQzNd6xAC8dSHcFXd2okDE99iM5BP6ShA4Klh1fZMD
         ylNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRLn+q2Sr6az32MM0KNfnzB5vk15Q8nQydm2qP/MZnI=;
        b=Zc0Y0y7aSZjmSB6qyb120DXFGQkkXDx5hJNj89F3nqgR39bT9v4/766560SeWesYlG
         B4+Xaxk3P5HhQ/ubACuT9DXPl1+BwuFI/EwQifPif8gLVcMC+NHFimJYCjqrckiV2HS/
         Qy9PyGf2Qp+T07chnulnjMWsc6ynrHAXVXOAzGE+pEnQKl9nUNMprxslibI8rAEVhTpG
         DkrmR96I72R/JPLNBB3yoE2i0tvUgRY/dAYyYJGes5CeXYoOBohYcgySh5BxqvDBJ3vV
         TlMz9AgIxxbWLN7chp5zHAH1jgP7hTBb/uTRa9O8gYctDyfVce9gBdx/mXki9PxRg7ew
         q/JA==
X-Gm-Message-State: ACrzQf0DFte83zJKap6n8/JUcYzpJwjSlKS8zRjPLZc2ZvFZfNNFSqYP
        5NHVQa3cWDKKsrR/zryp2DImrw==
X-Google-Smtp-Source: AMsMyM51lEJ5noXhwXCsUy3UlXAS1YoU9eGpGMYJULFvBPn7BOL5tW8bH9yKciQdB1gFLDSKFi6U2Q==
X-Received: by 2002:a2e:3507:0:b0:277:388:3fa5 with SMTP id z7-20020a2e3507000000b0027703883fa5mr6860466ljz.41.1667911557016;
        Tue, 08 Nov 2022 04:45:57 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id i5-20020a2e2205000000b0026dd4be2290sm1714414lji.90.2022.11.08.04.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 04:45:56 -0800 (PST)
Message-ID: <ec87eaa6-2e76-db16-f300-686a92e4f324@linaro.org>
Date:   Tue, 8 Nov 2022 13:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 4/4] dt-bindings: soundwire: Convert text bindings to
 DT Schema
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
 <1667911156-19238-5-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667911156-19238-5-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 13:39, Srinivasa Rao Mandadapu wrote:
> Convert soundwire text bindings to DT Schema format.
> 
> Update interrupt property items as per device tree,
> as it is not appropriately described in text file.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> ---
> Changes since V4:
>   -- Update interrupt names in example.
>   -- Fix blank lines.
>   -- Remove dependecy patch info.
> Changes since V3:
>   -- Remove subnode description and add appropriate pattern properties.
>   -- Add interrput names in example.
>   -- update some properties description.
>   -- Revert minIteams change in previous version.
>   -- Rebase to latest code base.
> Changes since V2:
>   -- Update commit message.
>   -- Add child node property.
>   -- Change file name.
>   -- Remove minIteams for few properties.
>   -- Remove redundant required properties.
>   -- Remove redundant description for wakeup-source property.
>   -- Update interrupt property items.
> Changes since V1:
>   -- Remove the status field in example.
>   -- Remove interrupt-names property in the required list.
>   -- Add the wakeup-source property.	
>  
>  .../devicetree/bindings/soundwire/qcom,sdw.txt     | 215 ------------------
>  .../bindings/soundwire/qcom,soundwire.yaml         | 244 +++++++++++++++++++++
>  2 files changed, 244 insertions(+), 215 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> deleted file mode 100644
> index e0faed8..0000000
> --- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> +++ /dev/null
> @@ -1,215 +0,0 @@
> -Qualcomm SoundWire Controller Bindings
> -
> -
> -This binding describes the Qualcomm SoundWire Controller along with its
> -board specific bus parameters.
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
> -		    Example:
> -			"qcom,soundwire-v1.3.0"
> -			"qcom,soundwire-v1.5.0"
> -			"qcom,soundwire-v1.5.1"
> -			"qcom,soundwire-v1.6.0"
> -			"qcom,soundwire-v1.7.0"
> -- reg:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: the base address and size of SoundWire controller
> -		    address space.
> -
> -- interrupts:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: should specify the SoundWire Controller core and optional
> -		    wake IRQ
> -
> -- interrupt-names:
> -	Usage: Optional
> -	Value type: boolean
> -	Value type: <stringlist>
> -	Definition: should be "core" for core and "wakeup" for wake interrupt.
> -
> -- wakeup-source:
> -	Usage: Optional
> -	Value type: boolean
> -	Definition: should specify if SoundWire Controller is wake up capable.
> -
> -- clock-names:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: should be "iface" for SoundWire Controller interface clock
> -
> -- clocks:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: should specify the SoundWire Controller interface clock
> -
> -- #sound-dai-cells:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: must be 1 for digital audio interfaces on the controller.
> -
> -- qcom,dout-ports:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: must be count of data out ports
> -
> -- qcom,din-ports:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: must be count of data in ports
> -
> -- qcom,ports-offset1:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: should specify payload transport window offset1 of each
> -		    data port. Out ports followed by In ports.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,ports-offset2:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: should specify payload transport window offset2 of each
> -		    data port. Out ports followed by In ports.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,ports-sinterval-low:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: should be sample interval low of each data port.
> -		    Out ports followed by In ports. Used for Sample Interval
> -		    calculation.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,ports-word-length:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: should be size of payload channel sample.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,ports-block-pack-mode:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: should be 0 or 1 to indicate the block packing mode.
> -		    0 to indicate Blocks are per Channel
> -		    1 to indicate Blocks are per Port.
> -		    Out ports followed by In ports.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,ports-block-group-count:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: should be in range 1 to 4 to indicate how many sample
> -		    intervals are combined into a payload.
> -		    Out ports followed by In ports.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,ports-lane-control:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: should be in range 0 to 7 to identify which	data lane
> -		    the data port uses.
> -		    Out ports followed by In ports.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,ports-hstart:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: should be number identifying lowerst numbered coloum in
> -		    SoundWire Frame, i.e. left edge of the Transport sub-frame
> -		    for each port. Values between 0 and 15 are valid.
> -		    Out ports followed by In ports.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,ports-hstop:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: should be number identifying highest numbered coloum in
> -		    SoundWire Frame, i.e. the right edge of the Transport
> -		    sub-frame for each port. Values between 0 and 15 are valid.
> -		    Out ports followed by In ports.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- qcom,dports-type:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: should be one of the following types
> -		    0 for reduced port
> -		    1 for simple ports
> -		    2 for full port
> -		    Out ports followed by In ports.
> -		    Value of 0xFF indicates that this option is not implemented
> -		    or applicable for the respective data port.
> -		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -- reset:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: Should specify the SoundWire audio CSR reset controller interface,
> -		    which is required for SoundWire version 1.6.0 and above.
> -
> -- reset-names:
> -	Usage: optional
> -	Value type: <stringlist>
> -	Definition: should be "swr_audio_cgcr" for SoundWire audio CSR reset
> -		    controller interface.
> -
> -Note:
> -	More Information on detail of encoding of these fields can be
> -found in MIPI Alliance SoundWire 1.0 Specifications.
> -
> -= SoundWire devices
> -Each subnode of the bus represents SoundWire device attached to it.
> -The properties of these nodes are defined by the individual bindings.
> -
> -= EXAMPLE
> -The following example represents a SoundWire controller on DB845c board
> -which has controller integrated inside WCD934x codec on SDM845 SoC.
> -
> -soundwire: soundwire@c85 {
> -	compatible = "qcom,soundwire-v1.3.0";
> -	reg = <0xc85 0x20>;
> -	interrupts = <20 IRQ_TYPE_EDGE_RISING>;
> -	clocks = <&wcc>;
> -	clock-names = "iface";
> -	resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
> -	reset-names = "swr_audio_cgcr";
> -	#sound-dai-cells = <1>;
> -	qcom,dports-type = <0>;
> -	qcom,dout-ports	= <6>;
> -	qcom,din-ports	= <2>;
> -	qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
> -	qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
> -	qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
> -
> -	/* Left Speaker */
> -	left{
> -		....
> -	};
> -
> -	/* Right Speaker */
> -	right{
> -		....
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> new file mode 100644
> index 0000000..4114c5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> @@ -0,0 +1,244 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SoundWire Controller
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> +
> +description:
> +  The Qualcomm SoundWire controller along with its board specific bus parameters.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,soundwire-v1.3.0
> +      - qcom,soundwire-v1.5.0
> +      - qcom,soundwire-v1.5.1
> +      - qcom,soundwire-v1.6.0
> +      - qcom,soundwire-v1.7.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: specify the SoundWire controller core.
> +      - description: specify the Soundwire controller wake IRQ.
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: core
> +      - const: wakeup
> +
> +  clocks:
> +    items:
> +      - description: iface clock
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +
> +  resets:
> +    items:
> +      - description: SWR_AUDIO_CGCR RESET
> +
> +  reset-names:
> +    items:
> +      - const: swr_audio_cgcr
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 0
> +
> +  wakeup-source: true
> +
> +  qcom,din-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: count of data in ports
> +
> +  qcom,dout-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: count of data out ports
> +
> +  qcom,ports-word-length:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Size of payload channel sample.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 5
> +
> +  qcom,ports-sinterval-low:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Sample interval low of each data port.
> +                 Out ports followed by In ports. Used for Sample Interval
> +                 calculation.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 8
> +
> +  qcom,ports-offset1:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Payload transport window offset1 of each
> +                 data port. Out ports followed by In ports.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 8
> +
> +  qcom,ports-offset2:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Payload transport window offset2 of each
> +                 data port. Out ports followed by In ports.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 8
> +
> +  qcom,ports-lane-control:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Identify which data lane the data port uses.
> +                 Out ports followed by In ports.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 5
> +
> +  qcom,ports-block-pack-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Indicate the block packing mode.
> +                 0 to indicate Blocks are per Channel
> +                 1 to indicate Blocks are per Port.
> +                 Out ports followed by In ports.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 8
> +
> +  qcom,ports-hstart:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Identifying lowerst numbered coloum in
> +                 SoundWire Frame, i.e. left edge of the Transport sub-frame
> +                 for each port. Values between 0 and 15 are valid.

minimum: 0
maximum: 15
and drop that one sentence.

The same in other places.

> +                 Out ports followed by In ports.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 5
> +
> +  qcom,ports-hstop:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Identifying highest numbered coloum in
> +                 SoundWire Frame, i.e. the right edge of the Transport
> +                 sub-frame for each port. Values between 0 and 15 are valid.
> +                 Out ports followed by In ports.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 5
> +
> +  qcom,ports-block-group-count:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: In range 1 to 4 to indicate how many sample
> +                 intervals are combined into a payload.
> +                 Out ports followed by In ports.
> +                 Value of 0xFF indicates that this option is not implemented
> +                 or applicable for the respective data port.
> +                 More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 5
> +
> +  label:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f],[0-9a-f]$":
> +    type: object
> +    description: Child nodes for a standalone audio codec or speaker amplifier IC.
> +                 It has RX and TX Soundwire slave devices.

s/slave/secondary/

This is some odd indentation. Please use standard, like example-schema
is showing, so:

    description:
      Child nodes for a standalone audio codec or speaker amplifier IC.
      RX and TX Soundwire slave devices.

It looks you used such pattern in other places here - they should also
be corrected.

> +    properties:
> +      compatible:
> +        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> +


Best regards,
Krzysztof

