Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4535BD361
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiISRLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiISRKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:10:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0D40E1C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:09:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so48048122lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lVb+lu7bLuWuM7w2KiNdYfUMl0n4GRTV+2oijrejTlk=;
        b=Zj2lO6kdMeCmh7Bm4j7RB0qDEH8nyx0mlDIkz0gRRN77Qy+hHRChhAvw+iM/9qDYRB
         QCRBApyVEwD08Gr8XZfu9+SPIZX6VP6v7eQu4X0u5ngrLldoXguX2ATJ8+T5faNrjhBp
         sSLsjbMxOoOnkF/lqWu1bsb62lss6+tp9gVlE70Rhqd23136Cj187Bo8GatuWb4SLU3B
         Tz3c5MSazXi6H59bpuL8M17LU+go3IigRRdjwRr0gV1aJrvzWXLljPzFCapqtZGMk1Wy
         9C9tM+MDPCCRt7KT9ctc3zAhpSg4UqOKZhXRPpGrDjpplsu0Nh4TsZMMCXNu4PjAW1kH
         ZO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lVb+lu7bLuWuM7w2KiNdYfUMl0n4GRTV+2oijrejTlk=;
        b=lfAoYvA4kM50aEXSouZbvNEiJM7F19GHCI/otbPfCxfj/ewbiXH8NppwdM6PTncZlR
         ItO24UG/PcIJc1/I1O5ZB89ysVoYAo+aK1akmM/0HhAPb/6qvOb8b7pq95GChybaeelp
         mtGPn5ZXWIbIqu1btQpxuV9NR+YOAB7RGBuZoXxV1dLOFNMUw8YeymsAYXN6H3Zd4Iqz
         PvEdOEN1PJnc+9daI7I0sIVejeqnvq5uvopNpD3pC9VBd7MC0MYFPUp8CIy2pVTzv4d4
         iBfU2nMMbHQUiWbgtTTU9rVDNXis7BvtUSEJ1cob0NrcQT+howJ1fcW8EySBUPnq2zlQ
         VFOQ==
X-Gm-Message-State: ACrzQf1w1zHzQXAsG9Hww802ZOcokQxw8CfzOEafNKo9U0ukf2BbEgYc
        SmtzHAg53IOcc/Fr6QPzrCFjUg==
X-Google-Smtp-Source: AMsMyM4Lqv3V4HTNpij3bewW0+kWGfuXjph1gAaMah9LuiMCxtmvkmBws50sWVJQ1YNICioZZYfMgA==
X-Received: by 2002:a05:6512:1047:b0:49f:5309:3a0c with SMTP id c7-20020a056512104700b0049f53093a0cmr5575385lfb.683.1663607295274;
        Mon, 19 Sep 2022 10:08:15 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651234c900b00499bf7605afsm5129838lfr.143.2022.09.19.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:08:14 -0700 (PDT)
Date:   Mon, 19 Sep 2022 19:08:12 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
        richard.genoud@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, claudiu.beznea@microchip.com,
        lee@kernel.org, kavyasree.kotagiri@microchip.com,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        radu_nicolae.pirea@upb.ro, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 2/9] dt-bindings: serial: atmel,at91-usart: convert to
 json-schema
Message-ID: <20220919170812.l2sj7vyjks62ej44@krzk-bin>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com>
 <20220919150846.1148783-3-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220919150846.1148783-3-sergiu.moga@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 18:08:40 +0300, Sergiu Moga wrote:
> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
> json-schema format. Furthermore, move this binding to the
> serial directory, since binding directories match hardware,
> unlike the driver subsystems which match Linux convention.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> 
> v1 -> v2:
> - only do what the commit says, split the addition of other compatibles and
> properties in other patches
> - remove unnecessary "|"'s
> - mention header in `atmel,usart-mode`'s description
> - place `if:` under `allOf:`
> - respect order of spi0's DT properties: compatible, then reg then the reset of properties
> 
> v2 -> v3:
> - Previously [PATCH 5]
> - Check value of `atmel,usart-mode` instead of the node regex
> - Define all properties top level and disallow them explicitly for other type,
> since additionalProperties:false conflicts with referencing other schemas
> - Remove useless else if: after else:
> 
> 
> v3 -> v4:
> - add R-b tag, this was previously [PATCH 6]
> 
> 
> 
> 
>  .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ----------
>  .../bindings/serial/atmel,at91-usart.yaml     | 182 ++++++++++++++++++
>  2 files changed, 182 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


