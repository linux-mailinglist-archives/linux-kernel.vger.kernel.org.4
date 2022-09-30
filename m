Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C865F12C1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiI3TfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiI3Teo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:34:44 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A644105031;
        Fri, 30 Sep 2022 12:34:00 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so2896058ooo.8;
        Fri, 30 Sep 2022 12:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JUOh6KA8TmP/FnKF+rchY8Hc+0lfIWV8MZd+9zBGqnM=;
        b=7mcuMbsXrQgf/Psny5d23+4LdOUcAbxHabGXiDc9NcI6XDIFnhDNnStWHfB0R3Uarq
         q0CHQjh7BMFdhE6PszC1zc2BCQRTttEEgl7dcWpLckvr9nFhWMaFSUJ/tIO48SpQHr0a
         6rnYEgR3TKqOCNKTKZt9pb8CWbB8x3qdJQpxiL7BgMJknHF6AXdg7WNeDiCGWrzIGE7B
         O+/EPtkRElcHN8KgCDzeEadEp6NMhODJhNTYHrXG5c7YO5bJ5euA71rL8srnwT345N7J
         rNdIL9hHQFgIoMOMSRxz7yHQJfA+rb9/NTlJJI2PjGjBU7PGHyGfijb6OrO56sjFHjK4
         Gwqw==
X-Gm-Message-State: ACrzQf37M5foYZquP9sACxreoT6cTwefo5eD80DdMgZHPlbnuxijZ75t
        Bf9kDqPI6my0B8TVZv2/2jwfKvC1Uw==
X-Google-Smtp-Source: AMsMyM6DApZ4dDjTpY5YuXY4Q0QstBp9864BWaqbQY2ZqWjCfnWcAqEWq1CXJBryMVfGVB8Dulz7rA==
X-Received: by 2002:a9d:70d5:0:b0:659:81b1:87a2 with SMTP id w21-20020a9d70d5000000b0065981b187a2mr3881342otj.299.1664566390486;
        Fri, 30 Sep 2022 12:33:10 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h34-20020a4a9425000000b004357ccfc8bfsm624307ooi.7.2022.09.30.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:33:09 -0700 (PDT)
Received: (nullmailer pid 753043 invoked by uid 1000);
        Fri, 30 Sep 2022 19:33:08 -0000
Date:   Fri, 30 Sep 2022 14:33:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        collinsd@codeaurora.org, subbaram@codeaurora.org
Subject: Re: [PATCH v2 2/2] dt-bindings: add bindings for QCOM flash LED
Message-ID: <20220930193308.GA741352-robh@kernel.org>
References: <20220929121544.1064279-1-quic_fenglinw@quicinc.com>
 <20220929121544.1064279-3-quic_fenglinw@quicinc.com>
 <5445adda-80e6-41d0-9786-c26d253631c9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5445adda-80e6-41d0-9786-c26d253631c9@linaro.org>
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

On Thu, Sep 29, 2022 at 02:40:05PM +0200, Krzysztof Kozlowski wrote:
> On 29/09/2022 14:15, Fenglin Wu wrote:
> > Add binding document for flash LED module inside Qualcomm Technologies,
> > Inc. PMICs.
> > 
> > Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +  reg:
> > +    description: address offset of the flash LED controller
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  "^led[0-3]$":
> 
> In such case: ^led-[0-9]$"
> 
> > +    type: object
> > +    $ref: common.yaml#
> > +    unevaluatedProperties: false
> > +    description: |
> > +      Represents the physical LED components which are connected to the
> > +      flash LED channels' output.
> > +
> > +    properties:
> > +      led-sources:

This is for when the power source and LED connection are programmable. 
IOW, when 'reg' is not enough to describe the configuration. If you only 
have LED channels 1-4 with a fixed connection to LED pins/output 1-4, 
then use 'reg'.

> > +        description: |
> > +          The HW indices of the flash LED channels that connect to the
> > +          physical LED
> > +        allOf:
> > +          - minItems: 1
> > +            maxItems: 2
> > +            items:
> > +              enum: [1, 2, 3, 4]
> > +
> > +      led-max-microamp:
> > +        description: |
> > +          The maximum current value when LED is not operating in flash mode (i.e. torch mode)
> > +          Valid values when an LED is connected to one flash LED channel:
> > +            5000 - 500000, step by 5000
> > +          Valid values when an LED is connected to two flash LED channels:
> > +            10000 - 1000000, step by 10000
> > +        minimum: 5000
> > +        maximum: 1000000

anyOf:
  - minimum: 5000
    maximum: 500000
    multipleOf: 5000
  - minimum: 10000
    maximum: 1000000
    multipleOf: 10000

Drop any description that's captured by the constraints.

> > +
> > +      flash-max-microamp:
> > +        description: |
> > +          The maximum current value when LED is operating in flash mode.
> > +          Valid values when an LED is connected to one flash LED channel:
> > +            12500 - 1500000, step by 12500
> > +          Valid values when an LED is connected to two flash LED channels:
> > +            25000 - 2000000, step by 12500
> > +        minimum: 12500
> > +        maximum: 2000000
> > +
> > +      flash-max-timeout-us:
> > +        description: |
> > +          The maximum timeout value when LED is operating in flash mode.
> > +          Valid values: 10000 - 1280000, step by 10000
> > +        minimum: 10000
> > +        maximum: 1280000

Similar comment for these 2.

> > +
> > +    required:
> > +      - led-sources
> > +      - led-max-microamp
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/leds/common.h>
> > +    spmi_bus {
> 
> No underscores in node names, so just "bus"

SPMI is something else though...

