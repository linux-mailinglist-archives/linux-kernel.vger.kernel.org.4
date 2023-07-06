Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E794674A704
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjGFWYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjGFWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:24:11 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68A26A3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:22:09 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso1439618276.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 15:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688682126; x=1691274126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3ZnLWYda5s0Z078Xc8xlFfay4f1nZm55XtpErGsqnI=;
        b=J0xYFGJIHP1aeu1ek9eG6XIflCT3/NG5yzgBPxYBMizXOBO6SzfvC8tP6I15LvmIyd
         0/diWULwbjQ+pfs84WKRci9q6gNUy690OJ5bQxf9A0iUP86G1a2NW6Rsh335QFw4SHrg
         QeEZg3tfQ6RrkGkLW40v5FL8L8RPmgAomh9KQTHghpFGgAi1wSA7vnm65RByZrKHjuyA
         Mu41CqWfjXSP5Z3ymsrnEDQw2bdhsL4P+0d1m2aGKX6s2dl5EgV73G3hSw+1i67ecDDu
         mqEASUR4Sgg+gZMDouNoM1kRp4yLc4SJlTNYZHiQGwzBBWmekZfuUGwqEFnXUwROF7U7
         od0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682126; x=1691274126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3ZnLWYda5s0Z078Xc8xlFfay4f1nZm55XtpErGsqnI=;
        b=DjlYayL+OgtaPZLW5m8QmgYBr0XYGIkNQjk4Ffwl0NiP1ehb/llpnYfuBkzchbr4BQ
         DQmrVL5zpvUjyBzwASsOSdOWrrPcpsmrQOf9Lv0rJlsX5tuvc4/ZF+hunyMAHEB3haa/
         24n6zAzym+tBbhDL/uJO3xFBJHLNn5PVuYtpC3F88ehD1N5mUxdUxKmVhJedW/5HYd5F
         cx4OvY0FPM27xkeJVcTTOKQp77HR5ZRANmKHdbzgGFNHMBiy3TZN+Ctx9MkSW/eu0W90
         8nBm41YLDq5Kb2B7Eds4NtEfg58VKOA0PT53RhUhwginAnXJV018Baa10DeqGw7up/qH
         6jeA==
X-Gm-Message-State: ABy/qLaijADZiktWs0d996jVYzIso2sYWmanbOxLs5ZJr9Pqw/DuwU2u
        KkIOI3uGdvybsy+Y8FGZ2ZRCGDixdUoTW6P9g5g1sgowWH7FE2NR//o=
X-Google-Smtp-Source: APBJJlHrD0uZZQ/A/cUft82Lh9JCBJX/moY+JJATbzzD92duMgZi6yTWphFsvwNzjoMvOd6ujc0JNbgYNkCWWuDeuO4=
X-Received: by 2002:a25:9cc6:0:b0:bfe:d93a:8f2b with SMTP id
 z6-20020a259cc6000000b00bfed93a8f2bmr4069609ybo.60.1688682126451; Thu, 06 Jul
 2023 15:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <1adda828-cf35-fb2c-6db5-f9ca91b5b62a@linaro.org>
 <20230525093151.2338370-1-yangcong5@huaqin.corp-partner.google.com>
 <20230525093151.2338370-5-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=W_Vw=WTuap60PtzU8Jc58T1PsEhJfY96NmFFgmC1DB9w@mail.gmail.com>
 <CACRpkdZkNio99zS+ttEXncOtS1TcYbfunKSKddErRDV1gTY43w@mail.gmail.com>
 <CAD=FV=Xx_Bf=Fr1aCmmcjXAv1CyMYwEFba7C6k_HRE1VPtTtHQ@mail.gmail.com>
 <CACRpkdYif_h38TYDuSjY-0WkWNknFOe8n2Xe7zBydKxySrdZHA@mail.gmail.com> <CAD=FV=WNgAr=YaMu9+KSxZSHpG9Z31Pbka1N3E-OYR1-WKHiaQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WNgAr=YaMu9+KSxZSHpG9Z31Pbka1N3E-OYR1-WKHiaQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jul 2023 00:21:55 +0200
Message-ID: <CACRpkdZLgf15Ao6CPym6q2yC17XcA3kjtDCQ3F2-aa-XwZJ=xg@mail.gmail.com>
Subject: Re: [v4 4/4] drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel
To:     Doug Anderson <dianders@google.com>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        neil.armstrong@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hsinyi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 11:58=E2=80=AFPM Doug Anderson <dianders@google.com>=
 wrote:

> > So the Ilitek ILI9882t is an obvious break-out.
>
> I guess. To me it feels like the concept of breaking the driver into
> multiple sub-drivers and the idea of supporting ILI9882t more cleanly
> are orthogonal. You could still do your patch #4 and break out the
> page switching function without breaking up the driver.

Yeah that's true. But with Ilitek in particular we have these nice
precedents:
drivers/gpu/drm/panel/panel-ilitek-ili9322.c
drivers/gpu/drm/panel/panel-ilitek-ili9341.c
drivers/gpu/drm/panel/panel-ilitek-ili9881c.c

So it looks disorganized to me if this one Ilitek panel controller
now goes inside another driver with other completely unrelated
drivers.

> It feels to me fairly likely that many of the panels here are just as
> different from each other as the ILI9882t is from them. I guess it's
> not a dozen, but it feels like using the same "how different are they
> from each other" metric we'd end up with at least 5-6 new drivers. It
> seems clear to me that the panel that Sam first commented on is as
> different from the others in the BOE driver as the ILI9882t is.
> Certainly it has a pretty darn big unique command sequence for init...

It doesn't really matter until we can say certainly what display controller
each of them is. It seems we can't, but for this one we can.

> The problem is that it's hard for me to make a strong argument here
> when there is prior art of panels being supported with blob-sequences.
> In this case, I think you as an upstream developer have more leverage.
> I can help put pressure to make sure that upstream concerns are
> addressed, but I think it's on upstream to put their foot down and say
> that these blob sequences are not OK for new panels. In each case I
> landed a patch with a new blob sequence I tried to give the community
> time to respond and I tried to telegraph what I was going to do to
> make sure nobody was surprised...

I would say it is not fair to block driver coming from hobbyists or minor
vendors just trying to make something work. In general I think a working
something is better than nothing so I wouldn't block anything.

But with big companies who actually talk to Ilitek, Novotek and the other
companies ending with -tek that make these display controllers I would
certainly like to send the message that datasheets and proper
defines would be appreciated, and say it is also for their best, because
I mentioned proper gamma correction is possible if the driver author
just invest time and works with the DRM community and that should
be in their best interest. Feel free to pass this along the supply
chain if you can.

Yours,
Linus Walleij
