Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F956F11FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345402AbjD1GwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345160AbjD1GwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:52:12 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B19130E8;
        Thu, 27 Apr 2023 23:52:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75131c2997bso517445085a.1;
        Thu, 27 Apr 2023 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682664730; x=1685256730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hh+4d6qEtRWEqTzMTpVx8b14Wn3cPmdU68INgb/XVM=;
        b=KPUYVzw9jn2uhW/Uez5nBfu2RIgjhrhln4a+62XCb3gqOxkcyHLRhYrANpOrw4f2bk
         kbeVaud4lZUiebkJ7H4FGYs3eWFdu3fE26e1AgFc5F34GnhlHMvy8zgzMveK0vI/Sb4Y
         0pQU1lRq/iz151s1q73W6lly38usuvMQIiqgiRDI6W75LBZoe93CVqbTPuqq4DrpY0cl
         UE5pawmpmFJS8ZTs47qCR3UcnPlezzKz/FoFg2xRloTW+tqjxQHWR7GVxJ40XbIGINSx
         bJ0EKSOtp4NGLNAW7YzsJC4ZbPQ94jEBVdnvoWjJItLK4PSlo+6oBwuhfsxTXRxkDQPk
         H5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682664730; x=1685256730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hh+4d6qEtRWEqTzMTpVx8b14Wn3cPmdU68INgb/XVM=;
        b=EdWrRU4XDGPeXV7uRh2bzxuQO3SWrwSrntRucmI1ZnZm3bP6jWHDK5If6ZdLHZJMmG
         TAmLikR3Zn6LaxAu12X2VHMeQpeD4KrS6i4+mTdKToqtzVOP9Cbii+1eROXUvLJlgyno
         Zr1o4NTBrLFDGDLk3ni1c/zY8DgwprrrXC/Pak/CB4BRTUSpIH8tDfZc1VSDP8Bxn3N1
         LAJxJFIIr7da2RJ3Xk2yAzp50CKRONytNPIXsXqschAU5Wag84ysPRoBimoRfb9iAsmP
         D95nZrTRNhBuP5UEBuT9xLFnSlfWQt+Uqo7Nx+nu+0jEzWktQMI1KBXHIdqiZ355Posy
         1l2A==
X-Gm-Message-State: AC+VfDwkSEfCTs/YVweDTo2czZ8MOq6IDQ/JGT2cWfOOTytuUcEfxGzq
        lTWoRj6qf/NET2SSFm6lvUV8HjWOO/NuqWFpqUk=
X-Google-Smtp-Source: ACHHUZ5MhkN9DXCli9pgQwuci1geP1laLgORrWdNozlIMtV4s74aRHKPqvcv8BBXC6s2ewQ+w0wXmNP4JeSDMUOVNRU=
X-Received: by 2002:ac8:7e93:0:b0:3e6:9429:1e01 with SMTP id
 w19-20020ac87e93000000b003e694291e01mr15567860qtj.11.1682664730653; Thu, 27
 Apr 2023 23:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230418152824.110823-1-nick.hawkins@hpe.com> <20230418152824.110823-2-nick.hawkins@hpe.com>
 <ZEqikkknyRrFTh2t@surfacebook> <DM4PR84MB19272617D9E728DC09715A45886A9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB19272617D9E728DC09715A45886A9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Apr 2023 09:51:34 +0300
Message-ID: <CAHp75Vc3JX1tjzHmXWQwgHArc2S=xbxJfvdbbJzutKjXFwNDog@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
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

On Thu, Apr 27, 2023 at 10:01=E2=80=AFPM Hawkins, Nick <nick.hawkins@hpe.co=
m> wrote:
> > Thank you for your contribution. To begin with, I don't believe a simpl=
e GPIO
> > driver needs 1000+ LoCs. But see more comments below.
>
> Andy,
>
> Thank you for your feedback. I will apply all the input you have provided=
.

You are welcome!

> I will need to rewrite this code and I am considering the need to
> perhaps create two files instead of one to keep code length down. As
> implied by the description I was trying to have one file handle two
> different compatible strings.
>
> I believe that one file will need to be the regular IO from the host and
> memory mapped IO pins of our SoC. The other will need to be the memory
> mapped IO pins coming from our CPLD. Both of these sources are interrupti=
ble
> which does cause some complexity.
>
> Please let me know if what I have described above is not a good approach =
to
> take with GPIO drivers. Any guidance would be greatly appreciated.

I don't know your hardware, otherwise what you wrote above sounds good to m=
e.

--=20
With Best Regards,
Andy Shevchenko
