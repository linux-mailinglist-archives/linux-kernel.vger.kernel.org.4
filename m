Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31825B9A41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIOMAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiIOL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:59:59 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2686222A4;
        Thu, 15 Sep 2022 04:59:56 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id w22-20020a056830061600b006546deda3f9so12362447oti.4;
        Thu, 15 Sep 2022 04:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sLkaEDH98zZtAFnFWH1/tkX3GjTR/wSS1F3yaWvbetE=;
        b=AA7dZ16l3Sm5Cwa7lSY4EB+hH4urK5XIEDF7ebpPCLFajFFpvibr0TTHwF5fdSNZRU
         EsrTkXaAqrB2MtzpITMcoU6ZEhKLEAmqO0HOP7vmK6h+Ye5GoEJvsy8lXfhVn80q/pgl
         2LPN/Ee8eKxTVVAwJMCswrVuLFxogSVnMO/osSD7fYnx1trcoo4oiaqNT1KDld9566z2
         UHoMGB5Y8jWLVAa5vQQUqIC3V5Fqi4/uGvZyrUV57PqRZgcmeQa3RKLnv6D8es4/gi9A
         PmXoOuUbnhoWQwf096hSJwXKlxmIhiFuTtFIPL6mZtBEPQU5AlULfW9qfTLDjjuRbvQd
         eU9A==
X-Gm-Message-State: ACgBeo0DkaWcHkjVVwxNVauNtLCcbI3BFxNewl+navC0wczewJTYpTn1
        jUwh7lD+oNV823DdaTY/zg==
X-Google-Smtp-Source: AA6agR5MZxVPb+jJCNa0zyEESImmngxm4labBAs2ed6ZpK10/DXIEoUu4T82Z3m8x1of5HNcL4DzTA==
X-Received: by 2002:a9d:7c89:0:b0:655:dfb1:331c with SMTP id q9-20020a9d7c89000000b00655dfb1331cmr7872731otn.224.1663243196172;
        Thu, 15 Sep 2022 04:59:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cd15-20020a056830620f00b00638c25074afsm8406773otb.34.2022.09.15.04.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 04:59:55 -0700 (PDT)
Received: (nullmailer pid 987712 invoked by uid 1000);
        Thu, 15 Sep 2022 11:59:55 -0000
Date:   Thu, 15 Sep 2022 06:59:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: spmi: Add qcom,bus-id
Message-ID: <20220915115955.GA986622-robh@kernel.org>
References: <20220914165212.3705892-1-vkoul@kernel.org>
 <20220914165212.3705892-2-vkoul@kernel.org>
 <20220915095103.7qys3ixd6yyngkzs@krzk-bin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915095103.7qys3ixd6yyngkzs@krzk-bin>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:51:03AM +0100, Krzysztof Kozlowski wrote:
> On Wed, 14 Sep 2022 22:22:11 +0530, Vinod Koul wrote:
> > For PMIC arbiter version 7 and beyond we need to define if we are using
> > primary or secondary bus, so add a new property of qcom,bus-id
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml   | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: Unevaluated properties are not allowed ('dma-channels', 'dma-masters', 'dma-requests' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml

Ignore this. Unrelated.

Rob

