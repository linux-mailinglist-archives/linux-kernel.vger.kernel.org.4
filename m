Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5F65224A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiLTORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiLTORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:17:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE31CB05;
        Tue, 20 Dec 2022 06:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53487B812A5;
        Tue, 20 Dec 2022 14:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB36C433EF;
        Tue, 20 Dec 2022 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671545801;
        bh=aR9QMgocYSz4U3/eJjLNgSMrMPwutNnlewjFdmIWMQI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E+g1heNbk3hVgPX/xsLcnO+qMA1B/n7mMRO7BFY23RHjFVf5Jt2vgcAXq1NPSpYw/
         jZswuIsc6hoUfipvCtbCkH1LI/iRTGN5C4B6XbF97TLDCbze6Sk9TCd2eTXFLnXOr1
         cJhOg6U8Pkno1VWGThe35ikbnJ/mHFuBWb6NEMku/2t39bU1PvN2w37kcOLP6HRgyT
         KcTo0cyE7XLjzCGDK5vSnkCqu9RThBwPAplSIYLSKYtGu0nTZNCw3t/nEUGpS/WiMS
         vsMTNJE5hvJP6e8Cg8t1EbaXEIEGrh32XXDJrff1r1BF2fSQsvu9aTgVH8pPgCCJUP
         nGfnycrL2zf8w==
Message-ID: <3a0980ef-7128-1153-7016-6bb44760bf3b@kernel.org>
Date:   Tue, 20 Dec 2022 15:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/4] dt-bindings: media: Document bindings for DW MIPI
 CSI-2 Host
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        linux-media@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, luis.oliveira@synopsys.com,
        Luis Oliveira <lolivei@synopsys.com>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
 <20221216143717.1002015-2-eugen.hristev@microchip.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221216143717.1002015-2-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 15:37, Eugen Hristev wrote:
> Add bindings for Synopsys DesignWare MIPI CSI-2 host.
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> [eugen.hristev@microchip.com: reworked binding, converted to yaml]
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---

1. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC.  It might happen, that command when run on an
older kernel, gives you outdated entries.  Therefore please be sure you
base your patches on recent Linux kernel.

You did not CC anyone, so who is supposed to take this patch?

2. Subject: drop second, redundant "bindings for".

>  .../bindings/media/snps,dw-csi.yaml           | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/snps,dw-csi.yaml b/Documentation/devicetree/bindings/media/snps,dw-csi.yaml
> new file mode 100644
> index 000000000000..439eadc8e517
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/snps,dw-csi.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/snps,dw-csi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare CSI-2 Host controller (csi2host)
> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@microchip.com>
> +
> +description:
> +  CSI2HOST is used to receive image coming from an MIPI CSI-2 compatible
> +  camera. It will convert the incoming CSI-2 stream into a dedicated
> +  interface called the Synopsys IDI (Image Data Interface).
> +  This interface is a 32-bit SoC internal only, and can be assimilated
> +  with a CSI-2 interface.
> +
> +properties:
> +  compatible:
> +    const: snps,dw-csi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    description:
> +      CSI2HOST can have two clocks connected. One clock is the
> +      peripheral clock for the inside functionality of the hardware block.
> +      This is named 'perclk'. The second clock can be the phy clock,
> +      which is used to clock the phy via an internal link.
> +      This clock is named 'phyclk', phy clock.
> +    items:
> +      - const: perclk
> +      - const: phyclk

Drop "clk" from both


> +
> +  phys:
> +    maxItems: 1
> +    description: MIPI D-PHY
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing the input port.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            description: Endpoint connected to input device
> +
> +            properties:
> +              bus-type:
> +                const: 4
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 4
> +
> +              clock-lanes:
> +                maxItems: 1
> +
> +              remote-endpoint: true
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Output port node, single endpoint describing the output port.
> +
> +        properties:
> +          endpoint:
> +            unevaluatedProperties: false
> +            $ref: video-interfaces.yaml#
> +            description: Endpoint connected to output device
> +
> +            properties:
> +              bus-type:
> +                const: 4
> +
> +              remote-endpoint: true
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - ports

reg? phys? interrupts? All others?

> +
> +examples:
> +  - |
> +    csi2: csi2@3000 {

Generic node names, so "csi"

> +        compatible = "snps,dw-csi";
> +        reg = <0x03000 0x7FF>;

lowercase hex

> +        phys = <&mipi_dphy_rx>;
> +        phy-names = "dphy";
> +        resets = <&dw_rst 1>;
> +        interrupts = <2>;
> +

Best regards,
Krzysztof

