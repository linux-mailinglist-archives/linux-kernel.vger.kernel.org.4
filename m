Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563816053F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiJSXcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJSXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:31:58 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F6170DD6;
        Wed, 19 Oct 2022 16:31:58 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so10427744otu.1;
        Wed, 19 Oct 2022 16:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MS0VPgDd6DBW5Ti7Tsf3pJIozjZqn06guICmD2Kp4sM=;
        b=0a+ruPl68EQ83VfXh8jxAR9EtN/DVoIU/4OkR3ukE65mQbGLgbA5bUtDCHdRjKJ0t3
         nMzmTip0nMX5nk6z8jUKOVSZ0z9nKc++7uPyLcMD+24YKag2DxwdbTGcPE8KpB+5a9Xq
         VDUllp6TtSNBqUAH11xOaWQf3NW0PpUnF9O6PJ1GKWlkp9TAQAtvr4uHN1F5ZvY8LOrE
         ejYRoULNFbOPB4dPyXCodVnqiSzK6743S12ONDyQWTAScXLGzV/E85VHd+Ktmj1y6/Kr
         Umi24ic1QIUqbZR5Uz4NIP/4NBsDg2LIckbItx+bXvFuXDvau+Joga7EBnALBVZsOVnJ
         suIw==
X-Gm-Message-State: ACrzQf12+vZ0/GdUf2dPEVWUZElHnWpXf65IyjYurJcxQ5RX9Re09m4l
        D6FrGx/gNTwI6ld9W6BxQA==
X-Google-Smtp-Source: AMsMyM6licy+56vLBx+iqqslzytNI3UKFyi0/zd2kw7rkpCogv5TjVOaifRFEOt+ifDYFE23dsBvIA==
X-Received: by 2002:a9d:6f02:0:b0:661:d432:fb52 with SMTP id n2-20020a9d6f02000000b00661d432fb52mr5498021otq.153.1666222317217;
        Wed, 19 Oct 2022 16:31:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s17-20020a4ac811000000b00480dccc0c2asm2117891ooq.14.2022.10.19.16.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:31:56 -0700 (PDT)
Received: (nullmailer pid 19942 invoked by uid 1000);
        Wed, 19 Oct 2022 23:31:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Da Xue <da@libre.computer>
In-Reply-To: <20221004-up-aml-fix-spi-v3-1-89de126fd163@baylibre.com>
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com> <20221004-up-aml-fix-spi-v3-1-89de126fd163@baylibre.com>
Message-Id: <166622204954.13100.10317615531856688163.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
Date:   Wed, 19 Oct 2022 18:31:53 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 16:01:03 +0200, Amjad Ouled-Ameur wrote:
> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
> pin biais when idle. Therefore define three pinctrl names:
> - default: SPI pins are controlled by spi function.
> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
> by spi function.
> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
> by spi function.
> 
> Reported-by: Da Xue <da@libre.computer>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml       | 67 ++++++++++++++--------
>  1 file changed, 42 insertions(+), 25 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml:46:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml:46:1: found duplicate key "allOf" with value "[]" (original value: "[]")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml: ignoring, error parsing file
make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.example.dts'
Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml:46:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

