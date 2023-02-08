Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6468F7CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjBHTFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjBHTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:05:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D22582B7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:05:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t17so13827211pfj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cql7MEjTp3NO2/OVM9pJ4Pr7OGop1ku8fCM7b03xw5I=;
        b=n3iCcQK/GbIC8BW2dq0ctRN8T+GPP/rSSecdxzNkxRLWtsYoJn0Z3biu/QMPTyTjoO
         SsDGbBFxQei+tMShxQUK8WrjBwrJetU5XAVYk0rAM+dhbjtMZgo2lpNkparSygsBKJAN
         ovwXgdBVKmfv67YmB6XE9SVDcPXXUBBkw1Q6Ljslp3nVOtdIpC+uG7NIz82N6nrdgCTA
         d2EIErkMrMSd7r7fmtf+nwvZFIuhf4QUMEbvbLOaBuTheUWIywOxYKFBxxoIzsWRTjt/
         MqoMmeDA8GlLrCnzp8zDy/FUA2AXwV3YE8CsugaO+rllFE9HmanXjLZbthtr0n9425lh
         fazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cql7MEjTp3NO2/OVM9pJ4Pr7OGop1ku8fCM7b03xw5I=;
        b=74Sucg+cVgzoVePcZk0bopXjxkWl0SkcMT64MM11IuutsC0tdQLkor7GlgK8TBA+G+
         //I7bFSRh6lf163NraysYWtUNDUDHRikPRH6qdaXSKtzjb5ZvHrB7EgbKAQxJcmS1WmN
         5eAomij5VDqeHh4eV3Ai/sn6kaRcEO++AgRZR/SqsR+qu6HME5eKlbV4dAMo6U/+LC4Q
         YaTm0LpaTto05CpAM5ZkSt+S3aVNNul8U9OKTCPZCZreK7CmLy480VJgPhQ692ceMFIT
         Ge5mZ64ywzQF4fXP48FaYotAvqmnFaP/cBMy1qkiBHAQz8nOMbfwju42SJIEJVd+iy2T
         9oXw==
X-Gm-Message-State: AO0yUKW8vKHcwwQIHXNiWc9EXr7krMUNcnkKPROr7X/WFT8o0M3HsW9V
        8LiVmvi6WPxBDwFwz7yEyG0BsO3enC1C//KOpttJTC2dHYc=
X-Google-Smtp-Source: AK7set/FIiZg6KcIhBA8creffafWrV3Q+tvHd7Z0Jt6HkZFhRvve4YqXcjq7g4n9S3ytigI3ufxN4lQkjkwnNJVVMBM=
X-Received: by 2002:a63:7b1e:0:b0:4fb:37f2:59aa with SMTP id
 w30-20020a637b1e000000b004fb37f259aamr649193pgc.2.1675883109969; Wed, 08 Feb
 2023 11:05:09 -0800 (PST)
MIME-Version: 1.0
References: <CAMxBKG1RwbRJMG0cKcnbyKgznXeZLL+Zp1zXeOnxpYU0NkOO8A@mail.gmail.com>
 <CAMxBKG3o_6R7M0gaUHXA5yGgSe6HBWYK25fwF=8mN+JTno9t7Q@mail.gmail.com>
In-Reply-To: <CAMxBKG3o_6R7M0gaUHXA5yGgSe6HBWYK25fwF=8mN+JTno9t7Q@mail.gmail.com>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Wed, 8 Feb 2023 19:04:58 +0000
Message-ID: <CAMxBKG0wDi-XwMZwMHq_DbFXt3pgK-CV-G7iT9BNftiXBoUHzQ@mail.gmail.com>
Subject: Re: drm: panel-orientation-quirks: Add quirk for Lenovo IdeaPad Duet
 3 10IGL5
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
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

I've resolved this by adding a matching quirk in
drivers/firmware/efi/sysfb_efi.c - see below.

Are you the right people to be notifying about this?

---
diff --git a/kernel/6.2-rc6 original/sysfb_efi.c b/kernel/6.2-rc6
changes/sysfb_efi.c
index 7882d4b..f06fdac 100755
--- a/kernel/6.2-rc6 original/sysfb_efi.c
+++ b/kernel/6.2-rc6 changes/sysfb_efi.c
@@ -264,6 +264,14 @@ static const struct dmi_system_id
efifb_dmi_swap_width_height[] __initconst = {
                                        "Lenovo ideapad D330-10IGM"),
                },
        },
+       {
+               /* Lenovo IdeaPad Duet 3 10IGL5 with 1200x1920
portrait screen */
+               .matches = {
+                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                       DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+                                       "IdeaPad Duet 3 10IGL5"),
+               },
+       },
        {},
 };
 ---

Thanks,
Darrell

On Tue, 7 Feb 2023 at 15:51, Darrell Kavanagh
<darrell.kavanagh@gmail.com> wrote:
>
> Further information:
>
> With the above fix, the very early boot console messages are not
> rotated. adding "fbcon=rotate:1" to the kernel command line corrects
> this. But these early boot console messages are still garbled - it
> looks like the display driver in use at the time cannot write to the
> screen fast enough - lines are half-formed before scrolling.
>
> Note that this corrects itself and later boot messages are legible
> before the plymouth splash (if in use). I can't see anything that
> looks like useful information re the fb in journalctl immediately
> preceding the first legible output seen during boot.
>
> I've played around with console, earlycon and fbcon parms to no useful
> effect. Any ideas?
>
> Darrell
>
> On Fri, 3 Feb 2023 at 18:32, Darrell Kavanagh
> <darrell.kavanagh@gmail.com> wrote:
> >
> > Hi,
> >
> > This is another Lenovo with detachable keyboard and 1200x1920 screen
> > mounted sideways.
> >
> > The following has been tested with 6.2.0-rc6.
> >
> > Thanks,
> > Darrell
> >
> > index 3659f04..590bb7b 100644
> > --- a/kernel/drm_panel_orientation
> > _quirks.c
> > +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_data[] = {
> >                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad
> > D330-10IGM"),
> >                 },
> >                 .driver_data = (void *)&lcd1200x1920_rightside_up,
> > +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
> > +               .matches = {
> > +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
> > +               },
> > +               .driver_data = (void *)&lcd1200x1920_rightside_up,
> >         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
> >                 .matches = {
> >                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
