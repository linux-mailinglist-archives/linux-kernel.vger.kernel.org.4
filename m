Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6854F6C12D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCTNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCTNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:11:22 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF422104;
        Mon, 20 Mar 2023 06:11:20 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17683b570b8so12898911fac.13;
        Mon, 20 Mar 2023 06:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317879;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DBr9c5b67bRojO7ujP8kx0WSXnrTxlAuuYnRf7yafXk=;
        b=H043XpUEn8F9JCTJ8bEBaWzeZ2M2hl4xdbvxNWd/nmI/ZZbX21GkDVx/QlJCr0SJbs
         W1x4yA5IxBojnQltkrTz9/PGEvdxQTkSsmvvrvJoQXIknBJTZrBCtbCzmonHTXMVMN5e
         FBT3aqTkDZEDHP6dLELb9XEUDPw9EszU2Aq0IfKaDP7z+VyMCfVCkBtQ6EiXDYF4bAF4
         il+SH/E1OULxliB/bMCBx4oOWiQnL+9b6zJ42rkieN/MqUpRNhjOY2uLURxg6ntvwqst
         4z7KSdx5eSmB7h4j6V0DZHEgh2YrG5uC9zcKHIbK4ZWpVFq14BraTHLrQNQWqxCvz5Q2
         1d2g==
X-Gm-Message-State: AO0yUKVAgTSJ+4bpM8H+wAWmTG0JirHMg5AaZ5qFA91aDbkuHj1UplVB
        wim2UGqsLqOG6kQ+Eg4mqw==
X-Google-Smtp-Source: AK7set+kAhkcOQ9jmYGffSEAwz3MqFLZgdXjIcCXTR5S4JEeE40EwhfCCF+T0rohxxxly9WNpXMOaw==
X-Received: by 2002:a05:6871:5c6:b0:17e:cb7:29bc with SMTP id v6-20020a05687105c600b0017e0cb729bcmr4589960oan.13.1679317879289;
        Mon, 20 Mar 2023 06:11:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id tl3-20020a0568718a0300b001777dc4dac1sm3246334oab.39.2023.03.20.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:11:18 -0700 (PDT)
Received: (nullmailer pid 1433164 invoked by uid 1000);
        Mon, 20 Mar 2023 13:11:18 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     stern@rowland.harvard.edu, vigneshr@ti.com,
        devicetree@vger.kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, srk@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, r-gunasekaran@ti.com
In-Reply-To: <20230320093447.32105-2-rogerq@kernel.org>
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-2-rogerq@kernel.org>
Message-Id: <167931771710.1430059.457411418248576558.robh@kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: usb: snps,dwc3: Add
 'snps,gadget-keep-connect-sys-sleep'
Date:   Mon, 20 Mar 2023 08:11:18 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Mar 2023 11:34:46 +0200, Roger Quadros wrote:
> The current USB gadget driver behaviour is to stop the controller
> and disconnect from the bus during System sleep.
> 
> The 'snps,gadget-keep-connect-sys-sleep' property can be used to
> change this behaviour and keep the controller active and connected
> to the bus during System sleep. This is useful for applications
> that want to enter a low power state when USB is suspended but
> remain connected so they can resume activity on USB resume.
> 
> This feature introduces a new constraint if Gadget driver is connected
> to USB host: i.e.  the gadget must be in USB suspend state to allow
> a System sleep as we cannot process any USB transactions
> when in System sleep.
> 
> The system hardware is responsible to detect the end of USB suspend
> and wake up the system so we can begin processing the USB transactions
> as soon as possible.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/qcom,dwc3.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,gadget-keep-connect-sys-sleep: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,gadget-keep-connect-sys-sleep: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,gadget-keep-connect-sys-sleep: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
./Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/ti,am62-usb.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230320093447.32105-2-rogerq@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

