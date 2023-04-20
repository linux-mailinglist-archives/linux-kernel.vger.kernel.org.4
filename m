Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD416E8C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjDTIEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjDTIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:04:08 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18A2D5A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:04:07 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54c12009c30so29834177b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977845; x=1684569845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fXWyKp3XSUcvTU5xoanOZtx5sHg5Egur8w0WrefDSQ=;
        b=w3tKpZ1Gy7L3CH/hzmouFjqkpGiLn09Spi0M03TPgYFZcjuP/VVGep+f9oMTBZfxq8
         u+ObHluAHc+2Npc4/GmveJPRpi2C706/n5thv672X4pV1c7lrhvbi/bJyFz5+3GVVtMc
         dycM5NwQvxqrC9kcRTBBLAvLGrxf+sY/gGk+X/naUstVFRbR7Chy+CxPucnVN0rKQM1g
         YIJi2Yx8hppaUgIXH32j23aHJvD+n+Vgnn/3Mum0Czu0z1E4xhoWkvKHIXGBWl7EigwO
         RYWjTuHvqdMIGMldIDclIS6pgDtp5Hf33c1eCqGRAAJr+6WPHr4Gg50bhugfaxNRxP+c
         bJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977845; x=1684569845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fXWyKp3XSUcvTU5xoanOZtx5sHg5Egur8w0WrefDSQ=;
        b=QLDndRBgAGGA9OGbL+Zte5ZeHY88AFlmJ09+d3JoPBhNrosR76Mx2Cpqq94J5om/zv
         gGPUFQfoUw6JrvjTwRYy5LLu/uO9STUfgbereZ5PwPNGy9hGlR31eLiyBA8EfNIjFR0/
         QK8sYL90oUiz3HoCruQ46sbF5aXOpB2UdC0KVCJRXZd5cgaGR07sL9/ORPrgPSJvp72T
         nAcM0+y0Sc7GGXPnunh+/O8BKQBN8kvnrn7g998+hsrcX2Q7cnE2lTbylhL6yTubY99T
         CzjYtJc+FxYi0Yk9XvbWU84r/VsKA3UAumnYnghtbik8no9P2UJVMidV6+5RpBEt3ZLI
         nc3g==
X-Gm-Message-State: AAQBX9d5gtoFRRE+5qoA8HJZdTY9BjxUErMo+4gXHCoPF1al/FmAuii3
        ILn6zzp/9zb0LaSHLpYBoRR6SL/5Y6LBogdzFr1dPw==
X-Google-Smtp-Source: AKy350ZRSQHQsf9xKUBA19c/nJKNEHXe853gEGTykFpQDkKhO3vkjtWKmzpLGp2OguXUdtch0PPAaVkLZeCkrwi2q0k=
X-Received: by 2002:a0d:cc53:0:b0:54f:b8ee:36c0 with SMTP id
 o80-20020a0dcc53000000b0054fb8ee36c0mr244377ywd.34.1681977845667; Thu, 20 Apr
 2023 01:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681646904.git.jahau@rocketmail.com> <9275af790e6e21b5cf661a2444effe4caf2be02e.1681646904.git.jahau@rocketmail.com>
 <CACRpkdZEtG=OjTECDO=SvFk89MqL10sKKMOABPEs-xxYv1hmqw@mail.gmail.com>
In-Reply-To: <CACRpkdZEtG=OjTECDO=SvFk89MqL10sKKMOABPEs-xxYv1hmqw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Apr 2023 10:03:54 +0200
Message-ID: <CACRpkdaRkJ-JVNqAOQLuOgDztDfUP7DBQU9QP7AMbnK=eN2HWQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 9:59=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> Hi Jakob,
>
> thanks for your patch!
>
> The following caught my eye:
>
> On Sun, Apr 16, 2023 at 2:50=E2=80=AFPM Jakob Hauser <jahau@rocketmail.co=
m> wrote:
>
> > Add device tree binding documentation for rt5033 multifunction device, =
voltage
> > regulator and battery charger.
> >
> > Cc: Beomho Seo <beomho.seo@samsung.com>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> > ---
> > The patch is based on linux-next (tag "next-20230413").
> (...)
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-cha=
rger.yaml
> (...)
> > +  richtek,pre-microamp:
> > +    description:
> > +      Current of pre-charge mode. The pre-charge current levels are 35=
0 mA to
> > +      650 mA programmed by I2C per 100 mA.
> > +    maxItems: 1
> > +
> > +  richtek,fast-microamp:
> > +    description:
> > +      Current of fast-charge mode. The fast-charge current levels are =
700 mA
> > +      to 2000 mA programmed by I2C per 100 mA.
> > +    maxItems: 1
> > +
> > +  richtek,eoc-microamp:
> > +    description:
> > +      This property is end of charge current. Its level ranges from 15=
0 mA to
> > +      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA=
 and 600 mA
> > +      in 100 mA steps.
> > +    maxItems: 1
> > +
> > +  richtek,pre-threshold-microvolt:
> > +    description:
> > +      Voltage of pre-charge mode. If the battery voltage is below the =
pre-charge
> > +      threshold voltage, the charger is in pre-charge mode with pre-ch=
arge current.
> > +      Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
> > +    maxItems: 1
> > +
> > +  richtek,const-microvolt:
> > +    description:
> > +      Battery regulation voltage of constant voltage mode. This voltag=
e levels from
> > +      3.65 V to 4.4 V by I2C per 0.025 V.
> > +    maxItems: 1
>
> These are very generic currents and voltages, and their usage is well kno=
wn
> and generic. So they should not be prefixed "richtek,".
>
> Use the properties already defined in
> Documentation/devicetree/bindings/power/supply/battery.yaml
> for these:
>
> precharge-current-microamp
> constant-charge-current-max-microamp
> charge-term-current-microamp
> precharge-upper-limit-microvolt
> constant-charge-voltage-max-microvolt
>
> Please double-check, I think those are the ones you need.
>
> Perhaps it is possible to just $ref these properties directly and add
> the additional restrictions on top.

On second thought, these are really weird properties to have on the
*charger* isn't it?

It is really *battery* restrictions.

A charger can charge many different batteries with different CC/CV
settings.

I think your charger should contain a phandle to a battery and the battery
node should contain these limits.

  monitored-battery:
    $ref: /schemas/types.yaml#/definitions/phandle
    description: phandle to battery node

Then you can just use the standard battery bindings for these properties
on the battery.

See for example:
Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.ya=
ml

There will be driver changes needed too, but this will be way cleaner.

Yours,
Linus Walleij
