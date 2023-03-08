Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A66AFEE3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 07:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCHG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 01:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCHG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:26:01 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B994BA8393
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 22:25:59 -0800 (PST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E7B1F3F592
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678256757;
        bh=ay6ZKa7Tg72PuDk32HxgWNWnSno0ChydUsA4JwYm9Lk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bR69JWJ/RSEyw8Ig0BEe5qc1zv6VQ9Ej0xPoEIA8nDbtjuyzdrohb15AGwLtJeYyV
         x260iyUIFRFbB7wOSXbylrYtOoYYwZRPjouTCletySFLzWizf6ISP7mReaCKDRtdN3
         y50E8ACkbKijOK2L8fA8L2gb7OPKOBFbyOSD4tdU0Uk77a4hMHAjOpsfsK1r5bNF9l
         iDha/hNZVuzbNlmnIQzycX3BiMJYABMwdJ/RMlCjUmYXLodhVY5CQGzKtH78Rm8oNn
         I5Pjs52ltScmfxZoJjSWJMXD4y9JU2KraqkXMHYd6qoQXaEzmA5FeEcnLa9jtgeeLp
         /pcGZqpkQSqlA==
Received: by mail-pl1-f198.google.com with SMTP id s15-20020a170902ea0f00b0019d0c7a83dfso8949279plg.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 22:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678256756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay6ZKa7Tg72PuDk32HxgWNWnSno0ChydUsA4JwYm9Lk=;
        b=tY0crLYIfSzKyexwVzeHdFp4Xu5JusGhxox8EYUB0hh//ZKROaBuk5RReypwxJuv0O
         dKJYZzm5hz/b3wS/a/lWGCHEUu0z9vOUuuxAjpbzQc77QHuKla4NcTtW+t1yqmDEqfcQ
         UPMYRYoGTzjsmS7WwPS6m87SzGn+PPZKTlTAM9NisYLTOBkjVVJuA+R9Y1f8Rout1aT6
         Hcf9aIXA1v6NeKpzyPznBQ7DbnmdXesL6oOk+IocDThzsGENlT2XXBopvGhNwm4CzVIL
         nrauKrh8LMKsgNjzPhwVcDEYEMWxwqqZnNW/ilBFS1EzrVJ5n2D/ePL/IXxh9zZjMkKw
         /irA==
X-Gm-Message-State: AO0yUKVpMXXH739LIZs66ia2Gk1KSs2xFh7KolRzJJdrXBWqvVR8kKi3
        4vLvP/lbnzjfDqDCjltLARW6LjDMLssuer92d6ovFVEcrJ16ANS3k244S0IpqXKS6EEON1q+UBQ
        R5JLHP0MJd/T3MBgJXQRUpdyhVnT8b3FNBUnqDfSy3jetc5+4Q64EPS1YWA==
X-Received: by 2002:a17:90a:ec14:b0:231:1da0:dfce with SMTP id l20-20020a17090aec1400b002311da0dfcemr6011213pjy.3.1678256756313;
        Tue, 07 Mar 2023 22:25:56 -0800 (PST)
X-Google-Smtp-Source: AK7set9J/bss+n+FmfnvRWBEazewQBhSsabCnB8JBItXmoxS20MAETu1QTDyhFvR4xmeSPpw2pPROEwS82nh86dFnHY=
X-Received: by 2002:a17:90a:ec14:b0:231:1da0:dfce with SMTP id
 l20-20020a17090aec1400b002311da0dfcemr6011210pjy.3.1678256755883; Tue, 07 Mar
 2023 22:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20230306142454.722020-1-koba.ko@canonical.com> <a83d9acd-a2c5-85ce-36dc-c6a8f0e11a66@redhat.com>
In-Reply-To: <a83d9acd-a2c5-85ce-36dc-c6a8f0e11a66@redhat.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Wed, 8 Mar 2023 14:25:44 +0800
Message-ID: <CAJB-X+X83dLFsOyYON9zLQxOVukg7bcrikRohn4sRR6UiSUbOQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Register ctl-led for speaker-mute
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 8:10=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> On 3/6/23 15:24, Koba Ko wrote:
> > Some platforms have the speaker-mute led and
> > current driver doesn't control it.
> >
> > If the platform support the control of speaker-mute led, register it
> >
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
>
> Thank you for your patch, one small remark below.
>
> > ---
> >  drivers/platform/x86/dell/dell-laptop.c | 43 +++++++++++++++++++++++++
> >  drivers/platform/x86/dell/dell-smbios.h |  2 ++
> >  2 files changed, 45 insertions(+)
> >
> > diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform=
/x86/dell/dell-laptop.c
> > index 1321687d923ed..38d95bae8e3ab 100644
> > --- a/drivers/platform/x86/dell/dell-laptop.c
> > +++ b/drivers/platform/x86/dell/dell-laptop.c
> > @@ -97,6 +97,7 @@ static struct rfkill *bluetooth_rfkill;
> >  static struct rfkill *wwan_rfkill;
> >  static bool force_rfkill;
> >  static bool micmute_led_registered;
> > +static bool mute_led_registered;
> >
> >  module_param(force_rfkill, bool, 0444);
> >  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted model=
s");
> > @@ -2177,6 +2178,34 @@ static struct led_classdev micmute_led_cdev =3D =
{
> >       .default_trigger =3D "audio-micmute",
> >  };
> >
> > +static int mute_led_set(struct led_classdev *led_cdev,
> > +                        enum led_brightness brightness)
> > +{
> > +     struct calling_interface_buffer buffer;
> > +     struct calling_interface_token *token;
> > +     int state =3D brightness !=3D LED_OFF;
> > +
> > +     if (state =3D=3D 0)
> > +             token =3D dell_smbios_find_token(GLOBAL_MUTE_DISABLE);
> > +     else
> > +             token =3D dell_smbios_find_token(GLOBAL_MUTE_ENABLE);
> > +
> > +     if (!token)
> > +             return -ENODEV;
> > +
> > +     dell_fill_request(&buffer, token->location, token->value, 0, 0);
> > +     dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct led_classdev mute_led_cdev =3D {
> > +     .name =3D "platform::mute",
> > +     .max_brightness =3D 1,
> > +     .brightness_set_blocking =3D mute_led_set,
> > +     .default_trigger =3D "audio-mute",
> > +};
> > +
> >  static int __init dell_init(void)
> >  {
> >       struct calling_interface_token *token;
> > @@ -2230,6 +2259,16 @@ static int __init dell_init(void)
> >               micmute_led_registered =3D true;
> >       }
> >
> > +     if (dell_smbios_find_token(GLOBAL_MUTE_DISABLE) &&
> > +         dell_smbios_find_token(GLOBAL_MUTE_ENABLE) &&
> > +         !dell_privacy_has_mic_mute()) {
>
> Since this is a speaker mute LED and since the Dell hw privacy
> stuff does not deal with the speaker at all, I believe that you
> should drop the "&& !dell_privacy_has_mic_mute()" part of
> the if condition here ?
>
> Can you please send a new version with this dropped?

Sure, have sent v2 with dell_privacy_has_mic_mute dropped
Thanks

>
> Regards,
>
> Hans
>
>
> > +             mute_led_cdev.brightness =3D ledtrig_audio_get(LED_AUDIO_=
MUTE);
> > +             ret =3D led_classdev_register(&platform_device->dev, &mut=
e_led_cdev);
> > +             if (ret < 0)
> > +                     goto fail_led;
> > +             mute_led_registered =3D true;
> > +     }
> > +
> >       if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
> >               return 0;
> >
> > @@ -2277,6 +2316,8 @@ static int __init dell_init(void)
> >  fail_backlight:
> >       if (micmute_led_registered)
> >               led_classdev_unregister(&micmute_led_cdev);
> > +     if (mute_led_registered)
> > +             led_classdev_unregister(&mute_led_cdev);
> >  fail_led:
> >       dell_cleanup_rfkill();
> >  fail_rfkill:
> > @@ -2299,6 +2340,8 @@ static void __exit dell_exit(void)
> >       backlight_device_unregister(dell_backlight_device);
> >       if (micmute_led_registered)
> >               led_classdev_unregister(&micmute_led_cdev);
> > +     if (mute_led_registered)
> > +             led_classdev_unregister(&mute_led_cdev);
> >       dell_cleanup_rfkill();
> >       if (platform_device) {
> >               platform_device_unregister(platform_device);
> > diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform=
/x86/dell/dell-smbios.h
> > index 75fa8ea0476dc..eb341bf000c67 100644
> > --- a/drivers/platform/x86/dell/dell-smbios.h
> > +++ b/drivers/platform/x86/dell/dell-smbios.h
> > @@ -34,6 +34,8 @@
> >  #define KBD_LED_AUTO_100_TOKEN       0x02F6
> >  #define GLOBAL_MIC_MUTE_ENABLE       0x0364
> >  #define GLOBAL_MIC_MUTE_DISABLE      0x0365
> > +#define GLOBAL_MUTE_ENABLE   0x058C
> > +#define GLOBAL_MUTE_DISABLE  0x058D
> >
> >  struct notifier_block;
> >
>
