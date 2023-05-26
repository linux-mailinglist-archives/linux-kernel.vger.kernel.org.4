Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7B711E54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjEZDLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjEZDK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:10:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF61B1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 20:09:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae851f2a7dso13039545ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 20:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685070593; x=1687662593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+WI7Z+fFUvAEo5FkMRnZUO/pj1xsf6MM2SkfBdHuzY=;
        b=YQdlarf9r1DRtZZVDCUrH7oadI+z+IR3NfI8l2Hd5qSK8BvL4RWUTOklOKDoG5yuPv
         9sw46fzNFZpjgqOZWmiM9zntaenoGIhj7whgVfMS0ucSkOh9GtGFkjaScGK3hrpEKWl9
         sjItsbeFX3l2gVMjTkiR2p6pFIYJs/oHf7qmMQGwkZ0Kn2cUFFJDhzTG4ZAOW0X1NqF+
         Fl2QHNBRJAUK865k0c7wmpsU4FA9DF7srC+nXVwXIp/7cMsuFzvcVeTEl4Svxh+eTKlt
         CCn4/3g2ixlgl1Ylb+g9vBp1KFRSmDWKECS7/2JEWn0o+ywdhI8UeMu798GgmlUwCl+M
         52/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685070593; x=1687662593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+WI7Z+fFUvAEo5FkMRnZUO/pj1xsf6MM2SkfBdHuzY=;
        b=AhiKMVoFY+tJ7bXxTFgVN3Wd8DXN8Y8eZ3Pbds3k1CDP6Ws9q1UWwVbq+C2yohFqTO
         2YNyJ2I+eG101Z7zlv+A4yZYFBOfl45yUqB3+f3l3d6XmGzLX3EFVWPvzlOQEQmBNu6J
         J1o9H/rb58DAn2zKDCyzziDQ9E6a3Ib/jioWsmTHQo0upNtcFfSCgulb4y6VQAH+4I3o
         3G47D8AgFruEANdpCpVSJlmnUno2kmNKikHzQ/VRrX9LiPxTVvi11Qn3bwa3rwwgvgES
         Jp1tWVC3kiuTMS05UnS6QZLHLyKLzYSt6WX2XiveyJF5H7CAH3CpZ8j5mkQXf7IgXdde
         WWOQ==
X-Gm-Message-State: AC+VfDwFkKYi/NNn2pw1PVzgvis55yjPxgDg+kjTF/8xoJeaaAfnao/2
        t0ukeg4317lA4tCz96+FjZIJrKtR/5OPLHHrjmw=
X-Google-Smtp-Source: ACHHUZ4RH3fco+TNyTCnAnqPBsNEzHPi9vD/mqMDrzVwAxoIi3azNCxh0oQRlYGIbWnZr2qVAQnSKuBVjSZDfjg+KOU=
X-Received: by 2002:a17:903:2445:b0:1ae:ce9:f391 with SMTP id
 l5-20020a170903244500b001ae0ce9f391mr4739089pls.4.1685070593342; Thu, 25 May
 2023 20:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230518230626.404068-1-aford173@gmail.com> <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
 <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
 <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com>
 <CAOMZO5Csjx17kfkxN1xMLuCg+-J0v6rjiuvaK-ZktXO50ZTuSw@mail.gmail.com>
 <CAHCN7xL2GWLTwMttCha=b9_W0nE5aimCQ08YJFrCF5vNZUOL7Q@mail.gmail.com>
 <8c65c5c3-0415-78c0-4585-df94a532a04e@linaro.org> <CAHCN7xJBf+8KyXbqxVSUUXbKqomX+i-13Ed23QFeF0SM8nQpzw@mail.gmail.com>
 <8f50dc2c-4d74-6c0f-87bc-b96bbf1373a9@linaro.org> <bef20993-b831-b692-237e-b1e89ac4f34b@linaro.org>
In-Reply-To: <bef20993-b831-b692-237e-b1e89ac4f34b@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 25 May 2023 22:09:40 -0500
Message-ID: <CAHCN7xLizrHuc-Lc=gP=2RpHtV6SwA+5YxeZG4nL6sWa+rywCA@mail.gmail.com>
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     neil.armstrong@linaro.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        dri-devel@lists.freedesktop.org, Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:19=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 25/05/2023 18:15, neil.armstrong@linaro.org wrote:
> > On 25/05/2023 17:57, Adam Ford wrote:
> >> On Thu, May 25, 2023 at 10:39=E2=80=AFAM Neil Armstrong
> >> <neil.armstrong@linaro.org> wrote:
> >>>
> >>> On 24/05/2023 14:49, Adam Ford wrote:
> >>>> On Wed, May 24, 2023 at 7:45=E2=80=AFAM Fabio Estevam <festevam@gmai=
l.com> wrote:
> >>>>>
> >>>>> Hi Adam,
> >>>>>
> >>>>> On Tue, May 23, 2023 at 8:49=E2=80=AFPM Adam Ford <aford173@gmail.c=
om> wrote:
> >>>>>
> >>>>>> Inki,
> >>>>>>
> >>>>>> I haven't heard back from you on whether or not you want the bindi=
ngs
> >>>>>> patch to be included with me resending the series as V7 or if you'=
re
> >>>>>> OK with a single, stand-alone patch.
> >>>>>> Will you let me know?  I have the patch standing by waiting for
> >>>>>> instructions.  If you're not the right person to ask, please let m=
e
> >>>>>> know who the right person is.
> >>>>>
> >>>>> Neil has also been collecting samsung-dsim patches. Maybe he can cl=
arify.
> >>>>
> >>>> If it matters, my preference all along was to do the bindings as a
> >>>> separate thing once the driver updates were merged into the tree.
> >>>> Since the bindings can be done in different ways, I was hoping to ha=
ve
> >>>> a separate discussion on the right way to do the bindings. If they
> >>>> need to be part of the series, I can do that.
> >>>
> >>> If you don't introduce compatibles, no need to send bindings, it can
> >>> be send separately.
> >>
> >> This series doesn't change any compatibility.
> >>
> >>>
> >>> Can I apply this serie and 20230503163313.2640898-2-frieder@fris.de ?=
 seems all has been reviewed.
> >>
> >> Looking at the driver, it looks like linux-next has some newer
> >> features added into the driver since I started, so this series might
> >> need a re-base.  If that's the case, let me know, and I'll do the
> >> re-base.
> >
> > Ok I'll pull the other bits and let you know if this one needs a rebase=
.
>
> Indeed, starting at patch 3 it fails to apply, a rebase on drm-misc-next =
is welcome!

Neil,

I rebased and I added the dt-bindings as an additional patch to the
series.  If people are unhappy with the bindings, I am hoping you can
apply the first 6 since they don't seem to break any backwards
compatibility, and we can discuss the bindings separately if
necessary.

adam

>
> Neil
>
> >
> > Neil
> >
> >>
> >> adam
> >>
> >>>
> >>> Neil
> >>>
> >>>>
> >>>> adam
> >>>
> >
>
