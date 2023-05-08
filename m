Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084E66FAFF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjEHM14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjEHM1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:27:46 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0FE348A4;
        Mon,  8 May 2023 05:27:45 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-18f4a6d2822so31032107fac.1;
        Mon, 08 May 2023 05:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683548864; x=1686140864;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N1qNtZkOJFNMLIG5NF8YsKtv7JnAcb6X8FfPa3NPMEY=;
        b=lzsQzJ8iBr30+ZNfStgWgHeHnKwTITllu6Zfeyly71dCBv/2crbWTF1Q+HSZUZbdmd
         l/KbsWZeHIt8FlC5FPFKatCIcplZ/dkvN9a3uAc8XhBdOIlb94PnYHiRUUUMmJ1laYtY
         ByYTzYSpfw0Ai5xWfrlGBFKFbdT0bDNHTtHbRqQWIOkvuHFIn0V+k72FoGK6UPeXyGXt
         SrUGmsUfCrGhpN+u9gdjXecvs50C6pvtmaNnT9mbSRobPtjyfx+dFI9C3jS7JJZrLDXx
         AtvMvfpSFDmp+UqpzEEnxoK2DY3O3j6BSWbd4dD3XSYyCj/7XpQ4WpdfZvAyGxlsww8z
         8QIQ==
X-Gm-Message-State: AC+VfDzXUljUr/gGSxFjYBFnzRPTXqh8CZ3kH1tuzZJwPuMgGq4ZPSj6
        mOiTtNLoTYT6+w4qHTIfNd++Ml2/RYV7
X-Google-Smtp-Source: ACHHUZ54sbYEhdOQ6Gn29dzpKoxCe6JDKsc00jIVM5oE77IUFpoRMfoW/91rxlvOQEnkp1gVgTLrMg==
X-Received: by 2002:a05:6830:1da8:b0:6a5:d9eb:c529 with SMTP id z8-20020a0568301da800b006a5d9ebc529mr4623587oti.8.1683548864263;
        Mon, 08 May 2023 05:27:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z26-20020a0568301dba00b006a2cc609ddasm4038745oti.2.2023.05.08.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:27:43 -0700 (PDT)
Received: (nullmailer pid 927520 invoked by uid 1000);
        Mon, 08 May 2023 12:27:38 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dinguyen@kernel.org, broonie@kernel.org, lars@metafoo.de,
        nuno.sa@analog.com, lgirdwood@gmail.com, tiwai@suse.com,
        upstream@semihalf.com, alsa-devel@alsa-project.org, perex@perex.cz,
        amstan@chromium.org
In-Reply-To: <20230508113037.137627-4-pan@semihalf.com>
References: <20230508113037.137627-1-pan@semihalf.com>
 <20230508113037.137627-4-pan@semihalf.com>
Message-Id: <168354885743.927427.9242565928327424252.robh@kernel.org>
Subject: Re: [PATCH v2 3/7] ASoC: dt-bindings: Add Google Chameleon v3 i2s
 device
Date:   Mon, 08 May 2023 07:27:38 -0500
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


On Mon, 08 May 2023 13:30:33 +0200, Paweł Anikiel wrote:
> Add binding for google,chv3-i2s device.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/google,chv3-i2s.yaml       | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508113037.137627-4-pan@semihalf.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