serial@200: $nodename:0: 'serial@200' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

serial@200: '#address-cells' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

serial@200: atmel,fifo-size: False schema does not allow [[16]]
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb

serial@200: atmel,fifo-size: False schema does not allow [[32]]
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

serial@200: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

serial@200: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb

serial@200: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb

serial@200: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/at91-sam9x60ek.dtb

serial@200: '#size-cells' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/at91-sama7g5ek.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

serial@200: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/at91-sam9x60ek.dtb

serial@f001c000: $nodename:0: 'serial@f001c000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f001c000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f001c000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f001c000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f001c000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f001c000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f0020000: $nodename:0: 'serial@f0020000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f0020000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f0020000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f0020000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f0020000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f0020000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f0020000: Unevaluated properties are not allowed ('dcd-gpios', 'dsr-gpios', 'dtr-gpios', 'rng-gpios' were unexpected)
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f0024000: $nodename:0: 'serial@f0024000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f0024000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb

serial@f0024000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb

serial@f0024000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb

serial@f8004000: $nodename:0: 'serial@f8004000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@f8004000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb

serial@f8004000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb

serial@f8004000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb

serial@f8004000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb

serial@f8004000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb

serial@f801c000: $nodename:0: 'serial@f801c000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9n12ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@f801c000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@f801c000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@f801c000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb

serial@f801c000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb

serial@f801c000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@f8020000: $nodename:0: 'serial@f8020000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9n12ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb45n.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f8020000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

serial@f8020000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

serial@f8020000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

serial@f8020000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

serial@f8020000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

serial@f8024000: $nodename:0: 'serial@f8024000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9n12ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb45n.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f8024000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f8024000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f8024000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f8024000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f8024000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-wb50n.dtb

serial@f8028000: $nodename:0: 'serial@f8028000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9n12ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb45n.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb

serial@f8028000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@f8028000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@f8028000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@f802c000: $nodename:0: 'serial@f802c000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@f802c000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb

serial@f802c000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb

serial@f802c000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb

serial@f8030000: $nodename:0: 'serial@f8030000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@f8030000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb

serial@f8030000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb

serial@f8030000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb

serial@f8040000: $nodename:0: 'serial@f8040000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@f8040000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-smartkiz.dtb

serial@f8040000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-smartkiz.dtb

serial@f8040000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-smartkiz.dtb

serial@f8044000: $nodename:0: 'serial@f8044000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb

serial@fc004000: $nodename:0: 'serial@fc004000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc008000: $nodename:0: 'serial@fc008000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc008000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc008000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc008000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

serial@fc008000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

serial@fc008000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc00c000: $nodename:0: 'serial@fc00c000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc00c000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc00c000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc00c000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb

serial@fc00c000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb

serial@fc00c000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc010000: $nodename:0: 'serial@fc010000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc010000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc010000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc010000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc010000: Unevaluated properties are not allowed ('linux,rs485-enabled-at-boot-time' was unexpected)
	arch/arm/boot/dts/at91-vinco.dtb

serial@fc069000: $nodename:0: 'serial@fc069000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-sama5d4ek.dtb
	arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
	arch/arm/boot/dts/at91-sama5d4_xplained.dtb
	arch/arm/boot/dts/at91-vinco.dtb

serial@fff8c000: $nodename:0: 'serial@fff8c000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff8c000: '#address-cells' is a required property
	arch/arm/boot/dts/at91sam9263ek.dtb

serial@fff8c000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91sam9263ek.dtb

serial@fff8c000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff8c000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff8c000: '#size-cells' is a required property
	arch/arm/boot/dts/at91sam9263ek.dtb

