Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630076943CB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBMLEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjBMLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:04:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5D40EE;
        Mon, 13 Feb 2023 03:04:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id be8so13117607plb.7;
        Mon, 13 Feb 2023 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzN50lIcZGBFDntOn8igk3Ln2b075PMIFDDX4eI/7dE=;
        b=i/1ycPfwnxtLqbPd8axwK16ZKstxlhG+1vFVRwfiJ6PauMp67fftQ/tOzg4kBCvclP
         6R4Jz9DtaAWmuaJwIQVX4Kv3ZkmXbsSbawWPfcJiNl5mbNSJzdyr4G9VkqZfAx32Qu/d
         H+9Jyt7W686kidgYp4/rZmDwAoAz+aCFTLkVI8Nr7IqOhoyqGvBShu8Q2EeuWDbA7xio
         R+fppiaMvGLrgJLbZlmKb2PE2w1Wkzu09MY9kQCZY84ZIkq1k/4w2f6dOS2FaBke56b8
         Yf5OQgwAhpWuwxjc0/D4UB7Vxhsrl7TEJORROhEN6NMo4KTR7FMvaqcx8RT88TelKKvV
         36Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzN50lIcZGBFDntOn8igk3Ln2b075PMIFDDX4eI/7dE=;
        b=OpG6vgWRkCCES4pDF8USdb8HrnropBgFqUwLc7YDKUbKNz5pCHS2LSxw93Pha0P+w6
         V1V2HVcPxKu8QeCFznFvlRBF8wiLYQdlRfWbJO9xPC5Lkbxr4WTcE7qpfdBaYQSbmd9i
         3eQ630LVUxR+EcfQt5cBkmjCOedkXUxhVxJpy1S/0jtLOI+MW2rd2es7+PAfE1HeZhND
         Hagr/eLeTJFfVY+XO3COhIVnJ4obQaoGJ8e5C4Mqu6d1kprePcodx0crW8bxIvmkNLLb
         E9+DJTgAEcn+iJhJLwe7auTbM7DtcgPoz8ELBhQmb+25fcZWlkgUYM7r8STQp0aWxDD+
         5wyw==
X-Gm-Message-State: AO0yUKULccGu9/Mfgshchp26JrFgVDc0Ni4SnEAkXEaSdpWWolsIZ+FW
        g4P8hjhd2wEPkgSA+tdKu3I=
X-Google-Smtp-Source: AK7set+RKDadqVzvT05fEYtx/HyoM0eOT/3UqvoygsGwDBL51skMUuDazlf8uNCR+PyFlReSF3bKvw==
X-Received: by 2002:a17:90b:1e46:b0:230:7aeb:2936 with SMTP id pi6-20020a17090b1e4600b002307aeb2936mr25721092pjb.20.1676286272423;
        Mon, 13 Feb 2023 03:04:32 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a2d8900b00233bab35b57sm4459375pjd.29.2023.02.13.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 03:04:32 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:04:25 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36523
 bindings
Message-ID: <Y+oZOXyE8/a+vreS@Gentoo>
References: <20230210161925.32343-1-lujianhua000@gmail.com>
 <6cffa875-d8cc-a4fe-e18d-2e24c28a49d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cffa875-d8cc-a4fe-e18d-2e24c28a49d8@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:45:23AM +0100, Krzysztof Kozlowski wrote:
> On 10/02/2023 17:19, Jianhua Lu wrote:
> > Novatek NT36523 is a display driver IC that can drive DSI panel. It
> > is also present in the csot and boe video mode panels. It is found
> > in Xiaomi Mi Pad 5 series.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> >  .../display/panel/novatek,nt36523.yaml        | 101 ++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> > new file mode 100644
> > index 000000000000..a7098d0ce7e1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/novatek,nt36523.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Novatek NT36523 based DSI display Panels
> > +
> > +maintainers:
> > +  - Jianhua Lu <lujianhua000@gmail.com>
> > +
> > +description: |
> > +  The nt36523 IC from Novatek is a generic DSI Panel IC used to drive dsi
> > +  panels.
> > +  Right now, only support cost and boe LCD display panels with the
> 
> boe? both?
Boe Technology Group Co., Ltd
> 
> > +  resolution of 1600x2560. It is a video mode DSI panel.
> 
> The binding or hardware supports only 1600x2560? The how it can be
> "right now"? It's defined, isn't it?
Yes
> 
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - xiaomi,elish-csot-nt36523
> > +          - xiaomi,elish-boe-nt36523
> > +      - const: novatek,nt36523
> > +    description: This indicates the panel manufacturer of the panel that is
> > +      in turn using the NT36523 panel driver. This compatible string
> > +      determines how the NT36523 panel driver is configured for the indicated
> > +      panel. The novatek,nt36523 compatible shall always be provided as a fallback.
> 
> Drop description. First it is free form text of binding, so unnecessary.
> Second, does not really bring any new information.
Acked
> 
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: phandle of gpio for reset line - This should be 8mA, gpio
> > +      can be configured using mux, pinctrl, pinctrl-names (active high)
> 
> Simplify description - 90% of it is redundant and only drive strength of
> 8 mA is important.
Acked
> 
> > +
> > +  vddio-supply:
> > +    description: regulator that supplies the I/O voltage
> > +
> > +  vddpos-supply:
> > +    description: positive boost supply regulator
> > +
> > +  vddneg-supply:
> > +    description: negative boost supply regulator
> > +
> > +  reg: true
> > +  ports: true
> > +  backlight: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vddio-supply
> > +  - vddpos-supply
> > +  - vddneg-supply
> > +  - reset-gpios
> > +  - ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |+
> 
> Drop +
Acked
> 
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    dsi0 {
> 
> dsi {
Acked
> 
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        panel@0 {
> > +            compatible = "xiaomi,elish-csot-nt36523", "novatek,nt36523";
> > +            reg = <0>;
> > +            vddio-supply = <&vreg_l14a_1p88>;
> > +            vddpos-supply = <&lcd_vddpos_5p5>;
> > +            vddneg-supply = <&lcd_vddneg_5p5>;
> > +
> > +            backlight = <&backlight>;
> > +            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
> > +
> > +            ports {
> > +              #address-cells = <1>;
> > +              #size-cells = <0>;
> > +
> > +              port@0 {
> > +                reg = <0>;
> 
> Mixed up indentation.
Acked
> 
> Best regards,
> Krzysztof
> 
