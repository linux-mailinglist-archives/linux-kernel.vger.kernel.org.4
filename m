Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D7B6364BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiKWPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbiKWPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:52:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FFBC6BEF;
        Wed, 23 Nov 2022 07:52:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r9-20020a1c4409000000b003d02dd48c45so1434898wma.0;
        Wed, 23 Nov 2022 07:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++E1vp6+xyfegCAT71khtdOEoE+9YsdkyoFRM1NuM3c=;
        b=GXLHAlwH+Njmvyj+SPjPfOH1/1e+wlgnzW2b8oN59RNi7+0RgESKcUiV6V9AxnLztK
         z50xDK/Njyfbb7uzRSs+2B/NxXl2ObEpOw4G098PzJVWYkmeu3KQKaOplm9vYhvbku2e
         Bh6FNqBAKj9jsrI9vy1Ezxrt34jD5jK+ySF4Rw8u2974AojnftTixzMdOZccwvKB4TDR
         4Y+wBiYu5pJPa798iAk/ttD8250UN08t9Qt6pq1xg38oGUDOXJj+vlu6dRdH1oFjzZ0a
         NcZCYXYisaeqFAjvjZHd1eVzP8hn0lHmIzSI4/qmXzYdeArTrpnG9PGJ1L/OuiuYk8HP
         FoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++E1vp6+xyfegCAT71khtdOEoE+9YsdkyoFRM1NuM3c=;
        b=MbyRKRS7DQZtunwQhWMZJypA+GDrJ7rCxdvmRd1ch1CoCG1tTfYA9YTXqgZUdEf9j3
         XpvQHOzkf0mRyFTdzJDCE3O9qPJeWlAxw6bTzOE5bOxF4HVvXyp8I9vPGeD2eEkyloFJ
         QdZt1dwXQc1GsEjkEdnaEEPqckIbCmFhaXJOqpHHdTC03vqxXm+HMSWg0NNTjjXwtXXx
         XNO/n2InhYPDSu2ZDehGunN0HTfQpZstA07NjKoz3WkTj4+shy0gXcN8bYvSRrgQFPm7
         VQ7cy9q+oguZi2VXLS5KiPuM8W2WaKgMmhRtUa9iw14BvZWGJHNxdc7ovqw0UyDGNQTa
         SNBg==
X-Gm-Message-State: ANoB5pn+PmIUKJFrf6k/w90szUr9i+TDYGBO9LVMMkygFgI1Ih8KT7CU
        lIwE0fw9KQDbh79SNYsncLM=
X-Google-Smtp-Source: AA0mqf71kvwmJPvlUO4d6EhKv/nSwsxHVmlh40//junEO4REeKrI6DGtUgYpipX4ygFdSNgOmdzVXg==
X-Received: by 2002:a7b:cb91:0:b0:3c6:cb54:ef66 with SMTP id m17-20020a7bcb91000000b003c6cb54ef66mr9934854wmi.90.1669218718769;
        Wed, 23 Nov 2022 07:51:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c510700b003cf5ec79bf9sm3006745wms.40.2022.11.23.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:51:58 -0800 (PST)
Date:   Wed, 23 Nov 2022 18:51:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] media: staging: stkwebcam: Restore
 MEDIA_{USB,CAMERA}_SUPPORT dependencies
Message-ID: <Y35Bm8bhKojxzdox@kadam>
References: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
 <20221123100831.GE39395@tom-ThinkPad-T14s-Gen-2i>
 <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
 <Y344AdRANmS3STsd@kadam>
 <CAMuHMdVRZhBECgABtTxe00gM7_EqBaX5auZhmjUfmcLx4zoetQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVRZhBECgABtTxe00gM7_EqBaX5auZhmjUfmcLx4zoetQ@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 04:49:05PM +0100, Geert Uytterhoeven wrote:
> Hi Dan,
> 
> On Wed, Nov 23, 2022 at 4:11 PM Dan Carpenter <error27@gmail.com> wrote:
> > On Wed, Nov 23, 2022 at 11:13:31AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Nov 23, 2022 at 11:08 AM Tommaso Merciai
> > > <tommaso.merciai@amarulasolutions.com> wrote:
> > > > On Mon, Nov 21, 2022 at 04:58:33PM +0100, Geert Uytterhoeven wrote:
> > > > > By moving support for the USB Syntek DC1125 Camera to staging, the
> > > > > dependencies on MEDIA_USB_SUPPORT and MEDIA_CAMERA_SUPPORT were lost.
> > > > >
> > > > > Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> > > >
> > > > Patch itself looks good but we have some style issue. Applying this
> > > > patch I got the following warning from checkpatchl:
> > > >
> > > > WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")'
> > > > #10:
> > > >
> > > > You have to pass only the first 12 chars of the sha1 commit into Fixes
> > > > msg:
> > > >
> > > > Use:
> > > >
> > > >  Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")
> > > >
> > > > Instead of:
> > > >
> > > >  Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> > >
> > > I always use 16 chars, to avoid these becoming ambiguous in a few years.
> >
> > If we assume hashes are randomly distributed and that people commit
> > 100k patches every year then with 12 character we would have 17
> > collisions every 1000 years.
> 
> So I can expect to see a collision before my retirement day
> (which coincides with the signed 32-bit time_t flag day ;-)
> 
> BTW, does the above take into account that commit hashes can
> collide with other object type hashes, too?

I assumed that `git show` won't show those other object types, but I
don't really know if that's true.

regards,
dan carpenter

