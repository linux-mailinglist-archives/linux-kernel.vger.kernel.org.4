Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A261F77A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiKGPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiKGPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:21:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1421EC6F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:21:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j15so16728027wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmMmv/oTSzrJmF1VX/DLHOeAhM5SZu/ZlDvV6Xk6vkU=;
        b=ojHMw/lKyqAMPjzaeD2oKHAQt0LI1sHBJgjP9hYFbHg/PX7CsLE2pY1fkbwLKxkHt3
         9wM/8gypUEIA7538MY1FEhuxZMAFaBR+bHLSqNql7NrbDZzOK6BI5lbnFUKUkRrT9uq5
         kArB09CRgtqg7JwIwymRuxWtLIWc4+OYdZpdvStRlYKL7cJ9BdIwzbP3dy3PpWcu1lRY
         fgYamakDOuDTsfelTot5+IB9ZnQpQ3Kmy2w6sxXO6d3VqVPlZ2srcSiTFrica8XfUaUS
         Rb2yDeKfgM2+E1SmLjCAp84MhQBSW5jPRhs6IryWHCHmCi1Ahx6edtcxoCMFX1z+Lbj4
         QcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmMmv/oTSzrJmF1VX/DLHOeAhM5SZu/ZlDvV6Xk6vkU=;
        b=PhPbp2IC7j+0v6IIMh1RuyR1y75hKyqevrbw+aqiI5StiY6s9yBXLQRrrf9Nw8RU6A
         pBMM7obNOgId+y0YOf70/x7Z3lzRjTqvfuyLUSFX2kTTQHuaA71brgHmrgasCBoA6z08
         ZUZiLvSsQODPKPWjqNvnVhJ0BGV5i7tcbqGEQuxbWAYEzojWewQBLROOvTnDoslKNypi
         h1WHIA9A2RvXEcgPc1Ed5hMjMjdrtS9CFVVQJAm5Ms1mg9qf2DAT6s1Ub6T075HQCSuP
         mKC78GmCCc+2y03qW5u8qON7cD/gLodtzETDFMk5CK9MDldATX4liyUMgcIwA5Kycv9l
         OcHA==
X-Gm-Message-State: ACrzQf1WX/JoFnY+MEQ30CztUq/ORxsa9O2hipZqmX7HqePv+BnPC6l2
        PWn7wY1GB/5u+ogJRPCUaYU=
X-Google-Smtp-Source: AMsMyM4hrXqGUG3Vmvld987T1WNtFXrKcXMKwXX+IQWKjrA0z6Y8rKFuw+/f/w0lDPc2ScNQ/JzxWg==
X-Received: by 2002:adf:b30d:0:b0:23a:43b7:aeb7 with SMTP id j13-20020adfb30d000000b0023a43b7aeb7mr11965840wrd.192.1667834511015;
        Mon, 07 Nov 2022 07:21:51 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b003c5571c27a1sm11377181wmq.32.2022.11.07.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:21:50 -0800 (PST)
Date:   Mon, 7 Nov 2022 18:21:47 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: video: use min_t() for comparison and
 assignment
Message-ID: <Y2kiixRDxjxSwFp+@kadam>
References: <Y2iHl5CuqyR2vEc8@qemulion>
 <Y2kGG3zuvvDLZKWq@kadam>
 <Y2kf40kSbFWkWkLl@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kf40kSbFWkWkLl@qemulion>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 08:40:27PM +0530, Deepak R Varma wrote:
> On Mon, Nov 07, 2022 at 04:20:27PM +0300, Dan Carpenter wrote:
> > On Mon, Nov 07, 2022 at 09:50:39AM +0530, Deepak R Varma wrote:
> > > Simplify code by using min_t helper macro for logical evaluation
> > > and value assignment. Use the _t variant of min macro since the
> > > variable types are not same.
> > > This issue is identified by coccicheck using the minmax.cocci file.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >
> > > Changes in v2:
> > >    1. Revise patch description. No functional change.
> > >
> > >  drivers/staging/most/video/video.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> > > index ffa97ef21ea5..d5cc7eea3b52 100644
> > > --- a/drivers/staging/most/video/video.c
> > > +++ b/drivers/staging/most/video/video.c
> > > @@ -173,7 +173,7 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
> > >  	while (count > 0 && data_ready(mdev)) {
> > >  		struct mbo *const mbo = get_top_mbo(mdev);
> > >  		int const rem = mbo->processed_length - fh->offs;
> > > -		int const cnt = rem < count ? rem : count;
> > > +		int const cnt = min_t(int, rem, count);
> >
> > TL;DR use size_t instead of int.
> 
> Hi Dan,
> Thank you for reviewing the patch. Please see my queries inline.
> 
> >
> > Using "int" here is wrong.  size_t is unsigned long meaning that it has
> > 64 bits to use to represent positive values.  (Let's ignore 32 bit
> > arches).  You have chopped it down to say that it now has 31 bits for
> > positives and if BIT(31) is set then treat it as negative.  Everything
> > which is larger than INT_MAX will be broken.
> 
> I did worry about the truncation int might cause to the size_t variable,
> however, as the result is being assigned to an int, I decided to go for int to
> be the typecast for min_t.

Let's ignore that other layers prevent "count" from being greater than
INT_MAX.  mbo->processed_length is a u16.  Also if "fh->offs" is more
than mbo->processed_length that's a separate bug and we are already
screwed.

So that means rem is a relatively small number.  A small number can
easily fit in "int cnt".  So we are eating a big pie ("count") but we
are taking small bites ("cnt").  Everything works fine.

But if we chop the pie in half or treat it as negative pie then the
math breaks.

> 
> Also, won't size_t will force the int rem to be treated as unsigned value which
> will impact the comparison when rem indeed is negative. If rem will never be
> -ve, my worry will be void.

Is "-ve" the TikTok way of abbreviating negative?  Am I old?

The small bites are always positive.  But if we are eating negative
pie then we take negative size bites.  min_t() should almost always use
unsigned types.  Everything else is a headache.  I have often wondered
why people do it but I think it's because of the 80 character rule and
the word "int" is shorter than "unsigned long".

regards,
dan carpenter

