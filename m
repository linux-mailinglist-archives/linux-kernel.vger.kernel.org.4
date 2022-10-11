Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB85FBE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJKXbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKXbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DBA3448
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 16:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 595026132C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF24C433D7;
        Tue, 11 Oct 2022 23:31:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SpdHD1If"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665531067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeIWYm6w8zuXKT4hOG1v1kS71KglJMt2ENnuOTKkego=;
        b=SpdHD1If+R+GNniyF2BTtKD6SoxAEWTswvaJB7vGsT10B0Hc1yGQws9Gw7qoQklE9aGUmj
        eP1hrG885BiwuztL+3zxJBbGXItfZ+gPa7+w9f6pmBLvrIyj8RMmN5hac5Hk9fkY1GfVdP
        u8hN9OSgyrp2pV/x5bRSj7OOXAq328I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 802e06af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Oct 2022 23:31:06 +0000 (UTC)
Date:   Tue, 11 Oct 2022 17:31:02 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [crng-random:jd/get_random_u32_below 23/23]
 include/linux/random.h:64:69: sparse: sparse: cast truncates bits from
 constant value (1f4 becomes f4)
Message-ID: <Y0X8tuJjEfR48xiD@zx2c4.com>
References: <202210100722.Wc2gmfS6-lkp@intel.com>
 <a473cc4da4874235b2b98fd1a57e782e@AcuMS.aculab.com>
 <Y0RcL2j98CatloRr@zx2c4.com>
 <4bbbde65cef74a579de34a75e6dba0a3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bbbde65cef74a579de34a75e6dba0a3@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 11:24:50PM +0000, David Laight wrote:
> From: Jason A. Donenfeld
> > Sent: 10 October 2022 18:54
> > 
> > On Mon, Oct 10, 2022 at 05:18:40PM +0000, David Laight wrote:
> > > From: kernel test robot <lkp@intel.com>
> > > > Sent: 10 October 2022 00:32
> > > > To: Jason A. Donenfeld <zx2c4@kernel.org>
> > > ...
> > >
> > > I'm missing the main mailing list email for this change.
> > > I'm guessing the non-inlined code for non-constant ceil
> > > is similar.
> > 
> > It's part of a development tree I already linked you to. It's not done
> > yet. This alert is just about needing a __force.
> 
> I keep thinking about this one.
> sparse is being stupid because it is looking at code that cade be reached.
> 'ceil' must be 500 so the test at line 62 is false.
> But what is the cast for?
> Line 64 is only executed when ceil is <= 256 and the condition
> only matters when ceil <= 255 - so the cast cannot be needed.

Yes, it's sparse being stupid.

> I think you might be trying to do 8-bit arithmetic - but you
> should know it gets promoted to 'int' (and then to unsigned int).
> What might do what you intended is (u8)~ceil % ceil.
> But that is the same as (0xff - ceil) % ceil.

Right. This already came up in a different thread and I made that change
already.

> Which is the same as 0xff % ceil.

Same as 0x100 % ceil, rather. It's compile-time evaluation though, keep
in mind, so it doesn't matter.

> A quick check with ceil == 5 gives the wrong answer
> as all values get accepted - and one need to be excluded.
> So you either need (mult & 0xff) > 0xff % ceil
> or (mult & 0xff) >= 0x100 % ceil.

Yes.

Jason
