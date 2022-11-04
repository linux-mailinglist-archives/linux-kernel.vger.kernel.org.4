Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9161A38E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKDVrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiKDVrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:47:45 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A545EE7;
        Fri,  4 Nov 2022 14:47:44 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so6965694fac.1;
        Fri, 04 Nov 2022 14:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4AWz3heTvW9/SjNGOnADQKijVdWZEZo5RmZcyg0wzU=;
        b=mJQGUpXWC7qfgGqVpQ/nleXiy45mPrMe1tV07AOnoKawzW3FvzOYiSRjXhIqvDSDcL
         XAV5du5dAEASbPk91y1VuO+5s2UNrVEDjrSlkCaGKPz9AvKjSPqCW0NJl6xIQlaQVQNt
         31LMfmMJxCeBJbxRah76bhzvM5M8ExFP4pdN2AftyK9GMsfj21XPQT45qc2yjQVx/4Kx
         8fMtJ5RGyyjjimplESaK/eGpNw1qv9x3Go1lHgK4EMFJg5G5R4HFGgHZgzVL/gdG7EJq
         IDMwzWSFiTgTEQMI6JvPRqntRwBYe2cZq5epbZJXhrKfw7LuGfWrh7JAJ2j375JV0ktL
         jzvA==
X-Gm-Message-State: ACrzQf2LQMIGXNbqH5dSe+imVLYCks9w5pZl5P+Gz+t1TWWnjJYzD7kU
        c4xMC030491V1jUvnfNXaQ==
X-Google-Smtp-Source: AMsMyM75XqDPp8F1ac7KnwNd5teq4r4YMJDMqo39kggUwLf7Jw9pTQVKqM7XDouGLMc4cawPhnXH7Q==
X-Received: by 2002:a05:6870:8911:b0:13b:69b2:86b2 with SMTP id i17-20020a056870891100b0013b69b286b2mr23730705oao.253.1667598463241;
        Fri, 04 Nov 2022 14:47:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ek17-20020a056870f61100b0013c50b812a2sm72744oab.36.2022.11.04.14.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:47:42 -0700 (PDT)
Received: (nullmailer pid 2885635 invoked by uid 1000);
        Fri, 04 Nov 2022 21:47:44 -0000
Date:   Fri, 4 Nov 2022 16:47:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: examples: add a list of templates and
 solutions
Message-ID: <20221104214744.GA2878314-robh@kernel.org>
References: <20221028233701.572280-1-krzysztof.kozlowski@linaro.org>
 <20221101130720.GA963805-robh@kernel.org>
 <34f40c1c-f933-cee6-f022-14c37650dc3a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f40c1c-f933-cee6-f022-14c37650dc3a@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:52:22AM -0400, Krzysztof Kozlowski wrote:
> On 01/11/2022 09:07, Rob Herring wrote:
> > On Fri, Oct 28, 2022 at 07:37:01PM -0400, Krzysztof Kozlowski wrote:
> >> It is useful to start from existing bindings when writing new ones,
> >> especially when one does not know that much DT schema.  However we have
> >> several bindings which are not the best examples, so people tend to copy
> >> their issues into new bindings.
> >>
> >> Beginners also might not know how to achieve some more complex solutions
> >> in DT schema, e.g. how one of two properties should be required by the
> >> bindings.  Some of such solutions are already in example-schema.yaml,
> >> but several other are missing.  Add reference with such re-usable
> >> design-patterns.
> > 
> > My main concern here is what's a good example today is not tomorrow... 
> 
> Yes, I agree. The problem I want to solve is some folks copy-paste some
> existing schema as starting point and then are surprised when receive
> basic style feedback.
> 
> Of course the optimal solution would be to make all schemas in same
> (proper) style, but this is going take some time...
> 
> How to solve this problem other way? I don't know.

shrug


> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../devicetree/bindings/examples.rst          | 63 +++++++++++++++++++
> >>  Documentation/devicetree/bindings/index.rst   |  1 +
> >>  2 files changed, 64 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/examples.rst
> >>
> >> diff --git a/Documentation/devicetree/bindings/examples.rst b/Documentation/devicetree/bindings/examples.rst
> >> new file mode 100644
> >> index 000000000000..710eea81d8b7
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/examples.rst
> >> @@ -0,0 +1,63 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +Examples of Devicetree Bindings to use a base
> >> +=============================================
> >> +
> >> +Following Devicetree Bindings in DT Schema are a known good starting point when
> >> +writing new bindings:
> >> +
> >> +1. Simple SPI device:
> >> +   Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> >> +
> >> +2. PMIC (MFD) with several sub-devices:
> >> +   Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> >> +
> >> +3. Battery charger (power supply):
> >> +   Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> >> +   (but use vendor prefix in filename)
> >> +
> >> +4. Clock controller for several devices with different clock inputs:
> >> +   Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> >> +
> >> +5. GPIO controller:
> >> +   Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
> >> +
> >> +
> >> +Re-usable design patterns when writing your own bindings
> >> +========================================================
> >> +
> >> +Following bindings show how to use common pattern of writing bindings:
> >> +
> >> +1. Property required and present only for one variant.  Property cannot appear
> >> +   on other variants:
> >> +   Documentation/devicetree/bindings/example-schema.yaml
> >> +   Line: 212
> >> +
> >> +2. Excluding properties, but none are required:
> >> +   Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
> >> +   Line: 155
> >> +
> >> +3. Excluding required properties, but one is required:
> >> +   Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> >> +   Line: 91
> >> +
> >> +4. Array with numbers (items) from given range - min/max:
> >> +   Documentation/devicetree/bindings/arm/l2c2x0.yaml
> >> +   Line: 74
> >> +
> >> +5. Array with numbers (items) from given range - enum:
> >> +   Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> >> +   Line: 101
> >> +
> >> +6. Uint32 matrix, variable length of two-items:
> >> +   Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >> +   Line: 278
> >> +
> >> +7. Phandle to syscon with offset:
> >> +   Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> >> +   Line: 42
> >> +
> >> +8. Variable length of array (e.g. clocks and clock-names) but narrowed to
> >> +   specific variant:
> >> +   Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> >> +   Lines: 33 and 71
> > 
> > It seems like some of these that are just a single property we could add 
> > to example-schema.yaml.
> 
> I am afraid the example-schema will grow too big for folks to look into.
> It's already quite complicated, with explanations of the dtschema
> behavior itself.

How about splitting up the top-level descriptions and property examples?

> How about then RST file with small code snippets?

Then they don't validate.

> 
> > Also, perhaps a reference to this from writing-schema.rst.
> 
> I can do this as well.
> 
> The problem with my approach above (and adding these to writing-schema)
> is that examples above can change, lines can be inadequate.

I just meant a link in writing-schema.rst to this doc. We already have 
that for example-schema.yaml.

Rob
