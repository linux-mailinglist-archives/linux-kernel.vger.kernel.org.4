Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8F60AE6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiJXPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiJXO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:59:33 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352DA12FFB6;
        Mon, 24 Oct 2022 06:36:51 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so3210614fac.1;
        Mon, 24 Oct 2022 06:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt2lFq6dbGdtBXekxOfaNEZN/Q3vZqwLHuw1ZuGP6SI=;
        b=ROKv94ke9wBlRPHup/6BG2oxiMGJt+NrAwhUwJsBDlJNQ9nNLFsW1cWlLh/a1fhkg4
         KVbE+ytiVb/PX2dBzwKp9H/GtphmxRGpubh5J6YKQDTtbuY4k/D2LxoA+Vt3LUk01Vyx
         5/onBG1IyyGbTSjAoIFF6hsj5RXXjYoAw498ZYL5AwpYb/CSSzj3+qvNDvQoDUz/9d4S
         nScT04nfAfcvWCvJ74ASw85ulhjU0vcGeGtpj0NhVEgthN+co76PlRj/BjUlZVDvEAuj
         2E2VGiLZi2ktnCbInLyu8mD8oA3NijIomMypW/hx62JD/AxzY1pZsekeqeiURelLV3Mz
         bdKA==
X-Gm-Message-State: ACrzQf3fxLgK8Lj8SHiT3m5a6YRFEv3lsldV5JWMcIB/YtHeIN3zvaaf
        Kak1B+jnIN/NMMj7OmvuVQ==
X-Google-Smtp-Source: AMsMyM65vyCZmrc6iE43AdD0YaQicAamKi0gPl15tMyryUnDapOZDkfhwpb+7+SFF1/+YvncsLwmmA==
X-Received: by 2002:a05:6870:d285:b0:12b:cdce:63d8 with SMTP id d5-20020a056870d28500b0012bcdce63d8mr36138626oae.140.1666618205246;
        Mon, 24 Oct 2022 06:30:05 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v5-20020a05683024a500b0066102eb189fsm4381512ots.26.2022.10.24.06.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:30:04 -0700 (PDT)
Received: (nullmailer pid 1686095 invoked by uid 1000);
        Mon, 24 Oct 2022 13:30:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     s.hauer@pengutronix.de, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andreas@kemnade.info, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-input@vger.kernel.org, linus.walleij@linaro.org,
        alistair23@gmail.com, shawnguo@kernel.org, rydberg@bitmath.org
In-Reply-To: <20221024111017.43859-3-alistair@alistair23.me>
References: <20221024111017.43859-1-alistair@alistair23.me> <20221024111017.43859-3-alistair@alistair23.me>
Message-Id: <166661790048.1678635.3297196935905640224.robh@kernel.org>
Subject: Re: [PATCH v9 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Mon, 24 Oct 2022 08:30:04 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 21:10:15 +1000, Alistair Francis wrote:
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/input/touchscreen/input.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dtb: touchscreen@24: button@0: False schema does not allow {'reg': [[0]], 'linux,keycodes': [[172]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dtb: touchscreen@24: button@1: False schema does not allow {'reg': [[1]], 'linux,keycodes': [[139]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dtb: touchscreen@24: button@2: False schema does not allow {'reg': [[2]], 'linux,keycodes': [[158]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dtb: touchscreen@24: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

