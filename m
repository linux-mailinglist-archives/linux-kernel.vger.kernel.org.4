Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354E372E3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbjFMNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240826AbjFMNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:19:39 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD691AC;
        Tue, 13 Jun 2023 06:19:38 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-34070ecad56so2025885ab.3;
        Tue, 13 Jun 2023 06:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662377; x=1689254377;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dT8m3Cu24ixjgaGAl25zXjiqNcC5dV8yRe8XpfUJ2IQ=;
        b=bowsdthfXE0WYxgg66Q1+sD6nSSLevN48cqBBMWe9Ip2AAbNmH0vrbhRT8OwgiPzNR
         ZjuUUATSaRW0Nlm6UPJz00+BYX/q+b00jq/BbsZ1wQZKbxi5dEHSf2WLbYZhFagA94lm
         p7NIKocSKYMdrwhxqEwtN/vJCHdYfiuN5bRdorFEA7pt9Vv6mSiG07NCuEGzn2fxxwPS
         Ajq7if8aHa11aLvKCWA9dwCDGDC/Cafy7G30KOG4pPqzPNvyoq/gG8sn5wFRDbO6Hkve
         z45mDFSRud4N/KlBvDaNhMftIrV2zchuofn7GSXEwp9MssxB3NpKaPr21AKfYruaMx/z
         seNw==
X-Gm-Message-State: AC+VfDyvuoI5Roy0+eSwJOSvak3qqrJhnVRoGCrgrNZXy32F52Dw3bvg
        KQ3KbTi9diPCy99oUtUxgmoQGhAQIg==
X-Google-Smtp-Source: ACHHUZ6LVxhdrfDigUUxZyyKOzUm0MeS+qqoJHzIRx8RuSnPu1sAgcWkvmpQVZ2+A3XSjEIAaFXQZw==
X-Received: by 2002:a92:d6c2:0:b0:340:8959:1268 with SMTP id z2-20020a92d6c2000000b0034089591268mr270515ilp.21.1686662377402;
        Tue, 13 Jun 2023 06:19:37 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v5-20020a92cd45000000b0032f240a0802sm500815ilq.48.2023.06.13.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:19:36 -0700 (PDT)
Received: (nullmailer pid 1671700 invoked by uid 1000);
        Tue, 13 Jun 2023 13:19:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     michal.simek@xilinx.com, robh+dt@kernel.org, git@amd.com,
        nava.manne@xilinx.com, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        michal.simek@amd.com, conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, siva.durga.prasad.paladugu@amd.com
In-Reply-To: <20230613123048.2935502-1-piyush.mehta@amd.com>
References: <20230613123048.2935502-1-piyush.mehta@amd.com>
Message-Id: <168666237486.1671584.5832429615873674500.robh@kernel.org>
Subject: Re: [PATCH V3] dt-bindings: reset: convert the
 xlnx,zynqmp-reset.txt to yaml
Date:   Tue, 13 Jun 2023 07:19:34 -0600
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


On Tue, 13 Jun 2023 18:00:48 +0530, Piyush Mehta wrote:
> Convert the binding to DT schema format. It also updates the
> reset-controller description.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> Changes in V2:
> - Addressed the Krzysztof review comment:
>  - Update DT binding to fix the dt_binding_check warning.
>  - Removed 2/2 - xlnx,zynqmp-firmware.yaml binding patch: Will send after
>    xlnx,zynqmp-reset.yaml binding merge.
> 
> Link: https://lore.kernel.org/lkml/168612336438.2153757.6000360498539992409.robh@kernel.org/T/#m4abfe6287177d5fd09f781d298dd19d56aae5e27
> 
> Changes in V3:
> - Addressed the Krzysztof review comment:
>  - Removed 2/2 - xlnx,zynqmp-firmware.yaml binding patch: Will send after
>    xlnx,zynqmp-reset.yaml binding merge.
>  - Update title: Removed "binding".
>  - Update Example:
>   - Removed header file.
>   - Dropped three levels of indentations: firmware and zynqmp_firmware.
>   - Removed the sata example.
> 
> Link: https://lore.kernel.org/all/22e3c25e-487b-c02f-46f3-6d2ab2be8813@linaro.org/
> ---
>  .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 -------------------
>  .../bindings/reset/xlnx,zynqmp-reset.yaml     | 52 ++++++++++++++++++
>  2 files changed, 52 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml: $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates that the pin should be operating in paired mode.'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230613123048.2935502-1-piyush.mehta@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

