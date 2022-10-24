Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97160C05B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJYBDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJYBCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25176426
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 532C7CE13CE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BB1C43470
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:00:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pWW9K8vh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666656002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6ouPlU6BGs4kPFwrmXeWjPLmjyMG2MThW4WJxW1s7s=;
        b=pWW9K8vhmx6hLrKIXvek8LsHCDkuswwo10zuOMeGTRGrWVUzvBTZFfdqJt9q4uX6gpGm6O
        w08+t/qymWPsTJYHo60ToERIBwjsXbDDGyqmOAKfAQvG7NEBx6p//dadLs/rg0Jzbjj113
        gRs8RsQki54FTm0Csnarmxo4VAk9V1Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 81e92919 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 25 Oct 2022 00:00:02 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id k67so9432139vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:00:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf3AxKarIoqyH3zbAWZmtCPpxXeyBI747otupe/cfqdQRZW4KIpM
        29YD2harVZr4s0npxP8fwpnr9zKrpOzWHTdFDhk=
X-Google-Smtp-Source: AMsMyM4uJtrhUNYc7Adm4TVrz9Gz+yFl4Ma2o6YtJnG1sietFGIpDFqeO4WLPFF0JwDGBtUuGk9vZZzh1HHJCZPQS+M=
X-Received: by 2002:a05:6102:411:b0:3aa:329e:18c8 with SMTP id
 d17-20020a056102041100b003aa329e18c8mr1060016vsq.70.1666656000860; Mon, 24
 Oct 2022 17:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221024162929.536004-1-Jason@zx2c4.com> <Y1b/iNMncyKI/W5c@ZenIV>
In-Reply-To: <Y1b/iNMncyKI/W5c@ZenIV>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Oct 2022 01:59:50 +0200
X-Gmail-Original-Message-ID: <CAHmME9q2JOGMKNrXqK7q=xfZdciy89P+GT0eGHVmVqOvKDYA8g@mail.gmail.com>
Message-ID: <CAHmME9q2JOGMKNrXqK7q=xfZdciy89P+GT0eGHVmVqOvKDYA8g@mail.gmail.com>
Subject: Re: [PATCH] ALSA: au88x0: use explicitly signed char
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
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

Hi Al,

On Mon, Oct 24, 2022 at 11:11 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Oct 24, 2022 at 06:29:29PM +0200, Jason A. Donenfeld wrote:
> > With char becoming unsigned by default, and with `char` alone being
> > ambiguous and based on architecture, signed chars need to be marked
> > explicitly as such. This fixes warnings like:
>
> It might make sparse to STFU, but it does *not* resolve the underlying
> issue:
>
> vortex_adb_checkinout() returns a number in range of 0..31 on success
> and -ENOMEM on failure.  Quite a few callers don't bother to check...

Yea, I saw that. I assume that the places that don't check don't
*need* to check. But maybe this driver is junk and other bugs lurk.
I'm not sure. Either way, I think this change is certainly an
improvement on the status quo. I don't intend to develop further on
it, but feel free to send patches atop once this lands.

Jason
