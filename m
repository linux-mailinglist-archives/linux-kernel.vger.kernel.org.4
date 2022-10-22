Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C8F608AE1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiJVJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiJVJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:12:28 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03222240BF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:26:46 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y10so3358493qvo.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BKyrgKd3nV6vFGC3v5G3QoxhQpPZq+Q6sUCuUsTeruE=;
        b=OcDvhKccr8ghjxH0QgjZx77y2NlLJteqVX9kW+cV7/58Nuy6KIfP5trWI7zAWuHdq0
         xp4g7VShVR6Hzr4WxBxR59Qtr/eVSoRi2bvX+ra7ZIdaPOBjjKcsilS9QXeuTPgnP3J+
         5rozGZwLhXJhXwRBzQvM0qP8dJk5uz2B/4+wbCvM7Izp/0i3CCKupYDIJYrkNry77mxx
         SXc6MxubO/Ne8Nf7RRBlBmEcAx/2PkC9/YsvKHcD8hXwhj6gsAK6WFNnR0yzvGntY+G5
         g69Vdd9whWkfRXejR5xxb8gA9hOgenJxsMw9oFjVsuWbN7djPSka8giu68h8j1sdaBuQ
         TUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKyrgKd3nV6vFGC3v5G3QoxhQpPZq+Q6sUCuUsTeruE=;
        b=JQjR/U+QzaCgmtlyDpmNgz9AWwgCDDJ9UM5MTVWD3A8hxZwa85NBjDpN3NWxkES9j4
         41oNWUPnTbM8fH59Am5dB8gvqj8nSDIUZGQzK80SxC9ASSq1iSLHBjzxyQC+xofYztRf
         W0hz2oDQK6f88uC3bd2eku9e889CSM4YTEqYdDLPlGmiqaIeMVlcJqSz5clYIHZ+NsSL
         +h8GhG2qwGdc+qUG8ip+waib5JJkJcoDir3+rkPQ7W4xFAHfEiXim6kTcRTZJrj76Dq4
         dZalErz2Bm9FsFR++5wrv0DUwcjHcrqoosuvDiGlrjSDmhAbl12KYP9qkXXDs/r4VP6B
         QO0w==
X-Gm-Message-State: ACrzQf2xDppagwGJzu+LfZ8qRbrleKao5qlUP+5T/7ZqiAnS/zsiOgfA
        03/I8JEuHQUHgwKAGYvRit84sQxN02JfgTOhiRUu0v9I3zWzBqYXxyM=
X-Google-Smtp-Source: AMsMyM6r0qiK79uGXwWq66ds8sugYf4PM27ZUYB+YW4f6cnrjf9d67B6CWvOt+R6b/+VDDELsIzk4NR0b4GVIEcfSw4=
X-Received: by 2002:ad4:5d6c:0:b0:4af:b5e0:63f1 with SMTP id
 fn12-20020ad45d6c000000b004afb5e063f1mr19524644qvb.35.1666427054688; Sat, 22
 Oct 2022 01:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-2-tanjubrunostar0@gmail.com> <Y1OlaBVGgHvAipuB@kroah.com>
In-Reply-To: <Y1OlaBVGgHvAipuB@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 09:24:02 +0100
Message-ID: <CAHJEyKVh9J-OMS=fBU7oiFtx7U00o2MFhQKRN2i9DhE7g3D_hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] staging: vt6655: fix lines ending in a '('
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

On Sat, Oct 22, 2022 at 9:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 22, 2022 at 07:06:07AM +0000, Tanjuate Brunostar wrote:
> > fix serveral checkpatch errors related to lines ending with a '(' by
> > refactoring the code lines
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 149 ++++++++++++++--------------------
> >  1 file changed, 63 insertions(+), 86 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 1e5036121665..f9d0b00d7cff 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -141,13 +141,11 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
> >   */
> >  static
> >  unsigned int
> > -s_uGetTxRsvTime(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byPktType,
> > -     unsigned int cbFrameLength,
> > -     unsigned short wRate,
> > -     bool bNeedAck
> > -)
> > +s_uGetTxRsvTime(struct vnt_private *pDevice,
>
> You have a strange mix of choices here for how you changed the code.
>
> This time you did not move the "static" or "unsigned int" to the same
> line as the function name, but then:
>
> > +             unsigned char byPktType,
> > +             unsigned int cbFrameLength,
> > +             unsigned short wRate,
> > +             bool bNeedAck)
> >  {
> >       unsigned int uDataTime, uAckTime;
> >
> > @@ -215,19 +213,16 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
> >
> >  /* byFreqType 0: 5GHz, 1:2.4Ghz */
> >  static
> > -unsigned int
> > -s_uGetDataDuration(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byDurType,
> > -     unsigned int cbFrameLength,
> > -     unsigned char byPktType,
> > -     unsigned short wRate,
> > -     bool bNeedAck,
> > -     unsigned int uFragIdx,
> > -     unsigned int cbLastFragmentSize,
> > -     unsigned int uMACfragNum,
> > -     unsigned char byFBOption
> > -)
> > +unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
>
> You moved "unsigned int" here, but then:
>
>
> > +                             unsigned char byDurType,
> > +                             unsigned int cbFrameLength,
> > +                             unsigned char byPktType,
> > +                             unsigned short wRate,
> > +                             bool bNeedAck,
> > +                             unsigned int uFragIdx,
> > +                             unsigned int cbLastFragmentSize,
> > +                             unsigned int uMACfragNum,
> > +                             unsigned char byFBOption)
> >  {
> >       bool bLastFrag = false;
> >       unsigned int uAckTime = 0, uNextPktTime = 0, len;
> > @@ -316,17 +311,13 @@ s_uGetDataDuration(
> >  }
> >
> >  /* byFreqType: 0=>5GHZ 1=>2.4GHZ */
> > -static
> > -__le16
> > -s_uGetRTSCTSDuration(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byDurType,
> > -     unsigned int cbFrameLength,
> > -     unsigned char byPktType,
> > -     unsigned short wRate,
> > -     bool bNeedAck,
> > -     unsigned char byFBOption
> > -)
> > +static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
>
> You did both the static and the return type here.
>
> Pick one style and stick with it please.  Consistancy matters, that is
> why we have a coding style to start with.  Brains and pattern matching
> and all that.
>
> In this case, this last one (both static and the return type), should be
> used.
>
> thanks,
>
> greg k-h

OK thanks
