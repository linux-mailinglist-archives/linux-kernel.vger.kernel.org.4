Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135286F9FD5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjEHG1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjEHG1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:27:02 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE17118179;
        Sun,  7 May 2023 23:27:00 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1927718b240so2669187fac.1;
        Sun, 07 May 2023 23:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527220; x=1686119220;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=witHYv1Hkh138s1daDFZMrxf1YGkxRazduMe4ExLmyE=;
        b=dXE6dbWIyEDgphfGWldzX3/MLgL2MpNogkHJDHwJDR/7hRbj4iOkedeVfT+eJcj5Ns
         p1JRHXL7gACYEDlTiP4Vyo023TkO5Cdof4g6OZ3qXT34RoqENinJfSl14XePSi7pW/o1
         9u+2Gtsmi9DcUCPSJXwFzi38U5Ce8iOxZHtwnWbGUwAWRkzUA8r8Elag1sDWbSsLY3pG
         o1jkmmVOA0KzhwgFWHPNZjJYLhiZUHV1qMKlIXRZbmaj+lKIBl01ZBvJjyvxqAR1zTgU
         ML/wDNOYCTKs0j2btygzt/OIIm3RNisfl0S4d8cLNTM4elJtJcP2K9WL4tBGrGXZcwac
         ZiQA==
X-Gm-Message-State: AC+VfDyEqcu060IISZNtlJrdvGO+SDmoxr6JJqjoX+HrWvDNqQO5dWdH
        vA3wiBfSw4kFNp7Cezd04g==
X-Google-Smtp-Source: ACHHUZ4IPcRapdZOKJCWtWLeNloyjZMFnl+3ZMAIwpbyb4CfDyFLDZldO69cTTbbsAhM+OmRQZ8ojg==
X-Received: by 2002:a05:6870:36c6:b0:17f:17a3:6a53 with SMTP id u6-20020a05687036c600b0017f17a36a53mr4261981oak.53.1683527220047;
        Sun, 07 May 2023 23:27:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n3-20020a056870034300b00176d49bb898sm4575083oaf.44.2023.05.07.23.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 23:26:59 -0700 (PDT)
Received: (nullmailer pid 213415 invoked by uid 1000);
        Mon, 08 May 2023 06:26:53 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Shenghao Ding <13916275206@139.com>
Cc:     Ryan_Chu@wistron.com, navada@ti.com, gentuser@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenghao-ding@ti.com, Sam_Wu@wistron.com,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        x1077012@ti.com, broonie@kernel.org, kevin-lu@ti.com,
        perex@perex.cz, devicetree@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, peeyush@ti.com
In-Reply-To: <20230508054512.719-1-13916275206@139.com>
References: <20230508054512.719-1-13916275206@139.com>
Message-Id: <168352721271.213340.3578983696891383785.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781 amplifier
Date:   Mon, 08 May 2023 01:26:53 -0500
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


On Mon, 08 May 2023 13:45:12 +0800, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 
> ---
> Changes in v7:
>  - Submit together with tas2781 codec driver code
>  - Add more detail description for ti,audio-slots
>  - Keep consistent for "I2C"
>  - remove reset-gpios description
>  - For reg, express as constraints instead
>  - remove unnecessary '|'
>  Changes to be committed:
> 	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508054512.719-1-13916275206@139.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

