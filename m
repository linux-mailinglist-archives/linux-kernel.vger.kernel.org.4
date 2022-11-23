Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B56367F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbiKWSC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiKWSCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:04 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB72D741;
        Wed, 23 Nov 2022 10:02:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j16so29248965lfe.12;
        Wed, 23 Nov 2022 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPfaV9JQYEEBlTl/fS8GFESyDnIDzd+AMUhHZbg9V84=;
        b=eKoPx+sUx3lamSLIjdVGDSUuRs8FkZJfekAEedrz6LWYH+KepBzDOYuMOK7f3c1PVg
         luWOSccwRgUvlTuOpv/BFryCTO4d9+4CUF4CM1NUQ7JYfE64n+7Wh8Mr3zO2z7YwVAb/
         Nr8ooCjfFBf1+bu9YqcQdNk5rXRt4QCZp+K6ItYpidbv8a2lrONEm/12drOxtxgS8qu9
         Yrg9BcvR8VisogZ4SVqo2cXzKshwrPh7yH/k95Pq5vPwAB2nODViU6YYHcR9eTGvLJ9K
         +E0pk5rb8PdiuZMjYT9aASnOFUf6k33s4WlcBK6pgQHXZsx075i5A6qQA7wh80CjfaRc
         2Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPfaV9JQYEEBlTl/fS8GFESyDnIDzd+AMUhHZbg9V84=;
        b=5Z4tApNDg5xoAtfcNhmjZGDBCj3PAa67Vg6n7Fxx9Hzx18cFDLh3R6+QtV3VW7mj+g
         vjFhSvYE+0FLQfH3xkVqRQUg5LRoY2/4dlJu9ltsu8uPfj1+tyAUFPvruHqrwhrgc17X
         HfO1ZpIG+iedx+89dUa6ecFvn0IHqH9b+whVQhYMApqMjTWd2zNd+BD1kvxIqdsUfhJK
         lyN14qQVqPceL3cJ1YMp1Z7NcAhtPpLB7L7d0jETSeHqJ+tugI/GG/jwfVvc/nLfnXQg
         QosrUOmBHdRWeFz9cyQPJM/vfnPdG3dLchnz6PBbEM8RFluN/CkAGqeBopkwNtLJ0Ozl
         1l6g==
X-Gm-Message-State: ANoB5pnR43p0VDDJ8DmCoAQXB3g8C/JdpBGUXPxixuVU0w4V4AsgW6sU
        19CFj938roA5Hh9WGOh4xjrICfichVqxitWSKCY=
X-Google-Smtp-Source: AA0mqf56v42d6nqEg/RKf0j6CF9PHx1Xu9ou1xq63pazvzimGl4nOGI1Oy3Opva0Ihc+dfH0ZmsKONw/5UJJdmCLf8A=
X-Received: by 2002:ac2:4e14:0:b0:4af:f5a0:8786 with SMTP id
 e20-20020ac24e14000000b004aff5a08786mr9144435lfr.265.1669226520087; Wed, 23
 Nov 2022 10:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20221122201232.107065-1-tmaimon77@gmail.com> <20221122201232.107065-3-tmaimon77@gmail.com>
 <577e273d-ff9b-4d8d-b797-d7275ab8374f@app.fastmail.com>
In-Reply-To: <577e273d-ff9b-4d8d-b797-d7275ab8374f@app.fastmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 23 Nov 2022 20:01:48 +0200
Message-ID: <CAP6Zq1ikqtKOGUZX-VAdyhs+nsvy7ah4gqRrbXVA8Gp9L46hXQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] soc: nuvoton: add NPCM LPC BPC driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com,
        Joel Stanley <joel@jms.id.au>, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Hector Martin <marcan@marcan.st>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sven Peter <sven@svenpeter.dev>,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your email

On Wed, 23 Nov 2022 at 12:58, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Nov 22, 2022, at 21:12, Tomer Maimon wrote:
> > Add Nuvoton BMC NPCM LPC BIOS post code (BPC) driver.
> >
> > The NPCM BPC monitoring two configurable I/O address written by the host
> > on the Low Pin Count (LPC) bus.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  drivers/soc/Kconfig                |   1 +
> >  drivers/soc/Makefile               |   1 +
> >  drivers/soc/nuvoton/Kconfig        |  24 ++
> >  drivers/soc/nuvoton/Makefile       |   3 +
> >  drivers/soc/nuvoton/npcm-lpc-bpc.c | 396 +++++++++++++++++++++++++++++
>
> In general, I try to keep drivers/soc/ for drivers that are
> used purely inside of the kernel and don't provide their
> own user space ABI, those should normally be part of
> some subsystem grouped by functionality.
>
> It appears that we have similar drivers for aspeed already,
> so there is some precedent, but I would still like to ask
> you and Joel to try to make sure the two are compatible,
> or ideally share the code for the user-facing part of the
> LPC driver.
Nuvoton and Aspeed use the same user-facing code to manage the host snooping.
https://github.com/openbmc/phosphor-host-postd
>
> > +config NPCM_PCI_MBOX
> > +     tristate "NPCM PCI Mailbox Controller"
> > +     depends on (ARCH_NPCM || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > +     help
> > +       Expose the NPCM BMC PCI MBOX registers found on Nuvoton SOCs
> > +       to userspace.
>
> This looks unrelated to the LPC driver, so this should
> probably be a separate patch. The same comment about user
> space presumably applies here, but I have not seen the driver.
You are right, it was added by mistake.
will drop off in the next patch
>
> The implementation of npcm-lpc-bpc looks fine otherwise, I only
> noticed one minor detail that I would change:
>
> > +     np = pdev->dev.parent->of_node;
> > +     if (!of_device_is_compatible(np, "nuvoton,npcm750-lpc") &&
> > +         !of_device_is_compatible(np, "nuvoton,npcm845-lpc")) {
> > +             dev_err(dev, "unsupported LPC device binding\n");
> > +             return -ENODEV;
> > +     }
>
> This check doesn't seem to make sense here, since those are
> the only two types you support.
About the LPC, I like to double check with our architectures on it
because the BPC should working on eSPI as well.
Maybe I should remove the LPC part.
>
>       Arnd

Best regards,

Tomer
