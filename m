Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9A68CD62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBGDVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGDVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:21:21 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A5731B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:21:18 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3173LEHA016291;
        Tue, 7 Feb 2023 04:21:14 +0100
Date:   Tue, 7 Feb 2023 04:21:14 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] tools/nolibc: Adding stdint.h, more integer types
 and tests
Message-ID: <Y+HDqlMR6QndYSN4@1wt.eu>
References: <20230206013248.471664-1-v@vda.io>
 <Y+C6mj4F77U43atS@1wt.eu>
 <bff2a9f8-6f70-409a-8acb-cf8917f653a6@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff2a9f8-6f70-409a-8acb-cf8917f653a6@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 05:19:18PM -0500, Vincent Dagonneau wrote:
> >   - do not forget your signed-off-by on patches.
> >
> 
> Again, sorry. I'm quite new to the send-email workflow. I just figured that I
> was probably supposed to use format-patch then send-email rather than just
> send-email... Makes way more sense though and now I can have a file with my
> cover letter and carry it over to the next version.

Don't be sorry. It can take a bit of time to get used to send-email (and
can be scary at times). And yes, I, too, prefer to first produce the
patches then send them. One advice is to produce them into a different
directory each time, it will save you from accidently sending a mix of
the previous version and the current one, and it will also help you
double-check the differences between the patches to see check if you
missed anything.

> >> I tested it successfully on x86_64 and arm64 (on qemu). I have some
> >> trouble setting up my cross compilation chain for i386, arm and mips
> >> however.
> >
> > What compilers do you use ? I'm using version 11.3 from these ones:
> >
> >   https://mirrors.edge.kernel.org/pub/tools/crosstool/
> >
> > All supported archs work fine for me. Usually on x86_64 you can even
> > start the i386 binaries locally (if your kernel has COMPAT or COMPAT_32
> > built in, which is most often the case). And very commonly arm64 support
> > armv7 binaries as well.
> > 
> > Just let me know if I can help you set up your environment, it's always
> > a good long-term investment!
> >
> 
> Ah, foolishly I was relying on the packaged cross compiler for Arch. Compiled
> everything just fine with the packaged versions on Ubuntu (gcc-10
> mips/arm/arm64/i386). I'll try with the toolchains @
> https://mirrors.edge.kernel.org/pub/tools/crosstool/ as well.

OK!

Cheers,
Willy
