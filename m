Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4E64D98F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLOK33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLOK3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:29:18 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536AD2C107
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:29:17 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-144bd860fdbso20433807fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oXw7NIVPJMG8+PM6AqoYuOzdnbApW+aYda86CP39V/M=;
        b=pbR+AoUW7XkzVI6hslj50b+8n6ZYADDBFfvCJcr09vYPd6isxF1bPgdBNd9uc1FmhK
         yzh2Ox2m4cLaLOFJPVq/Rozw6gnxCxyAfPg9kIgETBr7+4hrzG0vr0km0TO/4wdQmJOD
         Qh48Lwudg/JBlCNnTDep5CCPrNMaXeRP5pnMw7UMThzd2UkV1E6+mh7RnAJFQ61g1Avx
         8wmJu61Tc4A7zqnh2TnV5XslS0hMgZJhbYe8e+U0Ami6cqP+YtRvn2CeIlfjvZF0vADi
         5MprXybHopawd9lKWPNJcXUtICWmB948C2lEITpWgnwI4UBy2huybTVbD4OVcSuHDkpU
         B/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXw7NIVPJMG8+PM6AqoYuOzdnbApW+aYda86CP39V/M=;
        b=NVm/ESpLvOK0EW8US/d5VR0jNlSkjaFHXPo/p8J3FrsxbxMk6VEziHNfizLNXZVHNk
         rPKGIoH/TBt31NUfJm221uakRY/wP6rhNVoeWY51MlACIMZSDYMtOAHjwK3bkiic80ma
         7SsySfVEltQa2hojSHYsIhhuSU4Fw+S6APbR0KCHzHxCo+jCddF/oNA6Od+FcoQbdoKB
         NSWE6W2ydeGRovqY98RV2oZTwt7Fe57CGXLFaNtCyhyFMpCo8db3DolYpRkGnuE95tDg
         xXyOTrS9DdMAPuFtwVYu0yFJsu2mFlzyT5nvwag5F9ZuB7DWM3cBUU76d6dn0U9EC4Ko
         O8lA==
X-Gm-Message-State: AFqh2kpPDP6/dq9Bp3xs+ZoIQ3dYKoJHXlWnOuPBGX3yo4/V/RNWYWOX
        0Ai7ljbOHqb+bJF1rkQq7DAwopbM9E2AZX9tsfYBlA==
X-Google-Smtp-Source: AA0mqf48x0Ly0lTHVC6+zanhcKAfhc9CQQ27Yszl1vpQXNwpDj4LShgOnGxn/oMFV65gE+GYqDp1jb5049WikZUWkXI=
X-Received: by 2002:a05:6870:2393:b0:144:b04d:1669 with SMTP id
 e19-20020a056870239300b00144b04d1669mr170374oap.155.1671100155842; Thu, 15
 Dec 2022 02:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20221115112720.911158-1-treapking@chromium.org>
 <167103665890.995711.9267085599513513874.b4-ty@linaro.org> <CAEXTbpfgCVWNE=ao5=d8_Bo1YHmfb7e08aeMCaz38Tvt0jAcTw@mail.gmail.com>
In-Reply-To: <CAEXTbpfgCVWNE=ao5=d8_Bo1YHmfb7e08aeMCaz38Tvt0jAcTw@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Dec 2022 11:29:05 +0100
Message-ID: <CAG3jFysB_nWvJ7pqJj_jRNvncK58Rw=kHgdWu=ek7msHGi4E2w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: Add caching for EDID
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        allen chen <allen.chen@ite.com.tw>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 at 09:36, Pin-yen Lin <treapking@chromium.org> wrote:
>
> Hi Robert,
>
> Thanks for the review.
>
> I didn't see this patch on drm-misc-next, but my another patch merged
> instead: https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5eb9a4314053bda7642643f70f49a2b415920812
>
> Did something go wrong? Or is it me missing something?

This is my mistake. I'm switching to a 'b4 ty' based workflow, and the
wrong thank you message got sent out.

Let me have a look at this patch too.

>
> Regards,
> Pin-yen
>
> On Thu, Dec 15, 2022 at 12:51 AM Robert Foss <robert.foss@linaro.org> wrote:
> >
> > On Tue, 15 Nov 2022 19:27:20 +0800, Pin-yen Lin wrote:
> > > Add caching when EDID is read, and invalidate the cache until the
> > > bridge detects HPD low or sink count changes on HPD_IRQ.
> > >
> > > It takes 1.2s for IT6505 bridge to read a 3-block EDID, and skipping
> > > one EDID read would be a notable difference on user experience.
> > >
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > Repo: https://cgit.freedesktop.org/drm/drm-misc/
> >
> >
> > [1/1] drm/bridge: it6505: Add caching for EDID
> >       (no commit info)
> >
> >
> >
> > rob
> >
