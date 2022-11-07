Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A912061F748
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiKGPL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKGPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:11:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CE51E733
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:11:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f37so17155780lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3q0dohr1B1Wqg58YKi6q+jVgNzW2Xc2nw9ybQvmNZHc=;
        b=tWI/s1vWIn5sTzoRZlcxRejtjjKBvfQbwhjO0hoK4JfBNxfN6QiPzayL6T7ciObx4f
         43zudhip6ECtXmP+0v3xuPzhfv4/zH8hSDmiFw3Aw1G31LFii4sJ/j247uNCckr4N4Er
         25Tszar+5ADl5zra1wPduciAnw7KRXnL1SGSkUXa/1MsYkoqKCJk+BLfdGghKP7JyoHc
         XABXrMZ1gpLQ//HqWUz7D0vZWcUddl6sNKdUb0wSOvG7/kNgr2ps+mKklvF0XSCG1LO5
         F9uz6JYsNpWSO+WPGl1FGObN4kJhDtJ6pbmjOqIuRSLE9X7cUIr/o35x64qV9ZYZHSIV
         cGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q0dohr1B1Wqg58YKi6q+jVgNzW2Xc2nw9ybQvmNZHc=;
        b=X5m/WynSImTEOvoO1aLfE09GRHiI+Y/Sys4FSvfCq10hFjENy2h8ow0r3go2PsAaJ9
         LxT2fu4Ypi7OSjJZ32CgUCAds1cBN6bBNHqxmq7n4zO/TFb8f6z09bVvivSCpWXJoWkt
         7v9OSfGvXMsDZbsy+X4HLLrlCfhpKAVMtMLSjWY/Oh/ryrA/YxidEFqICVMnOj+QUir6
         05PrkyfFh+bTR7u1zcVr/3GsGVvjuGWa6r0+RwFnmVKJYNHz+x6jgxjmjr4AwhpVQNYk
         9ciCfmWtep0p21k7+up+OGoTmF2q1sF6zvnnxPfo1jZYvE5pH0elus71Sv82JT1MZhK4
         HniA==
X-Gm-Message-State: ACrzQf3nFYJAADKcIVO2QohW+1NDuBPWWdBl7oo2nR+EpTyl7k3RDtok
        Ble01bvnWX+AKI7uz2dfI1qJ9Q==
X-Google-Smtp-Source: AMsMyM6q1mkHkrGRULuuS8+XSOGSnErj4/TRCr4EoiNjg338TyCXySEFWrCmMRMCFzXJv2UAvd5esg==
X-Received: by 2002:a05:6512:308d:b0:4a2:33d3:b8f1 with SMTP id z13-20020a056512308d00b004a233d3b8f1mr18463441lfd.133.1667833880756;
        Mon, 07 Nov 2022 07:11:20 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651220c300b0049e9122bd1bsm1274566lfr.164.2022.11.07.07.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:11:19 -0800 (PST)
Message-ID: <7abbac13-3a2b-2ea7-98d2-8bcace52c3de@linaro.org>
Date:   Mon, 7 Nov 2022 16:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] dt-bindings: soundwire: Convert text bindings to
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
References: <1667830844-31566-1-git-send-email-quic_srivasam@quicinc.com>
 <1667830844-31566-4-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667830844-31566-4-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 15:20, Srinivasa Rao Mandadapu wrote:
> Convert soundwire text bindings to DT Schema format.
> 
> Update interrupt property items as per device tree,
> as it is not appropriately described in text file.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> ---
> This patch depends on:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42801e6185290d63691bd39cf8a3bba6cd5fe520

Hi,

This is a bit surprising. You pointed to Linus' repo, so what does this
dependency mean? The Linus' repo is the mainline, there is nothing else,
so all its commits are already in every tree... unless this is an RC
fix? If so, you should rather say which RC is needed.

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
>  .../bindings/soundwire/qcom,soundwire.yaml         | 241 +++++++++++++++++++++
>  2 files changed, 241 insertions(+), 215 deletions(-)
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
> index 0000000..b0590cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> @@ -0,0 +1,241 @@
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

Missing blank line.

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

You should have here a description.

> +    properties:
> +      compatible:
> +        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - '#sound-dai-cells'
> +  - '#address-cells'
> +  - '#size-cells'
> +  - qcom,dout-ports
> +  - qcom,din-ports
> +  - qcom,ports-sinterval-low
> +  - qcom,ports-offset1
> +  - qcom,ports-offset2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
> +
> +    soundwire@3210000 {
> +        compatible = "qcom,soundwire-v1.6.0";
> +        reg = <0x03210000 0x2000>;
> +
> +        interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +                     <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        interrupt-names = "core";

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

