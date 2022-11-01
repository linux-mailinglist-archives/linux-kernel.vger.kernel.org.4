Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39C4614B58
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKANHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKANHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:07:20 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3250B12AD3;
        Tue,  1 Nov 2022 06:07:20 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso16667306fac.13;
        Tue, 01 Nov 2022 06:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XX+1tQyagjhLYJ+rVwkc+QparYH+oKNVJedlnYRSRY=;
        b=vhlPqZeyjANJ0mLaudZJiWeGZkSnWjP3jai7N4KcnQJbEYdzgYCKOyRODGeQN0zFBO
         GUs7XmBK72NKY1CNUULacaC7kcVg9omYFqwAfwHTmtMUzwbx2VB4mLep1URi1XutbpKw
         XP8TrlMAx4PmKFlbm5eaudtKbwf1ZevOlCuan/CyIOiWjlX+XBvZ62XHx+ePGycOWLHC
         5tztoixggLWha5+r5JzijUjQmxhHlpYqEgIAwIin6hGSvgRN6VvrwaUNuh0ZIEwxsvSG
         EkNMyOdjK/0rpIllDiWnFrUpcjlslb8R1vaEGbMFCXxNoDGNrKqcpX8iRm8AiaL/pkRk
         jL+Q==
X-Gm-Message-State: ACrzQf1YbmWRaxYdJwzJHfqKka0sc57K7Da0gVBr5n/KtY4bzCT3Q9sN
        i9mYYlavT2A9fzgScle5bg==
X-Google-Smtp-Source: AMsMyM5PVguR3A71y3EsDEyzo/z7r2ozcy8ECLngqVTJ5asiI6SB11hF8kaDv6QHFIEGOshaVnNKlA==
X-Received: by 2002:a05:6870:1607:b0:131:dcec:98f6 with SMTP id b7-20020a056870160700b00131dcec98f6mr10612050oae.162.1667308039338;
        Tue, 01 Nov 2022 06:07:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d5e0b000000b00660e833baddsm3836746oti.29.2022.11.01.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 06:07:18 -0700 (PDT)
Received: (nullmailer pid 991499 invoked by uid 1000);
        Tue, 01 Nov 2022 13:07:20 -0000
Date:   Tue, 1 Nov 2022 08:07:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: examples: add a list of templates and
 solutions
Message-ID: <20221101130720.GA963805-robh@kernel.org>
References: <20221028233701.572280-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028233701.572280-1-krzysztof.kozlowski@linaro.org>
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

On Fri, Oct 28, 2022 at 07:37:01PM -0400, Krzysztof Kozlowski wrote:
> It is useful to start from existing bindings when writing new ones,
> especially when one does not know that much DT schema.  However we have
> several bindings which are not the best examples, so people tend to copy
> their issues into new bindings.
> 
> Beginners also might not know how to achieve some more complex solutions
> in DT schema, e.g. how one of two properties should be required by the
> bindings.  Some of such solutions are already in example-schema.yaml,
> but several other are missing.  Add reference with such re-usable
> design-patterns.

My main concern here is what's a good example today is not tomorrow... 


> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/examples.rst          | 63 +++++++++++++++++++
>  Documentation/devicetree/bindings/index.rst   |  1 +
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/examples.rst
> 
> diff --git a/Documentation/devicetree/bindings/examples.rst b/Documentation/devicetree/bindings/examples.rst
> new file mode 100644
> index 000000000000..710eea81d8b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/examples.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Examples of Devicetree Bindings to use a base
> +=============================================
> +
> +Following Devicetree Bindings in DT Schema are a known good starting point when
> +writing new bindings:
> +
> +1. Simple SPI device:
> +   Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> +
> +2. PMIC (MFD) with several sub-devices:
> +   Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> +
> +3. Battery charger (power supply):
> +   Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> +   (but use vendor prefix in filename)
> +
> +4. Clock controller for several devices with different clock inputs:
> +   Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> +
> +5. GPIO controller:
> +   Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
> +
> +
> +Re-usable design patterns when writing your own bindings
> +========================================================
> +
> +Following bindings show how to use common pattern of writing bindings:
> +
> +1. Property required and present only for one variant.  Property cannot appear
> +   on other variants:
> +   Documentation/devicetree/bindings/example-schema.yaml
> +   Line: 212
> +
> +2. Excluding properties, but none are required:
> +   Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
> +   Line: 155
> +
> +3. Excluding required properties, but one is required:
> +   Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> +   Line: 91
> +
> +4. Array with numbers (items) from given range - min/max:
> +   Documentation/devicetree/bindings/arm/l2c2x0.yaml
> +   Line: 74
> +
> +5. Array with numbers (items) from given range - enum:
> +   Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +   Line: 101
> +
> +6. Uint32 matrix, variable length of two-items:
> +   Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> +   Line: 278
> +
> +7. Phandle to syscon with offset:
> +   Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> +   Line: 42
> +
> +8. Variable length of array (e.g. clocks and clock-names) but narrowed to
> +   specific variant:
> +   Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> +   Lines: 33 and 71

It seems like some of these that are just a single property we could add 
to example-schema.yaml.


Also, perhaps a reference to this from writing-schema.rst.

Rob
