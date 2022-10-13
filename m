Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61ED5FDE81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJMQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJMQwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:52:06 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28E0CB03E9;
        Thu, 13 Oct 2022 09:52:03 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29DGptkO018919;
        Thu, 13 Oct 2022 18:51:55 +0200
Date:   Thu, 13 Oct 2022 18:51:55 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <20221013165155.GJ16609@1wt.eu>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk>
 <Y0gteD0QYVlYxSZh@zx2c4.com>
 <Y0g8HEYHZYHGdwlf@sirena.org.uk>
 <Y0g+wTTJmlaFVLzr@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0g+wTTJmlaFVLzr@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 10:37:21AM -0600, Jason A. Donenfeld wrote:
> On Thu, Oct 13, 2022 at 05:26:04PM +0100, Mark Brown wrote:
> > Note that I'm not saying we shouldn't upgrade our requirements at all,
> > just that I'm worrying about going from one extreme to the other in
> > terms of version requirements - it feels like there's a step change when
> > you move from things you can get in current release distros people are
> > likely to be using to things that will require a large proportion of
> > people to install extra stuff.  At the minute we're more at the other
> > end where it can be hard to figure out who'd even have the oldest
> > versions we support without deliberately seeking them out and keeping
> > them going is noticably making work for people.
> 
> Regarding "one extreme to the other", I suspect that in spite of my
> arguments, which would seem to justify an extreme, the actual thing I
> suggested is a bit more moderate: let's support the latest 2 or 3 gccs
> at the time of kernel release. If we choose 3, that's roughly 3 years of
> gccs, right?

Ideally we should support at the very least those of the oldest
supported LTS kernels, because one thing for LTS users is that we
also want to encourage them to try new kernels, and if they can't
build newer kernels from the start we all know they'll give up
very quickly. And this eases the backport to those kernels as it
is expected that a mainline fix will support those versions (even
if it may break from time to time by accident, but the intent is
there).

> 3 years seems like a fairly long amount of time.

For a developer changing their distro every 6 months, possibly. Not
for users who took time to stabilize their system to something working
and who are curious about what the new kernel provides from time to
time.

Willy
