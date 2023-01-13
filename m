Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FFE669958
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbjAMODY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbjAMOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:02:19 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B66E0FB;
        Fri, 13 Jan 2023 06:00:00 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id 187-20020a4a09c4000000b004d8f3cb09f5so5583078ooa.6;
        Fri, 13 Jan 2023 06:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uZVsiiDFInMIYEyzsy3Bu1x3TAY2YUibFW063HMGFlk=;
        b=ApbjVo3GetKKCxgzBiAE6f0GeYC6ndXbZJtSRWvfqarusgprhD24Sqd4HmSv9RAix5
         BWObjfGSY9GofsmFi+9tBcUzf105GEFlUtiMlTAnzvoeB1lg8kIgk5iQaYvvYkfO4U5T
         9KITYE3LNDYXOORRGbW3KANM8pmuNK9+u6qAQBNR3MDoeg5TU0Gwjym5N8d9gXNuL16Q
         9svBvpYtBXnfulOW/cLlsfAfnq44PiFhcBX+boRi77kXYwFbP5tg3kUS62gWzjarwBTp
         sf0W5eA3BGW2Kp0KNLKGPmnNW+fFvCExqAy28iA956dyk5gFGTd7z/UmhGerI3x/fRCp
         r6Mg==
X-Gm-Message-State: AFqh2kqL0VkiqG0C9CwSHp65f+8Z3ZTdOLU181qMc74X5kJJF/0C/O7s
        lipS79NarOQVGEbHlgAa7FmaSUhwFw==
X-Google-Smtp-Source: AMrXdXtIXR+6N8+6lDovnIqPSzO+JJfIUn0YeR827eClQoLJi48Dd+XNQmJsTqIEyeCPVlyghAGt+Q==
X-Received: by 2002:a4a:4fc1:0:b0:4af:1fd2:9175 with SMTP id c184-20020a4a4fc1000000b004af1fd29175mr5619984oob.2.1673618399173;
        Fri, 13 Jan 2023 05:59:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x6-20020a4aaa06000000b004f11e1ce173sm9840862oom.5.2023.01.13.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:59:58 -0800 (PST)
Received: (nullmailer pid 1789674 invoked by uid 1000);
        Fri, 13 Jan 2023 13:59:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113073045.4008853-1-tanmay.shah@amd.com>
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
Message-Id: <167361772796.1774342.1206394709563551124.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Date:   Fri, 13 Jan 2023 07:59:58 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jan 2023 23:30:46 -0800, Tanmay Shah wrote:
> This patch introduces bindings for TCM memory address space on AMD-xilinx
> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
> driver. This bindings will help in defining TCM in device-tree and
> make it's access platform agnostic and data-driven from the driver.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  .../devicetree/bindings/sram/xlnx,tcm.yaml    | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:28.21-70: Warning (reg_format): /example-0/amba/sram@ffe00000/tcm-lockstep@ffe00000:reg: property has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:43.21-70: Warning (reg_format): /example-0/amba/sram@ffe00000/tcm-core@0:reg: property has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:56.21-70: Warning (reg_format): /example-0/amba/sram@ffe00000/tcm-core@1:reg: property has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:30.21-85: Warning (ranges_format): /example-0/amba/sram@ffe00000/tcm-lockstep@ffe00000:ranges: "ranges" property has invalid length (24 bytes) (parent #address-cells == 2, child #address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:45.21-85: Warning (ranges_format): /example-0/amba/sram@ffe00000/tcm-core@0:ranges: "ranges" property has invalid length (24 bytes) (parent #address-cells == 2, child #address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:58.21-85: Warning (ranges_format): /example-0/amba/sram@ffe00000/tcm-core@1:ranges: "ranges" property has invalid length (24 bytes) (parent #address-cells == 2, child #address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:21.27-62.15: Warning (unit_address_vs_reg): /example-0/amba/sram@ffe00000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:22.39-35.19: Warning (avoid_default_addr_size): /example-0/amba/sram@ffe00000/tcm-lockstep@ffe00000: Relying on default #address-cells value
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:22.39-35.19: Warning (avoid_default_addr_size): /example-0/amba/sram@ffe00000/tcm-lockstep@ffe00000: Relying on default #size-cells value
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:37.28-48.19: Warning (avoid_default_addr_size): /example-0/amba/sram@ffe00000/tcm-core@0: Relying on default #address-cells value
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:37.28-48.19: Warning (avoid_default_addr_size): /example-0/amba/sram@ffe00000/tcm-core@0: Relying on default #size-cells value
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:50.28-61.19: Warning (avoid_default_addr_size): /example-0/amba/sram@ffe00000/tcm-core@1: Relying on default #address-cells value
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dts:50.28-61.19: Warning (avoid_default_addr_size): /example-0/amba/sram@ffe00000/tcm-core@1: Relying on default #size-cells value
Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: sram@ffe00000: tcm-lockstep@ffe00000:reg: [[4292870144, 131072], [4293001216, 131072]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtd.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: sram@ffe00000: tcm-core@0:reg: [[4292870144, 65536], [4293001216, 65536]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtd.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sram/xlnx,tcm.example.dtb: sram@ffe00000: tcm-core@1:reg: [[4293459968, 65536], [4293591040, 65536]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtd.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230113073045.4008853-1-tanmay.shah@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

