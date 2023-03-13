Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E76B6E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCMEas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCMEap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:30:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F05E26CD1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:30:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o12so43544725edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678681841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fG9OxMjZ468dHtvGkBjVBEAErcJNTsnIw9OpKzejQ+s=;
        b=mlSynKIYrRF2v9+rBJb0xAyGdnn/QRx6JNfANSlTDI4ulPVBM8MBPL2FcVHReMH/8q
         8h5VinUrPslkCUsEixaMvQTZCAzne4DD4xekiPh+5hvg73oedtuDupJ/58rQ+0YGb7AC
         3An2fS+g7nMQsRg4TjgfHldRtBeCCxc0fW4j5EnmuCQag04seZ1aD57i9Z/PStHFQ4MI
         ROH4+9Q5Mi5rozMRqduHGjLEFJr8VDdtQ2h4R0iJAkUe3ux8u+8lKtWfFIpMFkZ0ZQra
         UGi5Xkb++Os7pkCepxiL56X72X7sHohOlimQwcfQtlvVqRynpqBAiTyXIa9NYmj7fqVJ
         WuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678681841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fG9OxMjZ468dHtvGkBjVBEAErcJNTsnIw9OpKzejQ+s=;
        b=dB91SkkRaZoTU0AkJTR3AJos6Wh7fQEW98ru4gyoxN/LIm7YmZUVVkxBfIwVc2AtDU
         BVUPiXcJBOrZBcotSES7xh/QeBINloICdt/J7ez174FuHYOXcpmhnYr7raXU59ZCFYsD
         5hsAFGTuXQGOObR0aP1sDNcNZUJ+/OpRzQUp5W0ouS1+3f8pi5o0HuLSAWhpnoFMxaqd
         othLAFQEPCKzCp10Z1qCgQDLAHW5O2ZVE11FKuml6lSQqPexWZajynYlD7sT42Yo0CsZ
         BkONuc/qK1FtWpjD6qzFlPODKMH+eTli0pHNVvlRadf9rXKYpL8alV8e+f/eRlArdBUC
         Ujcw==
X-Gm-Message-State: AO0yUKWYKIXCTHX+YHEM7PFhWNuftRiOBEb8cO2dqkZf3vvfXlH19y8i
        L5liKNIutxBKRfELrsv1U8RR4NNfIkHSCtUjWNQ=
X-Google-Smtp-Source: AK7set9ftJFZqxFZw8KlH9fUxrHJNsIyoM61u8fPeAdOZU2uoSOQ9HCqOk8q7wHZxkujLT2CAh2ApsK7hdy0XZ73r0Q=
X-Received: by 2002:a17:906:6d98:b0:8ab:b606:9728 with SMTP id
 h24-20020a1709066d9800b008abb6069728mr16938287ejt.5.1678681841432; Sun, 12
 Mar 2023 21:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZAtkW6g6DwPg/pDp@khadija-virtual-machine> <eb7475da-7548-4820-a2b6-ff0f6cf4be71@kili.mountain>
