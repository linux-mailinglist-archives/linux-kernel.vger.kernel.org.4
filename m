Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07F96ABF65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCFMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCFMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:25:21 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77334212BB;
        Mon,  6 Mar 2023 04:25:20 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id l13so10197529qtv.3;
        Mon, 06 Mar 2023 04:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678105519;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=go08yN8ZO/E8IL+UZzsM8Ypz4ifwLeuitk1Dpvtflhg=;
        b=xikt3ZY3Av/8h9/8GUY5FS9lpFtQ+YUppgSTeqvZgSYDr6Ub6zuK1zQUD/7+umCqeA
         e1U+G5X/DgQ+nKa2A3b3Nu++D/4DDgyzOT/LHwnWo+n5y3nzGlkSpFuSLlkLOANVI8jB
         Fx8/Z8t7pykr3sGh6f6fSiFyJ87Fvg6IWe4AdhUc0yNUn/+g9fovOBQRroGZS9ICTgvt
         Uyc2IFLL+1zk9dJzwDJBC8V/g+Qon1TUIMzHLuVOO5TMAZQPVtJG8klFrV3ICJYlf0TI
         76mHnwP3jYgQXhatMJJBUvp64DVwKKjptmf7UcgOiKJxxwdXevhySQmTDXneFrElpCz6
         0x4Q==
X-Gm-Message-State: AO0yUKWLFSNamnqx7Dw7+5d3Mwqg14b5xDj8WvwDDgpo1QrRJuVMLmmC
        JtlEB5DIXfya3Lj/TUbEGg==
X-Google-Smtp-Source: AK7set9PTrNQli3SGEVrUKOSYgH4tGMPmdZVopkIMoc0rL2EVX/XmqG4LHiVP695Fy0kaUkbWU8B6w==
X-Received: by 2002:ac8:5bc9:0:b0:3bf:cd81:3a31 with SMTP id b9-20020ac85bc9000000b003bfcd813a31mr18660401qtb.65.1678105519378;
        Mon, 06 Mar 2023 04:25:19 -0800 (PST)
Received: from robh_at_kernel.org ([209.91.220.210])
        by smtp.gmail.com with ESMTPSA id y8-20020ac85248000000b003b86b962030sm7518717qtn.72.2023.03.06.04.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 04:25:18 -0800 (PST)
Received: (nullmailer pid 31427 invoked by uid 1000);
        Mon, 06 Mar 2023 12:25:17 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
In-Reply-To: <20230306095257.25957-1-minda.chen@starfivetech.com>
References: <20230306095257.25957-1-minda.chen@starfivetech.com>
Message-Id: <167810459782.12203.9014682894570874393.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: phy: Add StarFive JH7110 USB
 dt-binding
Date:   Mon, 06 Mar 2023 06:25:17 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Mar 2023 17:52:57 +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC USB 3.0 phy dt-binding.
> USB controller is cadence USB 3.0 IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-usb-phy.yaml | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:30:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:40:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:57:12: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.example.dts'
Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:57:12: mapping values are not allowed in this context
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:57:12: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):


See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230306095257.25957-1-minda.chen@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

