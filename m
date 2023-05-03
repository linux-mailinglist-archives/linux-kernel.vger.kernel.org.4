Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFFA6F6152
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjECWbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:31:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E450D7DAC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:31:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf702c3ccso302305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683153097; x=1685745097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw/uh5akf5sYyirenlPiMJ2fqzB54uKSrx04Lkzu3QY=;
        b=BklqgaLPbl6uRq0Dt4LFtNrfjW09mt809Tz5EJ2tmKfX8GCcdB49Whfnf/meC/A8yW
         dHaI+GCSwoOeb+3AZynNxIu14buIG6A3EIUsJu5AND0ELfYwri4oI5slLKZKMIAqKSiM
         4vOvZn0dCjKtEdl56t372JWSmN2ELkvJ/tHfNubv+pzLOBx8vBo/maeQLscRpdy47XTA
         srAGjyN0aIeUJ6iu8zDKWrWZLo8x1VxYkEt8NetSgurttqJiG88Bhs/5xVEeGZZ89+LI
         PBxpeu5nFnANsI4GEOO9V3s7YjzW+vAJEb/3VuocP24ZvnAR6XRsW2g8J2VJy8NfEzxf
         tfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683153097; x=1685745097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw/uh5akf5sYyirenlPiMJ2fqzB54uKSrx04Lkzu3QY=;
        b=IYVw/S5MJuLGMkkY6O8+yrughp6Qw7RC/mdRHuiBzXzCk3bkpZWG7BUlZDCQRWrAFe
         ifLqUjV/th1vk6Sy+aystqJm+gKPpnPnVP5i1OaEpWh6I0L0+s2iqN2c2iPZIqDUSK6Z
         9TeymW95dmSbfH3kKJcDXCRyEEOq+Gc8SMH3X/tprKT9E6K2TmCSRARKQtjj8oXKaHUd
         TYo51GRuZnjz1+glMIIyuDqTjk21mlVr1e/XrqNXRb9enCG+WmbnogInfRpELN99eeV9
         I0i0rRTJmys/kO0hoHH065GiOHRayWyxDuoJepQsdlhHFUKe3JspNz0EXubRnwK3sirZ
         wsCw==
X-Gm-Message-State: AC+VfDx8mZUknyIOn56x6fpb5Ka3qIezLIm5KRJ7CYSG16aKuGkHm32B
        J7qF2xUePcLdpAhCzAygQtRLCjz6NV4jhQDbrWF+iQ==
X-Google-Smtp-Source: ACHHUZ6BPYVItMkgdWhvpUirb3lFLKqBqD+EymX6++olzpx1b1PIiHZSkWCIXpw2RV7lcSCzuHSa50keIU6Bu306sto=
X-Received: by 2002:a17:902:d4c4:b0:1a6:42f0:e575 with SMTP id
 o4-20020a170902d4c400b001a642f0e575mr16024plg.5.1683153097163; Wed, 03 May
 2023 15:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230427221625.116050-1-opendmb@gmail.com> <CAGETcx-gDcqY7-_Ud0_rOtgvk7NbzevSa4UCV=NcqiV9zjAv7w@mail.gmail.com>
 <CAGETcx_xjNT1Tp0GeqoddFwGFpv3O33hZZpEiThNg1wwWcfEQw@mail.gmail.com> <597ba853-1fe4-9263-c448-422b0c2a91d8@gmail.com>
