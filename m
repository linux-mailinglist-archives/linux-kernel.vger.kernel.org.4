Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0D6B0A89
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjCHOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjCHOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:07:52 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88F4521F8;
        Wed,  8 Mar 2023 06:06:33 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-176eae36feaso8068691fac.6;
        Wed, 08 Mar 2023 06:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284393;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oxgkrPx+GT1CZkfZ5/WiXENKk4kTVmkKWF9GsEdsJ5Y=;
        b=Yz3ZJQQJGjIiprI6zAxlQ4p5seH2yb8hFqu7vHQXPMIQ/jLrJan77WMj5190ddJOHe
         49BbwJ3NMNqgvbq1kXmGnA7uv9a+b6LCIqLmDqt2Pwdhd2RcupdRXZ4ujSYUTJERwmXL
         qDaRjs6/NixLJeDvrsFO1E6MGPAYSJN6OuGQhe33/rYeA0DxiW/qQd7ALckiZAsxmztc
         2sLxtleiGZd4p6beju4saEshe6In7D0LdZLY6h14gDQe2pD9CC0QNnaV5GsKHnXgEeeH
         uFnvnLihVxSilesEwtIQYoz7Myo1atxuRL/Vp8+LosHDQ+2SOR50JoPUgoPdmD8LkalI
         PR+w==
X-Gm-Message-State: AO0yUKXl/XIsc72Vu9JsWRO78de6/WIFZ2UcSIARMRsCR+kJIeU87vQN
        2HpMJbGNkuQ2nrfjlbbYKw==
X-Google-Smtp-Source: AK7set/HkdLMFQ9Tad0ddCcyExnPUvCLXXfIw9IIgZBgi6e47Y7G6aGMR9sDcD51hu8Z/QSdiyx/+Q==
X-Received: by 2002:a05:6870:b525:b0:172:8941:f360 with SMTP id v37-20020a056870b52500b001728941f360mr12151211oap.4.1678284392883;
        Wed, 08 Mar 2023 06:06:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x38-20020a4a97e9000000b005251f71250dsm6135080ooi.37.2023.03.08.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:06:32 -0800 (PST)
Received: (nullmailer pid 2666467 invoked by uid 1000);
        Wed, 08 Mar 2023 14:06:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ldd-Mlp <ldd-mlp@list.ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Jean Delvare <jdelvare@suse.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20230308095209.14700-2-clamor95@gmail.com>
References: <20230308095209.14700-1-clamor95@gmail.com>
 <20230308095209.14700-2-clamor95@gmail.com>
Message-Id: <167828360220.2613154.17895980579184472148.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: media: i2c: add lm3560 binding
Date:   Wed, 08 Mar 2023 08:06:21 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 11:52:08 +0200, Svyatoslav Ryhel wrote:
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/media/i2c/ti,lm3560.yaml         | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/media/i2c/ti,lm3560.example.dts:26.43-44 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/i2c/ti,lm3560.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230308095209.14700-2-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

