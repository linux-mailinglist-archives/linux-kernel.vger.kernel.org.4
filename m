Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E841D709051
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjESHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjESHV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:21:58 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C79114;
        Fri, 19 May 2023 00:21:56 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3945180bef1so1817261b6e.1;
        Fri, 19 May 2023 00:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684480916; x=1687072916;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2IOR7w7BSJsvirN+EhQ0URabvoF0Ui+FpLBmxQFZG4s=;
        b=UOyCQLpcu3OPUmxAgv8HXSHDr0HAlUUUVwIpU+pNWNzE+SuqQL7Ip2D4DstOlS0WYU
         fxQj0wXZEHvR9gd6RwK+EEkMlt31OxhGx3KkkAfLU6FGxpBxyQpCTjsB8c89jwv0+kIi
         4DqjR4/YXyo7GWNETBn8qy7IRIb3p6fQn+tXUA8CGtWW0/Rt7VEqKfhF/RRAZKjlNpXY
         JoKHApRtC1IKTSoXWlaq+RXpunJxjc+zvQz3wLmxxTvhpBcP67MDSSVRJnkG60XwEtlH
         hpDqRcpBsM2PP5CjtrrPQgFSrCGzSzPw5/LCjsDlbQikXvGywwv2lc0B2EsMbiA0FIoj
         JF+g==
X-Gm-Message-State: AC+VfDygbdfIZHiYTYXvSlOz8/HX11YPV/IO9Pv1kY5LkMDmmKsIFlmP
        zcJ/DurSpvrmoudxkx+PZrqHUuxctA==
X-Google-Smtp-Source: ACHHUZ4Hx/ZbZtRBO65aGDwUX8MoiQLM3ifAOr1OlLqTwp8zpGcZ7hKvymgvutTpYkPcafPS7gkv8w==
X-Received: by 2002:a05:6808:8c3:b0:392:5ce5:d20 with SMTP id k3-20020a05680808c300b003925ce50d20mr702787oij.48.1684480915978;
        Fri, 19 May 2023 00:21:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j24-20020a9d7698000000b006acfdbdf37csm1418756otl.31.2023.05.19.00.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 00:21:55 -0700 (PDT)
Received: (nullmailer pid 2968846 invoked by uid 1000);
        Fri, 19 May 2023 07:21:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     balbi@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        git@amd.com, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, michal.simek@amd.com,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        siva.durga.prasad.paladugu@amd.com
In-Reply-To: <20230519065940.2190786-1-piyush.mehta@amd.com>
References: <20230519065940.2190786-1-piyush.mehta@amd.com>
Message-Id: <168448091422.2968830.10066003697035225886.robh@kernel.org>
Subject: Re: [PATCH V3] dt-bindings: usb: dwc3: Add interrupt-names
 property support for wakeup interrupt
Date:   Fri, 19 May 2023 02:21:54 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 May 2023 12:29:40 +0530, Piyush Mehta wrote:
> The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
> As the DWC3 IP supports the hibernation feature, to handle the wakeup
> or hibernation interrupt, add host mode "wakeup" interrupt-names
> optional property in the binding schema to capture remote-wakeup and
> connect/ disconnect event in the hibernation state.
> 
> We have a dedicated IRQ line specifically for the hibernation feature.
> When the "wakeup" IRQ line is triggered, it initiates a hibernation
> interrupt, causing the system to wake up from the hibernation state.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> Change in V2:
> -  Addressed ROB review comments
>  - Updated name of interrupt-names property with "wakeup"
>  - Move interrupt-names property from dwc3-xilinx core to dwc3 core.
> 
> Link: https://lore.kernel.org/all/CAL_JsqK6_7XD7+w+EQvPPmbmSOpfo3JDb0xDN4StuHUm1kgchw@mail.gmail.com/
> 
> Change in V3:
> -  Addressed Krzysztof Kozlowski comments
>  - Update binding schema enum.
>  - Upadet commit message.
> 
> Link: https://lore.kernel.org/all/76dfbf27-8ad2-6e09-5354-b006b9e81af1@linaro.org/
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/dwc3-xilinx.example.dtb: usb@0: usb@fe200000:interrupt-names: More than one condition true in oneOf schema:
	{'maxItems': 3,
	 'minItems': 1,
	 'oneOf': [{'items': [{'const': 'dwc_usb3'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'items': {'enum': ['host', 'peripheral', 'otg']},
	            'type': 'array'},
	           {'items': {'enum': ['host', 'peripheral', 'otg', 'wakeup']},
	            'type': 'array'}]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/dwc3-xilinx.example.dtb: usb@0: usb@fe200000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/dwc3-xilinx.example.dtb: usb@fe200000: interrupt-names: More than one condition true in oneOf schema:
	{'maxItems': 3,
	 'minItems': 1,
	 'oneOf': [{'items': [{'const': 'dwc_usb3'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'items': {'enum': ['host', 'peripheral', 'otg']},
	            'type': 'array'},
	           {'items': {'enum': ['host', 'peripheral', 'otg', 'wakeup']},
	            'type': 'array'}]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/dwc3-xilinx.example.dtb: usb@fe200000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,am62-usb.example.dtb: usb@f910000: usb@31100000:interrupt-names: More than one condition true in oneOf schema:
	{'maxItems': 3,
	 'minItems': 1,
	 'oneOf': [{'items': [{'const': 'dwc_usb3'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'items': {'enum': ['host', 'peripheral', 'otg']},
	            'type': 'array'},
	           {'items': {'enum': ['host', 'peripheral', 'otg', 'wakeup']},
	            'type': 'array'}]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,am62-usb.example.dtb: usb@f910000: usb@31100000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,am62-usb.example.dtb: usb@31100000: interrupt-names: More than one condition true in oneOf schema:
	{'maxItems': 3,
	 'minItems': 1,
	 'oneOf': [{'items': [{'const': 'dwc_usb3'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'items': {'enum': ['host', 'peripheral', 'otg']},
	            'type': 'array'},
	           {'items': {'enum': ['host', 'peripheral', 'otg', 'wakeup']},
	            'type': 'array'}]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,am62-usb.example.dtb: usb@31100000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230519065940.2190786-1-piyush.mehta@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

