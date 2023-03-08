Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2D06B0A8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCHOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjCHOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:07:50 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ADD34F48;
        Wed,  8 Mar 2023 06:06:28 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso9008486ots.9;
        Wed, 08 Mar 2023 06:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284387;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W3V1JTSU4mAasV6Yy4rBnCyWxykGtCx/CwR52o/KvEc=;
        b=nnP+miKgKM/KR2c1KRRD4udbdSculU2TMaEuxACq1Uhxy8fwllFzYOZZBklvcu6qlT
         jHQK0ZQlfTY6ZW3iRQau9dMhm/ek6eiR4xJN5n/5JWBroSdlxEkYFPfJLMkQm/WcM83o
         pqae3rk7hQmPCAEAUllStD/i5HJYfBV0kh/Gs9jMDWak2FcxujhXEFKlcDU/3+5Fu3m0
         YnVa8bZES4BFfLyUstl8FPHYI8Sqc1E77i7VNdyuJ7aYI9Llaqd2arq1extz/R0uxXQ4
         t4tfrLQGCGP/yIqpAZSl1srAKInyKDHQHlWdjy9nEGip+DHW8Y8z5tKcbxLb9xC4fmre
         V0wA==
X-Gm-Message-State: AO0yUKV8CNdMxNbng2t8+iRPjScThNEtvSCIqLqic6fRyWKi7dXxniXR
        ftZatoSZkTjwQgWkmlkkHA==
X-Google-Smtp-Source: AK7set+6pXcrDnyjZYZJ0PqF6YB97KGKOLOLPb2e+N3hu1Ms1rlAgf+tDK3agSRy0jFFRDTN4/rVRQ==
X-Received: by 2002:a9d:18f:0:b0:690:e7f9:bb61 with SMTP id e15-20020a9d018f000000b00690e7f9bb61mr8863276ote.26.1678284387420;
        Wed, 08 Mar 2023 06:06:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y22-20020a056830071600b0068d4dda3d61sm6434064ots.39.2023.03.08.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:06:26 -0800 (PST)
Received: (nullmailer pid 2666451 invoked by uid 1000);
        Wed, 08 Mar 2023 14:06:21 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Pawel Laszczak <pawell@cadence.com>, Vinod Koul <vkoul@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20230308082800.3008-2-minda.chen@starfivetech.com>
References: <20230308082800.3008-1-minda.chen@starfivetech.com>
 <20230308082800.3008-2-minda.chen@starfivetech.com>
Message-Id: <167828360080.2613078.14112010625330944896.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: Add StarFive JH7110 USB
 dt-binding
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


On Wed, 08 Mar 2023 16:27:58 +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC USB 3.0 phy dt-binding.
> USB controller is cadence USB 3.0 IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-usb-phy.yaml | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.example.dtb: usb@10100000: phy-names:1: 'anyOf' conditional failed, one must be fixed:
	'cdns3,usb2-phy' was expected
	'cdns3,usb3-phy' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.example.dtb: usb@10100000: 'phys' is a dependency of 'phy-names'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/phy/phy-consumer.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230308082800.3008-2-minda.chen@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

