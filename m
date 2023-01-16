Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020566C232
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjAPO24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjAPO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:28:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FEF22DDD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:11:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c6so30462504pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFQME8/E/AXD3LHu9E0b+WPu1IIOLSjjmuAK8YeSdpg=;
        b=bvZPLM7+cF/F9sx8yRYX9aPkNGTc8JOMB57AcaXXiOFu0VnLqPzIoxKFRfV7YQWJ92
         4zDjUfBZRF5vHF7hhCrEdr35e23XoCC1U/ZhD/CK+XxqyfNjI5RpdFYca7KfjvUhjvZA
         beksWM4OqIc9a86YSq29Zho4JKkHLmJkynWFZj523V/O0FjoXSespYnnBe1dn39str96
         5x4EF5JKhLCg247rdhKD9gC8bybfI5Jbj/elLm15n1RXf/3bm8eP4wOTP9aTMbfxSO/H
         P76o3LR5Pqa+tLo3+61oohx/eeRyZv638+Pvgr63jd6kjpDHK/Ncmm7SCIb+nenO5KkE
         fGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFQME8/E/AXD3LHu9E0b+WPu1IIOLSjjmuAK8YeSdpg=;
        b=mfNpLeobY/q9q/MdgHk9Oas2HooLQHxR8Dx3CUijIGaaBS4BB4B9ho7Uzg/2WrCebV
         wPQnd5+jK3YXu3KzVYiHwyqa8lCy0ey6Pj4jKGdV7lwcdnQWvspucqzw6wUkmLQ2hvuo
         ui2i0ABUe+3ymcGGjargQUQwEBcvMaj8XkR492ECbe0vXIg+iC8oOvPeTCfqrpZm5JOW
         PV8ki8B10eTAFKVJmfxdG1XUvgh8gSVh+Eerlchd6lhi2zwUyR/buJ/uBFVCSH7Xie5k
         sDKIeYng/X2I5ChH3kezX8ofDdKPPukl5jReSFaG1bpFAQxv9Zsbs42KkeUKcYhAiBuf
         PEGQ==
X-Gm-Message-State: AFqh2ko5Y47mlPzO8/R/sqaWzYSZ57VbMcot4YLx6qXTJtt+CECVs5ky
        gqBqNGoOXAqnrzKlc1sdFK2Se2AD79WuNORyCLz6zw==
X-Google-Smtp-Source: AMrXdXtcTeoVOEayHTG2AuWtXfilJDtnVUVtVR52b5vBuzSmZw1kuNmvUwFcTZRRNqTkAFqWJjB1WQepkuB/QqE6e8k=
X-Received: by 2002:a17:90a:7845:b0:229:2074:78e1 with SMTP id
 y5-20020a17090a784500b00229207478e1mr1062973pjl.119.1673878279223; Mon, 16
 Jan 2023 06:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20230106030108.2542081-1-swboyd@chromium.org> <CAPY8ntA=Dq6GFQ3gEOm9PzPyOa9bHTr8JrpXLibnai7xKqRbpQ@mail.gmail.com>
 <CAE-0n53UFuyYvjJUWViXy9Eex2mpBRJGtt4vGc2cbFZS9i8xFw@mail.gmail.com>
In-Reply-To: <CAE-0n53UFuyYvjJUWViXy9Eex2mpBRJGtt4vGc2cbFZS9i8xFw@mail.gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 16 Jan 2023 14:11:02 +0000
Message-ID: <CAPY8ntCcHG2A7LHT-jVa9SzvPggxBP8z-t_3rEy+YY8UVHNL9A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed
 during disable
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@lists.linux.dev, linux-mediatek@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

On Fri, 13 Jan 2023 at 21:12, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Dave Stevenson (2023-01-13 08:27:29)
> > Hi Stephen
> >
> > On Fri, 6 Jan 2023 at 03:01, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > The unprepare sequence has started to fail after moving to panel brid=
ge
> > > code in the msm drm driver (commit 007ac0262b0d ("drm/msm/dsi: switch=
 to
> > > DRM_PANEL_BRIDGE")). You'll see messages like this in the kernel logs=
:
> > >
> > >    panel-boe-tv101wum-nl6 ae94000.dsi.0: failed to set panel off: -22
> > >
> > > This is because boe_panel_enter_sleep_mode() needs an operating DSI l=
ink
> > > to set the panel into sleep mode. Performing those writes in the
> > > unprepare phase of bridge ops is too late, because the link has alrea=
dy
> > > been torn down by the DSI controller in post_disable, i.e. the PHY ha=
s
> > > been disabled, etc. See dsi_mgr_bridge_post_disable() for more detail=
s
> > > on the DSI .
> > >
> > > Split the unprepare function into a disable part and an unprepare par=
t.
> > > For now, just the DSI writes to enter sleep mode are put in the disab=
le
> > > function. This fixes the panel off routine and keeps the panel happy.
> >
> > It is documented that the mipi_dsi_host_ops transfer function should
> > be called with the host in any state [1], so the host driver is
> > failing there.
>
> Thanks for the info! It says "Drivers that need the underlying device to
> be powered to perform these operations will first need to make sure it=E2=
=80=99s
> been properly enabled." Does that mean the panel driver needs to make
> sure the underlying dsi host device is powered? The sentence is too
> ambiguous for me to understand what 'drivers' and 'underlying device'
> are.

The DSI host driver (ie in your case something under
drivers/gpu/drm/msm/dsi) should ensure that a transfer can be made,
regardless of state.

I must say that this has been documented as the case, but doesn't
necessarily reflect reality in a number of drivers.

> >
> > This sounds like the same issue I was addressing in adding the
> > prepare_prev_first flag to drm_panel, and pre_enable_prev_first to
> > drm_bridge via [2].
> > Defining prepare_prev_first for your panel would result in the host
> > pre_enable being called before the panel prepare, and therefore the
> > transfer calls from boe_panel_init_dcs_cmd boe_panel_prepare won't be
> > relying on the DSI host powering up early. It will also call the panel
> > unprepare before the DSI host bridge post_disable is called, and
> > therefore the DSI host will still be powered up and the transfer won't
> > fail.
> >
> > Actually I've just noted the comment at [3]. [2] is that framework fix
> > that means that the magic workaround isn't required, but it will
> > require this panel to opt in to the ordering change.
>
> Cool. Glad that we can clean that up with your series.
>
> Is it wrong to split unprepare to a disable and unprepare phase? I'm not
> super keen on fixing 6.1 stable kernels by opting this driver into the
> ordering change. Splitting the phase into two is small and simple and
> works. I suspect changing the ordering may uncover more bugs, or be a
> larger task. I'd be glad to test that series[2] from you to get rid of
> [3].

Ah, I hadn't realised it was a regression in a released kernel :(

Splitting into a disable and unprepare is totally fine. Normally
disable would normally disable the panel and backlight (probably by
drm_panel before the panel disable call), with unprepare disabling
power and clocks

Do note that AIUI you will be telling the panel to enter sleep mode
whilst video is still being transmitted. That should be safe as the
panel has to still be partially active to handle an exit sleep mode
command, but actually powering hardware down at that point could cause
DSI bus arbitration errors as clock or data lanes could be pulled down
when the host is trying to adopt HS or LP11.

  Dave

> >
> >
> > [1] https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#c.m=
ipi_dsi_host_ops
> > [2] https://patchwork.freedesktop.org/series/100252/
> > [3] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/msm/d=
si/dsi_manager.c#L47
> >
