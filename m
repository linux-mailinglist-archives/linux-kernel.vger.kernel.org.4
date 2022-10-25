Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A950760CCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiJYNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiJYM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4F61101;
        Tue, 25 Oct 2022 05:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F466191C;
        Tue, 25 Oct 2022 12:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FE8C433B5;
        Tue, 25 Oct 2022 12:55:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TLDAXUj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666702548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QGSEJHQ6O6h56v9HDr0qaun/dwKwWOG4TfufXFT9A7g=;
        b=TLDAXUj0dhqKSXKimkr9oIlh3k/6nMfUB9a8GjP+AlVoxSX0A5UQ6R6kYiZ9Jik4dkSDEM
        y9T9IimtGqYHqDbp4PYeU//M7RjFTubI2K6fWVwt9+GtwjIvleAmsbbdeLAdMYdic1pyFR
        bwXl+pUkkVyG7EZCgVEMlP8byRu3IXE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2b352582 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Oct 2022 12:55:48 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id h3so10832163vsa.4;
        Tue, 25 Oct 2022 05:55:47 -0700 (PDT)
X-Gm-Message-State: ACrzQf337OFKOose2iM9tqgenoZbYqp+Stx8rRXxLef+qg5EA3U+AGzv
        ReNvs/eKvf5hjI28fsZCZ9yyIbpFzHLAFNlU2to=
X-Google-Smtp-Source: AMsMyM4JokenVVEnbZ82CCTmDYmaTcsx2t4i/rPNK/XWJbxN4bY61RcFoPAXn4TA3gx2R7Mvql4drbYRB8ft7pY2F+0=
X-Received: by 2002:a05:6102:f9a:b0:3aa:1a11:2702 with SMTP id
 e26-20020a0561020f9a00b003aa1a112702mr5874116vsv.73.1666702547125; Tue, 25
 Oct 2022 05:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221024162901.535972-1-Jason@zx2c4.com> <ec8edb92-a21b-6291-4275-d7cba97d7ad7@gmx.de>
In-Reply-To: <ec8edb92-a21b-6291-4275-d7cba97d7ad7@gmx.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Oct 2022 14:55:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9r=E=sUEU0_thtrj6agd_8YbTVUm2fEsErGKM-ff6y03w@mail.gmail.com>
Message-ID: <CAHmME9r=E=sUEU0_thtrj6agd_8YbTVUm2fEsErGKM-ff6y03w@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: sis: use explicitly signed char
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

On Mon, Oct 24, 2022 at 8:29 PM Helge Deller <deller@gmx.de> wrote:
>
> On 10/24/22 18:29, Jason A. Donenfeld wrote:
> > With char becoming unsigned by default, and with `char` alone being
> > ambiguous and based on architecture, signed chars need to be marked
> > explicitly as such. This fixes warnings like:
> >
> > drivers/video/fbdev/sis/init301.c:3549 SiS_GetCRT2Data301() warn: 'SiS_Pr->SiS_EModeIDTable[ModeIdIndex]->ROMMODEIDX661' is unsigned
> >
> > Cc: Thomas Winischhofer <thomas@winischhofer.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Applied to linux-fbdev git tree.

For 6.1 as a fix, right? Since this is already broken on, e.g., ARM.

Jason