serial@fff90000: $nodename:0: 'serial@fff90000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff90000: '#address-cells' is a required property
	arch/arm/boot/dts/at91sam9m10g45ek.dtb

serial@fff90000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91sam9m10g45ek.dtb

serial@fff90000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff90000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff90000: '#size-cells' is a required property
	arch/arm/boot/dts/at91sam9m10g45ek.dtb

serial@fff94000: $nodename:0: 'serial@fff94000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff94000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff94000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fff98000: $nodename:0: 'serial@fff98000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb

serial@fff98000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb

serial@fff98000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/pm9g45.dtb

serial@fffb0000: $nodename:0: 'serial@fffb0000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb0000: '#address-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb

serial@fffb0000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb

serial@fffb0000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb0000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb0000: '#size-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb

serial@fffb0000: Unevaluated properties are not allowed ('linux,rs485-enabled-at-boot-time' was unexpected)
	arch/arm/boot/dts/animeo_ip.dtb

serial@fffb4000: $nodename:0: 'serial@fffb4000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb4000: '#address-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/ethernut5.dtb

serial@fffb4000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/ethernut5.dtb

serial@fffb4000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb4000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb4000: '#size-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/ethernut5.dtb

serial@fffb4000: Unevaluated properties are not allowed ('linux,rs485-enabled-at-boot-time', 'rs485-rts-delay' were unexpected)
	arch/arm/boot/dts/aks-cdu.dtb

serial@fffb4000: Unevaluated properties are not allowed ('linux,rs485-enabled-at-boot-time' was unexpected)
	arch/arm/boot/dts/animeo_ip.dtb

serial@fffb8000: $nodename:0: 'serial@fffb8000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb8000: '#address-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/evk-pro3.dtb

serial@fffb8000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/evk-pro3.dtb

serial@fffb8000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb8000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffb8000: '#size-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/evk-pro3.dtb

serial@fffb8000: Unevaluated properties are not allowed ('linux,rs485-enabled-at-boot-time', 'rs485-rts-delay' were unexpected)
	arch/arm/boot/dts/aks-cdu.dtb

serial@fffbc000: $nodename:0: 'serial@fffbc000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91sam9rlek.dtb

serial@fffbc000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91sam9rlek.dtb

serial@fffbc000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91sam9rlek.dtb

serial@fffc0000: $nodename:0: 'serial@fffc0000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffc0000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffc0000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffc4000: $nodename:0: 'serial@fffc4000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffc4000: '#address-cells' is a required property
	arch/arm/boot/dts/at91rm9200ek.dtb

serial@fffc4000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91rm9200ek.dtb

serial@fffc4000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffc4000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffc4000: '#size-cells' is a required property
	arch/arm/boot/dts/at91rm9200ek.dtb

serial@fffc8000: $nodename:0: 'serial@fffc8000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffc8000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffc8000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffcc000: $nodename:0: 'serial@fffcc000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffcc000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffcc000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/mpa1600.dtb

serial@fffd0000: $nodename:0: 'serial@fffd0000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd0000: '#address-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb

serial@fffd0000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb

serial@fffd0000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd0000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd0000: '#size-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb

serial@fffd0000: Unevaluated properties are not allowed ('linux,rs485-enabled-at-boot-time', 'rs485-rts-delay' were unexpected)
	arch/arm/boot/dts/aks-cdu.dtb

serial@fffd4000: $nodename:0: 'serial@fffd4000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd4000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb

serial@fffd4000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb

serial@fffd4000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd4000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd4000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb

serial@fffd8000: $nodename:0: 'serial@fffd8000' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd8000: '#address-cells' is a required property
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb

serial@fffd8000: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb

serial@fffd8000: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd8000: atmel,use-dma-tx: False schema does not allow True
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffd8000: '#size-cells' is a required property
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb

serial@ffffee00: $nodename:0: 'serial@ffffee00' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@ffffee00: '#address-cells' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@ffffee00: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@ffffee00: atmel,use-dma-rx: False schema does not allow True
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb

