Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4AA5F5EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJFCTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJFCS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:18:57 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C09691A6;
        Wed,  5 Oct 2022 19:18:53 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so494593oog.12;
        Wed, 05 Oct 2022 19:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jZIdY8QX+4KlsWpGeQFNIJVbEesoa2SUydZj7W7bFo=;
        b=Y/OfwScWIMBVRz4RW60IMiQs+kzOOz3KQaAMbdQ2hw2c3IspEAhCN+Shd23TlApXhT
         /MQMTnuP4whAI6/lpflckRu/+OjZJCuh4chNu8iJRjbIoHLSlnozvVejwUjZmeQrbbXa
         rC+PucfrOAiz08EskUPYgYhwatoW5hL+k5uR/LbtvCMP5YXUIRTPx2T76q3dK61SDl/Z
         vqfrToHBHohi0+ewB8Rdbf+8ofQfnA1qgcX0SWVXxCK9rhS5jCKksRdON/yhejtr46/Q
         7q3mYFloQwQrKb6mcacNGsJm+/3n/d2UbRVVxo93wVR3o76ZiexQmzySKWDDf5KyNsIB
         mrWQ==
X-Gm-Message-State: ACrzQf1SKox+h9M3PoSwTCFmZDgU4vefYCSLz89hoNMxvbO2Fit58Dh+
        jOra6dGCgKmLQDC7Txg70A==
X-Google-Smtp-Source: AMsMyM6tuGhNopZGM50q8/x8hUhVFnr7Vr8FB5GIyuq4D71Fu3og97txbMaQnhAN1xbLbinslOCD0A==
X-Received: by 2002:a9d:4e7:0:b0:65b:e537:5a75 with SMTP id 94-20020a9d04e7000000b0065be5375a75mr993837otm.138.1665022732299;
        Wed, 05 Oct 2022 19:18:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w19-20020a056830111300b006370abdc976sm4833668otq.58.2022.10.05.19.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 19:18:51 -0700 (PDT)
Received: (nullmailer pid 565676 invoked by uid 1000);
        Thu, 06 Oct 2022 02:18:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Martin_Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Cc:     devicetree@vger.kernel.org, brgl@bgdev.pl, hemantk@codeaurora.org,
        robh+dt@kernel.org, andersson@kernel.org, mani@kernel.org,
        saravanak@google.com, jeffrey.l.hugo@gmail.com,
        Michael.Srba@seznam.cz, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20221005145746.172138-3-m.zatovic1@gmail.com>
References: <20221005145746.172138-1-m.zatovic1@gmail.com> <20221005145746.172138-3-m.zatovic1@gmail.com>
Message-Id: <166502256551.562242.10019185148511138173.robh@kernel.org>
Subject: Re: [RFCv2 PATCH 3/4] dt-bindings: gpio: add Wiegand GPIO driver dt documentation
Date:   Wed, 05 Oct 2022 21:18:50 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022 16:57:45 +0200, Martin Zaťovič wrote:
> The Wiegand GPIO driver uses two GPIO lines to transmit data -
> data-hi and data-lo. These lines need to be defined in the
> devicetree, otherwise the driver will not probe successfully.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/gpio/gpio-wiegand.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-wiegand.example.dtb: wiegand: wiegand-gpio: {'compatible': ['wiegand,wiegand-gpio'], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]], 'data-hi-gpios': [[4294967295, 7, 6]], 'data-lo-gpios': [[4294967295, 6, 6]]} is not of type 'array'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/gpio/gpio-consumer.yaml
Documentation/devicetree/bindings/gpio/gpio-wiegand.example.dtb:0:0: /example-0/wiegand: failed to match any schema with compatible: ['wiegand']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-wiegand.example.dtb: wiegand-gpio: $nodename:0: 'wiegand-gpio' does not match '^wiegand-gpio@[0-9a-f]+$'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

