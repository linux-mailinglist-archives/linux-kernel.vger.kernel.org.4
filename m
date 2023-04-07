Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3D26DAED0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbjDGOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDGOWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:22:02 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D5A1;
        Fri,  7 Apr 2023 07:21:57 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-17683b570b8so45759676fac.13;
        Fri, 07 Apr 2023 07:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680877316; x=1683469316;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NMIR9M1GbiWk7oGA/2V+GFh3GIKCgNeg+MN6EFnM3to=;
        b=d9R4ALeghTUQJLwsGR+CsbdKG2gNf+5Z4Q1r6IShHiwFhI/NwjVFZCcgtkdzzjBhLE
         HQR2yzNJrizoiP/9deyMNlOqqS7wwn2u5eD2icYq6X3+qbjBj85FJQ/6luYk6ljif07B
         EA6ur9qiGbzopPxfPRayjLzZ926BGagUgeoB/4j4KguQKnHzL+MstrbTe92q+YYXmewU
         a3nvm+vPx9/ozwbaY+4Mb69Q+PeZvyRoakxJlAf3sRMiIxmz5pGPG9FEoze+nFqx80mo
         RQdrWjN7baD/30v9ngXeVcW13FeA9ZRS13UDlMrbRsWKaFHQYvKzQXi3cYIJVH36Mdjv
         kLAw==
X-Gm-Message-State: AAQBX9d8OYo3SyE1e2VKBKthgiCjEq/xuMBixkI7yXJrFU/HTWKSqoui
        Uc3VeZy4gjSPgerVuxXGgg==
X-Google-Smtp-Source: AKy350b/+e/EnCQS6A6IciZNVcnyRxRm4mJKpC51Qck5j3M+4aEIHe0nOKJg64J+Py4r8vCgLUCATA==
X-Received: by 2002:a05:6870:5692:b0:15f:e044:23b2 with SMTP id p18-20020a056870569200b0015fe04423b2mr1915525oao.7.1680877316381;
        Fri, 07 Apr 2023 07:21:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id yg21-20020a05687c009500b0016a37572d17sm1725734oab.2.2023.04.07.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 07:21:55 -0700 (PDT)
Received: (nullmailer pid 2506786 invoked by uid 1000);
        Fri, 07 Apr 2023 14:21:55 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Fred Treven <fred.treven@cirrus.com>
Cc:     ben.bright@cirrus.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, james.ogletree@cirrus.com,
        robh+dt@kernel.org, patches@opensource.cirrus.com,
        dmitry.torokhov@gmail.com, devicetree@vger.kernel.org,
        krzystztof.kozlowski+dt@linaro.org
In-Reply-To: <1680819613-29256-1-git-send-email-fred.treven@cirrus.com>
References: <Add devicetree bindings for CS40L26 driver>
 <1680819613-29256-1-git-send-email-fred.treven@cirrus.com>
Message-Id: <168087712059.2500855.14244097462998293799.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: input: cirrus,cs40l26: Add bindings
Date:   Fri, 07 Apr 2023 09:21:55 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Apr 2023 17:20:13 -0500, Fred Treven wrote:
> Add devicetree bindings for CS40L26 driver.
> 
> Signed-off-by: Fred Treven <fred.treven@cirrus.com>
> ---
>  .../devicetree/bindings/input/cs40l26.yaml         | 92 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cs40l26.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/cs40l26.example.dts:24.13-26: Warning (reg_format): /example-0/i2c/cs40l26@58:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/input/cs40l26.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/cs40l26.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/cs40l26.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/cs40l26.example.dts:21.13-34.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
Documentation/devicetree/bindings/input/cs40l26.example.dts:21.13-34.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/input/cs40l26.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/cs40l26.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/input/cs40l26.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/cs40l26.example.dts:22.31-33.13: Warning (avoid_default_addr_size): /example-0/i2c/cs40l26@58: Relying on default #address-cells value
Documentation/devicetree/bindings/input/cs40l26.example.dts:22.31-33.13: Warning (avoid_default_addr_size): /example-0/i2c/cs40l26@58: Relying on default #size-cells value
Documentation/devicetree/bindings/input/cs40l26.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/cs40l26.example.dtb: cs40l26@58: 'cirrus,bst-exploratory-mode-disabled', 'reset-gpios' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/cs40l26.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1680819613-29256-1-git-send-email-fred.treven@cirrus.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