In-Reply-To: <eb7475da-7548-4820-a2b6-ff0f6cf4be71@kili.mountain>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 13 Mar 2023 05:30:30 +0100
Message-ID: <CAKXUXMx+v_X2QGw4gqByWyGiyyJ+Cdecw_K+Wc=Edk4XrAM3zw@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: fix exceeds line length
To:     Dan Carpenter <error27@gmail.com>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Fri, Mar 10, 2023 at 8:40=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Fri, Mar 10, 2023 at 10:09:47PM +0500, Khadija Kamran wrote:
> > Length of line 182 exceeds 100 columns in file
> > drivers/staging/grebus/arche-platform.c, fix by removing tabs from the
> > line.
> >
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/greybus/arche-platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging=
/greybus/arche-platform.c
> > index fcbd5f71eff2..0f0fbc263f8a 100644
> > --- a/drivers/staging/greybus/arche-platform.c
> > +++ b/drivers/staging/greybus/arche-platform.c
> > @@ -179,7 +179,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, v=
oid *devid)
> >                               if (arche_pdata->wake_detect_state !=3D
> >                                               WD_STATE_COLDBOOT_START) =
{
> >                                       arche_platform_set_wake_detect_st=
ate(arche_pdata,
> > -                                                                      =
    WD_STATE_COLDBOOT_TRIG);
> > +                                             WD_STATE_COLDBOOT_TRIG);
>
> The original line was done deliberately so that it lines up.  If we
> apply your patch and re-run checkpatch -f on the file then it has a new
> warning:
>
> CHECK: Alignment should match open parenthesis
> #182: FILE: drivers/staging/greybus/arche-platform.c:182:
> +                                       arche_platform_set_wake_detect_st=
ate(arche_pdata,
> +                                               WD_STATE_COLDBOOT_TRIG);
>
> Always try to think about the bigger picture.  Why did the original
> author do it that way?  The change makes checkpatch happy, but does it
> make the code more readable?  Is there a more important readability
> improvement to be done here?
>
> For example, you could re-arrange the if statements like this and pull
> everything in a few tabs.  Don't necessarily do that.  Just think about
> doing it.  I write quite a few cleanup patches that I don't send because
> the next day I just decide it's not worth it.
>
> When I look at this file, the style is not bad at all.  But at the start
> of the file there is #if IS_ENABLED(CONFIG_USB_HSIC_USB3613).  What is
> that?  The CONFIG doesn't exist and the header doesn't exits.  Probably
> it can be deleted.
>
> But that raises a new question.  Lukas Bulwahn is always looking for
> CONFIG_ entries which don't exist.  I would have expected him to find
> this already.
>

True, and my (private) random linux notes of the checkkconfigsymbols
effort on this config states:

USB_HSIC_USB3613: Reported and maintenance of dead code is fine for
staging maintainer

