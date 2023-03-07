Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C64A6AD95B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCGIie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCGIic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:38:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB72E0EE;
        Tue,  7 Mar 2023 00:38:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k10so25264978edk.13;
        Tue, 07 Mar 2023 00:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678178308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFkwqhkT+lIt2irVF6rhRMk0pnuU8Ja1oB/xp+FXlr8=;
        b=lUvWp6toVHkr4XQ7hhtU/YiewW60L/6LagLE9I0VbD7fq1zn7c+LpYUcPLm4sStnaI
         o90OrqJ36nric2PeL0uS1QEdYAkrOEsnb6h+nZ+FYT7mi8lAupvgVxZk9X0IOqV0tR56
         Ib1sShHJrT0vCcGZnMmjx/xmO7mezHQV54kCzaz63gbVPrvvKzw2U5QsF/MVI2BYz++A
         ljYMIBdbtWLRfOqEK72sMBh4mXAzXRjn6vpArJRx9wVM6TDQt3YZz6cVoxY+inyyfr9e
         rfbxhjlHLA+lXZfHSoC74fXRH+dDLWALUYu0hYHQ52awLQ9Nuka2gOGBjmnwa5vSS/W3
         M4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678178308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFkwqhkT+lIt2irVF6rhRMk0pnuU8Ja1oB/xp+FXlr8=;
        b=Bk1Wne6zUK7t6oron0ipXlO7uTXI49TIElwIZzj3Eau53Q8CEVDaGL/23Dz64+t8+l
         RB6NbE6CYcaGc7YJq8jltxvFeZeUJzNI6KEvYHirL/v3e5USDaQeoGYviw/8DnTpsyxT
         T7aCvT0BbudMv50kM5eMBCsHbxvvUBqgkU7a1ZECxy1FbmwmKflQAYea+waQy1ZLLkar
         n/6YccqFhzASNtsJuAFSaY0GXW07AGfgFuBWsq0g1e/hIqu9s18jJRuLc6LEtCU/eDUv
         Az7ac/SsQbFFmJGMx0lYeZF6nyb2sAsLQULva0rwIzm9x0S2h4NCisfeKqWv9HNixkEO
         y/kA==
X-Gm-Message-State: AO0yUKV+sMkOq82UgV5lEv1S7P0GiVyjv65qJKRx151XgvaHwF00BOUe
        mHHsHT/Ysvz6ArPzLSSx3GiBb9FI9I0aEwfG7Xk=
X-Google-Smtp-Source: AK7set835bG0dJ6ngtk0PjuuqUnLs8sqgHQUsfUtZuyvpNqCpDSFdEABaR2fb1BA1EJAY+RMipe53NieyYlhlK8/Rk0=
X-Received: by 2002:a17:906:a4b:b0:879:9c05:f5fb with SMTP id
 x11-20020a1709060a4b00b008799c05f5fbmr6743103ejf.5.1678178307909; Tue, 07 Mar
 2023 00:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20230307075923.28821-1-lukas.bulwahn@gmail.com>
 <CAMuHMdV1eYWhDKwTAxC32Qp0CcxrWxgu=uRNTdu_G8K=gHS9Yw@mail.gmail.com> <c85990e892571ae5da7a9c4b0e86897ee34286a7.camel@physik.fu-berlin.de>
In-Reply-To: <c85990e892571ae5da7a9c4b0e86897ee34286a7.camel@physik.fu-berlin.de>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 7 Mar 2023 09:38:16 +0100
Message-ID: <CAKXUXMyRd2V+a9yoqfgkVPY3UufKHKTOPxxXLSJCK49DDEUQEA@mail.gmail.com>
Subject: Re: [PATCH] arch: sh: remove references to config USB_OHCI_SH
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 9:19=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Geert!
>
> On Tue, 2023-03-07 at 09:16 +0100, Geert Uytterhoeven wrote:
> > Hi Lukas,
> >
> > On Tue, Mar 7, 2023 at 9:02=E2=80=AFAM Lukas Bulwahn <lukas.bulwahn@gma=
il.com> wrote:
> > > Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") left =
some
> > > references to the config USB_OHCI_SH in ./arch/sh/ around, expecting =
those
> > > to be removed with the whole SH architecture deletion.
> > >
> > > As that did not happen, do minor clean-up instead and remove the refe=
rences
> > > to the removed config USB_OHCI_SH instead.
> > >
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/sh/Kconfig
> > > +++ b/arch/sh/Kconfig
> > > @@ -326,7 +326,6 @@ config CPU_SUBTYPE_SH7720
> > >         select CPU_SH3
> > >         select CPU_HAS_DSP
> > >         select SYS_SUPPORTS_SH_CMT
> > > -       select USB_OHCI_SH if USB_OHCI_HCD
> >
> > Shouldn't this select USB_OHCI_HCD_PLATFORM instead, as the (now
> > removed) Kconfig help text for USB_OHCI_SH used to say?
> >
> >     +       select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> >
> > I completely forgot I already made that comment before, cfr.
> > https://lore.kernel.org/all/CAMuHMdVM3BpvVD3c4gp1OidnwF5zFd4MJecij7zWBn=
ahzNaSNw@mail.gmail.com
> >
> > The same is true for the three selects below.
> > As USB is now broken, the proper solution will need
> > Fixes: 4f6dfc2136fb2e8d ("usb: remove the dead USB_OHCI_SH option")
>

Well, I assumed that I am just cleaning up some minor stuff, not
fixing broken code...

With your link and explanation, Geert, I know what needs to be done. Thanks=
.

> Thanks a lot for catching this!
>
> @Lukas: Can you send a new patch with the suggested changes?
>

I will send a new patch in a second.

Lukas

> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
