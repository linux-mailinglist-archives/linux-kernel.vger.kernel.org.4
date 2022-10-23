Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D5609492
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJWQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:02:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C381B9D6;
        Sun, 23 Oct 2022 09:02:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z8so4490233qtv.5;
        Sun, 23 Oct 2022 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz9XWOiFFESBdr9jPKCVIx0TC9wy87EzicgD9ba52i0=;
        b=ZokdKQIdSRu7VzLbgEOLMf/rI3gDm9tW+Cv4ONl1Nkcxw7yojEF3/MYhd+uVT/b4LC
         OpRpyac88bcCgI34v0/B9NQkzskE4LjHsqj1NVU9l8sd8hGUUog5GjYTfC6h4LSki7Qu
         Wpy786dGMgk6gO3yp7F+eLmf86V6N9bdmKrmArMGQgz78KJ7pXNoja4FDcxX1NlbRgsK
         s3JqLvNN7HDl3ETG8mCX1aIxaE+gocfWaaxAmdFbSmOUVEF1kOrwds1JQHS9BkIcUqfH
         ZEq1W/p/ScJRMHxNgI29Nua+lcwPq8g6kRHHPZEcmFIyHmz81feMTb4zX9KeI3R9M5Xg
         EIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz9XWOiFFESBdr9jPKCVIx0TC9wy87EzicgD9ba52i0=;
        b=BGYVqpaZAaQ+nIR6qGWZFpENzDOJyRkv/q+IKCaO2BiEKV1jJRhKJt47MmK27CMObW
         OxfpCqFvr43kprX3OrnSA06lUpGdKdeIWsKv8YDdC8kSxEogf5hTtLfAtI36CSmnBl7H
         VGokDaVmMdAssjiyY7ENtAyvYkX49nooLqHukzsEiObzYKf9efPCiOCTPsb0x/mMmPly
         hDQiaCSgUXL/AvizKlxooarc/eD/lC4Gwel8eJn7Mt4LPCQonuhcLp8oIyV9POucK4C4
         lkoaj5DQivAT248uxbJOhRjydej0qDdapRbtkhRdPxnd64+N93JdUhDMwJbHsWmw0v2q
         IwSA==
X-Gm-Message-State: ACrzQf3in/59kGcRl0Enle5ldVTSgQtAdgjpb6hf4CBRUGENvZGUfnek
        rWQvwzSUlts+c6Ogq3KmYRNryYbgIRst0ANb3UI=
X-Google-Smtp-Source: AMsMyM7aYaB8/2SOnUGvUpXd/LkfX/0hvh87q/Ui5soeEouao7CzE89xb7wocp8CNjvZ2XCd8s1B7EhtWhxlUeR3qZY=
X-Received: by 2002:ac8:5c07:0:b0:39c:de84:64ad with SMTP id
 i7-20020ac85c07000000b0039cde8464admr24196322qti.336.1666540959639; Sun, 23
 Oct 2022 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221022220508.37489-1-maurinbe@gmail.com> <CAEc3jaDjGBUspf5zPUfjPKgP+nk4zVFqJ0pgR8LAmX35qmx+fA@mail.gmail.com>
In-Reply-To: <CAEc3jaDjGBUspf5zPUfjPKgP+nk4zVFqJ0pgR8LAmX35qmx+fA@mail.gmail.com>
From:   Benoit Maurin <maurinbe@gmail.com>
Date:   Sun, 23 Oct 2022 18:02:29 +0200
Message-ID: <CALamgT9ecqStP4YamvgHnbbZ9m9ux-fDr6UPYcfFfztJH=goRw@mail.gmail.com>
Subject: Re: [PATCH] input/xpad: LED controllable through input events
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Roderick,

Thanks for having a look. I'd understand if this is not a desirable directi=
on,
I was not aware of this legacy-ish connotation of EV_LED (should have figur=
ed
it out with the hoops about the clear_bit thing) and it seemed convenient t=
o
interact with the pad through a single /dev/input/xxx interface.

Let me know what you decide :)
Benoit


Le dim. 23 oct. 2022 =C3=A0 06:00, Roderick Colenbrander
<thunderbird2k@gmail.com> a =C3=A9crit :
>
> Hi Benoit,
>
> Thanks for your patch. I'm thinking out loud whether this is a
> direction we want to go in regards to EV_LED. I vaguely recall some
> discussions a while ago that EV_LED was really from a different era
> for legacy reasons (keyboard LEDs). Since the introduction of the LED
> framework that was really the way to go.
>
> Thanks,
> Roderick
>
> On Sat, Oct 22, 2022 at 3:08 PM Benoit Maurin <maurinbe@gmail.com> wrote:
> >
> > (EV_LED, LED_MISC, #VALUE) can now be used to control leds on the
> > xpad gamepad (was only possible through /sys/class/leds/xpad0/brightnes=
s)
> > with permissions of /dev/input/xxx
> >
> > To test the code (xpad can be compiled out-of-tree with some slight
> > tweaks):
> >
> > ```
> > import evdev
> > device =3D evdev.InputDevice('/dev/input/event15') # not js0
> > device.set_led(8, 2)
> > device.set_led(8, 0) # this won't be delivered
> > device.set_led(8, 16) # must do this instead
> > device.set_led(8, 15)
> > ```
> >
> > Signed-off-by: Benoit Maurin <maurinbe@gmail.com>
> > ---
> >  drivers/input/joystick/xpad.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
> > index 2959d80f7..fcf4d2c8f 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -1646,6 +1646,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
> >                 goto err_free_mem;
> >         }
> >
> > +       input_set_capability(xpad->dev, EV_LED, LED_MISC);
> >         snprintf(led->name, sizeof(led->name), "xpad%d", xpad->pad_nr);
> >         led->xpad =3D xpad;
> >
> > @@ -1824,6 +1825,28 @@ static void xpad_deinit_input(struct usb_xpad *x=
pad)
> >         }
> >  }
> >
> > +static int xpad_event(struct input_dev *dev, unsigned int type,
> > +                     unsigned int code, int value)
> > +{
> > +       struct usb_xpad *xpad =3D input_get_drvdata(dev);
> > +
> > +       if (type !=3D EV_LED || xpad->led =3D=3D NULL)
> > +               return 0;
> > +       xpad_send_led_command(xpad, value);
> > +       xpad->led->led_cdev.brightness =3D value;
> > +       /* Bit clearing is necessary otherwise two events with
> > +        * different non-null values will deliver only the first one.
> > +        * To work around this, we clear the bit to indicate that the
> > +        * current value is zero. The downside is that events with zero
> > +        * value won't be delivered. It's not a big deal since a value =
of
> > +        * 16 can be sent which is the same as 0
> > +        * See xpad_send_led_command, command %=3D 16
> > +        */
> > +
> > +       clear_bit(code, xpad->dev->led);
> > +       return 0;
> > +}
> > +
> >  static int xpad_init_input(struct usb_xpad *xpad)
> >  {
> >         struct input_dev *input_dev;
> > @@ -1851,6 +1874,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
> >                 input_dev->open =3D xpad_open;
> >                 input_dev->close =3D xpad_close;
> >         }
> > +       input_dev->event =3D xpad_event;
> >
> >         if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
> >                 /* set up axes */
> > --
> > 2.38.1
> >
