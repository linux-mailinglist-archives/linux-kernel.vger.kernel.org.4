Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6483608158
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJUWMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJUWMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:12:10 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD74B2441B8;
        Fri, 21 Oct 2022 15:12:08 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so625856oop.9;
        Fri, 21 Oct 2022 15:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7kJ8nWws4CdYxlh1B9Atp5y9g2i8sKYiDiGJZXRmEI=;
        b=S4yqKDMwuekQgAECgcBeDfoDl+EKaTAnJdtE5DRwYQoAwYXDiKbxX7srIIUWSyatwn
         IWB6ygwnG5RINtoNUHx8mUf2M2mRlbFCJM7IRRE5DEEVbFz+VtFShNujPG8jmekNBv+b
         YnDNZVjq9MbItqlOek2Dg/EYZ+KJKBa2MQnwqnRg5rly8W0pjPki/l5+7qu4nqtHlpmC
         EgiUKi2HZ/aDKVTISndA8tVGxGS5mCXJ7IUAotx/hhpyi7t5gMOsN0ZXhPsyM4JLu/sY
         lfkfnzWiSzWpW9OBTR+8gH0eMwrbNLb59A9PvvHgU5LYcSrsJYHW/L8cqUt07LTwBNDu
         YkJQ==
X-Gm-Message-State: ACrzQf3LqjU9u5Pu2OTdKK3KfH17IA38n4Ube9LuQexceUGHYK07SNfb
        o6YpoP0m/DfRB2w+huN6oA==
X-Google-Smtp-Source: AMsMyM44mYEduOCve2TkVYfwaNjYyUW48/ORzqaTp28KfbVGQNZ7AEpDcq9TzSF6OK3JoocFYxlbxw==
X-Received: by 2002:a05:6820:168b:b0:476:2e4c:6cf1 with SMTP id bc11-20020a056820168b00b004762e4c6cf1mr10032684oob.69.1666390327919;
        Fri, 21 Oct 2022 15:12:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j3-20020acab903000000b0035179b87ba5sm1595444oif.20.2022.10.21.15.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:12:07 -0700 (PDT)
Received: (nullmailer pid 516244 invoked by uid 1000);
        Fri, 21 Oct 2022 22:12:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Elad Nachman <enachman@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
In-Reply-To: <20221021194552.683-2-vadym.kochan@plvision.eu>
References: <20221021194552.683-1-vadym.kochan@plvision.eu> <20221021194552.683-2-vadym.kochan@plvision.eu>
Message-Id: <166639031801.513906.6752849188940196302.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
Date:   Fri, 21 Oct 2022 17:12:08 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 22:45:49 +0300, Vadym Kochan wrote:
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Dropped deprecated compatibles and properties described in txt file.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
>  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
>  2 files changed, 199 insertions(+), 126 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml:17:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/mtd/marvell-nand.txt

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

