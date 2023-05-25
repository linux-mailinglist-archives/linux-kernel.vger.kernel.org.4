Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F31711028
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbjEYP56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjEYP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:57:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56DCC
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:57:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso2623363b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030276; x=1687622276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRjbJCM4Bj74nexhlReHUV30/iPPE3wUZ1F4retby8I=;
        b=gA4nf4yE2oHcpLPG55DTtVk+Y/9CF0daz/KwHlax1WiOIRzWOkUfQe7Ma7FQsqQ7Iy
         vYsMo0UBYGTfuGq291YU/rgalQ7J8Mf2Ke45yLjRHiexvqzG5+3HoWJFAH7C0+0E8Cfl
         apoVH6RIsz2gT6XTIPaHv86tJlO62bkMIhzBI/XqK370wWDTpagGejMptXIBXv6jSuMR
         frs34sVL9FYOpfNVhomgOS05pAnmAUqyZp7bZUUQAsjCSePdw0Ur98DQJAvpTX9aZaT9
         s7lRCaYjbayOxWrgu4ULz6Ub3DFmHXmu9/BjBhwaB3Wd8NSuh4j5jnZg/KAXF3K1oPi1
         SiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030276; x=1687622276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRjbJCM4Bj74nexhlReHUV30/iPPE3wUZ1F4retby8I=;
        b=cDaJZr3M8HV9J7SY1ypHJVcnLI4x2YQzCM7NtouNCQp1PDyg4zLog7NEcmj5v5aPDk
         p6Nyvtab5gDfMUAjIseSvWzzRZEBgPkOzkEPqq85doPQo8dQjiko4ygdC6r9FBJMm2D5
         vGe8Sp7N7rOFO/8ZP4t++Y8QsK5TyJG+emmz3mviJHTIaY2mLMXz6Al33CvfB/GTLYoy
         TUtUQnCe7d2wDUIl2BdCYpVFatOyqbblA9u2p/5Ihr3oh6vqOVoGTWETL8lkSYE54vSF
         F5Ks1UclxggepfAEpFGj2DsWesNV8KJ+eyT7wDSFUt3j4qVyPFHpKGBoNKVO0hP15ERJ
         Gj0Q==
X-Gm-Message-State: AC+VfDyEDWeott7lYLM4uoW7Bei1TVoY1/mEsiUCMIbxiFABYGk7c4nH
        u2dxf7VpscuMdVX/QEHT+1w4c87pVr9iLdUn4w0=
X-Google-Smtp-Source: ACHHUZ5w5Mg4M6wIDvC98hKt+3Drl/mfQnNGc32bmmOnnc9YXW/slwv2zt0FgYB659YyDJIKT4oy2vmbx6km3wv3Q5A=
X-Received: by 2002:a05:6a20:4289:b0:10d:d0cd:c1c7 with SMTP id
 o9-20020a056a20428900b0010dd0cdc1c7mr6832286pzj.15.1685030275580; Thu, 25 May
 2023 08:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230518230626.404068-1-aford173@gmail.com> <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
 <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
 <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com>
 <CAOMZO5Csjx17kfkxN1xMLuCg+-J0v6rjiuvaK-ZktXO50ZTuSw@mail.gmail.com>
 <CAHCN7xL2GWLTwMttCha=b9_W0nE5aimCQ08YJFrCF5vNZUOL7Q@mail.gmail.com> <8c65c5c3-0415-78c0-4585-df94a532a04e@linaro.org>
In-Reply-To: <8c65c5c3-0415-78c0-4585-df94a532a04e@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 25 May 2023 10:57:44 -0500
Message-ID: <CAHCN7xJBf+8KyXbqxVSUUXbKqomX+i-13Ed23QFeF0SM8nQpzw@mail.gmail.com>
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

On Thu, May 25, 2023 at 10:39=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 24/05/2023 14:49, Adam Ford wrote:
> > On Wed, May 24, 2023 at 7:45=E2=80=AFAM Fabio Estevam <festevam@gmail.c=
om> wrote:
> >>
> >> Hi Adam,
> >>
> >> On Tue, May 23, 2023 at 8:49=E2=80=AFPM Adam Ford <aford173@gmail.com>=
 wrote:
> >>
> >>> Inki,
> >>>
> >>> I haven't heard back from you on whether or not you want the bindings
> >>> patch to be included with me resending the series as V7 or if you're
> >>> OK with a single, stand-alone patch.
> >>> Will you let me know?  I have the patch standing by waiting for
> >>> instructions.  If you're not the right person to ask, please let me
> >>> know who the right person is.
> >>
> >> Neil has also been collecting samsung-dsim patches. Maybe he can clari=
fy.
> >
> > If it matters, my preference all along was to do the bindings as a
> > separate thing once the driver updates were merged into the tree.
> > Since the bindings can be done in different ways, I was hoping to have
> > a separate discussion on the right way to do the bindings. If they
> > need to be part of the series, I can do that.
>
> If you don't introduce compatibles, no need to send bindings, it can
> be send separately.

This series doesn't change any compatibility.

>
> Can I apply this serie and 20230503163313.2640898-2-frieder@fris.de ? see=
ms all has been reviewed.

Looking at the driver, it looks like linux-next has some newer
features added into the driver since I started, so this series might
need a re-base.  If that's the case, let me know, and I'll do the
re-base.

adam

>
> Neil
>
> >
> > adam
>
