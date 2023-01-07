Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29174660FE7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjAGPSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:18:07 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B046F1704D;
        Sat,  7 Jan 2023 07:18:06 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id o13so2444619ilc.7;
        Sat, 07 Jan 2023 07:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qt3iT4aovtQ+3YTo4FRMDvWABE+Y3B6IyX+wff/2RkE=;
        b=WrD6CCPDNIlMIDRA0IrqQPA2AOd2+AfTYWivllPN60WOcIYq71l/0SfGS29qBgo7Xn
         xgEnCVwr4Za227Li0IEicjzD1Q0y+xxZGtIuK3OzrRw0P1NhaKU5lOJvjFSD/J5qBVc+
         3zQkCLjaR18z6y7cGvo/hJLR6YyOgBjLMcRGwTqptKlXMAcrMi0fuy82EpZLxGuC7N+Y
         RS6S3Ld/aOItzgTWqZcYecGgvON/Yduv8FYqlivsDxztKoAwzH8DrbihJdfmW/K0sA1p
         ys1hb+P+bh+hoDlGAsCJ4HOYbOf32hrRgpzqJfIHB+oqdlIC9xlKhYENg19FpQxWvtcn
         MiFQ==
X-Gm-Message-State: AFqh2krE7iPBCrV8cUXuJzYi/ktClin3K3FUB84iLj0wFROx/hoVlvAC
        2rrLYIN1diBEGw0mP2UZLw==
X-Google-Smtp-Source: AMrXdXuBk+V3WJWqTsqMVyXlcUc2Ry4MJDOK+iidIpfuB8S7Y2PTqJuABcPa7DNShcvdFVZA2Yp0gw==
X-Received: by 2002:a92:da4f:0:b0:30c:42d9:22a5 with SMTP id p15-20020a92da4f000000b0030c42d922a5mr17020681ilq.13.1673104685792;
        Sat, 07 Jan 2023 07:18:05 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f94-20020a0284e7000000b00389d02a032dsm747863jai.172.2023.01.07.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 07:18:05 -0800 (PST)
Received: (nullmailer pid 1799735 invoked by uid 1000);
        Sat, 07 Jan 2023 15:18:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     anand.gore@broadcom.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com,
        Linux SPI List <linux-spi@vger.kernel.org>, dregan@mail.com,
        tomer.yacoby@broadcom.com, f.fainelli@gmail.com,
        kursad.oney@broadcom.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, jonas.gorski@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230106200809.330769-2-william.zhang@broadcom.com>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-2-william.zhang@broadcom.com>
Message-Id: <167310423078.1757548.4915356991338777285.robh@kernel.org>
Subject: Re: [PATCH 01/16] dt-bindings: spi: Convert bcm63xx-hsspi bindings to
 json-schema
Date:   Sat, 07 Jan 2023 09:18:03 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Jan 2023 12:07:53 -0800, William Zhang wrote:
> This is the preparation for updates on the bcm63xx hsspi driver. Convert
> the text based bindings to json-schema per new dts requirement.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 52 +++++++++++++++++++
>  .../bindings/spi/spi-bcm63xx-hsspi.txt        | 33 ------------
>  2 files changed, 52 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.example.dtb: spi@10001000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'num-cs' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230106200809.330769-2-william.zhang@broadcom.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

