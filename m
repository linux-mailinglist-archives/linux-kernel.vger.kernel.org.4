Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BA86A8871
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCBSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCBSUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:20:08 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9256457CF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:20:05 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5384ff97993so443279387b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 10:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZAPXM0LrNiqSTWbCG2CR8IPVb5EwH+3MFjYQTbFfCc=;
        b=TI8oAEznTj0VbOLCat1DPNqMU06vdate7f6rAjVdP5wpmvMipvaE7Y+c4QzmwWSIXM
         lAaN4vVSZ7VQi2YHztan6+crDPP0eLCnNq/7pjcQ+HxaMlq3epLNaIsGS/s0pBjuUNc8
         HoBc9LdjkUHbEN6yCc87Hl6kAkNUlBPeq8S3QBTZZlzPjq7jCZuANxpZQWdVMCjHOhON
         lYNbySLjyjujXc1zizmCIW+lexghQWo6DM8gquFowDffkmpE1THRLdvmk4sx9E1VSvEp
         AD3Lj5P3sxY4EaM3IKTF03UwF+Q9iwroahk/JpaLH86fM9TNvfDEx5cb6nQXY59CyW8t
         Er1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZAPXM0LrNiqSTWbCG2CR8IPVb5EwH+3MFjYQTbFfCc=;
        b=QCSA/rjdxGiRSi4tR5uLcRf27+BoJyml3M5XMkXlnK1iIyF92tvol2aY0TPMFTrJ2v
         PK+n5wVN/mFXrI9vaISqJLzLrnkRUgHruAyKcwiJ00HltoAkiMLO8AQK9olb/YYTC3VD
         PEni4TlvF8OP576to/xUoMQrqC9iDPrJqH83cAlr3IJZy4MdtWIqhIH9aWRxJIctDOo3
         KO83dKciFj96HL86bbQKtVAgRpnZ4AFM6jAfPdnoUUTf0pIng7j9X5zduatkSCitHViC
         D9LgaOxuhg4qJXokvhxrr66sBbkEH0Yzr2PaS/KAIh7cOqLnT3SoYrbTGzDvVpWi/9/A
         IAGA==
X-Gm-Message-State: AO0yUKVIp/QfeZz2kfh9/vjd9a+TRue/5A3x7cgw8XTgrU0LgHiqQn6K
        r4DCsostBfh/spjRBnXgxxmFDzXBfMVy+tRSbnC98g==
X-Google-Smtp-Source: AK7set8MuWxgyggg2x5O2vzdSY/MWzzPRlU35FhPBPzcMfaqX0BnsN2Uz7YPLspM/KtBSWLbypAoRUS5my77kUFM1R4=
X-Received: by 2002:a0d:d946:0:b0:52e:c5f1:a0d4 with SMTP id
 b67-20020a0dd946000000b0052ec5f1a0d4mr1859997ywe.4.1677781204806; Thu, 02 Mar
 2023 10:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20230131141756.RFT.v2.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
 <CAPY8ntAUhVB6UtQTeHAcxNW950Ou+NcEoGwk3JnVWLay89_0Nw@mail.gmail.com>
 <CAD=FV=UNx7ivymvpGKcuyvvepvo-T2B2aREJy2GyawTHCnazsw@mail.gmail.com>
 <e077d60d-5881-1ccc-a17a-fbe64392e29d@linaro.org> <CAD=FV=W_FVUOD6T0Lx-JTqrqaP9gPgb4R-2TaSqKwkaBkqHJmQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W_FVUOD6T0Lx-JTqrqaP9gPgb4R-2TaSqKwkaBkqHJmQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Mar 2023 20:19:54 +0200
Message-ID: <CAA8EJpq-gHjtNzDya-50K3mz5Odhgfd=cSKYfNReSnoRf5reTQ@mail.gmail.com>
Subject: Re: [RFT PATCH v2 1/3] drm/bridge: tc358762: Set pre_enable_prev_first
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 at 19:26, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Feb 27, 2023 at 5:24=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 28/02/2023 02:26, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Wed, Feb 1, 2023 at 1:51=E2=80=AFAM Dave Stevenson
> > > <dave.stevenson@raspberrypi.com> wrote:
> > >>
> > >> On Tue, 31 Jan 2023 at 22:22, Douglas Anderson <dianders@chromium.or=
g> wrote:
> > >>>
> > >>> Set the "pre_enable_prev_first" as provided by commit 4fb912e5e190
> > >>> ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init
> > >>> order"). This should allow us to revert commit ec7981e6c614
> > >>> ("drm/msm/dsi: don't powerup at modeset time for parade-ps8640") an=
d
> > >>> commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> > >>> time").
> > >>
> > >> I see no reference in the TC358762 datasheet to requiring the DSI
> > >> interface to be in any particular state.
> > >> However, setting this flag does mean that the DSI host doesn't need =
to
> > >> power up and down for each host_transfer request from
> > >> tc358762_pre_enable/tc358762_init, so on that basis I'm good with it=
.
> > >>
> > >> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >>
> > >>> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >>> ---
> > >>>
> > >>> (no changes since v1)
> > >>>
> > >>>   drivers/gpu/drm/bridge/tc358762.c | 1 +
> > >>>   1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/br=
idge/tc358762.c
> > >>> index 0b6a28436885..77f7f7f54757 100644
> > >>> --- a/drivers/gpu/drm/bridge/tc358762.c
> > >>> +++ b/drivers/gpu/drm/bridge/tc358762.c
> > >>> @@ -229,6 +229,7 @@ static int tc358762_probe(struct mipi_dsi_devic=
e *dsi)
> > >>>          ctx->bridge.funcs =3D &tc358762_bridge_funcs;
> > >>>          ctx->bridge.type =3D DRM_MODE_CONNECTOR_DPI;
> > >>>          ctx->bridge.of_node =3D dev->of_node;
> > >>> +       ctx->bridge.pre_enable_prev_first =3D true;
> > >>>
> > >>>          drm_bridge_add(&ctx->bridge);
> > >
> > > Abhinav asked what the plan was for landing this [1]. Since this isn'=
t
> > > urgent, I guess the plan is to land patch #1 in drm-misc-next. Then w=
e
> > > sit and wait until it percolates into mainline and, once it does, the=
n
> > > patch #2 and #3 can land.
> > >
> > > Since I have Dave's review I can commit this to drm-misc-next myself.
> > > My plan will be to wait until Thursday or Friday of this week (to giv=
e
> > > people a bit of time to object) and then land patch #1. Then I'll
> > > snooze things for a while and poke Abhinav and Dmitry to land patch #=
2
> > > / #3 when I notice it in mainline. If, at any point, someone comes ou=
t
> > > of the woodwork and yells that this is breaking them then, worst case=
,
> > > we can revert.
> >
> > This plan sounds good to me.
>
> Pushed to drm-misc-next:
>
> 55cac10739d5 drm/bridge: tc358762: Set pre_enable_prev_first
>
> If my math is right then I'd expect that to get into mainline for
> 6.4-rc1. I guess that means it'll be in Linus's tree mid-May. I'll
> schedule a reminder to suggest landing at patches #2 and #3 again in
> late May.

It might be earlier, if msm-next merges drm-misc earlier (e.g. for the
PSR patches).

--=20
With best wishes
Dmitry
