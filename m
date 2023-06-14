Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15872F8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjFNJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjFNJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:13:19 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC9A19A;
        Wed, 14 Jun 2023 02:13:17 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a69a593245so2868707fac.0;
        Wed, 14 Jun 2023 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686733996; x=1689325996;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iyn4Imh8C+Bmc0NBF5Csz90N/HTVVr12fkAQs9kcqjs=;
        b=gkAx9epTkee2UgGEHPc8r5l+uoRTbeJiCyMWDOMIZot7ANZ+/mwCP4431eeY8cx4/v
         2utt/ZlfwIzHTm+B3XRWiTuuXwt+2qBm0F4YurXKkSjjgIpKKCPivkN4CM3CvIDob6N3
         8i5FkmjxZyGtGBbrAU3Qf22svNHOVP1yewHxQ8HM0HTqgs8Ab9/AHV1nLzn+EKIlCUO3
         GAgIs3b9ulSnkfi3P4ou+mzeY56o8a/yi/517ly/kgSc8xrpXKzPaUWmL3iIU6+InF+w
         PTsgK4GPqCmlxTZLQHxyG+aHrk5RGrfdw5j4cDSbE+70pxTKKNKhc82Y2WABfvCzKH3i
         Rl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686733996; x=1689325996;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iyn4Imh8C+Bmc0NBF5Csz90N/HTVVr12fkAQs9kcqjs=;
        b=ecD0TK0FOkkQvg+uxUtuKAea30FJy8DcR7VcMv6fsBljWWeX/W7Dq/N2ZQ4ffi9nFM
         O4gdWloCLQwTGsve3Ko4DhVX6iMwnA5i26eRSDoPL2tqI3Lwg80yLqTH/RUq1MZl4Vv6
         /oyjCN2uh2ONa+9mONJsyFYXxmD4ACgLmyD05iXBu0PL/p3OZO2jDoHX4J95C5ncPeUH
         veyXjfE6ZXvMz9A7GxZBh0HErtB4iXmM8kYUK8e+BfUoU++qhpQ4/AeUznNQFDjbowjG
         d3rpgNjspWvtya6YOCGLGCQV2MrlKhzyPaT2KDlnO1aizMOu8PvGJNincoIuLYjxZOce
         antA==
X-Gm-Message-State: AC+VfDw0NI5B7k4UlGCEA71VX+KHbyExheyXyEOf03+LFj3LcOiN0rpI
        Klq/Z0U6wsTbINV7CCRgDj4Y2pnk9HhrUeqqkDc=
X-Google-Smtp-Source: ACHHUZ5+ZHli1VEWhgLDEyeSuhsWZu+OYDedFMRGcR87LykJFOwwXC20QZ34hrhyZqj8qaRn5YcpFa+yJ75846/AggU=
X-Received: by 2002:a05:6871:40e:b0:19f:5c37:abb9 with SMTP id
 d14-20020a056871040e00b0019f5c37abb9mr10124276oag.12.1686733996401; Wed, 14
 Jun 2023 02:13:16 -0700 (PDT)
MIME-Version: 1.0
From:   Mithil <bavishimithil@gmail.com>
Date:   Wed, 14 Jun 2023 14:43:03 +0530
Message-ID: <CAGzNGR=BkOMtw2PhudUs_b4ffk3B+x==9dtWuA-kcqnePaHVYA@mail.gmail.com>
Subject: Re: [PATCH 05/10] dt-bindings: power: reset: Add bindings for twl6030-power
To:     "robh@kernel.org" <robh@kernel.org>
Cc:     "bavishimithil@gmail.com" <bavishimithil@gmail.com>,
        "contact@paulk.fr" <contact@paulk.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sre@kernel.org" <sre@kernel.org>,
        "tony@atomide.com" <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [PATCH 05/10] dt-bindings: power: reset: Add bindings for
twl6030-power

On Tue, Aug 23, 2022 at 12:54 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Aug 20, 2022 at 12:46:55PM +0530, Mithil Bavishi wrote:
> > Adds documentation for the twl6030 power driver.
> >
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> > ---
> >  .../bindings/power/reset/twl6030-power.txt    | 31 +++++++++++++++++++
>
> New bindings must be DT schema format.
>
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/twl6030-power.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/reset/twl6030-power.txt b/Documentation/devicetree/bindings/power/reset/twl6030-power.txt
> > new file mode 100644
> > index 000000000..946bb3d9f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/twl6030-power.txt
> > @@ -0,0 +1,31 @@
> > +Texas Instruments TWL family (twl6030) reset and power management module
> > +
> > +For now, the binding only supports the complete shutdown of the system after
> > +poweroff.
> > +
> > +Required properties:
> > +- compatible : must be
> > +       "ti,twl6030-power"
> > +
> > +Optional properties:
> > +
> > +- ti,system-power-controller: This indicates that TWL6030 is the
>
> We have a generic property for this.
>

What is property is that? And how would it get implemented here?

> > +  power supply master of the system. With this flag, the chip will
> > +  initiate an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
> > +  system poweroffs.
> > +
> > +Example:
> > +&i2c1 {
> > +       clock-frequency = <2600000>;
> > +
> > +       twl: twl@48 {
> > +               reg = <0x48>;
> > +               interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> > +               interrupt-parent = <&intc>;
> > +
> > +               twl_power: power {
> > +                       compatible = "ti,twl6030-power";
> > +                       ti,system-power-controller;
>
> Why do you need a child node here? There aren't any resources for the
> sub-block.
>

Just an example and how it is used on a device as well, is it fine if
just the block is as-is?

Mithil
