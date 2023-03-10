Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC16B5434
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjCJWXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCJWXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:23:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825DFA2C2C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:23:42 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kb15so6685219pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678487022;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKLsTjbboNr3JZyGjBDURtUNYpO0ZZ2dX7lvovz04Dg=;
        b=CcfiKC/L9YjtU91mWdND3mJ37Sk/ctXeGF2pOnqkfJXrS4e80XRepKQ9urQ4/NI3Rk
         OEj+GpnkNMy9i8CZsj9BUKRqHqhm9ORAl4eboNDqTKfEgt7iPCtuDRswc1aQFtRQqExX
         X9pjeUA5+T6qC4zwmdCLvCo5cITGbqS4c8vfSEtGRZZjZiN8wfGfSOP8NunXNi0kUfCf
         mlWwvlEflKe+Wb2lijo01YWln3nqeC0Ztetu1CVN+bsityDZmV4yDRBZNWsTFU99E2E3
         kocfWpczynIgjxgvjqti9PYraAaxRy20p0nhxixfM7nVlhFoRXXaLIXeEPu/+d4QcaxY
         wYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487022;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKLsTjbboNr3JZyGjBDURtUNYpO0ZZ2dX7lvovz04Dg=;
        b=TqR10e5pLjjADUP3bpuKsIq35lPGdw1S04vetFKYTXhFP6NM8xTFi7n8nfef6S5JDD
         8c7k+mrAzdRIgukV/WiSblpIQwEPnamIysBQ8rM85LMn/Z9zcxLn+IC1Ke0V2iMbRe+V
         Tp3t5HluwSl7XD7rZgOCmMIh2q4QrAxzNy0SA0cKNEF/QhZWvJ2oCNXvySEpV/NUM0Fu
         4Kb5z4I5A1IY/IDqxJ2Sm9aKMm1IxV70pM3usVbbNU86ftrgGKK+l8afnqFkRvB8KNQ8
         G6TozlDDBy6HqhdinigrK+X9hLP6evPfNL0GOgLlk++ru/Hl/puYBtm2XJ5IP3gooUB9
         jdtQ==
X-Gm-Message-State: AO0yUKXTwugc8iRnf7WqhlowyZpT93H7P45YmPopCKLxbj3Pbsn80rvj
        kUWttsMKa6ZM3UYCY7EeJt1pXuiS6zMmxGeS5Cw=
X-Google-Smtp-Source: AK7set8zSZvon37o6sCBJ9UJyWK3ko7kVhvTIbJxZyf289K8RjaGxbk/nw4Fi3a2ymdpCx0L+lialw==
X-Received: by 2002:a17:902:efce:b0:19b:110d:28dc with SMTP id ja14-20020a170902efce00b0019b110d28dcmr22122207plb.19.1678487021951;
        Fri, 10 Mar 2023 14:23:41 -0800 (PST)
Received: from CloudiRingWorld ([122.231.69.163])
        by smtp.gmail.com with ESMTPSA id ku3-20020a170903288300b0019aaab3f9d7sm457608plb.113.2023.03.10.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:23:41 -0800 (PST)
Date:   Sat, 11 Mar 2023 06:23:38 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750: Rename camel case functions in
 sm750_cursor.*
Message-ID: <ZAut6vnYur0Xi4Nj@CloudiRingWorld>
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
>

Acturally, if you set tabs be 8 characters as it said in Linux kernel coding
style, it lines up with the right side of the (.

The checkpatch.pl didn't say "CHECK: Alignment should match open parenthesis".

It shows up didn't line up the ( may because tabs are 4 characters in
mails.

So, should I just change the subject of the email? If I want to resend this patch,
should I make it a reply to this current discussion string or something else?


