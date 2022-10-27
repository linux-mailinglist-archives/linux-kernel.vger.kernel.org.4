Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE160EFED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiJ0GMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiJ0GMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:12:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA33815DB09
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:12:29 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a5so198006qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2QZ9vtdnPCb5anjpxrp18BAjMTMzX01x/KMYy3kefQs=;
        b=VctcnEzDheqjAB6wY79o8KHV0GUSpIrsXU6nYArQZkweOusS/2EH44abmuydZyohYC
         r2eZqOigOSK4VjyMFZCVxvcceBmyyugO49AZ44fA8WxSzlUbS34wI4Yved+esoWPkW6A
         usEHLQd0WCHhDM5jVgrAwQW6907Vmn4bzKNerFMklahCrnZy+hZ1TkxhgFjjDU8QVxr7
         2DammHlGBsvtpEe7X/GYy5aoHE9JqYVft2pkRyZjUFYLhMj7/w72mm5xnEAyK1w0MCcY
         uk4FrUJYo+gOnXY+TuJkhE8uxbgetwIIKGAIFBdjpluJi4rCY0OSbB1M4ZQWZCVFbqhR
         GVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QZ9vtdnPCb5anjpxrp18BAjMTMzX01x/KMYy3kefQs=;
        b=fUgN11t9Uh5HG9ETf+zHs/yjYzqNUbhht4I8KeSGKpjN0COpXb3EJs3oIPfme8o/bg
         DWT/TH/AhLipkA/PifZJuyg56FoFPsGT4YVe5xGO6gchSVLdK6gNejCI4N/UauBjRc0i
         67RocLQO3JCM9Nx2VrrFsgED85L6MFrLUWFcR5ShcgyucIM1UXqsQlqBiqxNYivZkg5w
         Tfnz2rn7Ov4TZ/vi0Ae52oAYEL/CUjIM0hAgGmXXrJGKHkNmTajA6/KUQZIwQSoyDVR0
         7McIIZB3qz1m87EpnhY/yVlHZFgy6MEbzlnr/Lu3SYqBwGA20ikhed6MlNPamvwstNKe
         xBZQ==
X-Gm-Message-State: ACrzQf0dstQW6WFhmXFplfwYjENL5tr4Y2cQscFvcucUdROidlB/+9NS
        4Y0AkuScu422eN7ByUbI2Kb/MIPQTXlGT96hETVfld+epGGSrfa6
X-Google-Smtp-Source: AMsMyM4xXlENiaz9joPwyHRduYwc4xPqiMmIlzMPZqKw0mWLeKGMn1YIoZ7Ls6vROZk1Ojke6i+lloYvcBtLVJAILK4=
X-Received: by 2002:a05:622a:147:b0:39c:dc0d:7d0f with SMTP id
 v7-20020a05622a014700b0039cdc0d7d0fmr38493245qtw.281.1666851138604; Wed, 26
 Oct 2022 23:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666740522.git.tanjubrunostar0@gmail.com>
 <47da976cd02d262cebe520b21a0bf2451de6731b.1666740522.git.tanjubrunostar0@gmail.com>
 <Y1k7cDP4Dpdr5EOe@kroah.com>
In-Reply-To: <Y1k7cDP4Dpdr5EOe@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 27 Oct 2022 07:12:06 +0100
Message-ID: <CAHJEyKW8ofQ0fNQ0L4TzqJTEUMDfAPMufGATbX2Ep7JJKcWHQg@mail.gmail.com>
Subject: Re: [PATCH 05/17] staging: vt6655: changed variable name: pvRTS
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

On Wed, Oct 26, 2022 at 2:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 25, 2022 at 11:37:01PM +0000, Tanjuate Brunostar wrote:
>
> Philipp has pointed out most of this already, but I'll just be specific
> and say what isn't ok in all of these patches:
>
> >       change variable names pvRTS to meet the
>
> "name" not "name"
>
> >         linux coding standard, as it says to avoid using camelCase naming
>
> "Linux" not "linux"
>
> >         style. Cought by checkpatch
>
> Why is this all indented?
>
> Please do not do that, look at existing accepted changes in the git log
> and match up what they look like.
>
> But worst of all, you didn't really fix the variable name at all.  You
> just appeased a tool that was trying to say "don't use camelCase, use
> sane names".
>
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 56 +++++++++++++++++------------------
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 2cac8f3882df..e97cba014adf 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -87,7 +87,7 @@ static const unsigned short w_fb_opt_1[2][5] = {
> >  /*---------------------  Static Functions  --------------------------*/
> >  static void s_v_fill_rts_head(struct vnt_private *p_device,
> >                             unsigned char by_pkt_type,
> > -                           void *pvRTS,
> > +                           void *pv_rts,
>
> "pvRTS" is using Hungarian Notation.  Look it up on Wikipedia for what
> it means, and why people used to use it.
>
> For us, we don't need that at all as the type of the variable is obvious
> in the code and the compiler checks it.
>
> So "pvRTS" is trying to say "this is a pointer to void called "RTS".
>
> We don't care about the "describe the variable type in the name" thing,
> so it should just be called "RTS", or better yet, "rts", right?
>
> But then, step back.  Why is this a void pointer at all?  This is really
> a structure of type struct vnt_rts_g_fb.  So why isn't that being passed
> here instead?
>
> So try to work on both, fixing up the names to be sane, and then,
> getting rid of the void * stuff, to better reflect how data is flowing
> around and what type that data is in.
>
> thanks,
>
> greg k-h

I see. thank you for the pointers

Tanju
