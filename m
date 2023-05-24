Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF970FEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjEXTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEXTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:42:26 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C7130
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:42:25 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-456f7ea8694so471958e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684957344; x=1687549344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNTJOwky/qCDAD6V6w3Og06bM/WY9gM+YM9PZwHETOg=;
        b=PYV/PGOyG75ebKOJpa8EjtuywyYgc9adk1CzQFCWSn77/mQHNSCeNVGGbz52Gv5tZr
         RHRdi1ICmMT+JBXjh++kUCknmTSd/yAL4fohfT18qNfhwlepwypXf9GHlJdnFfw7T6Jl
         P4PGrcaHFJ8g/IhTM/a7lz5yU1v/GbLCsSnNLWSZzw3Y/qRBtvOElC+MzWQWECKsWILT
         p+xX7Zvj1zfLAJyPH01ERyMjtvS7Q4o3V1NkJzJW3vSt8y/oGn/cX0eYZllv7C99lrmS
         OgUwA8jYewZYLx8Tqe/Ail89fdR9ZsPm3cm2M3S7HnWw/iuig7j688ZLQCftoCV8DkET
         A9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957344; x=1687549344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNTJOwky/qCDAD6V6w3Og06bM/WY9gM+YM9PZwHETOg=;
        b=AwNFYeDOCphtH0OBtj1mz+wP7ruSYJJXbeE7BDHUVKGxy0LoPrcVJTEIBTojlKwgtV
         qNH1X5OOgwA5l4zHYkxbJVXWIG7eRlJJ41IteOoV8RgEdmqdECHVDvA18+XIkn1jU58O
         RcusvzLh8w+pwdcte3hf6x11R8w65JgTEaOfToU+ijh/2x27FJ0IRXetymFb0mQuaTwC
         LZVca6Gg5hvrJeXySVyne9NeHRsFvcSCW+xS6DuAuLB2UkaU3RGCc9hmA8Lz+JkoQqbR
         eUh4uWrc0RDzmS1oDArweTO562x4nENAuwcRmdDMMm81RwaMM1w5WIuHBV4mL6LY4ZVx
         HOvQ==
X-Gm-Message-State: AC+VfDwDr81HCZ4Sb9VY//H0j5qaP802uNgqgQKxegTj182MJabt6nhX
        SQMrLmARYuC9YaKaoih6sMA+XXhtckA5Yjw9oMqqjA==
X-Google-Smtp-Source: ACHHUZ6QVkA/o5/98l+QmdbWky8XuB/nZPjeOrLT7V61vWawnAq8hhwHPsgmbejo7MIUqHlLhQlEwVBk/uw5IPZISMg=
X-Received: by 2002:a1f:5c4d:0:b0:456:d210:68e2 with SMTP id
 q74-20020a1f5c4d000000b00456d21068e2mr5872901vkb.10.1684957344300; Wed, 24
 May 2023 12:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230523155101.196853-1-brgl@bgdev.pl> <ZG1TLBsOy4mZQlW3@sol>
 <ZG1x5pcyTN2Fio4J@sol> <ZG2USw7TTdFSRZ3E@sol>
