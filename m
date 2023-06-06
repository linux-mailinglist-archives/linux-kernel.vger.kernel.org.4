Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48488723F6B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjFFK1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjFFK13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:27:29 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDACE55;
        Tue,  6 Jun 2023 03:27:28 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7748d634a70so229920839f.2;
        Tue, 06 Jun 2023 03:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047248; x=1688639248;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JAPwM9u2F/Ud8Dzoq+JTM/HoPHsb9s153yZMWbPc3GE=;
        b=PKTRNP9chvoAjEIzlHfBHCw2r/ttla4TUGpqBQZsijSTR0fhQ6HIs7/iE20gRvLXiH
         bc9nx7HtcQPDEogQNUoTkt6NrsERSN2uH0yV39f37Ikk3YTgBWqfSgn0VVdznJtGnclq
         NY+dxPqmYX42WirHI166x1+JMIXkMDhLaMZ+BBU/asqSo1EGrNG8tjErKUQStW8YPEXX
         3jZOOb2Qq4v+5oZFWmnuLREb+D0uHOCTLux4nccmSZ5Jfi+McX9inphI43HTG0EXCfHp
         vp8wCfvhJjZ1RsDssoJzMZeQFjzPaMMRAZC1EYzZutFjwHdRtB23AW8mQrBwayQ62ImU
         YXNA==
X-Gm-Message-State: AC+VfDwARxDjfCXKiHHwLgX84NEP4vSfhC8RUadwzz81X9R2hNB9zJUG
        KhKvbdG6i2t9UlN+wy73xw==
X-Google-Smtp-Source: ACHHUZ68E0V6jIRjSy2wh4tmUQtFk1OPqANyFaBsAC3f1lK9fAcvLfnZ2Yb+yr9jd5qlQIhh7Sju9w==
X-Received: by 2002:a5d:9544:0:b0:775:8241:724a with SMTP id a4-20020a5d9544000000b007758241724amr1726719ios.16.1686047247601;
        Tue, 06 Jun 2023 03:27:27 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o22-20020a02c6b6000000b00408df9534c9sm2670058jan.130.2023.06.06.03.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:27:26 -0700 (PDT)
Received: (nullmailer pid 411520 invoked by uid 1000);
        Tue, 06 Jun 2023 10:27:24 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     andrew@aj.id.au, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-doc@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-aspeed@lists.ozlabs.org,
        lee@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, p.zabel@pengutronix.de,
        joel@jms.id.au, patrick@stwcx.xyz, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux@roeck-us.net, corbet@lwn.net,
        thierry.reding@gmail.com
In-Reply-To: <20230606094535.5388-4-billy_tsai@aspeedtech.com>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
Message-Id: <168604724448.411496.12229634069665354962.robh@kernel.org>
Subject: Re: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Date:   Tue, 06 Jun 2023 04:27:24 -0600
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


On Tue, 06 Jun 2023 17:45:33 +0800, Billy Tsai wrote:
> Add device binding for aspeed pwm-tach device which is a multi-function
> device include pwm and tach function.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> 
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dts:37.15-28: Warning (reg_format): /example-0/pwm-tach@1e610000/tach/fan@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dts:36.19-38.15: Warning (avoid_default_addr_size): /example-0/pwm-tach@1e610000/tach/fan@0: Relying on default #address-cells value
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dts:36.19-38.15: Warning (avoid_default_addr_size): /example-0/pwm-tach@1e610000/tach/fan@0: Relying on default #size-cells value
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230606094535.5388-4-billy_tsai@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

