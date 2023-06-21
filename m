Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69A9739115
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFUUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFUUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:52:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2F219C;
        Wed, 21 Jun 2023 13:52:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b4725e9917so63538341fa.2;
        Wed, 21 Jun 2023 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687380742; x=1689972742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmIDeIftl/J1oTKrvXeOO7UZTGQdp+QEUmL6PNdEA80=;
        b=mbGPczFkhaKwPmZi/JCZ6V4Sm/YvtZnGJdQbrD4OC8cgNjZLKLCwuIA7Qcvyptfyle
         C+8aQ1HEtgM/d0t3yn+pL0vKi/1Nh44P0Fojiq9GgtPCKdhx1ASvZzfK1yo67EqP3+7K
         w6wLMIKQXc8+07H/g8myZYCqQudPMlujsNsZQH/IRg7998Gh1C7kO9/fC1tv4viTpuWV
         YdolOyTnR7uncttPOA8QBAWltNxf9E7ghmfuhWgiwOR0t3744mmMUg0mNs/ihU/9pXrA
         eYVoDRSL7BFhrpzRp/+mHbE8+l1ZxMb/kAPfklNwoqP+BikBjMrb3wu8of9lzQeHTTr9
         AwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687380742; x=1689972742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmIDeIftl/J1oTKrvXeOO7UZTGQdp+QEUmL6PNdEA80=;
        b=CTtLdxXTzBmjLhX5z+TQp++YVKEOhAehKwQ9mUpc6O6KKWWJvwtubUsS43r14ny83z
         Kzfs7nMxEVMoDRiuek5mo0ILiHUJfsfu6+o5sMd4JwJp3vHrlkO/fkmjW7kvDojw/0dE
         yXLGjU43OANXJP+RafPIXDoBHVdUt0ajcpoO6mzpUb4IMzaEcCfWRbXjgm6+KOlv1+Ew
         rxXkLJg5kaL9yeUaPr+ygqlIJjvibHjgsyRqQc56mOA6f7bQAV6gJ0nvuI6w/eNq8g/h
         G7PuDFD7FcJvPIWClAx/9zsArMRaRCj5r33T/vVvhbmAJRxPAMSj1GIrho8wWgNY83ph
         dC3A==
X-Gm-Message-State: AC+VfDxC6qzG5i2ZDjx0dOr1/WY6fSpOCCChFtMh0YV+i0euSkFhN+w1
        bk/qSZDC9C9Z1E36PkfjndBSumS8WMykWk0pnI8=
X-Google-Smtp-Source: ACHHUZ4Koruy9Ehxdxr2YisgN6XBu4IK85gKx5qj4KmAi//FHdw/k8BOw86E8OYQDYWxtC13R9iX94zrSaN1N36dY4s=
X-Received: by 2002:a05:6512:1112:b0:4f9:5bed:9c1f with SMTP id
 l18-20020a056512111200b004f95bed9c1fmr2394019lfg.56.1687380741936; Wed, 21
 Jun 2023 13:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230607214102.2113-1-jason.gerecke@wacom.com>
 <20230608213828.2108-1-jason.gerecke@wacom.com> <CANRwn3R-XbfB+mP9AQ-J7R_19jLi4eS3MhswaWjL+LCEih-7pg@mail.gmail.com>
 <CAO-hwJJC12dRhmykE+P_LBcEJ2G0gHy3Nh1gvWULjdA=4qa-ZQ@mail.gmail.com>