So, I did report it, and a quick search on lore.kernel.org
(https://lore.kernel.org/all/?q=3DUSB_HSIC_USB3613) will give us some
more insight and refresh Greg's and my memory:

I reported the issue here:
https://lore.kernel.org/all/CAKXUXMym0M1UNuNGUVpFr2yUwOwjkZ_sQpCD0jC8YB+hs=
=3Dj-bA@mail.gmail.com/

And Greg responded:

"... It's a good example driver for those wanting to create a greybus
host controller driver so it's nice to have in the tree..."

So, even though the code is dead, it is a nice example of some driver
code. So, we keep it.


> Anyway, we can write our own scripts to make a list of stuff inside
> IS_ENABLED():
>
> git grep IS_ENABLED | \
>         perl -ne 'if (/IS_ENABLED\((.+?)\)/){ print "$1\n"}' | \
>         sort -u | tee CONFIG_list
>
> Then we can go through the CONFIG_list file and see which other stuff
> doesn't exist.
>
> for i in $(grep ^CONFIG CONFIG_list  | cut -d '_' -f 2-) ; do \
>         grep -q -w "config $i$" $(find -name Kconfig) || echo $i ; \
> done | tee CONFIG_not_found
>
> I have never done this before so I don't know what you'll find.  But
> everywhere you look if you just look closer then it raises questions
> which raise more questions.  So it's interesting to explore.  Anyway,
> look closely at each line in the file and follow the rabbit holes until
> you find something interesting to work on.
>

@Dan, Thanks for pointing out my clean-up activity here!

Yes, I agree with Dan. That is certainly an interesting task to
explore. If you search the mailing list, you will find another bash
script of similar length that Joe Perches used a few years back. I
personally use the script ./scripts/checkkconfigsymbols.py. They may
differ a bit on what they report, but I fear at this point, most of
its reports are false positives. I have looked at all of them, I am
checking the new ones introduced, and sending out patches to clean up
stuff. There are a few on my todo list, like cleaning up the
definition of CONFIG_CAAM_QI. If you want to assist, please let me
know. I can certainly give you a few things that are at least worth a
deeper investigation and maybe also some clean up.

Lukas

> regards,
> dan carpenter
>
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/g=
reybus/arche-platform.c
> index fcbd5f71eff2..2d9e0c41b5e3 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -165,43 +165,39 @@ static irqreturn_t arche_platform_wd_irq(int irq, v=
oid *devid)
>                  * 30msec, then standby boot sequence is initiated, which=
 is not
>                  * supported/implemented as of now. So ignore it.
>                  */
> -               if (arche_pdata->wake_detect_state =3D=3D WD_STATE_BOOT_I=
NIT) {
> -                       if (time_before(jiffies,
> -                                       arche_pdata->wake_detect_start +
> -                                       msecs_to_jiffies(WD_COLDBOOT_PULS=
E_WIDTH_MS))) {
> -                               arche_platform_set_wake_detect_state(arch=
e_pdata,
> -                                                                    WD_S=
TATE_IDLE);
> -                       } else {
> -                               /*
> -                                * Check we are not in middle of irq thre=
ad
> -                                * already
> -                                */
> -                               if (arche_pdata->wake_detect_state !=3D
> -                                               WD_STATE_COLDBOOT_START) =
{
> -                                       arche_platform_set_wake_detect_st=
ate(arche_pdata,
> -                                                                        =
    WD_STATE_COLDBOOT_TRIG);
> -                                       spin_unlock_irqrestore(&arche_pda=
ta->wake_lock,
> -                                                              flags);
> -                                       return IRQ_WAKE_THREAD;
> -                               }
> -                       }
> -               }
> -       } else {
> -               /* wake/detect falling */
> -               if (arche_pdata->wake_detect_state =3D=3D WD_STATE_IDLE) =
{
> -                       arche_pdata->wake_detect_start =3D jiffies;
> +               if (arche_pdata->wake_detect_state !=3D WD_STATE_BOOT_INI=
T)
> +                       goto out_unlock;
> +
> +               if (time_before(jiffies,
> +                               arche_pdata->wake_detect_start +
> +                               msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_=
MS))) {
> +                       arche_platform_set_wake_detect_state(arche_pdata,
> +                                                            WD_STATE_IDL=
E);
> +               } else if (arche_pdata->wake_detect_state !=3D WD_STATE_C=
OLDBOOT_START) {
>                         /*
> -                        * In the beginning, when wake/detect goes low
> -                        * (first time), we assume it is meant for coldbo=
ot
> -                        * and set the flag. If wake/detect line stays lo=
w
> -                        * beyond 30msec, then it is coldboot else fallba=
ck
> -                        * to standby boot.
> +                        * Check we are not in middle of irq thread
> +                        * already
>                          */
>                         arche_platform_set_wake_detect_state(arche_pdata,
> -                                                            WD_STATE_BOO=
T_INIT);
> +                                                            WD_STATE_COL=
DBOOT_TRIG);
> +                       spin_unlock_irqrestore(&arche_pdata->wake_lock, f=
lags);
> +                       return IRQ_WAKE_THREAD;
>                 }
> +       } else if (arche_pdata->wake_detect_state =3D=3D WD_STATE_IDLE) {
> +               /* wake/detect falling */
> +               arche_pdata->wake_detect_start =3D jiffies;
> +               /*
> +                * In the beginning, when wake/detect goes low
> +                * (first time), we assume it is meant for coldboot
> +                * and set the flag. If wake/detect line stays low
> +                * beyond 30msec, then it is coldboot else fallback
> +                * to standby boot.
> +                */
> +               arche_platform_set_wake_detect_state(arche_pdata,
> +                                                    WD_STATE_BOOT_INIT);
>         }
>
> +out_unlock:
>         spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
>
>         return IRQ_HANDLED;
