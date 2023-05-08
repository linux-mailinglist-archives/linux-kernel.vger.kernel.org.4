Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A06FA341
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjEHJ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjEHJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:27:20 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F160D59FB;
        Mon,  8 May 2023 02:27:18 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6aaffc866c4so324654a34.2;
        Mon, 08 May 2023 02:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538038; x=1686130038;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DguH7yd98IO9no2ougJQcRCCw8JxeycA5jMXenEALPQ=;
        b=cMAX1HkLFqT3tMBaTB6+aDEc5c2kPAugnE4YPP/JAJRq2yhPIOkovQymh4lqDrksZ0
         4IQzTii0Wr6etbxQQS0K2KW9dPAYtgmLZf9BEO7YjJ5wDqtrzWAYrVPsXLMfUcQUp1Rn
         0ji32M9Sv9r9pv5RmLpGgIc2l8LUFS0kGnX4GLSFQpIyNLgDiJpD59MJ3FEM92fE79Wh
         Tnul+qkoYyAg6JHLX6Ezy3D8TwaQyAd3gQ+ZMqVnUDC9sEoK23GpkC/30V9vcLouiL7p
         naazbrrpv6FUtGOuJgJ2sZ9W3oD8kqsZdlAaVPNe6rxc2k1wjUmGsaIOyw7Ymbp5iq0W
         pbog==
X-Gm-Message-State: AC+VfDxGDEwazJc/mH40B/KBW3rNSNXnQ9NJTCBD3up03FQJZoYxDX7J
        1xwEzCT1+XQFsYxbDg763FZo9IpZYubp
X-Google-Smtp-Source: ACHHUZ4aCjwS3clxMxZaGq8mqr3vyeaqLy0a5Z1wm8QlVNY4m6uxyOmhNS1CHyug8eYUUbVMjFrUlg==
X-Received: by 2002:a9d:6443:0:b0:6a1:1bd4:d8c8 with SMTP id m3-20020a9d6443000000b006a11bd4d8c8mr4421158otl.26.1683538038151;
        Mon, 08 May 2023 02:27:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c5-20020a9d6845000000b006aaf62e838dsm1798202oto.53.2023.05.08.02.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:27:17 -0700 (PDT)
Received: (nullmailer pid 575486 invoked by uid 1000);
        Mon, 08 May 2023 09:27:12 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        neil.armstrong@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org,
        daniel@ffwll.ch, sam@ravnborg.org, devicetree@vger.kernel.org,
        airlied@gmail.com, dri-devel@lists.freedesktop.org,
        linux-imx@nxp.com
In-Reply-To: <20230508083826.1016206-2-victor.liu@nxp.com>
References: <20230508083826.1016206-1-victor.liu@nxp.com>
 <20230508083826.1016206-2-victor.liu@nxp.com>
Message-Id: <168353803230.575435.10408042054525345719.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add BOE
 EV121WXM-N10-1850 panel
Date:   Mon, 08 May 2023 04:27:12 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 08 May 2023 16:38:25 +0800, Liu Ying wrote:
> Add BOE EV121WXM-N10-1850 12.1" WXGA (1280x800) TFT LCD panel
> compatible string.  The panel has a LVDS display interface.
> 
> The panel's product specification can be found at:
> http://www.onetech.com.tw/files/EV121WXM-N10-1850ProductSpecification_20180801.pdf
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> * Add Krzysztof's A-b tag.
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508083826.1016206-2-victor.liu@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