In-Reply-To: <ZG2USw7TTdFSRZ3E@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 24 May 2023 21:42:13 +0200
Message-ID: <CAMRc=MeRfCoj7bcf-GKrRY3Mp5SEhmb289g=JAHBK-01aERCtw@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: fix a crash on line-request release
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 6:36=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, May 24, 2023 at 10:09:42AM +0800, Kent Gibson wrote:
> > On Wed, May 24, 2023 at 07:58:36AM +0800, Kent Gibson wrote:
> > > On Tue, May 23, 2023 at 05:51:01PM +0200, Bartosz Golaszewski wrote:
> > > > When a GPIO device is forcefully unregistered, we are left with an
> > > > inactive object. If user-space kept an open file descriptor to a li=
ne
> > > > request associated with such a structure, upon closing it, we'll se=
e the
> > > > kernel crash due to freeing unexistent GPIO descriptors.
> > > >
> > >
> > > > @@ -1565,17 +1571,21 @@ static ssize_t linereq_read(struct file *fi=
le, char __user *buf,
> > > >
> > > >  static void linereq_free(struct linereq *lr)
> > > >  {
> > > > + struct gpio_device *gdev =3D lr->gdev;
> > > >   unsigned int i;
> > > >
> > > >   for (i =3D 0; i < lr->num_lines; i++) {
> > > >           if (lr->lines[i].desc) {
> > > >                   edge_detector_stop(&lr->lines[i]);
> > > > -                 gpiod_free(lr->lines[i].desc);
> > > > +                 down_write(&gdev->sem);
> > > > +                 if (gdev->chip)
> > > > +                         gpiod_free(lr->lines[i].desc);
> > > > +                 up_write(&gdev->sem);
> >
> > Ummm, taking another look at the oops I sent you, the crash actually
> > occurs in edge_detector_stop():
> >
> > May 23 11:47:06 firefly kernel: [ 4216.877056] Call Trace:
> > May 23 11:47:06 firefly kernel: [ 4216.877512]  <TASK>
> > May 23 11:47:06 firefly kernel: [ 4216.877924]  irq_domain_deactivate_i=
rq+0x19/0x30
> > May 23 11:47:06 firefly kernel: [ 4216.878543]  free_irq+0x257/0x360
> > May 23 11:47:06 firefly kernel: [ 4216.879056]  linereq_free+0x9b/0xe0
> > May 23 11:47:06 firefly kernel: [ 4216.879608]  linereq_release+0xc/0x2=
0
> > May 23 11:47:06 firefly kernel: [ 4216.880230]  __fput+0x87/0x240
> > May 23 11:47:06 firefly kernel: [ 4216.880744]  task_work_run+0x54/0x80
> >
> > That free_irq() call is in edge_detector_stop() (which apparently is in=
lined),
> > not in gpiod_free().
> >
> > So pretty sure this patch doesn't even solve my problem, but I will tes=
t
> > it to confirm.
> >
>
> Yeah, doesn't fix my problem still crashes.
>
> If the line request doesn't have edge detection enabled (so no
> irq) then I don't get a crash.
> i.e. use gpioset to request the line, rather than gpiomon.
>
> (To provide background for anyone else trying to follow along, the
> scenario is:
> 1. create a gpio-sim
> 2. request a line
> 3. destroy the gpio-sim
> 4. release the line.
>
> 3 triggers this error:
>
> May 24 11:11:12 firefly kernel: [  200.027280] gpio_stub_drv gpiochip0: R=
EMOVING GPIOCHIP WITH GPIOS STILL REQUESTED
>
> and 4 triggers a crash - if the requested line holds an irq.)
>
> I would point out:
> /**
>  * gpiochip_remove() - unregister a gpio_chip
>  * @gc: the chip to unregister
>  *
>  * A gpio_chip with any GPIOs still requested may not be removed.
>  */
> void gpiochip_remove(struct gpio_chip *gc)
>
> which is where that dev_crit() is, so destroying the gpio-sim has already
> invalidated that contract.
>
> Anyway, it seems my problem is the forced removal of the gpiochip invalid=
ates
> the irq that the line request is holding.
> Not sure how best to deal with that.
>
> Moving the edge_detector_stop() inside the "if (gdev->chip)" check of
> your patch does prevent crash.
> But in that case edge_detector_stop() does other cleanup that is no longe=
r
> getting done.
> Perhaps if the chip is gone then zero line->irq prior to calling
> edge_detector_stop()?
> Again, this is starting to feel like a hack for gpiolib not being good
> at telling the client that it has to pull the rug.
> Though according the the gpiochip_remove() docs, it WONT pull the rug,
> so you get that.
>
> Cheers,
> Kent.

Interestingly enough, I did test it just like you and the "fix" seemed
to address the issue. Upon a further look at the code, it's of course
clear that the patch is wrong.

I wanted to debug the code to see what's happening exactly but it
turned out that enabling the generation of DWARF data hid the issue as
well even without any fix. It means that it's some kind of a memory
corruption rather than a regular NULL-pointer dereference.

I'm not yet sure where the crash happens exactly other that it's in
the irq domain code.

Anyway, I'll be back at it tomorrow.

Bart
