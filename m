Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0565D5FA118
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJJPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJJPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:25:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51158083
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF970B80EE6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4957C433D6;
        Mon, 10 Oct 2022 15:25:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Uwv4h3BT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665415524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RdbMujFV34XpbKGJi3efXOaUBUw4LGwqBnVGjxoITaE=;
        b=Uwv4h3BTwrNPre4qKdBce2ur95RWM1PMWYSD+idHiJ5Vec56IKJ+tTkQFYciG2HlrmjSN/
        sXLvbrLwC11iIrQgQ3XMd0p/XZT04gd6nKi3GYebEGdEVj8p3Ev1KbNiZXuUeKbE0aEqwH
        EMhVroNttMBYs/U5cS32wFdMpJHdUyg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 17a21f2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 15:25:24 +0000 (UTC)
Date:   Mon, 10 Oct 2022 09:25:22 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mfd: syscon: Remove repetition of the
 regmap_get_val_endian()"
Message-ID: <Y0Q5Yn8w91KePV5a@zx2c4.com>
References: <Y0GZwkDwnak2ReTt@zx2c4.com>
 <20221008154700.404837-1-Jason@zx2c4.com>
 <CAHk-=wiqN9EJ6zKXh21EQ2CV-B7_oDJKy73+yhRwtbNMWCzfVA@mail.gmail.com>
 <Y0HKeTWneX12OP+Y@smile.fi.intel.com>
 <Y0POMogrdDN+BR37@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0POMogrdDN+BR37@google.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 08:48:02AM +0100, Lee Jones wrote:
> On Sat, 08 Oct 2022, Andy Shevchenko wrote:
> > > And if not, please just send me the revert through the normal channels. Ok?
> > 
> > Yeah, revert is a good move here.
> 
> Thanks for the clarification Andy.
> 
> Linus, by normal channels, do you mean you'd like a follow-up PR?

I would assume so.

What happened here is that I sent you (Lee) and Andy this patch, but
also had Linus in the recipient list because I sent this as a reply to
my initial message on the pull request thread, creating some ambiguity.
Sometimes when Linus is on the CC like that, it's an indication that
he's to take it directly. That's not the plan here. Rather, I think the
idea is that you can queue it up in your tree, and send it out with the
next PR of fixes for 6.1.

Jason
