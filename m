Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8C63649C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiKWPuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiKWPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:49:42 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ECCC6956;
        Wed, 23 Nov 2022 07:49:19 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id z1so12682631qkl.9;
        Wed, 23 Nov 2022 07:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2hwfJ3OGi9bNFK3Bxx9uQ9VsJMFOKPpsAznNmxcF54=;
        b=6DI2d28p4IB35GeQ9uhN3VYIQBXuzjNstFv4icEgtFsmcXZN1NRpaoZoyU2IQiCaaH
         J5D1xFR1MjoV/mQOBHnJy9aiDQ6LkUECQdYTFZ9e9NYz2qoVoaZ6hwIbLh3fQnWEScoE
         Wkp3M8Jt6eHiZjtznYJUv5A69KjtWGWRSepC1mzcxzJaGDaRJjU6t5UIoLDZCwDrCHK5
         zAmOsoypFh/zR2mU+bwZgMKmTPINnzyWhuYqi+tfVN0lawfwzSXaX/4p0B5gZigRyXa9
         tCnztaU2ebMPJhReipeOGr1zC4vucW7cmP0rQqJ+jNbvrI4cOcyEc3SM0k6HQFaboA+/
         vCuw==
X-Gm-Message-State: ANoB5pnC5/Az/TFoIlPWtaVKpGGntD3gu3+OdCuTRGPqi1ddO6O9x3gt
        N9zkjTWGvbM/ni4p0nn2c+92/GDXZ/WIEg==
X-Google-Smtp-Source: AA0mqf5/s1nu9KxeNK5kWrTGT6fnqZq6W3t8ZCgJikRoanX5vFzYP0wdD/w224AijyROyzU3NDswgQ==
X-Received: by 2002:a37:8a45:0:b0:6f9:fd7a:f300 with SMTP id m66-20020a378a45000000b006f9fd7af300mr9618927qkd.257.1669218558707;
        Wed, 23 Nov 2022 07:49:18 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id cb7-20020a05622a1f8700b0039cc0fbdb61sm10002545qtb.53.2022.11.23.07.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:49:17 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id z192so21330486yba.0;
        Wed, 23 Nov 2022 07:49:17 -0800 (PST)
X-Received: by 2002:a25:8249:0:b0:6dd:b521:a8f2 with SMTP id
 d9-20020a258249000000b006ddb521a8f2mr7980121ybn.380.1669218556787; Wed, 23
 Nov 2022 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
 <20221123100831.GE39395@tom-ThinkPad-T14s-Gen-2i> <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
 <Y344AdRANmS3STsd@kadam>
In-Reply-To: <Y344AdRANmS3STsd@kadam>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Nov 2022 16:49:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRZhBECgABtTxe00gM7_EqBaX5auZhmjUfmcLx4zoetQ@mail.gmail.com>
Message-ID: <CAMuHMdVRZhBECgABtTxe00gM7_EqBaX5auZhmjUfmcLx4zoetQ@mail.gmail.com>
Subject: Re: [PATCH resend] media: staging: stkwebcam: Restore
 MEDIA_{USB,CAMERA}_SUPPORT dependencies
To:     Dan Carpenter <error27@gmail.com>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Wed, Nov 23, 2022 at 4:11 PM Dan Carpenter <error27@gmail.com> wrote:
> On Wed, Nov 23, 2022 at 11:13:31AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Nov 23, 2022 at 11:08 AM Tommaso Merciai
> > <tommaso.merciai@amarulasolutions.com> wrote:
> > > On Mon, Nov 21, 2022 at 04:58:33PM +0100, Geert Uytterhoeven wrote:
> > > > By moving support for the USB Syntek DC1125 Camera to staging, the
> > > > dependencies on MEDIA_USB_SUPPORT and MEDIA_CAMERA_SUPPORT were lost.
> > > >
> > > > Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> > >
> > > Patch itself looks good but we have some style issue. Applying this
> > > patch I got the following warning from checkpatchl:
> > >
> > > WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")'
> > > #10:
> > >
> > > You have to pass only the first 12 chars of the sha1 commit into Fixes
> > > msg:
> > >
> > > Use:
> > >
> > >  Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")
> > >
> > > Instead of:
> > >
> > >  Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> >
> > I always use 16 chars, to avoid these becoming ambiguous in a few years.
>
> If we assume hashes are randomly distributed and that people commit
> 100k patches every year then with 12 character we would have 17
> collisions every 1000 years.

So I can expect to see a collision before my retirement day
(which coincides with the signed 32-bit time_t flag day ;-)

BTW, does the above take into account that commit hashes can
collide with other object type hashes, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