In-Reply-To: <597ba853-1fe4-9263-c448-422b0c2a91d8@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 May 2023 15:31:00 -0700
Message-ID: <CAGETcx-87Bpy1U5ZUu+2u0LzRTvXBij6fdwWiFPLK98JyQZ_sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] input: gpio-keys - fix pm ordering
To:     Doug Berger <opendmb@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gergo Koteles <soyer@irl.hu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 3:21=E2=80=AFPM Doug Berger <opendmb@gmail.com> wrot=
e:
>
> On 5/2/2023 7:18 PM, Saravana Kannan wrote:
> > On Mon, May 1, 2023 at 1:40=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> >>
> >> On Thu, Apr 27, 2023 at 3:18=E2=80=AFPM Doug Berger <opendmb@gmail.com=
> wrote:
> >>>
> >>> Commit 52cdbdd49853 ("driver core: correct device's shutdown
> >>> order") allowed for proper sequencing of the gpio-keys device
> >>> shutdown callbacks by moving the device to the end of the
> >>> devices_kset list at probe which was delayed by child
> >>> dependencies.
> >>>
> >>> However, commit 722e5f2b1eec ("driver core: Partially revert
> >>> "driver core: correct device's shutdown order"") removed this
> >>> portion of that commit causing a reversion in the gpio-keys
> >>> behavior which can prevent waking from shutdown.
> >>>
> >>> This RFC is an attempt to find a better solution for properly
> >>> creating gpio-keys device links to ensure its suspend/resume and
> >>> shutdown services are invoked before those of its suppliers.
> >>>
> >>> The first patch here is pretty brute force but simple and has
> >>> the advantage that it should be easily backportable to the
> >>> versions where the regression first occurred.
> >>
> >> We really shouldn't be calling device_pm_move_to_tail() in drivers
> >> because device link uses device_pm_move_to_tail() for ordering too.
> >> And it becomes a "race" between device links and when the driver calls
> >> device_pm_move_to_tail() and I'm not sure we'll get the same ordering
> >> every time.
> >>
> >>>
> >>> The second patch is perhaps better in spirit though still a bit
> >>> inelegant, but it can only be backported to versions of the
> >>> kernel that contain the commit in its 'Fixes:' tag. That isn't
> >>> really a valid 'Fixes:' tag since that commit did not cause the
> >>> regression, but it does represent how far the patch could be
> >>> backported.
> >>>
> >>> Both commits shouldn't really exist in the same kernel so the
> >>> third patch reverts the first in an attempt to make that clear
> >>> (though it may be a source of confusion for some).
> >>>
> >>> Hopefully someone with a better understanding of device links
> >>> will see a less intrusive way to automatically capture these
> >>> dependencies for parent device drivers that implement the
> >>> functions of child node devices.
> >>
> >> Can you give a summary of the issue on a real system? I took a look at
> >> the two commits you've referenced above and it's not clear what's
> >> still broken in the 6.3+
> >>
> >> But I'd think that just teaching fw_devlink about some property should
> >> be sufficient. If you are facing a real issue, have you made sure you
> >> have fw_devlink=3Don (this is the default unless you turned it off in
> >> the commandline when it had issues in the past).
> >>
> >
> > I took a closer look at how gpio-keys work and I can see why
> > fw_devlink doesn't pick up the GPIO dependencies. It's because the
> > gpio dependencies are listed under child "key-x" device nodes under
> > the main "gpio-keys" device tree node. fw_devlink doesn't consider
> > dependencies under child nodes as mandatory dependencies of the parent
> > node.
> >
> > The main reason for this was because of how fw_devlink used to work.
> > But I might be able to change fw_devlink to pick this up
> > automatically. I need to think a bit more about this because in some
> > cases, ignoring those dependencies is the right thing to do. Give me a
> > few weeks to think through and experiment with this on my end.
> Thank you for taking a deeper look at gpio-keys, and for getting through
> the gobblety-gook description in my cover-letter ;).
>
> Yes, the dependencies of children are not automatically inherited by
> their parents and it is not clear to me whether or not that should
> change, but it definitely creates a problem for the sequencing of
> gpio-keys device callbacks.
>
> I initially prepared the second patch as a way to explicitly create
> device links specifically for the gpio-keys device from these child
> dependencies as a work around for the fw_devlinks being dropped. I don't
> really consider this a viable patch which is why I made it an RFC, but I
> hoped it would highlight the issue.

Thanks. It definitely made it easier for me to get to the root of the
problem/omission.

> However, the regression actually occurs in v4.18 and fw_devlink isn't
> introduced until v5.7 so it is desirable to think about solutions that
> could be backported to older versions.

For older versions, if they have device link support, I'd recommend
creating device links and letting that take care of it.

Also, if you use the right GPIO APIs, at least on newer kernels Linus
W was looking into creating device links automatically from the GPIO
framework level.

So maybe you can backport some variant of that into the older kernels
and leave it to fw_devlink on the newer ones.

-Saravana

> This is why I provided the first
> patch for discussion. Again, it is not a desirable solution just an
> illustration what could be easily backported to restore the gpio-keys
> behavior prior to commit 722e5f2b1eec ("driver core: Partially revert
> "driver core: correct device's shutdown order"") without affecting other
> devices.
>
> Thanks again for your willingness to take the time to think this through,
>      Doug
>
> >
> > -Saravana
>
