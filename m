Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA1604630
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJSNAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiJSM7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0ACEF584;
        Wed, 19 Oct 2022 05:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9396461879;
        Wed, 19 Oct 2022 12:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2514CC433D6;
        Wed, 19 Oct 2022 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666183328;
        bh=jvfxDN8r/XizL0ChTBmSaxeamI0jxplna9DW+B+RXNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iB6ZNL25Gep/vI3OUdogByimx2cwdGaRzSGrGnCnh5vcbVhXHjudaYowfNdgmtsk/
         /BkVPSTlX0reEimIg7/Q9hS8E+YxKv2Lue3SLStFN2/KWu36OuwK3aogOU5KAkVYpf
         SX1RFW0QIZNJ8vey4+dpCegmsxV93u3ZmDfxKILeO62At5+KR3iLN5Jaxsa9cXI/HD
         iMOVh+y6yA7Awo/kfYHbJFfQN2gxoCIaCtqNyROssDHHTdzrdR6cuw3fAHQjGfmcam
         HoLPCnctn9rJF3vttU1CrqAl1xxnXgqThJmcmH3fqIo/tLRh+Xa6/ked7WNgUL3Wzt
         1OiUS7kvN5VPA==
Date:   Wed, 19 Oct 2022 18:12:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Subject: Re: [PATCH v2] dt-bindings: soundwire: Convert text file to yaml
 format
Message-ID: <Y0/wm2mOfzjtg4Kq@matsya>
References: <1666092240-22008-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666092240-22008-1-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-22, 16:54, Srinivasa Rao Mandadapu wrote:
> Update soundwire bindings with yaml formats.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> ---
> 
> This patch depends on:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42801e6185290d63691bd39cf8a3bba6cd5fe520

why is this dependency for yaml conversion?

> 
> Changes since V1:
>   -- Remove the status field in example.
>   -- Remove interrupt-names property in the required list.
>   -- Add the wakeup-source property.	
>  
>  .../devicetree/bindings/soundwire/qcom,sdw.txt     | 214 ---------------------
>  .../devicetree/bindings/soundwire/qcom,sdw.yaml    | 186 ++++++++++++++++++
>  2 files changed, 186 insertions(+), 214 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> deleted file mode 100644
> index c85c257..0000000
> --- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> +++ /dev/null
> @@ -1,214 +0,0 @@
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
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml b/Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml
> new file mode 100644
> index 0000000..65bff91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml
> @@ -0,0 +1,186 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soundwire/qcom,sdw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SoundWire Controller
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> +
> +description:
> +  This binding describes the Qualcomm SoundWire controller along with its
> +  board specific bus parameters.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,soundwire-v1.3.0
> +      - qcom,soundwire-v1.5.0
> +      - qcom,soundwire-v1.5.1
> +      - qcom,soundwire-v1.6.0
> +
> +  reg:
> +    items:
> +      - description: the base address and size of SoundWire controller
> +                   address space.
> +
> +  interrupts:
> +    items:
> +      - description: specify the SoundWire controller core and optional
> +                   wake IRQ.
> +
> +  interrupt-names:
> +    items:
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
> +  wakeup-source:
> +    description: specify the Soundwire Controller is wakeup Capable.
> +    type: boolean
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
> +    description: size of payload channel sample.
> +    minItems: 5
> +    maxItems: 5
> +
> +  qcom,ports-sinterval-low:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: sample interval low of each data port.
> +    minItems: 5
> +    maxItems: 5
> +
> +  qcom,ports-offset1:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: payload transport window offset1 of each data port.
> +    minItems: 5
> +    maxItems: 5
> +
> +  qcom,ports-offset2:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: payload transport window offset2 of each data port.
> +    minItems: 5
> +    maxItems: 5
> +
> +  qcom,ports-lane-control:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: identify which data lane the data port uses.
> +    minItems: 5
> +    maxItems: 5
> +
> +  qcom,ports-block-pack-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: indicate the block packing mode.
> +    minItems: 5
> +    maxItems: 5
> +
> +  qcom,ports-hstart:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: identifying lowerst numbered coloum in SoundWire frame.
> +    minItems: 5
> +    maxItems: 5
> +
> +  qcom,ports-hstop:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: identifying highest numbered coloum in SoundWire frame.
> +    minItems: 5
> +    maxItems: 5
> +
> +  qcom,ports-block-group-count:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: indicate how many sample intervals are combined into a payload.
> +    minItems: 5
> +    maxItems: 5
> +
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - '#sound-dai-cells'
> +  - '#address-cells'
> +  - '#size-cells'
> +  - qcom,dout-ports
> +  - qcom,din-ports
> +  - qcom,ports-word-length
> +  - qcom,ports-sinterval-low
> +  - qcom,ports-offset1
> +  - qcom,ports-offset2
> +  - qcom,ports-lane-control
> +  - qcom,ports-block-pack-mode
> +  - qcom,ports-hstart
> +  - qcom,ports-block-group-count
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
> +        interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&lpass_rx_macro>;
> +        clock-names = "iface";
> +
> +        qcom,din-ports = <0>;
> +        qcom,dout-ports = <5>;
> +
> +        resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
> +        reset-names = "swr_audio_cgcr";
> +
> +        qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
> +        qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
> +        qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
> +        qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
> +        qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +        qcom,ports-block-pack-mode =    /bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
> +        qcom,ports-hstart =             /bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
> +        qcom,ports-hstop =              /bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
> +        qcom,ports-block-group-count =  /bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
> +
> +        #sound-dai-cells = <1>;
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +    };
> -- 
> 2.7.4

-- 
~Vinod
