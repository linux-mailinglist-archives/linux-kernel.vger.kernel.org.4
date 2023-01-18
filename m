Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3119C671F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjAROVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjAROUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:20:39 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E995F485B6;
        Wed, 18 Jan 2023 06:03:07 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id q15so6013731qtn.0;
        Wed, 18 Jan 2023 06:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKjCXevW62S/STV+8V15nuVhX39R6Lq27p721ZHl2aw=;
        b=lZcMkFu9EFeTY9KEgGfz991NH1BrPtfath2yp5ZE3JD48ij9U1kGecgpTJxZ/Zbvgc
         MyMV6/n85aOS+bP5vDq9JgnbuJLtPpvmKSZXpq5YVb1IiYiBK1jzEJ08L1xXE/InIV2C
         1M5aNwO3U/q0SFDmvFhcGz5rIfZJuwfW1KhyKCOhlT7k0a0ga1Q9IBKRdO5caABSxUiO
         0AsGZVWRWE9973iRTJowbRbjY+oV8W4BeRjwOIb5QOkDmvo4pKcoTbegM+JCmNwxJSlq
         Y/EsUkD9hWMHTbBe+vEu+1HoOGPHYfPwCK6jCLXAaQpJYlLSfZI+UnSMibsAi8vwEqkY
         rNhA==
X-Gm-Message-State: AFqh2kqP8FC4w9idrXToQyGS/QJ7D0XUahTpcsbLMkZRX8k7kBGDFPwB
        I4E6lrhi44gUCbpiPoUIesS+9Z2q8FXg+GJD
X-Google-Smtp-Source: AMrXdXt4K0LpIFu00zVdb33y8xLd/D/WNmA1tBSGwBbl9L3zTTAxHUvzKm30u6UPzx80R/WfuMZ9Hg==
X-Received: by 2002:ac8:709a:0:b0:3a4:f209:84cd with SMTP id y26-20020ac8709a000000b003a4f20984cdmr9340806qto.9.1674050586840;
        Wed, 18 Jan 2023 06:03:06 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id fv13-20020a05622a4a0d00b003ae189c7454sm13547466qtb.91.2023.01.18.06.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:03:06 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-4f7b55575f7so5731867b3.11;
        Wed, 18 Jan 2023 06:03:06 -0800 (PST)
X-Received: by 2002:a0d:cbd7:0:b0:46f:bd6:957d with SMTP id
 n206-20020a0dcbd7000000b0046f0bd6957dmr709206ywd.383.1674050585830; Wed, 18
 Jan 2023 06:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20230118122003.132905-1-wsa+renesas@sang-engineering.com>
 <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com> <CAMuHMdUegruzCdP_+_qNuhVvFWp-_8zvdYw=v3kmt6zDU8=w5Q@mail.gmail.com>
 <Y8f2elExwiwxK2n+@pendragon.ideasonboard.com>
In-Reply-To: <Y8f2elExwiwxK2n+@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jan 2023 15:02:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYsCN+evJB8idRFQ-v2B4bJ6vi+DSF=Zg6+QSiu+Op5Q@mail.gmail.com>
Message-ID: <CAMuHMdXYsCN+evJB8idRFQ-v2B4bJ6vi+DSF=Zg6+QSiu+Op5Q@mail.gmail.com>
Subject: Re: [PATCH] media: renesas: vsp1: blacklist r8a7795 ES1.*
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Jan 18, 2023 at 2:39 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Jan 18, 2023 at 02:30:51PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Jan 18, 2023 at 2:21 PM Laurent Pinchart wrote:
> > > On Wed, Jan 18, 2023 at 01:20:02PM +0100, Wolfram Sang wrote:
> > > > The earliest revision of these SoC may hang when underrunning. Later
> > > > revisions have that fixed. Bail out when we detect a problematic
> > > > version.
> > > >
> > > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > > ---
> > > >
> > > > The BSP tries to work around the issue, yet this is neither upstreamable
> > > > nor are we sure the solution is complete. Because the early SoC revision
> > > > is hardly in use, we simply "document" the problem upstream.
> > >
> > > The workaround isn't upstreamable as-is, but I think it could be
> > > upstreamed after being cleaned up.
> > >
> > > Overall, how much support do we still have upstream for H3 ES1.x, and do
> > > we need to keep it ? H3 ES.1x is relatively old, does someone still rely
> > > on it ?
> >
> > I think the upstream support level for R-Car H3 ES1.x is about the same
> > as for H3 ES2.0.
>
> Question is, do we need to keep it ? :-) And if we do, instead of
> black-listing devices in the VSP driver, how about dropping them from
> r8a77950.dtsi ?

I prefer blacklisting in the driver, as dropping them from r8a77950.dtsi
wouldn't disable them when used with an older or out-of-tree DTB.

>  We already delete quite a lot of devices there.

... because they don't exist on H3 ES1.x.

> Note that without VSP support, you will get no display either, so the
> DU device (and the LVDS encoder) so also be deleted.

True...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
