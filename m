Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D40689A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBCNw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjBCNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:52:13 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2B9AFC2;
        Fri,  3 Feb 2023 05:51:56 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id s124so4197825oif.1;
        Fri, 03 Feb 2023 05:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0jj9gHXQzeTegxc5ifle/pC5AQPQL/9erpLdHEPqBc=;
        b=1ZB8r7Z7iQ3P7JM5IRVKLKvNODm5ob/5ij3dT25eut+aI3Vf17PQUuwyE2dqdj8VEs
         2KEntXtCEW68uWHDZN41Lt5HSZag8ntWTkM8k/a5wtIPf5YKx2sqf3xFaghnhTunXs6F
         GPlv2Yt4Zp1RXsVIdLTIbPhd3Ppey+RQKq8PJ0wf107oNZcpF5PBUsIomW+/4uIuhxaN
         rzGlntMbq7qRghCQqjiMmhC1ZywAcKICY0+64KIN833H5YdnDcttlscQcO9EW/f85fYZ
         3Ejn+unaLEH86zouM1mBXazTx666TPxEIa4eQFK2UOoShxqgGu7D5bPdL3z0n3PVKd00
         NIag==
X-Gm-Message-State: AO0yUKXZ9LBRpifBEpWG0F5R1oe3y7EVkQUMfk72zpyjNQWnqd16peNq
        3fTKA583eyR6b0ZthjIXyw==
X-Google-Smtp-Source: AK7set9GnMjZPQwg4ZvZ1OCLOCzeHoNXp6WHCRFHCa42vbc9O0oYiYLXbh6m33mjRk69hL37c6pQwQ==
X-Received: by 2002:aca:408b:0:b0:370:ac59:7226 with SMTP id n133-20020aca408b000000b00370ac597226mr4042902oia.11.1675432315646;
        Fri, 03 Feb 2023 05:51:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s191-20020acaa9c8000000b003631fe1810dsm793426oie.47.2023.02.03.05.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 05:51:55 -0800 (PST)
Received: (nullmailer pid 4088845 invoked by uid 1000);
        Fri, 03 Feb 2023 13:51:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org, jun.li@nxp.com,
        balbi@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org
In-Reply-To: <20230203014526.1461386-1-peng.fan@oss.nxp.com>
References: <20230203014526.1461386-1-peng.fan@oss.nxp.com>
Message-Id: <167543212276.4084541.17286318072815310709.robh@kernel.org>
Subject: Re: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
Date:   Fri, 03 Feb 2023 07:51:54 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Feb 2023 09:45:26 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MQ use Synopsys DesignWare USB3 Controller IP, so add the
> compatible.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Rebased on linux-next, remove power-domains from v1
> 
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dtb: usb@fe800000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3399-dwc3', 'snps,dwc3'] is too long
	'fsl,imx8mq-dwc3' was expected
	'snps,dwc3' was expected
	'synopsys,dwc3' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dtb: usb@fe800000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dtb: usb@fe800000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3399-dwc3', 'snps,dwc3'] is too long
	'fsl,imx8mq-dwc3' was expected
	'snps,dwc3' was expected
	'synopsys,dwc3' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dtb: usb@fe800000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dtb: usb@fe800000: Unevaluated properties are not allowed ('dr_mode' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230203014526.1461386-1-peng.fan@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

