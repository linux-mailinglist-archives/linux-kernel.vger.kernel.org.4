Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41868698FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBPJ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBPJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:26:29 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4144023301;
        Thu, 16 Feb 2023 01:26:28 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bx13so1078520oib.13;
        Thu, 16 Feb 2023 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5a+U98zHbOPXpE3srV4izBd1vHz49WorWPd9n2zsyI=;
        b=Qe5UpQf51lGPQ3qHMEqsaKFqGTZ+aIQoEyGIyb7Jy+CEltSDMPPZvd5BdtRo73Eih3
         EvKwBu1IFVJkj0pu92lnPvJFS6+Lx8udTnU1TdoepRLcHt0qvgJbMuZ0uQ0as99CjzAe
         dR7IzFFlZToScRg0hPtxkZnlzdHoGISIfx/iewOr4lhv/mRww87AA0i+CTV7HF0UB6Wr
         LspwJAj+3lTjOWwFWIcM1PAGuqpJzTRAoDEcBdm1Ldv/Uxcxtf/xk99esoVgmRFcIVwE
         seaNG3hLtIwYersrJ7Ym9pzwOKF0W8Tgg+Ih/W9Eyoy7hbMI7lAwMhJhgtPSj9/7JUyR
         6V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5a+U98zHbOPXpE3srV4izBd1vHz49WorWPd9n2zsyI=;
        b=TlkaqLzLQqp6pJLd+I0H1V4Q0wP1Ouk5yEOOb1+Ma4b9hbUwhHg+rrDgZpu+JcrCaq
         0IytzhqOjB++aYtDCxVFT94LGU+VGWqEajqU2GZb+EOnRvhfRkIAyB6FBjbHpdCOVrJF
         5oIq8PdFDq2h5Mo0veJUPgmcbYrg8deSI/ZJ5C+ELp/JonwGPxZdvFznb8jNsNHsh4zy
         YQVWQFD0aU8zpJqXCoCdyjIV1fb+7q3BOiNyLByTMmrnlvxtB8UtLZaRvyAg6JxLNYIh
         J6WG0E1kOcAtdi7WpFENv9bGjtuv6O4aem52jVI8fw9g5WvmuWSf2TIU/M27r3Q8hm1j
         gBDA==
X-Gm-Message-State: AO0yUKW6L7eRn9AQBoyO0LFcAff+ydw8lZUu5ByTHcTIOGwNCJiRQHKr
        vNQXHJZp9TE0iH55TX7lIZHp6ylzQ6FP1UIYOCk=
X-Google-Smtp-Source: AK7set8WIaIIo8ptjksPot491eOaLZOXa6acdxmnRlBFpLZv6Lk8/aa+uE0h5j6URqWtXtpqlEqPqzbbfoFD41oAwIA=
X-Received: by 2002:a05:6808:1a02:b0:37a:c636:6af3 with SMTP id
 bk2-20020a0568081a0200b0037ac6366af3mr158687oib.77.1676539587379; Thu, 16 Feb
 2023 01:26:27 -0800 (PST)
MIME-Version: 1.0
References: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
In-Reply-To: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
From:   qi feng <fengqi706@gmail.com>
Date:   Thu, 16 Feb 2023 17:26:16 +0800
Message-ID: <CACOZ=ZXN7Jnug_vhWexFvxknZEwaRM9BHXEo8O20q=sEKecNLQ@mail.gmail.com>
Subject: Re: [PATCH v4] HID: add KEY_CAMERA_FOCUS event in HID
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengqi <fengqi@xiaomi.com>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop more

Qi Feng <fengqi706@gmail.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8816=E6=97=A5=
=E5=91=A8=E5=9B=9B 16:48=E5=86=99=E9=81=93=EF=BC=9A
>
> From: fengqi <fengqi@xiaomi.com>
>
> Our HID device need KEY_CAMERA_FOCUS event to control camera,
> but this event is non-existent in current HID driver.
> So we add this event in hid-input.c.
>
> Signed-off-by: fengqi <fengqi@xiaomi.com>
>
> ---
> changes in v4:
>
> -add HID_UP_CAMERA in HID usage tables , Then add the mapping under HID_U=
P_CAMERA
> -modify the commit log of patch
> -Link to v3:https://lore.kernel.org/linux-input/9a85b268c7636ef2e4e3bbbe3=
18561ba2842a591.1676536357.git.fengqi@xiaomi.com/T/#u
> -Link to v2:https://lore.kernel.org/linux-input/CACOZ=3DZU0zgRmoRu8X5bMUz=
UrXA9x-qoDJqrQroUs=3D+qKR58MQA@mail.gmail.com/T/#t
> -Link to v1:https://lore.kernel.org/linux-input/CACOZ=3DZWB3grJKn7wAZEZ0B=
DyN7KJF4VWUTNs-mPxeoW_oiR7=3Dg@mail.gmail.com/T/#t
> ---
>  drivers/hid/hid-input.c | 10 ++++++++++
>  include/linux/hid.h     |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 77c8c49852b5..c6098ae2fac7 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1225,6 +1225,16 @@ static void hidinput_configure_usage(struct hid_in=
put *hidinput, struct hid_fiel
>                         return;
>                 }
>                 goto unknown;
> +       case HID_UP_CAMERA:
> +               switch (usage->hid & HID_USAGE) {
> +               case 0x020:
> +                       map_key_clear(KEY_CAMERA_FOCUS);        break;
> +               case 0x021:
> +                       map_key_clear(KEY_CAMERA);              break;
> +               default:
> +                       goto ignore;
> +               }
> +               break;
>
>         case HID_UP_HPVENDOR:   /* Reported on a Dutch layout HP5308 */
>                 set_bit(EV_REP, input->evbit);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 8677ae38599e..88793b77bd63 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -155,6 +155,7 @@ struct hid_item {
>  #define HID_UP_DIGITIZER       0x000d0000
>  #define HID_UP_PID             0x000f0000
>  #define HID_UP_BATTERY         0x00850000
> +#define HID_UP_CAMERA          0x00900000
>  #define HID_UP_HPVENDOR         0xff7f0000
>  #define HID_UP_HPVENDOR2        0xff010000
>  #define HID_UP_MSVENDOR                0xff000000
> --
> 2.39.0
>