serial@ffffee00: '#size-cells' is a required property
	arch/arm/boot/dts/at91-dvk_som60.dtb
	arch/arm/boot/dts/at91-gatwick.dtb
	arch/arm/boot/dts/at91-kizbox2-2.dtb
	arch/arm/boot/dts/at91-nattis-2-natte-2.dtb
	arch/arm/boot/dts/at91sam9263ek.dtb
	arch/arm/boot/dts/at91sam9m10g45ek.dtb
	arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dtb
	arch/arm/boot/dts/at91-sama5d3_xplained.dtb
	arch/arm/boot/dts/at91-tse850-3.dtb
	arch/arm/boot/dts/at91-wb50n.dtb
	arch/arm/boot/dts/pm9g45.dtb
	arch/arm/boot/dts/sama5d31ek.dtb
	arch/arm/boot/dts/sama5d33ek.dtb
	arch/arm/boot/dts/sama5d34ek.dtb
	arch/arm/boot/dts/sama5d35ek.dtb
	arch/arm/boot/dts/sama5d36ek_cmp.dtb
	arch/arm/boot/dts/sama5d36ek.dtb
	arch/arm/boot/dts/tny_a9263.dtb
	arch/arm/boot/dts/usb_a9263.dtb

serial@fffff200: $nodename:0: 'serial@fffff200' does not match '^spi(@.*|-[0-9a-f])*$'
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/animeo_ip.dtb
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9n12ek.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/mpa1600.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffff200: '#address-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9n12ek.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/mpa1600.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffff200: 'atmel,usart-mode' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9n12ek.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/mpa1600.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffff200: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/at91-sam9x60ek.dtb

serial@fffff200: '#size-cells' is a required property
	arch/arm/boot/dts/aks-cdu.dtb
	arch/arm/boot/dts/at91-ariag25.dtb
	arch/arm/boot/dts/at91-ariettag25.dtb
	arch/arm/boot/dts/at91-cosino_mega2560.dtb
	arch/arm/boot/dts/at91-foxg20.dtb
	arch/arm/boot/dts/at91-kizbox.dtb
	arch/arm/boot/dts/at91-kizboxmini-base.dtb
	arch/arm/boot/dts/at91-kizboxmini-mb.dtb
	arch/arm/boot/dts/at91-kizboxmini-rd.dtb
	arch/arm/boot/dts/at91-lmu5000.dtb
	arch/arm/boot/dts/at91-q5xr5.dtb
	arch/arm/boot/dts/at91-qil_a9260.dtb
	arch/arm/boot/dts/at91rm9200ek.dtb
	arch/arm/boot/dts/at91sam9260ek.dtb
	arch/arm/boot/dts/at91sam9261ek.dtb
	arch/arm/boot/dts/at91sam9g15ek.dtb
	arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb
	arch/arm/boot/dts/at91sam9g20ek.dtb
	arch/arm/boot/dts/at91sam9g25ek.dtb
	arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dtb
	arch/arm/boot/dts/at91sam9g35ek.dtb
	arch/arm/boot/dts/at91-sam9_l9260.dtb
	arch/arm/boot/dts/at91sam9n12ek.dtb
	arch/arm/boot/dts/at91sam9rlek.dtb
	arch/arm/boot/dts/at91sam9x25ek.dtb
	arch/arm/boot/dts/at91sam9x35ek.dtb
	arch/arm/boot/dts/at91-sam9x60ek.dtb
	arch/arm/boot/dts/at91-smartkiz.dtb
	arch/arm/boot/dts/at91-wb45n.dtb
	arch/arm/boot/dts/ethernut5.dtb
	arch/arm/boot/dts/evk-pro3.dtb
	arch/arm/boot/dts/mpa1600.dtb
	arch/arm/boot/dts/tny_a9260.dtb
	arch/arm/boot/dts/tny_a9g20.dtb
	arch/arm/boot/dts/usb_a9260.dtb
	arch/arm/boot/dts/usb_a9g20.dtb
	arch/arm/boot/dts/usb_a9g20_lpw.dtb

serial@fffff200: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/at91-sam9x60ek.dtb
