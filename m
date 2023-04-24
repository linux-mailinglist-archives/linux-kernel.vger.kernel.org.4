Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DA06ED1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjDXP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDXP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:59:23 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735D16A59;
        Mon, 24 Apr 2023 08:59:22 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6a438f0d9c9so3688321a34.1;
        Mon, 24 Apr 2023 08:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351962; x=1684943962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ1Hz9RAdCq/GB1HaxyxLVXHyGyd0uhfNpdOefl8fI4=;
        b=g+JBAjtwMkDCkPZ2862LYr9VIdNUuTPrBG0TsOXjsm8INll8oDrdd96oCMXKTYTtoP
         VHBMjUWkr6gYJGf1ZsM0H9v5UCTZQfORw8/EM2/MLj7BB1uaSYCs1IevaCtqDLBXi+zq
         26OVdIXBRgXpX5DkZuylerD2/Yd4FMQR6IT8YIAU7MNsS/wnRYK4Uja51jeYiWepRDMy
         PJd4mCMwOgFhPowjCRLMDy94x9R5/ehM78fD+NXbhvYIg3xt4+o5FeuSgVIzVGjJBl+v
         IrR9eBk6cUJg1YOj4AyB/uiivNgGZv1tVTOtBDIMZU1hd/9I4DoraLiSXA8CA7a92SJS
         VgWw==
X-Gm-Message-State: AAQBX9dwFMBjrVPuVAs1VkvzNJTzKQgN/YleREztBa0Ge2UcH34Qahbi
        gdW7Yss6hCS87HVukSS6Ng==
X-Google-Smtp-Source: AKy350Zx8vum6et4oh1aktNWgI1tpYztaZV30hc95RVVftyvE3Uep6TTmjcx/8Yz78StJ5XoOXaRtQ==
X-Received: by 2002:a05:6870:1ca:b0:187:7579:76c0 with SMTP id n10-20020a05687001ca00b00187757976c0mr11863905oad.37.1682351961545;
        Mon, 24 Apr 2023 08:59:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870a60600b0017aafd12843sm4622442oam.32.2023.04.24.08.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:59:21 -0700 (PDT)
Received: (nullmailer pid 2707611 invoked by uid 1000);
        Mon, 24 Apr 2023 15:59:20 -0000
Date:   Mon, 24 Apr 2023 10:59:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/43] dt-bindings: watchdog: add DT bindings for Cirrus
 EP93x
Message-ID: <20230424155920.GB2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-10-nikita.shubin@maquefel.me>
 <b39724a8-5e29-411e-9deb-29dd37609372@roeck-us.net>
 <7353ae3d-baf1-4f7f-9d87-ae322aa37338@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7353ae3d-baf1-4f7f-9d87-ae322aa37338@roeck-us.net>
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

On Mon, Apr 24, 2023 at 07:18:06AM -0700, Guenter Roeck wrote:
> On Mon, Apr 24, 2023 at 07:16:16AM -0700, Guenter Roeck wrote:
> > On Mon, Apr 24, 2023 at 03:34:25PM +0300, Nikita Shubin wrote:
> > > This adds device tree bindings for the Cirrus Logic EP93xx
> > > watchdog block used in these SoCs.
> > > 
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > ---
> > >  .../bindings/watchdog/cirrus,ep93xx-wdt.yaml  | 38 +++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> > > new file mode 100644
> > > index 000000000000..f39d6b14062d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> > > @@ -0,0 +1,38 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/watchdog/cirrus,ep93xx-wdt.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Cirrus Logic EP93xx Watchdog Timer
> > > +
> > > +maintainers:
> > > +  - Wim Van Sebroeck <wim@linux-watchdog.org>
> > > +
> > > +description:
> > > +  Watchdog driver for Cirrus Logic EP93xx family of devices.
> > > +
> > > +allOf:
> > > +  - $ref: "watchdog.yaml#"
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - cirrus,ep9301-wdt
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > 
> > The driver does support reading the timeout from devicetree.
> > It might make sense to mention that here.
> > 
> Never mind - I guess that is includeds in watchdog.yaml.
> Sorry for the noise.

Except that it needs to be 'unevaluatedProperties: false' instead if 
timeout property is supported.

> 
> > > +
> > > +examples:
> > > +  - |
> > > +    wdt0: watchdog@80940000 {
> > > +        compatible = "cirrus,ep9301-wdt";
> > > +        reg = <0x80940000 0x08>;
> > > +    };
> > > +
> > > -- 
> > > 2.39.2
> > > 
