Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69476B1661
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCHXQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCHXQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:16:27 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB69DEB41;
        Wed,  8 Mar 2023 15:16:26 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id bj30so331128oib.6;
        Wed, 08 Mar 2023 15:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317386;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gkX7rAQmM3AX63K1Qld4/q+GZWpaFlKF0517mS+3JsQ=;
        b=qVjRVBJyc4f5PrZP6ZSQusNpoazUrdyBzx4T94TyIz9r2Xo427Zx46g5Jtak59I2U0
         NxrJkMfLTOWAe5JG5owHVsCrSq8nrkSsSxuJmWZ76QpY03oxV48oc4LZcOhBzZc/SG3w
         0o2qlWyvRcAsjMTToIOq4QMVw6Knq1O0U/zarmPmN7HVgMK/s6r4bWjgoMo3PzGhtckL
         5Iebk5KVMur4at6+5hOdtQNDp66dFOxxXZdVaV8Wq7z5Kp/yKxvcBnf17CyHubu+oDzf
         ltsswstz2Z9LRHSZp5IgmYd+1NET9zmsW2SJ9r7kQFXL97AZmqipcGrNyFK3RP2vGPe7
         zaKQ==
X-Gm-Message-State: AO0yUKWu4jA09JqXkUo5okznWRG/AkZQFKMtu0OO9xUu9ZenQC6MNukT
        Nx1xVbhQaGhTFXU0rGII++KZphENrw==
X-Google-Smtp-Source: AK7set8eTIkftn7ZUIAF33m0MWAmUWSub9y0pDrdcRmFM6ARN5d/fSQ5EnsgtQAARqb3n7yfcyrJEQ==
X-Received: by 2002:a05:6808:3a90:b0:384:3d87:6839 with SMTP id fb16-20020a0568083a9000b003843d876839mr8655721oib.39.1678317386017;
        Wed, 08 Mar 2023 15:16:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bb16-20020a056808169000b00383ebc74edasm6836159oib.7.2023.03.08.15.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:16:25 -0800 (PST)
Received: (nullmailer pid 4056119 invoked by uid 1000);
        Wed, 08 Mar 2023 23:16:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.or,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
References: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
Message-Id: <167831736142.4055564.5049179553784335115.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: Document rohm,bd65b60 bindings
Date:   Wed, 08 Mar 2023 17:16:25 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 20:14:50 +0000, Bogdan Ionescu wrote:
> Hi all,
> 
> This is my first patch to the kernel, so I expect to have made
> some mistakes. I did my best to follow the documentation and
> submitting patches guidelines, but if I missed something, please
> let me know.
> 
> I wasn't sure if I had to add myself to the MAINTAINERS file for such a
> small patch, so I didn't.
> 
> Patch begins here:
> 
> Added devicetree bindings documentation for the rohm,bd65b60
> led driver.
> 
> Signed-off-by: Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
> ---
>  .../bindings/leds/rohm,bd65b60-leds.yaml      | 77 +++++++++++++++++++
>  include/dt-bindings/leds/leds-bd65b60.h       | 20 +++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml
>  create mode 100644 include/dt-bindings/leds/leds-bd65b60.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dts:25.17-30: Warning (reg_format): /example-0/i2c/led_controler@64:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dts:21.13-35.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dts:21.13-35.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dts:23.30-34.15: Warning (avoid_default_addr_size): /example-0/i2c/led_controler@64: Relying on default #address-cells value
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dts:23.30-34.15: Warning (avoid_default_addr_size): /example-0/i2c/led_controler@64: Relying on default #size-cells value
Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230308201451.11629-1-bogdan.ionescu.work@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

