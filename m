Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A056FAFF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjEHM16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjEHM1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:27:48 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0090C3A5DC;
        Mon,  8 May 2023 05:27:46 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-39212bf4ff0so2404749b6e.1;
        Mon, 08 May 2023 05:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683548866; x=1686140866;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Gh42LPUVun0Rjq4FHuafOLMtx9f3rbpY5E+7IEMZN0=;
        b=Wml1bzPL5qmtOdb9EDH9rw4Dn0NP7ar3oRjYX5XJPwVmRzwodObwDix1uKxtSI1Q8F
         h8QiiBfBXll5Kb/Zf+FN/papGHXv4KG/ivVkEW9ENOddkVCn8dKLMRrJAJcFywow3FJL
         Oyijfs2N1WFWfS75jS3VfAjQ3fJvaUtS4hcIDWjniccD4b0idLwfn0+VIjUP5ze81jOB
         xh1jjPDltRLN+L0+OTvd6LnqQqJKWQKSSShjjvtPH2jaOhL8QC7rFTBTmWJHAYaqnWcZ
         ztECQtjkGhdWqE7NnvQBjnc9fSwVvZNKUZM/Q9vif5DSeNnUGEFKaF4DTNoRiHIBwo2A
         raEQ==
X-Gm-Message-State: AC+VfDwAIl1RCliIgQhnbZVASuCI0nquTFz1pWkMZyrYphtItxCifHW7
        L6UO0XXKtl/QFy6F5RRVpw==
X-Google-Smtp-Source: ACHHUZ6fbFILs4fyrIwJnUV9CLXdQHb0MjKV2Lm/C+sIGKLZFkUWw4IiJBOAiy+p7oBVknJl0IjjeA==
X-Received: by 2002:a05:6808:b15:b0:38e:eaf:cf29 with SMTP id s21-20020a0568080b1500b0038e0eafcf29mr4772858oij.29.1683548866052;
        Mon, 08 May 2023 05:27:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x67-20020a4a4146000000b0052a77e38722sm4364073ooa.26.2023.05.08.05.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:27:45 -0700 (PDT)
Received: (nullmailer pid 927524 invoked by uid 1000);
        Mon, 08 May 2023 12:27:38 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        s.hauer@pengutronix.de, srinivas.kandagatla@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        festevam@gmail.com, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
References: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
Message-Id: <168354885877.927501.14485011836566521791.robh@kernel.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX93
Date:   Mon, 08 May 2023 07:27:38 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 08 May 2023 19:46:38 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 OCOTP support
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Reuse imx-ocotp.yaml
>  Based on https://lore.kernel.org/all/20230506064128.34005-1-krzysztof.kozlowski@linaro.org/
> 
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508114639.1525521-1-peng.fan@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

