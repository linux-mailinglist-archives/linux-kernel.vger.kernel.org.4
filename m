Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F62724DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjFFUMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbjFFUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:12:29 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E6D10F2;
        Tue,  6 Jun 2023 13:12:19 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33b36a9fdf8so427605ab.2;
        Tue, 06 Jun 2023 13:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686082339; x=1688674339;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oTi+J4/KlqfIRDKD6li2U1FfODcCfumrK5ycv6/faOA=;
        b=gijvrZfUEWAJ6Z1LYwlyTCNQm77Tlcv5JYMehaYajHyjtRZp+kN+PsOC3WUHB3tOJO
         TpSoeNqn4P2PHe1j+NzuAoMcO81iQ+B1fouegCF1/ESP8vPjfhSnAvGbvxqriTyG34Yp
         ALpLlQMSdmnsK3EpIqaJcxoUkU3kRUc/0qjSV8LEmqIZzDVJ8uhAwkYFU5ZZJ8fAfE87
         sAA7W9czyAA1bGM4UGKRQkRmLTIjMWvnvyKaLZ7O21Q8iWOSU8y5z1xv/QXfRIym+Wwc
         NqLODDVYA21ghMYwRu6sGFaBkjUCpVtKhCVgE4rHjH1CMOq733a+9D8ISdw2nXbRun8g
         UDSA==
X-Gm-Message-State: AC+VfDzoAxa8VbOMHoXfIjoSQY8pTaG8hHgW9TD1rn/guNHVzfLq/NJ3
        jHLj5ovNRUvWVcpFu9OIGg==
X-Google-Smtp-Source: ACHHUZ4/dvwbcy01BSUtuPxen2FdLAX+HOYoKuxbwugA8+RyXNtv6V1MfDRHfuJMMh2dINX0gXQ+sQ==
X-Received: by 2002:a92:dac5:0:b0:335:908b:8f5 with SMTP id o5-20020a92dac5000000b00335908b08f5mr4291681ilq.10.1686082338996;
        Tue, 06 Jun 2023 13:12:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m11-20020a924a0b000000b0033d2eba1800sm3283987ilf.15.2023.06.06.13.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 13:12:18 -0700 (PDT)
Received: (nullmailer pid 1540120 invoked by uid 1000);
        Tue, 06 Jun 2023 20:12:16 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>, oxffffaa@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
Message-Id: <168608233614.1540103.8185199247808319074.robh@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Date:   Tue, 06 Jun 2023 14:12:16 -0600
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


On Tue, 06 Jun 2023 22:35:07 +0300, Arseniy Krasnov wrote:
> Add description of 'nand-rb' property. Use "Fixes" because this property
> must be supported since the beginning. For this controller 'nand-rb' is
> stored in the controller node (not in chip), because it has only single
> r/b wire for all chips.
> 
> Fixes: fbc00b5e746f ("dt-bindings: nand: meson: convert txt to yaml")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
nand-rb: size (5) error for type uint32-array
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.example.dtb: nand-controller@ffe07800: nand-rb: b'true\x00' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230606193507.35024-1-AVKrasnov@sberdevices.ru

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

