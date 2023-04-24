Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C046ED2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjDXQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjDXQxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:53:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A061712;
        Mon, 24 Apr 2023 09:53:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec816d64afso20195782e87.1;
        Mon, 24 Apr 2023 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355227; x=1684947227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4a2P0TUQ0mn+DpoMQpgGHoufc6HMZENvo2lrGhlperY=;
        b=AMO41QCJ9wgDvxfnHevXOMLXc5fmHjxUDQW7Sq5BkbnA/YBKTmx9W1ba2Bq9aqCsOB
         nh5grgU3i7+ybXGo9IbyMKeBOzfT+1D4GcQS/5aHukaSAdxyNxch2vVJuDuzt+30LIlw
         fvPCgwBLJvshkBAxGXDG3cuniq/GDuqaPD3K5rntvzMAZbvcxcQpjvseaoI2hd1quFmQ
         cyqRyZpD1TDGA++plkbhwGAVG63Ln+sCUnW7GqVp38ZRsb14cEUBy6J0wJN6hMxXM6fV
         DgrJvAQb6x6R0QOEk4yKHr/ZqjZywySSUUxgVRXup3axAjk3AnqBu3cEmdx0rVf+gEL6
         ay2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355227; x=1684947227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4a2P0TUQ0mn+DpoMQpgGHoufc6HMZENvo2lrGhlperY=;
        b=VCZONbHh5s/N4lsDjpXTbot3eDIvS5vL0nNU++3f08fE1UxAPZ1CYzd5BL78hUWFwQ
         DRCeO9++54cldZSZwX5ObqeHP+6O9KPpDXcIDj5cvs4rMcqQdH/9BAoukHeHEH7x2Jt+
         mD9r3cugUIkgZKFt9HIJp30VGbGTDkvlDWChShx7bsl2YpOaek92SsvKsyoD6FpbIWNn
         WgJTT6BXhmIPqEU89p9z5elyYUiEA4CYriMEAg6KO7IMWqkMWTKijMqS9FiMmgEQX1sy
         HYZaobO5B1BVVMQ8lE7D3WOClNWJrCn0Wp7wM2e+/+c7skLQZDsQHOFfaNVM9ZGXEV7f
         3ISQ==
X-Gm-Message-State: AAQBX9drJFg4v0ksqP38qn5bIBXYCAyxNEZRNuK2iXIwODUew4cQeKJf
        ij0jfp2jVPwGHejWRw9FfHmaeryk+EheLyA+MeA=
X-Google-Smtp-Source: AKy350b/IT3RaAB1CmITHJJLsYFLerjZZ/NE70bzoYD2fmKSh3wDqqv0xtIuxcZi+DcSWA4fU+VlG4ZXc3K+GrR1+FM=
X-Received: by 2002:a05:6512:1589:b0:4e2:7ab6:15cd with SMTP id
 bp9-20020a056512158900b004e27ab615cdmr5502211lfb.30.1682355227201; Mon, 24
 Apr 2023 09:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230418170341.28805-1-n2h9z4@gmail.com> <20230421183420.GA1568047-robh@kernel.org>
In-Reply-To: <20230421183420.GA1568047-robh@kernel.org>
From:   Nikita B <n2h9z4@gmail.com>
Date:   Mon, 24 Apr 2023 18:53:35 +0200
Message-ID: <CAJVoGU0QDSjQ+pjCWQ7PW8aA6-GyU9j8nAAoDD_hriAHp7Eirg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: watchdog: brcm,kona-wdt: convert txt file
 to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 at 20:34, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 18, 2023 at 07:03:41PM +0200, Nikita Bondarenko wrote:
> > Converted txt file to yaml. No additional changes.
> >
> > Signed-off-by: Nikita Bondarenko <n2h9z4@gmail.com>
> > ---
> >
> > Changes in v3:
> > - updated commit message
> > - updated the compatible definition to probably fix "compatible is too long" warning
> > - updated example to how it was in the txt file
> >
> >
> > I do not have this warning when I am running
> > make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
> > maybe I run it without some additional variable?
> >
> > But I checked arch/arm/boot/dts/bcm28155-ap.dts, it includes bcm11351.dtsiv which contains
> > compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> > which probably causes a warning
> > This is exact how it was in txt file example.
> >
> > If I put it in an example in a yaml file, dt_binding_check does not pass.
> > Looks like the issue is in the enum type of compatible. It does not allow multiple strings.
> > Updated to not to use enum. The example with two strings in compatible passes the checks.
> >
> > make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
> >   LINT    Documentation/devicetree/bindings
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   DTEX    Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dts
> >   DTC_CHK Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dtb
> >
> > make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dtbs_check
> >   LINT    Documentation/devicetree/bindings
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>
> And that's it? You need to remove all the .dtb files if you don't see
> any DTB lines. But this runs it for you:
>
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230418170341.28805-1-n2h9z4@gmail.com/
>
> It all looks fine, so not sure what your question/issue is?
>
> >
> >
> > v2 patch is here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230402135555.62507-1-n2h9z4@gmail.com/
> >
> >  .../bindings/watchdog/brcm,kona-wdt.txt       | 15 -------
> >  .../bindings/watchdog/brcm,kona-wdt.yaml      | 41 +++++++++++++++++++
> >  2 files changed, 41 insertions(+), 15 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> > deleted file mode 100644
> > index 2b86a00e351d..000000000000
> > --- a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> > +++ /dev/null
> > @@ -1,15 +0,0 @@
> > -Broadcom Kona Family Watchdog Timer
> > ------------------------------------
> > -
> > -This watchdog timer is used in the following Broadcom SoCs:
> > -  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> > -
> > -Required properties:
> > -  - compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> > -  - reg: memory address & range
> > -
> > -Example:
> > -     watchdog@35002f40 {
> > -             compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> > -             reg = <0x35002f40 0x6c>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> > new file mode 100644
> > index 000000000000..3d4403b41cbe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/brcm,kona-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom Kona Family Watchdog Timer
> > +
> > +description: |
> > +  This watchdog timer is used in the following Broadcom SoCs:
> > +  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> > +
> > +maintainers:
> > +  - Florian Fainelli <f.fainelli@gmail.com>
> > +  - Ray Jui <rjui@broadcom.com>
> > +  - Scott Branden <sbranden@broadcom.com>
> > +
> > +allOf:
> > +  - $ref: watchdog.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: brcm,bcm11351-wdt
> > +      - const: brcm,kona-wdt
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    watchdog@35002f40 {
> > +        compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> > +        reg = <0x35002f40 0x6c>;
> > +    };
> > --
> > 2.34.1
> >

Hello!

Got it, thank you!
