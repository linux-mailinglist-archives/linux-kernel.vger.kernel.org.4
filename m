Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE26F8964
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjEETOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjEETO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:14:28 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7417522682;
        Fri,  5 May 2023 12:14:23 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-195c83a9ed8so474738fac.0;
        Fri, 05 May 2023 12:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314062; x=1685906062;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ob/tYM63KWmpHL+MbVncyNEUjCaAQy3a3Q0ZpHwG/qc=;
        b=cDhaGSG9ccJcYrzLWh9rGgshg7nTe5pzJ06lnv/DeIzd6jWoyq3QlQppzu+fymWY8Q
         7XaBup+PpSnCgaWqlmSqkr7lz+yFr9nR3N3WawMXPwSlsCDpk34CAe65/2eRl+dh41WX
         leGo5EslI5g9RFDoEjMCeFogtSHFyv8mIp8LBtyZnxyx/bBkkxIaGh7S0RHcWZr96KIf
         7qHz4wcx+RFeYPD6d49QtNpO/T9Xm+c77UZqP8rTNQkBZXyhdKgKEHmy/utN/ZTWbI5+
         J+xx1PD1nZnqhaxLs0QT21n91w6N0i8+hvplPiOLGC4ybbjOkwIAK9Aiq37TSmQAgKnu
         luzw==
X-Gm-Message-State: AC+VfDzAkgEoltZrgbO5jiBoiMkirQoN6gyhbGoBRL+ruLZXzVCjnRjv
        QNtOb/l0y3G2/45413fAJyYPEX8fSw==
X-Google-Smtp-Source: ACHHUZ6FK7GAnvCJYewkHMMfv4Kk0sJFerm0OriIL32hAr3N87hUS6kt7QUf+IvQqrQPQ3I++KfXOA==
X-Received: by 2002:a05:6871:40f:b0:180:2a5e:7f8f with SMTP id d15-20020a056871040f00b001802a5e7f8fmr1374449oag.22.1683314062575;
        Fri, 05 May 2023 12:14:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ec51-20020a0568708c3300b001727d67f2dbsm2153520oab.40.2023.05.05.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:14:21 -0700 (PDT)
Received: (nullmailer pid 3406638 invoked by uid 1000);
        Fri, 05 May 2023 19:14:20 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     shawnguo@kernel.org, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev, fushi.peng@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        kishon@kernel.org, vkoul@kernel.org, robh+dt@kernel.org
In-Reply-To: <20230505185247.1854677-2-Frank.Li@nxp.com>
References: <20230505185247.1854677-1-Frank.Li@nxp.com>
 <20230505185247.1854677-2-Frank.Li@nxp.com>
Message-Id: <168331406075.3406622.9380633591504481297.robh@kernel.org>
Subject: Re: [PATCH 2/2] doc: dt-binding: cdns-salvo-phy: add property
 usb2-disconnect-threshold-microvolt
Date:   Fri, 05 May 2023 14:14:20 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 05 May 2023 14:52:47 -0400, Frank Li wrote:
> Add usb2-disconnect-threshold-microvolt property to address fake USB
> disconnection issue during enumeration or suspend state for difference
> platform.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml: properties:usb2-disconnect-threshold-microvolt: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230505185247.1854677-2-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

