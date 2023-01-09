Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0F662F32
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjAISeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbjAISdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:33:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE292AE67
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:31:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id co23so9141955wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXXAJ3DUbtkoovXuYo+KyTb41EHZPfFvK143Ru7TRh0=;
        b=Y3YgV25OfF4n3rHemKxGZcfAeio40Dp6qtvOjQWf913+9nWH4KqVyHdHIkMkUsAwXG
         93CXGcSSc6sfg5XBZJ59/TRBU/9vyU3+m6ECVJFZliFy4OOw37gA/swtHHzS46FmyYtO
         2kaPopgHHI8DZIFkD2sqHY1FZhHGfgeF5u92IDOtcoCrKiefVUZAgBDI7o2pQOXPJ+Xb
         cqUX0qfSTCRgoGVFyPlYlbRY7FDuwtfqCKa4UCJgkJurzhyAOsCefsf/nt8FXdd5/qqS
         r4jRzTw9IGfuVnNp06Bqd6jb//rWFYDqTkSPfYnfcZDZh8Hbtc1hN3JevPbwvxiTs25I
         2c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXXAJ3DUbtkoovXuYo+KyTb41EHZPfFvK143Ru7TRh0=;
        b=d6C8lf3SC/44FiAdLqtiVc+kcoxuUkddRvr8s4KDtq+ggoWGUn1iYG7sXO//NmhP8c
         LLqSaariP66VAtVPyG6scWIaqRqJdW9BedwygemebOkuTzgu7+q+D6bTyI1v7GuQ2sAC
         uVffB80Olp2mRG92mXmQF+YcSXbkBWIGMWwRwTYkEzBtTybyeWb+BY50GAJbZaDURX1z
         fPvbWmAWwdyRwZO45Mdtn+WWjMXSeIK+gMX3x0TxIaCS95DwTqw4KjfkFGRfms9XAgU7
         M69HWtje9tAvVCH8LKe2UsXuG+ufTl5E2LrWi6GOUmd7OC4kpNILvWKXmWBUjT5VZ8VU
         4sHw==
X-Gm-Message-State: AFqh2krUkIJDjUfeB6Ch88rmd6aqP8a0rjVKJyc2e2GjPG7nuvzO7hZ9
        scybDMbOX4KltHiH3Wj3g+yncZHf6WYfk4IZK5Q=
X-Google-Smtp-Source: AMrXdXscfKc2XlHhJGkSUt354hzYjXoSXX7udzIPMG3m4dLRRzySFvVOTt7lnZdOtk3U1hQBc413+xKD/FpirX0yc24=
X-Received: by 2002:a5d:6451:0:b0:28b:905d:a0b5 with SMTP id
 d17-20020a5d6451000000b0028b905da0b5mr1043980wrw.451.1673289065282; Mon, 09
 Jan 2023 10:31:05 -0800 (PST)
MIME-Version: 1.0
References: <df0096b5aea2a18d1540cde379c5abf589ccd7c4.1669799805.git.mazziesaccount@gmail.com>
 <CGME20230109134646eucas1p17c7fbd379b0301b8429278ff289f2e83@eucas1p1.samsung.com>
 <6c865dd8-b6c3-4491-48ca-df3e3fa45a2d@samsung.com> <0ef85cba-fa9b-6d72-ca44-48c4d6cf2752@linaro.org>
In-Reply-To: <0ef85cba-fa9b-6d72-ca44-48c4d6cf2752@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 9 Jan 2023 20:30:54 +0200
Message-ID: <CANhJrGPbFo=v=G-HbbpHgCkT2fSmFTE43o4OzoVSOK66e5ZLrg@mail.gmail.com>
Subject: Re: [RESEND2,v4,2/2] drm/meson: dw-hdmi: Use devm_regulator_*get_enable*()
To:     neil.armstrong@linaro.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
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

Hi Marek & All,

ma 9. tammik. 2023 klo 17.23 Neil Armstrong
(neil.armstrong@linaro.org) kirjoitti:
>
> On 09/01/2023 14:46, Marek Szyprowski wrote:
> > Hi Matti,
> >
> > On 30.11.2022 10:23, Matti Vaittinen wrote:
> >> Simplify using the devm_regulator_get_enable_optional(). Also drop the
> >> now unused struct member 'hdmi_supply'.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >> ---
> >> v4 resend 2:
> >> Respinning unchanged code with the commit title changed as wa suggested
> >> by Robert Foss and commit message changed as was suggested by Martin.
> >>
> >> I am doing a clean-up for my local git and encountered this one.
> >> Respinning as it seems this one fell through the cracks.
> >> ---
> >>    drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
> >>    1 file changed, 3 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> >> index 5cd2b2ebbbd3..7642f740272b 100644
> >> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> >> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> >> @@ -140,7 +140,6 @@ struct meson_dw_hdmi {
> >>      struct reset_control *hdmitx_apb;
> >>      struct reset_control *hdmitx_ctrl;
> >>      struct reset_control *hdmitx_phy;
> >> -    struct regulator *hdmi_supply;
> >>      u32 irq_stat;
> >>      struct dw_hdmi *hdmi;
> >>      struct drm_bridge *bridge;
> >> @@ -665,11 +664,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
> >>
> >>    }
> >>
> >> -static void meson_disable_regulator(void *data)
> >> -{
> >> -    regulator_disable(data);
> >> -}
> >> -
> >>    static void meson_disable_clk(void *data)
> >>    {
> >>      clk_disable_unprepare(data);
> >> @@ -723,20 +717,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
> >>      meson_dw_hdmi->data = match;
> >>      dw_plat_data = &meson_dw_hdmi->dw_plat_data;
> >>
> >> -    meson_dw_hdmi->hdmi_supply = devm_regulator_get_optional(dev, "hdmi");
> >> -    if (IS_ERR(meson_dw_hdmi->hdmi_supply)) {
> >> -            if (PTR_ERR(meson_dw_hdmi->hdmi_supply) == -EPROBE_DEFER)
> >> -                    return -EPROBE_DEFER;
> >> -            meson_dw_hdmi->hdmi_supply = NULL;
> >> -    } else {
> >> -            ret = regulator_enable(meson_dw_hdmi->hdmi_supply);
> >> -            if (ret)
> >> -                    return ret;
> >> -            ret = devm_add_action_or_reset(dev, meson_disable_regulator,
> >> -                                           meson_dw_hdmi->hdmi_supply);
> >> -            if (ret)
> >> -                    return ret;
> >> -    }
> >> +    ret = devm_regulator_get_enable_optional(dev, "hdmi");
> >> +    if (ret != -ENODEV)
> >
> > The above line should be "if (ret < 0)", otherwise it breaks hdmi support.
> >

Sorry for the trouble and thanks for pointing this out! I believe the
condition I was looking for was
if (ret && ret != -ENODEV).

At least in my eyes the use of regulator_get_optional() sounds like
the -ENODEV should not be treated as an error. The obvious mistake is
regarding return value 0 as such. Thanks for spotting this!

> > I've noticed this once this change has been merged to linux-next and all
> > my Amlogic Meson based boards failed to initialize HDMI. Is it possible
> > to fix this in drm tree or do I need to send the incremental fixup?
>
> Nop, please send an incremental fix and I'll apply it asap.

Thanks for cleaning-up the mess I caused Marek! Please, let me know if
you want me to cook the fix.

Yours,
- -Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
