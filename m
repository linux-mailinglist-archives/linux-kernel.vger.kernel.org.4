Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B76743AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjF3LYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjF3LYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:24:03 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10189C0;
        Fri, 30 Jun 2023 04:24:01 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7835ffc53bfso43805839f.1;
        Fri, 30 Jun 2023 04:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688124240; x=1690716240;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xQcHCEfZmuNEbtp3cdeH3UJbr+AqROplj2X1YQLpNg=;
        b=eqSpGMpIKL6j4hfSmm1ol3tm5fVYXDpk4hjMbeePr6rbe/U6dtXiWLh4yZ0dEyggNV
         XToo9CL3EH9XlGFCfJCX8lu6uSLvDt0yFNKLWV5W+x9+W1TCQJFrWL3LiB14E/qwaKlk
         As8o8ZTfF8g8tBBvIu3IgkXSnxBHyXHs+bkjGDorEI7g7/d5Ngcplam/2F3zox/FjUZW
         cEmqjB6WzN+jD6XCGsBXwEMy63RWO3oDWgx9EQKpeMDgfTex4WHSoLhPJbR7vinsXGPJ
         orLmlmK5JVyZIc46R/Aig+PRRMPCHPG3f7cJ6E0MVaINpOdaGnF1RXnnY5sTP4OPirFr
         iOsw==
X-Gm-Message-State: AC+VfDz7bfy7xBFjDSFHpBniS27ndV/jobJ4qyqhBYw99R6WUyYzb7lf
        KpVN1SkhlcJ2ND9vQyAp+VZcTR8AkA==
X-Google-Smtp-Source: ACHHUZ5xH1J9xSD1ATB7C+2MVvmjFL+cw3O4K/E8UXcBMl92pRkMHx8HlcLX/wo2pE27VaghmDzUrQ==
X-Received: by 2002:a6b:a1a:0:b0:783:3899:e1d7 with SMTP id z26-20020a6b0a1a000000b007833899e1d7mr1960946ioi.2.1688124240296;
        Fri, 30 Jun 2023 04:24:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y13-20020a5e920d000000b00786582eb9fbsm29977iop.15.2023.06.30.04.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:23:59 -0700 (PDT)
Received: (nullmailer pid 1082768 invoked by uid 1000);
        Fri, 30 Jun 2023 11:23:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
In-Reply-To: <20230630100321.1951138-4-jstephan@baylibre.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-4-jstephan@baylibre.com>
Message-Id: <168812423413.1082731.16618986920467028772.robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: media: add mediatek ISP3.0 camsv
Date:   Fri, 30 Jun 2023 05:23:54 -0600
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


On Fri, 30 Jun 2023 12:01:52 +0200, Julien Stephan wrote:
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
> 
> This adds the bindings, for the ISP3.0 camsv module embedded in
> some Mediatek SoC, such as the mt8365
> 
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../bindings/media/mediatek,mt8365-camsv.yaml | 113 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.example.dts:28:18: fatal error: dt-bindings/power/mediatek,mt8365-power.h: No such file or directory
   28 |         #include <dt-bindings/power/mediatek,mt8365-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230630100321.1951138-4-jstephan@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

