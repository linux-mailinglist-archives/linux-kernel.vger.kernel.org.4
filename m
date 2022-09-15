Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7626C5B9323
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIODgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIODg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:36:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E4A92F71;
        Wed, 14 Sep 2022 20:36:21 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g23so8138675qtu.2;
        Wed, 14 Sep 2022 20:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uJffsqDRUOivPZiC/tl2/T1Mr1z4G0FCt64C8blLYZ4=;
        b=VeguLffCxfpspTiwdtq9UYKbMufW723noBqlOXGYv9kyyzX90xkv2vzm2I2PEPmJJO
         boAIMekRhBXHBG5vAF/QLtA3W9Gp+22wTwqels+K66SvO1fO9YieGqy6CVxr4Fk7F4BS
         KUTeULswMGfGvshWz45/zc8Jep/TmSo97GyH7V948bwu4qDtkN+ZeXR6U8urNPdbxjUm
         NbnwEFcxITV8IL1wfCvKNK4GRkZIq5quF3ntXhlP4AwfwWuZ4/6wejY4RmLfL2G1YoKZ
         rHKCYKu4YydlyPA348LQYnDMLm9Hjo4u//s0ftLmErPMSbCdVE8mY8bsou+HyL8nY4Rr
         +xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uJffsqDRUOivPZiC/tl2/T1Mr1z4G0FCt64C8blLYZ4=;
        b=n0Yl+GBWlD4iJQMP4eKFSzq3WBqpsrRA5AHfPWVdNdn+h76Ip+AKDJMLcws9hKhjID
         waWlFEAG6p9xZ4zx1PHtjZYxX+6vDrPZJPlhY2wyRkltOQb9vs0a4TXLSBjdCk50piJT
         emDKWxr7+AqWoJjn2bsFyxlSSBreSiM+6qkABvqJ1euHUAoe9AY9xcNJVhZhPoWC/GWZ
         SGGPA0xEdqA4I3BlnYctltuJkN2eedBFeziHQSZiTFcNwXjsS6Ulks/wAdMow4EcLM9I
         bbW2UXkubVjoA7zMAFGNuyXn9HKjbiESsG5ajG/Ne6xy/y6ifJ4lqUCruBGQdUyG6A+P
         3O6w==
X-Gm-Message-State: ACgBeo3oarBA3iRDS1S4Ss42oBFvZ+ZPrCyfnXVPqYBAw78OV/fA4TaZ
        TtCEOvJkvhG4uG4pm6isvD1AKBXo9KK/q7e8OV4=
X-Google-Smtp-Source: AA6agR4c8u6CA4VfIRaIl+yIQVBvxQDaeXAQN44DFOYuEyXUnfD+E++zb5w5jiIL9rOauuVd+M9PPulwORz+2O5YzXE=
X-Received: by 2002:a05:622a:164e:b0:35b:a852:52ca with SMTP id
 y14-20020a05622a164e00b0035ba85252camr21445333qtj.2.1663212980577; Wed, 14
 Sep 2022 20:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220311060936.10663-1-JJLIU0@nuvoton.com> <20220311060936.10663-2-JJLIU0@nuvoton.com>
 <3f77c8c8-4bba-007b-fae9-5fb47f44719c@canonical.com>
In-Reply-To: <3f77c8c8-4bba-007b-fae9-5fb47f44719c@canonical.com>
From:   Jim Liu <jim.t90615@gmail.com>
Date:   Thu, 15 Sep 2022 11:36:09 +0800
Message-ID: <CAKUZ0+HLAxLw8Tio1HZt8TkYag_UGuDktjNbORwPzfRRrEJ0jQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dts: add Nuvoton sgpio feature
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, CTCCHIEN@nuvoton.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
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

Hi Krzysztof Kozlowski

Thanks for your review.
I am modifying this driver now, and i have some questions.

what's mean "Generic node name." ?
Nuvoton NPCM750 SGPIO module is base on serial to parallel IC (HC595)
and parallel to serial IC (HC165).
and dts node name is followed aspeed dts node name.

Could you give more information??

Best regards,
Jim

On Fri, Mar 11, 2022 at 5:18 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 11/03/2022 07:09, jimliu2 wrote:
> > add Nuvoton sgpio feature
> >
> > Signed-off-by: jimliu2 <JJLIU0@nuvoton.com>
> > ---
> >  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> > index 3696980a3da1..58f4b463c745 100644
> > --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> > +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> > @@ -329,6 +329,36 @@
> >                               status = "disabled";
> >                       };
> >
> > +                     sgpio1: sgpio@101000 {
>
> Generic node name.
>
> > +                             clocks = <&clk NPCM7XX_CLK_APB3>;
> > +                             compatible = "nuvoton,npcm750-sgpio";
> > +                             interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> > +                             gpio-controller;
> > +                             #gpio-cells = <2>;
> > +                             pinctrl-names = "default";
> > +                             pinctrl-0 = <&iox1_pins>;
> > +                             bus-frequency = <16000000>;
> > +                             nin_gpios = <64>;
> > +                             nout_gpios = <64>;
> > +                             reg = <0x101000 0x200>;
>
> In each node first goes compatible, then reg.
>
> Best regards,
> Krzysztof
