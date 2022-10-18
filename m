Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5C602D08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJRNcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJRNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:32:04 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD7CC97CD;
        Tue, 18 Oct 2022 06:32:03 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1321a1e94b3so16818488fac.1;
        Tue, 18 Oct 2022 06:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEJ3nN0wOjqyjek8ZcKMEHHdhLOGpeMQeNTSyKEyuvo=;
        b=4yDUXo+cwg0Q/R+XTaF4Fw8Izat6OYrZE3Cjb7YvV8njKEcIVJFRkhdE/bZUglHeeh
         Sf9i+DvAzRfczF+jp87jMiAW73N4MKAerc+2doxu78U0JRFS7RvsF9iVNZHp1OYzbzFZ
         buJXnCiA15DMGe1Wz7N3LmQ9CmZJkdNm2TxzcmqGvAYubb3QPyXRuvx7dCMGvM/I3nRr
         A7stCzCzzdy/0o1+bJD0iVAXGSMsrl7DdMERYr3FfwwhVIgB0uqy/B0OUNVbTs2fBJpb
         tpK77cCejrky8CF9pHMPEJppXfESWfsCbUNLd1gM65QvSdBf7yiro6S4YdOQ0OdlWhut
         QswA==
X-Gm-Message-State: ACrzQf3AqCCtTBtvelT5SG5tserngpt0bluQyTzkUj+AELCKHu2EItTA
        57NIzfQzsWevW4DETZO6iQ==
X-Google-Smtp-Source: AMsMyM4jST8n+8ZZo9uiDI29BwfZwbKZGPxkYGiRwMYca9UhzVLi1KxoUnPi4QS1AdrgrAKBc6liug==
X-Received: by 2002:a05:6871:1d5:b0:12b:239:ef00 with SMTP id q21-20020a05687101d500b0012b0239ef00mr1561467oad.85.1666099922195;
        Tue, 18 Oct 2022 06:32:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e12-20020a9d63cc000000b0066102eb189fsm5926004otl.26.2022.10.18.06.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:32:01 -0700 (PDT)
Received: (nullmailer pid 180827 invoked by uid 1000);
        Tue, 18 Oct 2022 13:32:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     rogerq@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, lee@kernel.org,
        linux-phy@lists.infradead.org, dan.carpenter@oracle.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20221018084333.149790-2-s-vadapalli@ti.com>
References: <20221018084333.149790-1-s-vadapalli@ti.com> <20221018084333.149790-2-s-vadapalli@ti.com>
Message-Id: <166609952062.171721.12955273990805791032.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J721e
Date:   Tue, 18 Oct 2022 08:32:01 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 14:13:31 +0530, Siddharth Vadapalli wrote:
> TI's J721e SoC supports additional PHY modes like QSGMII and SGMII
> that are not supported on earlier SoCs. Add a compatible for it.
> 
> Extend ti,qsgmii-main-ports property to support selection of upto
> two main ports at once across the two QSGMII interfaces.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 48 +++++++++++++++----
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml:75:12: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.example.dts'
Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml:75:12: mapping values are not allowed in this context
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml:75:12: mapping values are not allowed in this context
./Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/phy/ti,phy-gmii-sel.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

