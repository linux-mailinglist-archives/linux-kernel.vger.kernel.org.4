Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CAC700D72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbjELQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjELQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:55:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB54C3D;
        Fri, 12 May 2023 09:55:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f427118644so60437795e9.0;
        Fri, 12 May 2023 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683910520; x=1686502520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVTgoVGLmfiSnDYvanbFiLjHDZAEOgfT7L1XJHgPDs4=;
        b=Yy2XpG9W+CgUdhqpRnqt8p7ojoszi7SHmsuXn84K2qqr6Kgeqd8FJDMONlvMHiIROg
         42MibeR0AYOtv/dB1jEVlmpiaczW+ZZ87VmxR/UXZW32x0vof3jQtA9Mo8ZKZpvIUvA9
         a20w2j6El4yk8q0q39WxvUvKbrzAA9nQbrSB692jaFoGeOnJZuIzLPGj9bYQXwVbFbbT
         FpajdDAQpUOeysQbSgmovY+srcMZeKj6s5lEkhqEz18kKYMiBWzuzfMTyu05UZhv2YDG
         noL8f3cyDUPoqffypu5n7mc3/jJ9iaBHwogPqClLitQ7SPbnPPzt6eYHhSocXpzBTGR7
         5cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683910520; x=1686502520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVTgoVGLmfiSnDYvanbFiLjHDZAEOgfT7L1XJHgPDs4=;
        b=jZ+Xb8p9I/QA851LI07YrKOFl78kZ0cdb+OQMpOT6uMPvZd5wFf/BKA3E3hlUeTQJs
         nHdHxAJelYNRT7jgdPu3RpVy44Al5QDo/etWoiA9MUgGTJnGGu748ELnZYgXphO+9709
         oalIcxxL5YZ8myEyaJoeM8w4uWPa5srAJZLBGPeQODkGYBCHKn1hdb+fxGa3wlHz+5Eu
         029xFh4+wzuJfnJRseq0n+VXPk8A+r54dsr9Wd51a/PTsVMKTAUZ7xJ/tWEeGT9mNxCp
         coZ5AslelUnpRgaL2+b6SqG30tsFFmVNn1QcLgu/Fq1F0tzhGAPTN8DEM37JtBkKR/ZF
         rwRQ==
X-Gm-Message-State: AC+VfDy2AAvrUKJ3G7n/RCWbxN0noFc7jmddUHm7vQNlca42wePfwkP2
        zkoOQM9NOxhyMgXoAN8UsWGlSLnJUROZ6c+7kA==
X-Google-Smtp-Source: ACHHUZ4FnsBU6iMCQ52SbGMbgjldPfuXW4a9zBtcb/Ps6zGdodTUrDUANz8UXtOOVnSLnNYGK6OiCXnzLUGabMvWnRE=
X-Received: by 2002:a1c:cc0e:0:b0:3ef:622c:26d3 with SMTP id
 h14-20020a1ccc0e000000b003ef622c26d3mr20385705wmb.35.1683910520000; Fri, 12
 May 2023 09:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2-hcJYVpBNwnMS6qUp4=MW8kSryDAz7G5cNA8R00QabC9bjg@mail.gmail.com>
 <20230503153231.1136114-1-tomas.mudrunka@gmail.com> <ZFMN5nmqLAX170SE@nixie71>
 <ZF19yOojiaSbo3vS@google.com>
In-Reply-To: <ZF19yOojiaSbo3vS@google.com>
From:   =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date:   Fri, 12 May 2023 18:55:08 +0200
Message-ID: <CAH2-hcJ8XxK060O-QCCBz+=cKk1HbT-aOKQH2EOY=D=xttvz7A@mail.gmail.com>
Subject: Re: [PATCH v5] Fix freeze in lm8333 i2c keyboard driver
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

> So this is still racy, isn't it? The interrupt may come after read is
> done, but before we register the handler.

Well. It is. But please see the rest of the thread, where we've
already discussed this.

Every time the interrupt handler runs, the interrupt is disabled and
then reenabled after i2c communication is done. Which means this exact
thing happens on each keypress anyway. So i don't think it's a
necessarily huge deal. It might not be perfect solution, but it makes
things much better. window in which the deadlock condition can happen
is now in range of few ms (or us), instead of ~10 seconds (previously
it included bootloader and basicaly any moment from power up to driver
load)

Another solution would be to trigger on LOW instead of FALLING as
proposed in initial version of the patch. That would be safer in terms
of lm8333 deadlock, but Jeff was concerned about possibility of
interrupt storm taking down whole system in case the IRQ line gets
stuck in LOW for some reason...

Tom

p=C3=A1 12. 5. 2023 v 1:44 odes=C3=ADlatel Dmitry Torokhov
<dmitry.torokhov@gmail.com> napsal:
>
> On Wed, May 03, 2023 at 08:44:06PM -0500, Jeff LaBundy wrote:
> > Hi Tomas,
> >
> > On Wed, May 03, 2023 at 05:32:31PM +0200, Tomas Mudrunka wrote:
> > > LM8333 uses gpio interrupt line which is triggered by falling edge.
> > > When button is pressed before driver is loaded,
> > > driver will miss the edge and never respond again.
> > > To fix this we run the interrupt handler before registering IRQ
> > > to clear the interrupt via i2c command.
> > >
> > > Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> > > ---
> >
> > Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> >
> > >  drivers/input/keyboard/lm8333.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard=
/lm8333.c
> > > index 7457c3220..52108c370 100644
> > > --- a/drivers/input/keyboard/lm8333.c
> > > +++ b/drivers/input/keyboard/lm8333.c
> > > @@ -178,6 +178,8 @@ static int lm8333_probe(struct i2c_client *client=
)
> > >                     dev_warn(&client->dev, "Unable to set active time=
\n");
> > >     }
> > >
> > > +   lm8333_irq_thread(client->irq, lm8333);
>
> So this is still racy, isn't it? The interrupt may come after read is
> done, but before we register the handler.
>
> > > +
> > >     err =3D request_threaded_irq(client->irq, NULL, lm8333_irq_thread=
,
> > >                                IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > >                                "lm8333", lm8333);
> > > --
> > > 2.40.1
> >
>
> Thanks.
>
> --
> Dmitry
