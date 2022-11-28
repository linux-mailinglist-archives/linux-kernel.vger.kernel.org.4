Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA963A827
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiK1MXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiK1MWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:22:43 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B621C416;
        Mon, 28 Nov 2022 04:20:49 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1433ef3b61fso12695745fac.10;
        Mon, 28 Nov 2022 04:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CZfqieASnhH+cyHXFa4EKAUAtyWhOd13pMXBilnYNUI=;
        b=SmI2yOsGUgH5FmNDNMX5EupeERqDhrgcuxb2Sxoz7s9uvZGQqyZn26xFekZgIY2PIt
         nssYIw1NGeRo26HwaMq6IvN/cJnUHrFm6RhBJcJpw1JkV76/pykBaeOu04ppc0Im+Nmr
         SDk/IrPXJ99OalAo7a3aQ985UJ/WcwZlWe8tw4Wh5QNXGL9PglXlS7uJ+oQz/O1TQc7d
         ex5MVa7HpNg9E8eyBoHxV+exJw0fQK4xsBrTut4/fY76U+Y6M3gvHSUZWkZBVhVXQTpo
         PUW5RpoF/gCYcZna7hwLkQmnf21YTTSJnEMzAGthFMP+H15x8oAcQxvhzpMM61ltJ2Lo
         SPdw==
X-Gm-Message-State: ANoB5plfxwuHlGKIMhOZUZEEveJcSZ9b4/33bNgmDJ3Ngm8tlWNIIhpV
        8T7QwXsWFYt4WBt7QT16qw==
X-Google-Smtp-Source: AA0mqf4RKqWQ3b691Fmb1KfiNQtiJj0CsVedJ+SQsQPxogZKCvZwUN6fcq8rYa/OZuGhmhfmOTgZLQ==
X-Received: by 2002:a05:6870:d799:b0:143:8f03:f4a1 with SMTP id bd25-20020a056870d79900b001438f03f4a1mr4879849oab.66.1669638048598;
        Mon, 28 Nov 2022 04:20:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a056830271000b0066bb73cce68sm4620796otu.69.2022.11.28.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:20:48 -0800 (PST)
Received: (nullmailer pid 477521 invoked by uid 1000);
        Mon, 28 Nov 2022 12:20:47 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        bin.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        benliang.zhao@mediatek.com, Richard Weinberger <richard@nod.at>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20221128020613.14821-8-xiangsheng.hou@mediatek.com>
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
 <20221128020613.14821-8-xiangsheng.hou@mediatek.com>
Message-Id: <166963790250.472824.6710482280926376664.robh@kernel.org>
Subject: Re: [PATCH 7/9] dt-bindings: spi: mtk-snfi: add two timing delay property
Date:   Mon, 28 Nov 2022 06:20:47 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Nov 2022 10:06:11 +0800, Xiangsheng Hou wrote:
> add rx-sample-delay and rx-latch-latency property.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  .../bindings/spi/mediatek,spi-mtk-snfi.yaml      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml: properties:rx-sample-delay:minItems: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml: properties:rx-sample-delay:maxItems: False schema does not allow 47
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml: properties:rx-sample-delay:minItems: False schema does not allow 0
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221128020613.14821-8-xiangsheng.hou@mediatek.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

