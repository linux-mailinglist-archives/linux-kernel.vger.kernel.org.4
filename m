Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356C16FAFF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjEHM1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjEHM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:27:44 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638535D87;
        Mon,  8 May 2023 05:27:43 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1929d8c009cso3540498fac.2;
        Mon, 08 May 2023 05:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683548862; x=1686140862;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbhTWzxFBA8cjY3QB1KEOYtXC8Es1z/fAvwcXxTXprk=;
        b=ZrLpHunvPayOLstvNAuL+VSrN3YML5FyLdb0Rj1YrdBHUWbyaFYFnt2DncTscOXsmI
         MNVdwvsixVnw3G+kfj8PKEBLrVLys5V2MKbIzqm19jc7BrxZKM3zOP8xoKJdfmPP6e5D
         cV0t1GW/tIMfOVLgWDHwPh6s9ckih1CqWdDls5WI90P1RUIm2XwtF9CUXIgeiNRTR/1u
         GzjusaLH4FFfdM2CsbIpOOV04iGsbmyybJRB+2q5T9A0xz9RdvhcehwzQjIuYB4raxyX
         +uYxUb5l/DQuCQJb/+Knmr1jOuk2dDXOIVf63299fc4rogcU+EqaR8pk/DjBGSe/uYHs
         LPDg==
X-Gm-Message-State: AC+VfDwibu5SSHY5HmHh3jNBqN8ARa7QDa6VF9E5CCYUvQvMhBTcr0tb
        Wi5IZb2wQbYL0q8fMRYHZg==
X-Google-Smtp-Source: ACHHUZ6jqVJTOPEan49ez/yig9l6E+2Wm72pEEUy1n5q4wnl1Kg2i3kYZzyUB/3bpHP3Grxt7fWPLg==
X-Received: by 2002:a05:6870:9551:b0:177:a565:a7e1 with SMTP id v17-20020a056870955100b00177a565a7e1mr5114919oal.16.1683548862398;
        Mon, 08 May 2023 05:27:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i5-20020a056870864500b0018b03bf5f97sm4853170oal.41.2023.05.08.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:27:41 -0700 (PDT)
Received: (nullmailer pid 927522 invoked by uid 1000);
        Mon, 08 May 2023 12:27:38 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     devicetree@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
        robh+dt@kernel.org, lars@metafoo.de, amstan@chromium.org,
        dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, nuno.sa@analog.com,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230508113037.137627-5-pan@semihalf.com>
References: <20230508113037.137627-1-pan@semihalf.com>
 <20230508113037.137627-5-pan@semihalf.com>
Message-Id: <168354885809.927469.7527279348028988087.robh@kernel.org>
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Add Google Chameleon v3
 audio codec
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


On Mon, 08 May 2023 13:30:34 +0200, Paweł Anikiel wrote:
> Add binding for google,chv3-codec device.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/google,chv3-codec.yaml     | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-codec.yaml
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508113037.137627-5-pan@semihalf.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

