Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC50271256C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243216AbjEZL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEZL05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:26:57 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE7A12F;
        Fri, 26 May 2023 04:26:52 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33aa60f4094so1841745ab.1;
        Fri, 26 May 2023 04:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685100411; x=1687692411;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iJ0RPfGniHm7encY03gp85qFDTA63n+cLMONk4Pv+1c=;
        b=FNJrB50hULQ7GRgUv1Emq0wzjI+/PIe3QVK2IW4ad78mTz6AaFNRpqRF7n++jYRo2b
         DQqj8tnoxdKbzkod7MRwnP1xNVs+2SewfXyIzAK1tncAa9pvRvRnJrN5XgF19u0gaz5u
         YOqsXEIKNPdYK24DDwDb3wEkk66QPcpRRYsMdMR1FecmefF1ch72dkbhEV+ZP6aD9vPv
         ELz33S0ZKtA6arQdbgfzzAMs+wndBPN3OUrfB4kwAUfGYeqizFQzxmgjNT+jru88eEtT
         Ri0hU4MLxu0K7CV3eg283cQ20T971RTGPvFtGdetoLJY58aYmnh3JEs1G5WhtxnwdlA4
         4LtA==
X-Gm-Message-State: AC+VfDyJYefBzqEpVZnkRBR2kzkhQlXGGXBGJ9UM4ZwdnEk8Hncn0Qe9
        L3dYNXroUNtlMSBEpmt1OltTQPTiMg==
X-Google-Smtp-Source: ACHHUZ6GnIFh8ipON1bp5u1Prt8xzgxoVgKcM4++yVzVDfMvM6WrNw0eIqO5rOyt2QdBKgaMkfivyw==
X-Received: by 2002:a05:6e02:220a:b0:33a:a77d:3072 with SMTP id j10-20020a056e02220a00b0033aa77d3072mr3852954ilf.7.1685100410625;
        Fri, 26 May 2023 04:26:50 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id k15-20020a02a70f000000b00413e7ca0f4csm1072271jam.174.2023.05.26.04.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 04:26:49 -0700 (PDT)
Received: (nullmailer pid 547735 invoked by uid 1000);
        Fri, 26 May 2023 11:26:47 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        jacopo.mondi@ideasonboard.com, linuxfancy@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        martin.hecht@avnet.eu, Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        laurent.pinchart@ideasonboard.com,
        Nicholas Roth <nicholas@rothemail.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>
In-Reply-To: <20230526103427.774226-2-tomm.merciai@gmail.com>
References: <20230526103427.774226-1-tomm.merciai@gmail.com>
 <20230526103427.774226-2-tomm.merciai@gmail.com>
Message-Id: <168510040778.547713.18211801531465598183.robh@kernel.org>
Subject: Re: [PATCH 1/2] media: dt-bindings: alvium: add document YAML
 binding
Date:   Fri, 26 May 2023 05:26:47 -0600
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


On Fri, 26 May 2023 12:34:15 +0200, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the ALVIUM
> Camera from Allied Vision Inc.
> 
> References:
>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  .../media/i2c/alliedvision,alvium.yaml        | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.example.dts:30.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230526103427.774226-2-tomm.merciai@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

