Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90616147C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKAKfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKAKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:35:02 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969FD10FC1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:35:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h24so8991205qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 03:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2aaGLKKXcT3j30MpIDyxy2HNmeZ1E4qLEn3KEfbdC2E=;
        b=cx3LSgS0miVBOswaIFOKRNQjF55iGsu65SdP4m1PqTNNWLvZImGG1LSc647FTNZHXm
         XW5UnjFDCxXV9N/vKS0vvBbHWfwhkuF7KzoenqHVksvfQPsz2zIXkhQMvGYSKR1RliFR
         nsRPmXVieOb/NjiCwsThAglShVRJEUgLCWbuS6kzwnLpfGRkZbulqKjucdtZfqoZLcWv
         Q08VStTwlCqVNIfnzc3L474VXyH0zZnDP8uWNUOe96HQxLNsMhKZiK9MKfTHc0mPZ149
         i+4gBOo7hJeRBJdTQx4pYYyUIGE3tDqXZvC0sIcX0ge9DztESv7u2THXFilP2CAKNGym
         u5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aaGLKKXcT3j30MpIDyxy2HNmeZ1E4qLEn3KEfbdC2E=;
        b=gOxuWtbx8v62BI/iAMzbS+iNHnZaWF6uoGgaPd4AjXsqMcm3J4/1oXe9CBDrkjePIS
         HR8335XhLVSXdghOKd8rPbPudLW75wB88a4l6LYNCBo1xZl0nqYB64TPU7u/pvCuIBFt
         WYp55ULiG9V8FgMxgp1nKlRSQ92bD2pR66PBaLC7oQD3lR7JanC/6wgVDdK/OOHhx6/u
         4bLjDUnKGqaqo9WIdYSmSKY+T8cwT5oXQyQwd/dZPMBuNUDc4A+iuGOCcAVCVnXmOx/K
         o5p9qq2La32QlfGl72AHnTOhuRVUHiAmh+nGHBMrz2HoPEqE0ckAxU3EER47Nmjqz43X
         qXVg==
X-Gm-Message-State: ACrzQf3IcVi/mnnFKUw8D00EQstrKkGZh3R69k/0KwbD60ZA9DwbkFjZ
        bPx1Jf/z3xplDUSaSH8/ot9KMMtzwjm15o94OfY=
X-Google-Smtp-Source: AMsMyM7UV3u7zRqR6wGPLF4qbbQbM86yDXQPB54lE++xeoWkG/RqZ5CMpMicLcFNZ7JRXuQmB5WeU3DbsGWCzf2nCDo=
X-Received: by 2002:ac8:58cd:0:b0:39c:b865:8c71 with SMTP id
 u13-20020ac858cd000000b0039cb8658c71mr13955440qta.38.1667298899772; Tue, 01
 Nov 2022 03:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221101080006.GA63438@rdm> <alpine.DEB.2.22.394.2211010938240.2834@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2211010938240.2834@hadrien>
From:   jovial umwari <umwarijovial@gmail.com>
Date:   Tue, 1 Nov 2022 13:34:48 +0300
Message-ID: <CAMk1CBNsheLvpw=jvZrbyK3MC1VJjoBNeuoCQsmCutBTat3jmw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] staging: most: dim2: hal: aligning function parameters
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
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

Will do. Thanks

On Tue, 1 Nov 2022 at 11:39, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 1 Nov 2022, UMWARI JOVIAL wrote:
>
> > According to Linux Kernel Coding Style, lines should not end with a '('
> > Fix-issue reported by checkpatch.pl script.
>
> How about something like "To improve readability, start the list of
> function parameters on the same line as the function name.  Issue reported
> by checkpatch."
>
> That would more clearly explain the intent behind the change.
>
> julia
>
>
> >
> > Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> > ---
> >
> > Changes in v2:
> >     1.Resending this patch because it was sent multiple times earlier.No
> >       functional changes.
> >
> >  drivers/staging/most/dim2/hal.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
> > index a5d40b5b138a..6abe3ab2b2cf 100644
> > --- a/drivers/staging/most/dim2/hal.c
> > +++ b/drivers/staging/most/dim2/hal.c
> > @@ -346,9 +346,8 @@ static void dim2_clear_ctram(void)
> >               dim2_clear_ctr(ctr_addr);
> >  }
> >
> > -static void dim2_configure_channel(
> > -     u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address, u16 hw_buffer_size,
> > -     u16 packet_length)
> > +static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address,
> > +                                u16 hw_buffer_size, u16 packet_length)
> >  {
> >       dim2_configure_cdt(ch_addr, dbr_address, hw_buffer_size, packet_length);
> >       dim2_configure_cat(MLB_CAT, ch_addr, type, is_tx ? 1 : 0);
> > --
> > 2.25.1
> >
> >
> >
