Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F22728616
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjFHRPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjFHRPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:15:46 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE88269A;
        Thu,  8 Jun 2023 10:15:45 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39a4eb67c5fso642657b6e.0;
        Thu, 08 Jun 2023 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686244545; x=1688836545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPT/tVmJaBHo3MhgPjztTD4skeAHAwVYuwE0Ewq+Bgo=;
        b=IHToE8+OMiQxRi0mkbx/gxmyAs5R1O7sF4BKdLeeQuLnbTKZQHyM548UPM8ZveZczc
         QjrhCzWFHU/Y9mS/lopiS9jKN270hhXXCaSyWJWZxyh6id7O/o/BTiLf1TfYhScjNkG0
         UNQC1MDfUNWN9p4NcJ0I9pe+XK6myRvqeQXVyV25F7D1aSbOnM7uSRqh48IVV02jkCoJ
         2vPHZ2lVWN/I8zLFXgj7PUw3zL1B93JKkhnWPHv5HNpxcJw5uRcx3cFH+FZ0sLWZ2Ufr
         BwQEAxhS6DnqLRzZ+HDPzReSrN+17WMQoDkqSpHC87NxE27uw+YGCZRU6tN7hyogYYE1
         siGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686244545; x=1688836545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPT/tVmJaBHo3MhgPjztTD4skeAHAwVYuwE0Ewq+Bgo=;
        b=gpALh1nLVenWPTkNSqdUvVYE8mUMXaK92S3lIFfQ3uqsIG+BKHZBOJ7zW1fHx/+fTm
         wLOTUkE9uRiG0RPecp2TsDi1dywvBSXiCn9lqKQztBfekDzHVC5jfg6l9slZTtaJ0KDR
         4zVL4OBTTwjFA+jMLGQmRl/RXdoiGsRg9lehuEGbsX/p7iqqWv2pjr4LErniD9V3WDwp
         5Mk1t91PiCRzqw1lPU7SFdgbTD+Sv4zhJHC1VEllr1Vsmgo4f6g9UUl/VkW3EgRaITPX
         qbexmK5wgHBT01guq3ZnnkIf7vBlU9gQ0OIX7xxXp6dEYI/u2qC+nndayJJjM0YA8Oxn
         esSQ==
X-Gm-Message-State: AC+VfDxLBZcDkeyiL/5sTFZfK6BwuLje4AoSM1fs7WMjU/ute6Sd6RW4
        NX+sUTG7rt1cv6eOGkjMd6xAu30scGjVBUrzwGs=
X-Google-Smtp-Source: ACHHUZ7xoEKV3/9BiBlIK6qqxj7uchpqf7tGIpgZxgdO4dZx1bmBXAVsN6Q6Wddj/65U+q1n/0iPtcgTw5xn9gTlAx8=
X-Received: by 2002:a05:6808:303:b0:39a:bbd4:bab with SMTP id
 i3-20020a056808030300b0039abbd40babmr5733436oie.31.1686244545170; Thu, 08 Jun
 2023 10:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230606014234.29491-1-nick.hawkins@hpe.com> <20230606014234.29491-3-nick.hawkins@hpe.com>
 <ZH76x6E9cbfrJHeu@surfacebook> <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHp75Vcc9hh6MYPSCJa1vniU=rC4Y+j9pCS4Np-b-Pyh5eUwNg@mail.gmail.com>
 <81CFCEE8-5276-475A-A2AB-A814DEDA04B2@hpe.com> <CAHp75VeZkLSTw8OFmDMYb+im0qK0NQRHpndzBM7fMHm=HZCzeA@mail.gmail.com>
 <7FEECBB4-482E-4719-94CA-6D10E4C08078@hpe.com> <CAHp75VfQguYENE0EtZ-ou=CXo0mAmeDT9byTu6hffT6w_cgM=Q@mail.gmail.com>
 <B5D811E0-714D-45E5-818A-8AD18905AC29@hpe.com>
In-Reply-To: <B5D811E0-714D-45E5-818A-8AD18905AC29@hpe.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Jun 2023 20:15:09 +0300
Message-ID: <CAHp75VcCJoTSPFOcQ5FKTi=EuUTvwzxus1n+nuowPxa0WagQeQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 5:58=E2=80=AFPM Hawkins, Nick <nick.hawkins@hpe.com>=
 wrote:
> > > Is there any documents available describing how regmap_gpio
> > > populates the GPIO lines? Does it automatically go through and add li=
nes
> > > for each successful regmap_read and bits per byte?
>
> > Nope, it assumes one bit per register or something different if xlate
> > callback is defined. This is my understanding. That said, it might be
> > that this is a limitation which does not allow you to switch to that
> > library.
>
> Thank you for this feedback. After exploring the gpio_regmap it seems
> it does not fit my needs. Some of the GPIOs are a combination of
> several bits in a byte. For instance the Health LED or Identify LED have
> more than 2 states. If acceptable I believe the gxp-gpio-pl.c file should
> not use the gpio_regmap.

Yes, just mention this reasoning in the cover letter.

--=20
With Best Regards,
Andy Shevchenko
