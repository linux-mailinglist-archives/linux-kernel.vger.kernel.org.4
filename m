Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F341612512
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJ2TUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 15:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2TUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 15:20:18 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EE17073
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:20:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f8so5470874qkg.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ocad5Lyn4uK3eb0Jbqif1DyUr96QuBMXxRW/XZWVONg=;
        b=eLcgPvkbsZCIugUEN6JCQApxMpeesd275Gd3cm6ZDMKz8hB6T25unXbNeXNAxgKQMi
         +6prrzgGntBeIYxT8qku1nHEM56mDz8/zydIoIZvQVYMyc7URidEcE34R1hXUtV1luH1
         KSj/fAfh+mOl6pD5dvuZdoS8KdOxv0fXUHBzmDw48gDW6yAr0FbQOtiEP9aod+b/VRpW
         1bn1A26TYWDidk0Kr9Phf23gq4LLE9AFsCPqlNCBpQYymoab8VhY0XL6Iop1I8jOZBGX
         hJmdWARMGuK9+zpt0q0jRbr4fKAYvpTEtAH11L7EGvEIHsxK0a66lecX3TI0yX9rRqqw
         DV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ocad5Lyn4uK3eb0Jbqif1DyUr96QuBMXxRW/XZWVONg=;
        b=hF8cTtPFUWRE3L4WH9HOA3HrbiBGxim8v97yRPkGV756PGUVqGKfVRuLVps1z/Cduf
         BY6Di0aGrgEBCEoUfeTXJN/ADpgnwqmVeo4SsnmReIoV3pF2UHNCWX1rCcxPTNa04d79
         rkq7bLNoSg7XJQNNeKc6sEwS2MgixbSu+SCqPjyN34TuH/Hm/mryNsonFMtCzaQeCdTE
         rMeMHGuuR4Xm0l+DAb0j0vwhnFFpUNrQeeXgrdyskjeo/7sA2qeps2qe5C3NskLlP85r
         NbFLrsKKxEsJ0M6BBMrvyNQHpoRQTeOxuqjLmUpkNqcWbbLkJsF7HhDe9davOzZIdDyl
         LkCw==
X-Gm-Message-State: ACrzQf0jEiiO4XSb2wtxIuPWfxbx3JybbItRh2VfhVwLRct2gEvHXPBs
        JKA9+tVH/69m3HwhFrmGOFiQ3udHGDVUWFQ7dz4=
X-Google-Smtp-Source: AMsMyM6YiDnaCDgAP3YJhi3SJh8doxy8CED/mBDBW3aRSPNcXX0vueSApKw7JIFU8GbroF4xMdCkqhy3DjxfcrfJD2s=
X-Received: by 2002:a05:620a:22c3:b0:6ec:53bb:d296 with SMTP id
 o3-20020a05620a22c300b006ec53bbd296mr3959351qki.158.1667071216182; Sat, 29
 Oct 2022 12:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666995639.git.tanjubrunostar0@gmail.com>
 <0e6a307052d3a354a850a502e509f46baccdbe1e.1666995639.git.tanjubrunostar0@gmail.com>
 <Y1za5Gzr/uXsPF3N@kroah.com>
In-Reply-To: <Y1za5Gzr/uXsPF3N@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 29 Oct 2022 20:20:04 +0100
Message-ID: <CAHJEyKUdL2v4mGLcY-DnJEpzv0CH+hQmd7B=2DWeUak3DJQ6vA@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] staging: vt6655: split long code lines in s_uGetRTSCTSDuration
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 28, 2022 at 11:23:23PM +0000, Tanjuate Brunostar wrote:
> > Increase code visibility by splitting long lines of code in the
> > function: s_uGetRTSCTSDuration
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 108 ++++++++++++++++++++++++----------
> >  1 file changed, 76 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 7eb7c6eb5cf0..8e56a7ee8035 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -186,20 +186,29 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
> >
> >       data_time = bb_get_frame_time(priv->preamble_type, pkt_type, frame_length, current_rate);
> >       if (rts_rsvtype == 0) { /* RTSTxRrvTime_bb */
> > -             rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
> > -             ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
> > +             rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20,
> > +                                          priv->byTopCCKBasicRate);
> > +             ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
> > +                                          priv->byTopCCKBasicRate);
>
> While I understand the feeling of "let's fix this warning by wrapping
> the line!" type of solution, overall, it's NOT the correct thing to do.
>
> Remember, coding style changes are to be done to make code easier to
> read and understand, not harder.  The original code here is easier to
> read, and you made it harder to understand.
>
> The "best" solution for this will be to fix up the line length by virtue
> of fixing up the incorrect variable names.  Here is the original lines:
>
>                 rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
>                 ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
>
> but if you were to fix up just 1 function and one variable name, look at
> what happens and checkpatch is happy with it:
>
>                 rts_time = get_frame_time(priv->preamble_type, pkt_type, 20, priv->top_basic_rate);
>                 ack_time = get_frame_time(priv->preamble_type, pkt_type, 14, priv->top_basic_rate);
>
> Or even better:
>                 type = priv->preamble_type;
>                 rate = priv->top_basic_rate;
>                 rts_time = get_frame_time(type, pkt_type, 20, rate);
>                 ack_time = get_frame_time(type, pkt_type, 14, rate);
>
> Look, no line-wrapping and isn't that easier to understand?  The second
> version here might even produce smaller compiled code overall, making it
> a even better solution.
>
> So step back, revisit this whole series with the goal of overall making
> the code better and easier to review.  Don't create a series just with
> the short-term goal of making checkpatch quiet.
>
> Hope this helps,
>
> greg k-h
It does help. Thank you.
