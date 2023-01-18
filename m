Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A88671EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjARN5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjARN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:57:18 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF34DCE6;
        Wed, 18 Jan 2023 05:31:05 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id x5so6196328qti.3;
        Wed, 18 Jan 2023 05:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuUEJG05N3nYMvxWxSZgupX5x29WRenTbmClFTcwzSc=;
        b=7yFsvlPr+5qjmUoQKBxOpCu8FMkONZgJesViE2u6+NrJA5jDr7CnMx0u8tQ+GVXQky
         ZjOPbzhbWR5X3x4lHWKDK16FmN16NvZ7zjH2NGVdAnLMcM4E5GQ/Mibqjbt1qgUHimgw
         8VlLVAY7o4S6QyBm2Zr0jn5Qtm0F+uNb8dfCDdiaCWWxsWBR7ldJpKvusbfCtNlAl9Ad
         w7ZqV4HrpCDsTI69xCsFV2HdaXbCql2pvJ2TALtrT6sD9a3d3h4lRrAfuZxaQ74QMlfh
         nb/UM1jiYQoajzKDcnK72bEpZGKN9KOwQnmaBgFzFdier00xO9yYTK7sTRFR03cgKXuK
         sDSA==
X-Gm-Message-State: AFqh2kr5k6b7yByzui+98d/YEX3KM4kbBng7jplA/Nb46OdJSyhkQt1a
        KDKVN/qvQ8nOoW9NmuZw+viUmpOH0mqmyJKe
X-Google-Smtp-Source: AMrXdXvczlAoS+gN4wt826CtzFghAo2rMhUaswqxC+YxMoaAooIrWNHcdRk42cBBmYVV65liEGsxyg==
X-Received: by 2002:a05:622a:1827:b0:3b6:3c95:735a with SMTP id t39-20020a05622a182700b003b63c95735amr9947007qtc.52.1674048664308;
        Wed, 18 Jan 2023 05:31:04 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id y5-20020ac85245000000b003b5bc7a4512sm5126690qtn.26.2023.01.18.05.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:31:03 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id c124so37982111ybb.13;
        Wed, 18 Jan 2023 05:31:03 -0800 (PST)
X-Received: by 2002:a25:d88c:0:b0:77a:b5f3:d0ac with SMTP id
 p134-20020a25d88c000000b0077ab5f3d0acmr731869ybg.202.1674048663439; Wed, 18
 Jan 2023 05:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20230118122003.132905-1-wsa+renesas@sang-engineering.com> <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com>
In-Reply-To: <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jan 2023 14:30:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUegruzCdP_+_qNuhVvFWp-_8zvdYw=v3kmt6zDU8=w5Q@mail.gmail.com>
Message-ID: <CAMuHMdUegruzCdP_+_qNuhVvFWp-_8zvdYw=v3kmt6zDU8=w5Q@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 2:21 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Jan 18, 2023 at 01:20:02PM +0100, Wolfram Sang wrote:
> > The earliest revision of these SoC may hang when underrunning. Later
> > revisions have that fixed. Bail out when we detect a problematic
> > version.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >
> > The BSP tries to work around the issue, yet this is neither upstreamable
> > nor are we sure the solution is complete. Because the early SoC revision
> > is hardly in use, we simply "document" the problem upstream.
>
> The workaround isn't upstreamable as-is, but I think it could be
> upstreamed after being cleaned up.
>
> Overall, how much support do we still have upstream for H3 ES1.x, and do
> we need to keep it ? H3 ES.1x is relatively old, does someone still rely
> on it ?

I think the upstream support level for R-Car H3 ES1.x is about the same
as for H3 ES2.0.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
