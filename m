Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0837A5B9A39
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIOL7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIOL7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:59:06 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2CF2B1;
        Thu, 15 Sep 2022 04:59:05 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id o204so1905783oia.12;
        Thu, 15 Sep 2022 04:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z+Uk70wenuE2avVZw1KYjIwZYeZGOnR3WHL7he3UtOU=;
        b=vz2Wy+s1JjmOFKTKAKJus36qPcmotwslIGbAmAvQF1tQEM8Q81Dj1aWbDgx/uYJ6KV
         5HVkmhiWYBJqNDyc3RhdL81MVPXy+ln4wkErmdRiZKOPjr2Yg1kvWdaFOO0yDsvwww8V
         7q2E3rFt0OkX4FfmpsxL0MKLWhR3sQW6QzyfBfnjkuXw9c62+2Yu7eyuHzKMHKT4E5B2
         ORun/28lPboL3fj+vJj+uSm4JE/xXNioGLxTm3qZAv3MiPLf+AUfT1WSZIkfFsnOWAu0
         vQ84+gD7Q9kFAdAINF9WNNnYBVWzD3bCJhJa5iSbLFQ+4yOBYXeCTZVz3pqKCBeF4nvY
         i9oA==
X-Gm-Message-State: ACgBeo2m/O1CKrHczIekeMwMsYJHMD9AtZf1JHDW9I8Ng4Dwam4r2zGd
        e8dMpOK0pHI7iaiFlvG5xA==
X-Google-Smtp-Source: AA6agR49VcAXbJ6flKXkElRGNVqdgLKhCCqHMxvV8f9HxhM/De4Z+GNeFJnd7dQ9ytUjuxfD6+kfcQ==
X-Received: by 2002:a05:6808:13cd:b0:343:41aa:4cbe with SMTP id d13-20020a05680813cd00b0034341aa4cbemr3803456oiw.264.1663243144633;
        Thu, 15 Sep 2022 04:59:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm52-20020a0568081ab400b00339befdfad0sm7567647oib.50.2022.09.15.04.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 04:59:04 -0700 (PDT)
Received: (nullmailer pid 986126 invoked by uid 1000);
        Thu, 15 Sep 2022 11:59:03 -0000
Date:   Thu, 15 Sep 2022 06:59:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     cy_huang <u0084500@gmail.com>, sre@kernel.org,
        alina_yu@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, mazziesaccount@gmail.com
Subject: Re: [PATCH v5 1/3] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
Message-ID: <20220915115903.GA984598-robh@kernel.org>
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
 <1663173015-7934-2-git-send-email-u0084500@gmail.com>
 <20220915095121.lh5c5gbn53qedtgw@krzk-bin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915095121.lh5c5gbn53qedtgw@krzk-bin>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:51:21AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 15 Sep 2022 00:30:13 +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > Add bindings for the Richtek RT9471 I2C controlled battery charger.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Co-developed-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Since v3
> > - Move unevaluatedProperties line after $ref for binding patch.
> > - Add Reviewed-by tag for binding patch.
> > 
> > Since v2
> > - Remove the properties for interrupt controller things in the binding documentation.
> > - Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
> > - Add regulator min/max microamp to allow otg vbus current adjustable in example.
> > - Specify the active-level for charge-enable-gpios in binding example.
> > 
> > ---
> >  .../bindings/power/supply/richtek,rt9471.yaml      | 73 ++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: Unevaluated properties are not allowed ('dma-channels', 'dma-masters', 'dma-requests' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml

Ignore this. Unrelated.

Rob
