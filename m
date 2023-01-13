Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB922669C72
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjAMPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAMPdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:33:23 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E9497489;
        Fri, 13 Jan 2023 07:26:56 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-15eeec85280so1491745fac.11;
        Fri, 13 Jan 2023 07:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFl6Q4g7MPhzi7rFCI7S01WgROoiezHHCsRIPY7pB5A=;
        b=Q/Yr6YH2j93UtzVPoPDrDOxAChPbfy1UxyFD0pCaMv9ngmyGCx7aKzLT/gFcy4ibbV
         oe807k1/uAapqiDZbQ3AMVS/c4B617dRgOUTTJ2DkxwGH2sCKxkBKCmD4ixpGmGldToU
         p7KmgvNPWJNplgVb0imIqcbFftKUMkbEXp4UskefH7xrU/nvkgUDKOaO8X5TgIqEmtY6
         JVQ0/OmpFjMM1uPREx6HUZtcB4YYzSj4LoiWZjydEYkF/F5CfohRaoaLcveXw84WKwre
         dauThI73HZnab4Vd/8dggNRuMgZ9ufG5XBjTHhgKvg4CDxs9KD5b7NSmcw/I1izJtqVN
         eAug==
X-Gm-Message-State: AFqh2krla9WUNe5NXsGn5J28fojOjkpX61AWi1AGbUEjr4cN7NsY/3cf
        ZV3cNK5gQ1NvI08C3rJ+pg==
X-Google-Smtp-Source: AMrXdXsc7sXL7Xdv5OthXOxFzCDt9YII/qfK8/O80QELAk4AfPL2W9gjEcHvGmx6lBBCzHkKPSZ4Pw==
X-Received: by 2002:a05:6870:a1a8:b0:143:89ce:80ee with SMTP id a40-20020a056870a1a800b0014389ce80eemr40993345oaf.20.1673623615723;
        Fri, 13 Jan 2023 07:26:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id em33-20020a0568705ba100b0014fd7e7c3fesm10583610oab.27.2023.01.13.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:26:55 -0800 (PST)
Received: (nullmailer pid 2224503 invoked by uid 1000);
        Fri, 13 Jan 2023 15:26:52 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     tony.luck@intel.com, keescook@chromium.org,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, gpiccoli@igalia.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
References: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
Message-Id: <167362342171.2212232.12797856408416030039.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: reserved-memory: ramoops: Update the binding
Date:   Fri, 13 Jan 2023 09:26:52 -0600
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


On Fri, 13 Jan 2023 17:28:44 +0530, Mukesh Ojha wrote:
> Update the ramoops region binding document with details
> like region can also be reserved dynamically apart from
> reserving it statically.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Change in v2:
>   - Added this patch as per changes going to be done in patch 3/3
> 
>  .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reserved-memory/ramoops.example.dts:17.13-40: Warning (reg_format): /reserved-memory/ramoops@bfdf0000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 2)
Documentation/devicetree/bindings/reserved-memory/ramoops.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/ramoops.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/ramoops.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/ramoops.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/ramoops.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reserved-memory/ramoops.example.dtb: reserved-memory: ramoops@bfdf0000:reg:0: [3219062784, 65536] is too short
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/reg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1673611126-13803-1-git-send-email-quic_mojha@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

