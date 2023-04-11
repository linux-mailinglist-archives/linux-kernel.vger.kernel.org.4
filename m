Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ADC6DDABF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDKM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDKM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:27:34 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5C32D4E;
        Tue, 11 Apr 2023 05:27:33 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id bx42so21696248oib.6;
        Tue, 11 Apr 2023 05:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681216053; x=1683808053;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fPMklZqVdMQPrpOHKD27i1gEFDXuDB7SlLv8f6x1+RE=;
        b=QizFMvWsU29Gign4VXSp/JTaWKiGMqx3nAoEf9eCk0zY4GUS+RyLrzfKmSbgZXruEK
         86CI5yy90iP3mISEdsvd1BtTmmq5VCTrJ5YWdrcFQ565T6EeNzIqq9hUkAGa/xa1DXh9
         3qHdcR4L+OiYvx+NPmiOI5Cu9zAqQGy3+vnZ5xW4p/5r51EaRykmt+StmDBzz1fG1ad8
         of18svAZ/g/68GaH9ZZHYNzmEn0omlG/pwx+44FrY7Oyx2wnw8Nw/wrmuxn37mUIeV5G
         lRwwueDUEj/XQOQawBTXmmZcpFnjaSeo/HLC/mwpwoqCIypKjnqXYfK5/D96VLBLyHLt
         SsVg==
X-Gm-Message-State: AAQBX9dUOlmc0x5HrC9H4Ji2Nvl7pQ/otGjFYqpK6DqTHx2i2XzF1oea
        itUB7+Y0Jg818IDaTJPEHlLfCiRTyQ==
X-Google-Smtp-Source: AKy350YXe6dsVgfmCXS9O9b35GWw8ZAwxGxlToWm0D22O/BpViZ7j2KkXNe7bfTiQ21cd3yd5MfOqw==
X-Received: by 2002:a05:6808:9b6:b0:389:2fb1:db3 with SMTP id e22-20020a05680809b600b003892fb10db3mr5578107oig.6.1681216052884;
        Tue, 11 Apr 2023 05:27:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s189-20020acadbc6000000b003874e6dfeefsm5492449oig.37.2023.04.11.05.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:27:32 -0700 (PDT)
Received: (nullmailer pid 2781045 invoked by uid 1000);
        Tue, 11 Apr 2023 12:27:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
Message-Id: <168121603157.2780605.18056732208268371049.robh@kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: Document APDS9306 Light Sensor
 bindings
Date:   Tue, 11 Apr 2023 07:27:31 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Apr 2023 09:12:02 +0800, Subhajit Ghosh wrote:
> Add devicetree bindings for Avago APDS9306 Ambient Light Sensor.
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
>  .../bindings/iio/light/avago,apds9306.yaml    | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/light/avago,apds9306.example.dts:29.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/iio/light/avago,apds9306.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411011203.5013-2-subhajit.ghosh@tweaklogic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

