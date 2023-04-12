Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C766DF57E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjDLMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjDLMhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:37:20 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3502136;
        Wed, 12 Apr 2023 05:36:58 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id u24-20020a9d7218000000b006a413c893c8so1602142otj.10;
        Wed, 12 Apr 2023 05:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303017; x=1683895017;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9jOdXT+V+Zebmm8aG72BfjVRbdNVFQ3IJ98e2LoaQk=;
        b=olgxdaTOIhpw2U5bt/nLzF0cR0jgfAS0+mgB7CreozjO7po4Me3SWFDC+t0A8yLt/Q
         DL641SEDpMzM+Uo7ya1Z0o0j5rGILDPSp68y0ZQCUaavEF186rOIH7bg4fGaXgpjnABL
         bChKLi50hzrhHzgIunCg75/pCLJSURNnd7HSFhTrisjqhKDrhdM/dK4hgmdmWDVReDHg
         EXqg85CIUoFTWfjYyhQt3DvIzRztqDiEG1OsmJSb5cB6m1QW8WFct1goytZBfPHAp53D
         DJ8Ujka67UThuK0mkPugKtGeCjV/Od5fFtKj8YU4MF8HsRYvrwm4OHOFQ4+mAWmdMxBN
         SRVA==
X-Gm-Message-State: AAQBX9dtinkA4h3mB79enkMmusWx6kN2gxNW3SQPDKbVWYNOi3AEMR0W
        wWScP/s9S9GRhcFrHF/rmQ==
X-Google-Smtp-Source: AKy350YCmmL8l5yHH833Xd2sbcl1HHzX9eJq4tR5XRATEpUVzPaDkVbwu1IyS1SBmIWmKcwdtb0cMg==
X-Received: by 2002:a9d:7f85:0:b0:6a3:780:5848 with SMTP id t5-20020a9d7f85000000b006a307805848mr6617802otp.25.1681303017217;
        Wed, 12 Apr 2023 05:36:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a056830100e00b006864b5f4650sm6505510otp.46.2023.04.12.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:36:56 -0700 (PDT)
Received: (nullmailer pid 1486735 invoked by uid 1000);
        Wed, 12 Apr 2023 12:36:56 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tony Dinh <mibodhi@gmail.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
In-Reply-To: <20230412025737.20280-2-mibodhi@gmail.com>
References: <20230412025737.20280-1-mibodhi@gmail.com>
 <20230412025737.20280-2-mibodhi@gmail.com>
Message-Id: <168130276446.1439316.3427548118074442016.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: mvebu: Add device tree binding for
 Marvell Armada 38x
Date:   Wed, 12 Apr 2023 07:36:56 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Apr 2023 19:57:35 -0700, Tony Dinh wrote:
> Add device tree binding for Marvell Armada 38x.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
> 
> Changes in v2:
> - Add marvell,38x.yaml. For now, add this binding to the Marvell
> directory to keep it consistent with other Marvell yaml files.
> At a later date and a separate patch, consolidate the Marvell
> yaml files into  marvell.yaml.
> 
>  .../bindings/arm/marvell/armada-38x.yaml      | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/arm/marvell/armada-38x.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412025737.20280-2-mibodhi@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

