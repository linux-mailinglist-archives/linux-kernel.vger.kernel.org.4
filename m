Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6037B6DE9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDLC7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjDLC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:59:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FBF4C0D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:58:55 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33C2wZZu031187
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 22:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1681268317; bh=zRuRID1z90VR55CAaVZuRCvfNFHtlJxq/Hc6njhL5mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Q6eq9W5jIgLrV8r00PWgoLh8tmlUMRKmdjaw0YJ336taBk5oeHJLMsyV+PNvUYj1j
         B7S4GEevbzPi16GfrHyODh/6aR/z5zYTwwr2hf4nUe2MV81szeLQoFMviD/x/OuP70
         DAq3detdKfDy+K6qDRHC5yCHkP/bJ7ZHd7lUKxmxQjJiTHvn8SSn5sWuTii8UkX6UH
         7+2wbd5q3LIOaOYa898dz5YZtZX9HkeEXshwyJz6XaIMaWp7hMleN7k20mddTontM8
         p1aXjRJukUkBycSjm+JIkpVsFu8s6H0mgk3Opi99+tGhHn4dLIGWcS8lynVv+sklMW
         kswFWN5WOY0LA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E999015C4935; Tue, 11 Apr 2023 22:58:34 -0400 (EDT)
Date:   Tue, 11 Apr 2023 22:58:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Deborah Brouwer <deborah.brouwer@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <20230412025834.GA301301@mit.edu>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <ZDSRSWhWsN34MghQ@xps>
 <CANiq72=n1b=fJ2XZZx_MLKkbKMTmnmTBMgA3GJ_hqyARPtwEiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=n1b=fJ2XZZx_MLKkbKMTmnmTBMgA3GJ_hqyARPtwEiQ@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:22:56PM +0200, Miguel Ojeda wrote:
> 
> Thanks, it is great to hear that the guide helped! :)
> 
> On resources: nowadays we have a webpage, too. Still to be completed,
> but you may find it useful already: https://rust-for-linux.com

Something that would perhaps be useful is to document (a) what
versions of Rust is available for various distributions, or pointers
to how to get that information for various distributions.  For
example, you can get that information from Debian using [1].  It
appears that Fedora isn't distributing rustc at *all*, at least
according to [2], so apparently for Fedora people will need to install
it from source.

[1] https://packages.debian.org/search?keywords=rustc&searchon=names&suite=all&section=all
[2] https://idroot.us/install-rust-fedora-37/

The other thing that would be worth documenting is (b) something about
what versions of Rust people have actually tested.  The comments at
[3] are quite scary, since per [4], the minimum version of Rustc
supported is 1.62.0 --- and per [3], **only** Rust 1.62.0 is
supported, since we use unstable Rust features.

[3] https://rust-for-linux.com/rust-version-policy
[4] https://docs.kernel.org/process/changes.html

But for example, with Debian, Debian stable is shipping Rust 1.48.0,
and Debian testing (which is currently in "hard freeze" so it can be
released as Debian stable this summer) is shipping Rustc 1.63.0.

Since I use Debian testing, the question which is foremost in my mind
is whether I can expect to have things work if I use the
distro-provided 1.63.0 rustc, or is this really a case of "it's not
Rust 1.62.0, so good luck to you"?

If the goal is accelerate adoption of Rustc, and calm people's fears
vis-a-vis using Rust, it's not enough to say, "why don't you use the
distribution-provided version or Rust"?  It would be helpful if those
Rust pioneers can share what versions of Rust they have tested
against, especially for those commonly used distributions, such as
Debian, and give us a report whether we should expect things to work,
so we can ignore the scary warning from the build system that we're
using an unsupported version of Rust, and if it breaks, we get to keep
both pieces.

And for those distributions that don't currently ship Rust, such as
Fedora, if someone could build their own unofficial packages, until we
can convince Red Hat to start shipping -their own supported Rust
compilers, that might be a great way of bridging that gap.

Cheers,

					- Ted
