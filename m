Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7ED67C1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjAZArU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjAZArT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:47:19 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B934914223;
        Wed, 25 Jan 2023 16:47:18 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 123so290629ybv.6;
        Wed, 25 Jan 2023 16:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G7hdpsJNHoT61rXRZ8EkFu8uZ65XHhD/2X2WufvxGtA=;
        b=NJJKrehKj8FIV/l3WqyzCH35LygKM8SRGFH64Yw0V9ftmsUNcVH+Vud+yfao2jhY/6
         T8EgsKmKh6gAyrLwCIwu7+Rl5m744MqTuXtqZ1N0Cz2w/vH7vs6U7do5zuTyaGinN/ng
         kt/kG26gHCtleEyB78pSo6cWfBI6wYEjoHB4vIfU/31+0likgnYewlsUEn2pb2qYFmgF
         8hbwaUxjDHuFyPF2/5n8+18TyASLfcPdQeoWwYguTvubgAMY61B+LR9C3yJonW+T/Dig
         Xsj/KtcPzET3ecDQ8fSw+yXiCjaAKq10L0tVTeeXqNb5twHJeT+fUgTlL9BlNgGAK5uW
         W4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7hdpsJNHoT61rXRZ8EkFu8uZ65XHhD/2X2WufvxGtA=;
        b=wg37AkB26zg7h4ITiZgArnm11T3lNOgE4oLy/lvJsP5bfKaZLlm+1IOvMGg9VVi1Pr
         nYxi+9nR7TcEIL4QvwZtM8Y57Ab/zJWxTDpoHd1j1X15eMBb0IuLobZRR/AkHAbjRtwP
         WSY3TGYDb6rlHce60hdoMVYQg7JBmOtYGq03QQXnvgUQ0/+XlUkvC3aYtbiYGhJDlpFZ
         MRMEG3vC49fzDScCv5BYyeeDO9sXQ8BHablDXiroVX8H05l/2XaJjP39v1ow0J1Ae/D8
         eyhWWQj7gjcSv16Czwj6xycznMlxKRS99UkKm88F0Qs5EMwFO6xnlbd41jtPRdkzKkpO
         CQ2Q==
X-Gm-Message-State: AFqh2kpOc6jKi64gtbzdA1yj1duod4KhgW/n4+Kmk5gzDFwruF0SOufn
        0RK3L67dH2dkB4ZAPXy+hJfRn762WZwSyo/IfRI=
X-Google-Smtp-Source: AMrXdXtbkM/WLeL3rk0MtM9ie3WZUvXwZSXv5cVATg2b1vkZ7SY9vPf7jG6lG16Mu7Jsyd86pG7VSD8QQD9W040iQRA=
X-Received: by 2002:a25:6405:0:b0:6f3:6ba:b281 with SMTP id
 y5-20020a256405000000b006f306bab281mr3936458ybb.137.1674694037978; Wed, 25
 Jan 2023 16:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v1-3-9a5192dcef16@diag.uniroma1.it> <CAEc3jaCEKfqEJSV4=6GRj1Ry97xH+HwVSeEOZReNwkt=rLNvNQ@mail.gmail.com>
In-Reply-To: <CAEc3jaCEKfqEJSV4=6GRj1Ry97xH+HwVSeEOZReNwkt=rLNvNQ@mail.gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Wed, 25 Jan 2023 16:47:07 -0800
Message-ID: <CAEc3jaDRzvw4wqomWTZ4QiGT7ndm0u+LQuqDTOWB=B-6w=2yzg@mail.gmail.com>
Subject: Re: [PATCH 3/5] HID: dualsense_remove: manually unregister leds
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>,
        linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One other little note. For completeness I guess we need a similar
patch for the multicolor led class.

On Wed, Jan 25, 2023 at 4:43 PM Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
>
> Hi Pietro,
>
> Thanks for your patch. For sure for ds4/dualsense there have been edge
> cases around rumble removal and others. Those were prevented by this
> 'output_worker_initialized' variable, which is checked during the
> centralized work scheduling function (dualshock4_schedule_work /
> dualsense_schedule_work). That said I don't mind the change as it
> prevents the work scheduling functions to get called unnecessarily.
>
> Thanks,
> Roderick Colenbrander
>
> On Wed, Jan 25, 2023 at 4:26 PM Pietro Borrello
> <borrello@diag.uniroma1.it> wrote:
> >
> > Unregister the LED controller before device removal, as
> > dualsense_player_led_set_brightness() may schedule output_worker
> > after the structure has been freed, causing a use-after-free.
> >
> > Fixes: 8c0ab553b072 ("HID: playstation: expose DualSense player LEDs through LED class.")
> > Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> > ---
> >  drivers/hid/hid-playstation.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> > index 27c40894acab..9e23860b7e95 100644
> > --- a/drivers/hid/hid-playstation.c
> > +++ b/drivers/hid/hid-playstation.c
> > @@ -1503,11 +1503,15 @@ static void dualsense_remove(struct ps_device *ps_dev)
> >  {
> >         struct dualsense *ds = container_of(ps_dev, struct dualsense, base);
> >         unsigned long flags;
> > +       int i;
> >
> >         spin_lock_irqsave(&ds->base.lock, flags);
> >         ds->output_worker_initialized = false;
> >         spin_unlock_irqrestore(&ds->base.lock, flags);
> >
> > +       for (i = 0; i < ARRAY_SIZE(ds->player_leds); i++)
> > +               devm_led_classdev_unregister(&ps_dev->hdev->dev, &ds->player_leds[i]);
> > +
> >         cancel_work_sync(&ds->output_worker);
> >  }
> >
> >
> > --
> > 2.25.1
