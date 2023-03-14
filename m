Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7CE6B9763
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjCNOLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjCNOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:10:50 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285E18E3F2;
        Tue, 14 Mar 2023 07:10:43 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id m22so6449809ioy.4;
        Tue, 14 Mar 2023 07:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803042;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kvo3o7iBOZ0SitIt/v03D3djxGZS2cc9kZtOLnMfPWw=;
        b=p+ynSjweluMYjr9Nu6hpKU+JPB0SwxmYNY8fbVcaBHlnSidYW0cnHr9LjJkcnRIWEZ
         FI0lulf83n4LiDm4KPbdI1eywJjw+ry2PvUR+G6K98mZjmAQYLvRhwTh9kkKf2h8vSMP
         3JDXAN5eCmArjgySp7+4YvstKb2XoWCI4Qr1C/gnum7Rrc9USJf+PelybAA6N9OIseJq
         TvTngHj8Y6q4f0/GVS7IXHk8cyREFOxZzZjQNpko2HW0YQqoIKb80xMgkw7/ZSReCybr
         kbHkXOAV81itwihO6T6/SppRP/TxWKOxzen4PVuqXF/9CoJcQ6mUhXIlGxBEbTKoO3xi
         WO+g==
X-Gm-Message-State: AO0yUKVWezpxp38qI2TCdhSI2rI2jDdubZNWXEAnDS4HaUXa6umRR44G
        ZsoNJ/E+vgqCZyfGd78uK2rLOlfPHA==
X-Google-Smtp-Source: AK7set8ACG0kSoQkv6VrxHrp+10R+OZ6fW7tNemyOQje4bekljWOx5pe5rtb2DbjX232JVkUkLxoyg==
X-Received: by 2002:a6b:cf05:0:b0:74c:9907:e5b4 with SMTP id o5-20020a6bcf05000000b0074c9907e5b4mr8795099ioa.6.1678803042294;
        Tue, 14 Mar 2023 07:10:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a22-20020a02ac16000000b003ed8808d450sm787450jao.161.2023.03.14.07.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:10:40 -0700 (PDT)
Received: (nullmailer pid 83795 invoked by uid 1000);
        Tue, 14 Mar 2023 14:10:19 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     bparrot@ti.com, robh+dt@kernel.org, mchehab@kernel.org,
        tomi.valkeinen@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        martyn.welch@collabora.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        u-kumar1@ti.com, praneeth@ti.com, nm@ti.com, j-luthra@ti.com,
        vigneshr@ti.com, devarsht@ti.com,
        niklas.soderlund+renesas@ragnatech.se, sakari.ailus@linux.intel.com
In-Reply-To: <20230314115516.667-13-vaishnav.a@ti.com>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <20230314115516.667-13-vaishnav.a@ti.com>
Message-Id: <167880254910.26054.12313108385082876859.robh@kernel.org>
Subject: Re: [PATCH v7 12/13] media: dt-bindings: Add DT bindings for TI
 J721E CSI2RX driver
Date:   Tue, 14 Mar 2023 09:10:19 -0500
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


On Tue, 14 Mar 2023 17:25:15 +0530, Vaishnav Achath wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> parts together.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> (no changes since v5)
> 
> Changes in v5:
> - Add Laurent's and Rob's R-by.
> 
> Changes in v2:
> - Rename to ti,j721e-csi2rx.yaml
> - Add an entry in MAINTAINERS.
> - Add a description for the binding.
> - Change compatible to ti,j721e-csi2rx to make it SoC specific.
> - Remove description from dmas, reg, power-domains.
> - Remove a limit of 2 from #address-cells and #size-cells.
> - Fix add ^ to csi-bridge subnode regex.
> - Make ranges mandatory.
> - Add unit address in example.
> - Add a reference to cdns,csi2rx in csi-bridge subnode.
> - Expand the example to include the csi-bridge subnode as well.
> - Re-order subject prefixes.
> 
>  .../bindings/media/ti,j721e-csi2rx.yaml       | 101 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx.example.dtb: ticsi2rx@4500000: csi-bridge@4504000: False schema does not allow {'compatible': ['cdns,csi2rx'], 'reg': [[72368128, 4096]], 'clocks': [[4294967295, 26, 2], [4294967295, 26, 0], [4294967295, 26, 2], [4294967295, 26, 2], [4294967295, 26, 3], [4294967295, 26, 3]], 'clock-names': ['sys_clk', 'p_clk', 'pixel_if0_clk', 'pixel_if1_clk', 'pixel_if2_clk', 'pixel_if3_clk'], 'phys': [[4294967295]], 'phy-names': ['dphy'], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]], 'bus-type': [[4]], 'clock-lanes': [[0]], 'data-lanes': [[1, 2]]}}}}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
Documentation/devicetree/bindings/media/ti,j721e-csi2rx.example.dtb: /example-0/ticsi2rx@4500000/csi-bridge@4504000: failed to match any schema with compatible: ['cdns,csi2rx']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230314115516.667-13-vaishnav.a@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