In-Reply-To: <CAO-hwJJC12dRhmykE+P_LBcEJ2G0gHy3Nh1gvWULjdA=4qa-ZQ@mail.gmail.com>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Wed, 21 Jun 2023 13:52:10 -0700
Message-ID: <CANRwn3SwEOZWxkCAU8FvFZyLHNpq78bZQtN7tbGTQjU=sQ9iAA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Use ktime_t rather than int when dealing
 with timestamps
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Joshua Dickens <Joshua@joshua-dickens.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 9:04=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Jun 21, 2023 at 5:18=E2=80=AFPM Jason Gerecke <killertofu@gmail.c=
om> wrote:
> >
> > Following up since no action seems to have been taken on this patch yet=
.
>
> Sorry, this went through the cracks (I seem to have a lot of cracks recen=
tly...)
>
> >
> > On Thu, Jun 8, 2023 at 2:38=E2=80=AFPM Jason Gerecke <killertofu@gmail.=
com> wrote:
> > >
> > > Code which interacts with timestamps needs to use the ktime_t type
> > > returned by functions like ktime_get. The int type does not offer
> > > enough space to store these values, and attempting to use it is a
> > > recipe for problems. In this particular case, overflows would occur
> > > when calculating/storing timestamps leading to incorrect values being
> > > reported to userspace. In some cases these bad timestamps cause input
> > > handling in userspace to appear hung.
>
> I have to ask, is this something we should consider writing a test for? :=
)
>

Very good point! I'm happy to work on such a test.

Are you open to merging this patch without delay while I write a
testcase? I don't like the idea of this (apparent) system freeze being
affecting users any longer than absolutely necessary.

> Also, you are missing the rev-by from Peter, not sure if the tools
> will pick it up automatically then.
>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>

Oof, good catch. Apologies to Peter :)

Jason

> Cheers,
> Benjamin
>
> > >
> > > Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/901
> > > Fixes: 17d793f3ed53 ("HID: wacom: insert timestamp to packed Bluetoot=
h (BT) events")
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> > > ---
> > > v2: Use div_u64 to perform division to deal with ARC and ARM architec=
tures
> > >     (as found by the kernel test robot)
> > >
> > >  drivers/hid/wacom_wac.c | 6 +++---
> > >  drivers/hid/wacom_wac.h | 2 +-
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > > index 2ccf838371343..174bf03908d7c 100644
> > > --- a/drivers/hid/wacom_wac.c
> > > +++ b/drivers/hid/wacom_wac.c
> > > @@ -1314,7 +1314,7 @@ static void wacom_intuos_pro2_bt_pen(struct wac=
om_wac *wacom)
> > >         struct input_dev *pen_input =3D wacom->pen_input;
> > >         unsigned char *data =3D wacom->data;
> > >         int number_of_valid_frames =3D 0;
> > > -       int time_interval =3D 15000000;
> > > +       ktime_t time_interval =3D 15000000;
> > >         ktime_t time_packet_received =3D ktime_get();
> > >         int i;
> > >
> > > @@ -1348,7 +1348,7 @@ static void wacom_intuos_pro2_bt_pen(struct wac=
om_wac *wacom)
> > >         if (number_of_valid_frames) {
> > >                 if (wacom->hid_data.time_delayed)
> > >                         time_interval =3D ktime_get() - wacom->hid_da=
ta.time_delayed;
> > > -               time_interval /=3D number_of_valid_frames;
> > > +               time_interval =3D div_u64(time_interval, number_of_va=
lid_frames);
> > >                 wacom->hid_data.time_delayed =3D time_packet_received=
;
> > >         }
> > >
> > > @@ -1359,7 +1359,7 @@ static void wacom_intuos_pro2_bt_pen(struct wac=
om_wac *wacom)
> > >                 bool range =3D frame[0] & 0x20;
> > >                 bool invert =3D frame[0] & 0x10;
> > >                 int frames_number_reversed =3D number_of_valid_frames=
 - i - 1;
> > > -               int event_timestamp =3D time_packet_received - frames=
_number_reversed * time_interval;
> > > +               ktime_t event_timestamp =3D time_packet_received - fr=
ames_number_reversed * time_interval;
> > >
> > >                 if (!valid)
> > >                         continue;
> > > diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> > > index 1a40bb8c5810c..ee21bb260f22f 100644
> > > --- a/drivers/hid/wacom_wac.h
> > > +++ b/drivers/hid/wacom_wac.h
> > > @@ -324,7 +324,7 @@ struct hid_data {
> > >         int ps_connected;
> > >         bool pad_input_event_flag;
> > >         unsigned short sequence_number;
> > > -       int time_delayed;
> > > +       ktime_t time_delayed;
> > >  };
> > >
> > >  struct wacom_remote_data {
> > > --
> > > 2.41.0
> > >
> >
>
