Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD5615837
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiKBCrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKBCrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC021812;
        Tue,  1 Nov 2022 19:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5583617C8;
        Wed,  2 Nov 2022 02:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B6FC433B5;
        Wed,  2 Nov 2022 02:47:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AG+tgG+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667357233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6a6dTW6KKeFFiifYxWa6q1oeaoI/6g0vF1UUpf+QGw=;
        b=AG+tgG+yXzo86A0MZsAxzh0ausmHZB2jwBmcvool7ZPF3PoCAJd517xOeV74Bx6aTkWpGL
        2Dbp+l8DfdGJ1J2SKvJMsYPQLVwGqxjXCKCMa2gNFgbRuvD+ZtOU7mNcFSV4Jz7QKBK0OR
        +MZdyshTHq3+egaKTAyVQ3zMvTKoOMc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8968a0d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 2 Nov 2022 02:47:12 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id t5so7803924vsh.8;
        Tue, 01 Nov 2022 19:47:12 -0700 (PDT)
X-Gm-Message-State: ACrzQf0oBJI+snvWlVw9rdDiY+EphwvN97/7Fg+4Ie9nZ7Voi4iD/PlY
        sOY0Xe6U4+8XhusgJLESyQFHuUO2D/tgZWFhEeQ=
X-Google-Smtp-Source: AMsMyM4s6R6+3wPjXr5ORpTViCSnm6NfuCxPssIJ65iEFLryiOGriyJ16OI2hKJZ/tKgr7D0wi4QNEivOxsE1PlmTHI=
X-Received: by 2002:a67:c297:0:b0:3aa:3cac:97b6 with SMTP id
 k23-20020a67c297000000b003aa3cac97b6mr10810553vsj.76.1667357231942; Tue, 01
 Nov 2022 19:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221024162756.535776-1-Jason@zx2c4.com>
In-Reply-To: <20221024162756.535776-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 2 Nov 2022 03:47:01 +0100
X-Gmail-Original-Message-ID: <CAHmME9qMqUyNp2bdoY1YH14yvhZAwE_oAC5tav9jbTGp0jeUpA@mail.gmail.com>
Message-ID: <CAHmME9qMqUyNp2bdoY1YH14yvhZAwE_oAC5tav9jbTGp0jeUpA@mail.gmail.com>
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

On Mon, Oct 24, 2022 at 6:28 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, signed chars need to be marked
> explicitly as such. Use `s8` and `u8` types here, since that's what
> surrounding code does. This fixes:
>
> drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: assigning (-9) to unsigned variable 'tm'
> drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: we never enter this loop
>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Was wondering whether you planned on taking this into your tree as a
6.1 fix for Linus for rc4?

Thanks,
Jason
