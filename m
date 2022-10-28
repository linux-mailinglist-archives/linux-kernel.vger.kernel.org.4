Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BDE610964
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 06:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ1E5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 00:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1E5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:57:01 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E5197FA6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 21:56:59 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f12so1444716uae.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 21:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HwmBRA+APmiXYQZg1tBoj+t+gqf2adSus7ddCo9oLb8=;
        b=aqK2XIPjlDLtOlNEGgLWQWnUPiTd1vIjnrR0nXxR8DN8msOgby2Ts6ShJhtqDf5IST
         TCGVfCOZhmOK2GoyJ0HnhVDqi1xOrmvWs/GeM6mMORLjIGgsst45LAdZr2rhJ4Bmb6XH
         s1Ka+rF7jG6DpxMrzH4ZL3lzP5k5PWSr8FlTlCCDb+lL0lA2agVyiT8bN1/dvXN9J+yz
         eT2tP3RO8XRggB9xUK6wm7wRyJ6dpCAm5E9VYvzNR9ZZpgRr2vJ0Y51jsuQqeiIdp0kF
         e60t5JJXEKqYYIW2tfAdk5kx/yv+gFaKzOD6XiPLGhjV9gZuYC68a9GnT5FgOOzqczZU
         lzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwmBRA+APmiXYQZg1tBoj+t+gqf2adSus7ddCo9oLb8=;
        b=rKMJ4DWQuhNVah/V91uGDceJ4j67cbz9nebksbCxLNW1j6iX/U0TdZKtlA/ewsRzPo
         96DSRUyZrFrg4xRq1a/4JN9DVVrorL3mZT3PXnw4aDtPukTWURL/wSKx3/Q4D+qmVEFU
         EKvUk1yasdm6ClIYXCeQY84spgf5wPn+vHN4vKsZf7EZ5Jy1BGoAdlUGYxl0lHS++DZl
         v0C2kIB39y2AMQzKZt75fJKDzHzX/f++Ue0a4iXQ78Uf/i6YInGRZYHFpQB3Lo7E+pON
         y51DyplsT3vsA1389FnALlslomUOb1/09frTrQIDj7BJXMqQKs/A4hI0M4kn5DDlq5dj
         E+Mg==
X-Gm-Message-State: ACrzQf309J+96spTc70FKJndDctDy2ZQ6OMVo7/UxP0it37tl79/lR1n
        OyG1O3+VPqs7zg9Z9SbtZVbgRtc8xK4fsKR26nCvEMZXCcJPkw==
X-Google-Smtp-Source: AMsMyM4qFN7TWztijVLg7jQodkESQRKvJCa/EbYFVcPPPR4p6coV5T8DX8gRYojFd2IWHg751skQF85nzYEKQjun/u0=
X-Received: by 2002:ab0:25d4:0:b0:3c1:c353:31cb with SMTP id
 y20-20020ab025d4000000b003c1c35331cbmr30171453uan.63.1666933018093; Thu, 27
 Oct 2022 21:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221026132838.GA44037@rdm> <20221026171430.GA5592@nam-dell> <Y1o5mktrnE5rbtCO@kadam>
In-Reply-To: <Y1o5mktrnE5rbtCO@kadam>
From:   jovial umwari <umwarijovial@gmail.com>
Date:   Fri, 28 Oct 2022 07:56:46 +0300
Message-ID: <CAMk1CBNwM3XFPyHVfBnE0K4XWmGX_ZwzBV-sns6Nj7Yutb4YtA@mail.gmail.com>
Subject: Re: [PATCH] Fixed[ERROR:trailing whitespace and braces around scalar initializer]
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nam Cao <namcaov@gmail.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
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

well for the start it was not giving an error but after  fixing blank
lines  that is when i saw that
Thank you for the hint i  fixed  it

On Thu, 27 Oct 2022 at 10:56, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Oct 26, 2022 at 07:14:34PM +0200, Nam Cao wrote:
> > On Wed, Oct 26, 2022 at 04:28:38PM +0300, UMWARI JOVIAL wrote:
> > > Using the checkpatch.pl script, found the below errors and  fixed
> > > ERROR: trailing whitespace
> > > CHECK: Please don't use multiple blank lines
> > > warning: braces around scalar initializer
> > >
> > > Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> > > ---
> > >  drivers/staging/most/dim2/dim2.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> > > index 7a5f80e637a0..28259ce05024 100644
> > > --- a/drivers/staging/most/dim2/dim2.c
> > > +++ b/drivers/staging/most/dim2/dim2.c
> > > @@ -987,7 +987,6 @@ static int rcar_gen2_enable(struct platform_device *pdev)
> > >             writel(0x04, dev->io_base + 0x600);
> > >     }
> > >
> > > -
> > >     /* BBCR = 0b11 */
> > >     writel(0x03, dev->io_base + 0x500);
> > >     writel(0x0002FF02, dev->io_base + 0x508);
> > > @@ -1084,7 +1083,6 @@ static const struct of_device_id dim2_of_match[] = {
> > >     {
> > >             .compatible = "xlnx,axi4-os62420_6pin-1.00.a",
> > >     },
> > > -   {},
> >
> > I'm no expert, but this looks like a null terminator and probably
> > should not be removed.
>
> You're absolutely correct.  Also I tried to see why checkpatch.pl was
> printing an error for this but it doesn't print an error for me.
>
> regards,
> dan carpenter
>
