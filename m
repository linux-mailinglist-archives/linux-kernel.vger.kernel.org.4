Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B762512A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKKCv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKKCvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:51:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5B12AB7;
        Thu, 10 Nov 2022 18:50:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7159361E8B;
        Fri, 11 Nov 2022 02:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9B3C433D7;
        Fri, 11 Nov 2022 02:50:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rm1rgxD7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668135024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LyraOPnlCHP94yFbYdpUoTdzUzgQ2LmoQkjnXpWunRY=;
        b=Rm1rgxD7LhHYjD1N9OxfxU77rq9eALW+OAnW2dP2PjMDhKRFAosWXs2NZ64K2yqfDV+9Dq
        18HePI5SigoMF/A2yp4zZ5UTD/4wMt/7R75E0+3YR+eBJBUCBj3VRvXlBdFcO68UHV1Ys2
        6e9VSxreuVujiNxvP83/oeBJyn44rTQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a2166a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 02:50:24 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id k1so4052984vsc.13;
        Thu, 10 Nov 2022 18:50:24 -0800 (PST)
X-Gm-Message-State: ACrzQf2zPZ9lonC/HafZ9X0tPPaB3CwMXHmdXgJvj02rGB0V9Nk6I6xA
        UrHPUGT4mlyUhD8rl0bu+HrWv9xUXdPgjlaMjrc=
X-Google-Smtp-Source: AMsMyM5mAJAq3OKZAPJf0P71bQxm0wDBTWP/oGX+r1QSrmqwkcVe94xdLX5yRoZnX264Ojr+MAPXc57EXvHArUvSrwc=
X-Received: by 2002:a67:6686:0:b0:3aa:3310:174 with SMTP id
 a128-20020a676686000000b003aa33100174mr4104056vsc.70.1668135023769; Thu, 10
 Nov 2022 18:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20221024162756.535776-1-Jason@zx2c4.com> <CAHmME9qMqUyNp2bdoY1YH14yvhZAwE_oAC5tav9jbTGp0jeUpA@mail.gmail.com>
In-Reply-To: <CAHmME9qMqUyNp2bdoY1YH14yvhZAwE_oAC5tav9jbTGp0jeUpA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Nov 2022 03:50:12 +0100
X-Gmail-Original-Message-ID: <CAHmME9rc08gSe7+keO3dGicqtOW629ofEGjWKdDGGASNq-CqxQ@mail.gmail.com>
Message-ID: <CAHmME9rc08gSe7+keO3dGicqtOW629ofEGjWKdDGGASNq-CqxQ@mail.gmail.com>
Subject: Re: [PATCH] media: stv0288: use explicitly signed char
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Wed, Nov 2, 2022 at 3:47 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Mauro,
>
> On Mon, Oct 24, 2022 at 6:28 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > With char becoming unsigned by default, and with `char` alone being
> > ambiguous and based on architecture, signed chars need to be marked
> > explicitly as such. Use `s8` and `u8` types here, since that's what
> > surrounding code does. This fixes:
> >
> > drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: assigning (-9) to unsigned variable 'tm'
> > drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: we never enter this loop
> >
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: linux-media@vger.kernel.org
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Was wondering whether you planned on taking this into your tree as a
> 6.1 fix for Linus for rc4?

Thought I should follow up with you about this again.

Thanks,
Jason
