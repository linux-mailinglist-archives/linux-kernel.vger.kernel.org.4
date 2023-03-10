Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8C6B5371
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjCJVww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjCJVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:52:30 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D8104AE1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:49:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i10so7035777plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484857;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvqFMoukHnbi8zZDWrIR0Cqy/xe4wY5XQEtCWDlrMbs=;
        b=BeDvODNBbxMyZd3xLBMTn42Ye5wUOBf3+W6xynBoF1HKwlfiXBTl7fR4zm7QJPwoZZ
         cmKJbTnaLgjaJ+aTnMOwAlpxW8myh6xHG8rX7jrFZDBqxQMttj+CdJiJGPkZXVEur2hD
         p+8PLPnJBxxGOEwEYR7rn3WJp3ZeHyNgRwxYLyvLwf3hN0EWNzNxkadxxFrTT5ipenRw
         +nlWqKFSkJGPRuxE5nHF+p7/lADlSDQywvp0zsyZrpft8rlB659wDvzC0oQ07B1882vd
         GL3hHafPSRSsXwgSQricA/HUVKJpRj2NCsAFjzdEkbciO+07L96H1QwIYZKDX7Av1L6k
         Zq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484857;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvqFMoukHnbi8zZDWrIR0Cqy/xe4wY5XQEtCWDlrMbs=;
        b=3xUlWFUtfKtWPn0wh2zZTiLiBNwyyFBp+xeXZBXpJABVlQppgjq8CqGtMMubLRPPlY
         +vVw+XVLwUZRKQG0v/0AZx8yjjTBhZed6HrH26VjCfwQBfzx7cJ8+RnHuDshAVsKs4MH
         6fOR9FGaEOhuau5MCLhl5cp5Aoy4/2KllTwJbFaLhKq0PRzA+9f2TLQNu/2hJEtd3JzE
         zMfPZYpJwcfoILEkTRr75kBUnmsa4JhDW7InK/PEsr4p6Fy+1guJ//xBI2iH3JlY7P0O
         3XRXLRw33QGz7pXVX+5Z4EDnR3wpsqRTtSmNg2t69Z3F9nESzs+IhYY7usqdAKF9m7xY
         73ZA==
X-Gm-Message-State: AO0yUKWdCRlFQV9dQeP7/j1y7LOrTlqq6Bl3Vgb8TvvBEntB6E4RlZsk
        FLVQ87KVG5iolykz4qTt+3/v2KqyGt6Zu668iJ0=
X-Google-Smtp-Source: AK7set81yoZfs27jmZWjD5lcqJFLlosobBO6dGfYY0pTt3rY7iVNSgVyfQifMqMFA2RVvbm4WsF6bw==
X-Received: by 2002:a17:90a:2c2:b0:233:e305:f617 with SMTP id d2-20020a17090a02c200b00233e305f617mr28341289pjd.32.1678484857168;
        Fri, 10 Mar 2023 13:47:37 -0800 (PST)
Received: from CloudiRingWorld ([122.231.69.163])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090ab78f00b002369e16b276sm360893pjr.32.2023.03.10.13.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:47:36 -0800 (PST)
Date:   Sat, 11 Mar 2023 05:47:34 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     julia.lawall@inria.fr
Cc:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750: Rename camel case functions in
 sm750_cursor.*
Message-ID: <ZAuldn536Ci0fcrV@CloudiRingWorld>
Reply-To: alpine.DEB.2.22.394.2303102236190.3199@hadrien
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your advice! Should I change this patch and patch message
and resend it?

On Sat, 11 Mar 2023 at 05:39, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> You don't need the filename in the subject.
>
> On Sat, 11 Mar 2023, Kloudifold wrote:
>
> > This patch fixes the "CHECK: Avoid CamelCase" reported by
> > checkpatch.pl by renaming camel case functions.
> >
> > Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> > ---
> >  drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
> >  drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
> >  2 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
> > index 43e6f52c2..ff643e33f 100644
> > --- a/drivers/staging/sm750fb/sm750_cursor.c
> > +++ b/drivers/staging/sm750fb/sm750_cursor.c
> > @@ -58,13 +58,13 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
> >       poke32(HWC_ADDRESS, 0);
> >  }
> >
> > -void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
> > +void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
> >  {
> >       cursor->w = w;
> >       cursor->h = h;
> >  }
> >
> > -void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
> > +void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
> >  {
> >       u32 reg;
> >
> > @@ -73,7 +73,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
> >       poke32(HWC_LOCATION, reg);
> >  }
> >
> > -void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
> > +void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg)
> >  {
> >       u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
> >               HWC_COLOR_12_2_RGB565_MASK;
> > @@ -82,8 +82,8 @@ void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
> >       poke32(HWC_COLOR_3, 0xffe0);
> >  }
> >
> > -void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
> > -                          const u8 *pcol, const u8 *pmsk)
> > +void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
> > +                           const u8 *pcol, const u8 *pmsk)
>
> The indentation of the second line looks random.  It's not a multiple of
> the tabs, and it doesn't line up with the right side of the (.  So there
> doesn't seem to be any need to change it for this patch.

