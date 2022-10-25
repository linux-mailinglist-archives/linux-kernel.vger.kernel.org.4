Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2D60D2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiJYRnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiJYRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0214517C54F;
        Tue, 25 Oct 2022 10:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9361D61A8A;
        Tue, 25 Oct 2022 17:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6EBC433B5;
        Tue, 25 Oct 2022 17:43:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bCMiDkUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666719822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vJqwIUPfAcqJps/uK/0x+HfmEw2EsJ0Z503zsGHjAE=;
        b=bCMiDkUUCC9d0WnRGLv1xiyGLAPwaxUYFEiqt0HcJk/a3H+WAYOroflUSHjPKuiMdNJUSv
        GQ4lsCGq31J4mvc3stEmjpUdFocQNRafbJZ+GiM1YWb4kxNCvfEnwu9TeeMofiW9kbL2W3
        vA17yh7AvPbrRPLEoA07WQXHSNWgy3E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9f21ff14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Oct 2022 17:43:42 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id t85so5786450vkb.7;
        Tue, 25 Oct 2022 10:43:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf3IPD+BkUHO7dS8h26hsqvX+bmkt+5DdL5NDnLDzAgYN7Yp/Gj1
        +bcvFK30K1GQ5IjkloeYDWA/1in74PoAYP2nDPo=
X-Google-Smtp-Source: AMsMyM5qRoXEj10ln68EWm1iDs0305P0ItRfe9qXZRx216ECvrCrHFVc0+8to77AuLgBULeSrnvQP+ivi0pdqsViRZ4=
X-Received: by 2002:a05:6122:317:b0:3b7:6590:daa1 with SMTP id
 c23-20020a056122031700b003b76590daa1mr5369383vko.37.1666719821023; Tue, 25
 Oct 2022 10:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <Y1e+SmS3O2ZaPVoe@kroah.com> <20221025122150.583617-1-Jason@zx2c4.com>
 <f0b755d2-6d73-5b04-e013-59f622e143da@gmail.com>
In-Reply-To: <f0b755d2-6d73-5b04-e013-59f622e143da@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Oct 2022 19:43:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9oOtdQkC_UVwiEJOcY7chz5RMuys20B+fZ9gOEz7z5zhg@mail.gmail.com>
Message-ID: <CAHmME9oOtdQkC_UVwiEJOcY7chz5RMuys20B+fZ9gOEz7z5zhg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8192e: remove bogus ssid character sign test
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        kvalo@kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 7:35 PM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 10/25/22 14:21, Jason A. Donenfeld wrote:
> > This error triggers on some architectures with unsigned `char` types:
> >
> > drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'
> >
> > But actually, the entire test is bogus, as ssids don't have any sign
> > validity rules like that. So just remove this check look all together.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-staging@lists.linux.dev
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Changes v1->v2:
> > - Remove ssid sign test entirely rather than casting to `s8 *`.
> >
> >   drivers/staging/rtl8192e/rtllib_softmac_wx.c | 9 +--------
> >   1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > index f9589c5b62ba..1e5ad3b476ef 100644
> > --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > @@ -439,7 +439,7 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
> >                       union iwreq_data *wrqu, char *extra)
> >   {
> >
> > -     int ret = 0, len, i;
> > +     int ret = 0, len;
> >       short proto_started;
> >       unsigned long flags;
> >
> > @@ -455,13 +455,6 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
> >               goto out;
> >       }
> >
> > -     for (i = 0; i < len; i++) {
> > -             if (extra[i] < 0) {
> > -                     ret = -1;
> > -                     goto out;
> > -             }
> > -     }
> > -
> >       if (proto_started)
> >               rtllib_stop_protocol(ieee, true);
>
> This patch cannot be applied on:
> [PATCH] staging: rtl8192e: use explicitly signed char

They're mutually exclusive, which is why this one here was marked as a
v2 and sent in reply to that one. Greg picked up the v2 and all is
well.

Jason
