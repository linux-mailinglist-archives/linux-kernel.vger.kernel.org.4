Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5F6CB34D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjC1BpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjC1BpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:45:10 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD521FF7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:45:09 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9A8D6C01F; Tue, 28 Mar 2023 03:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679967907; bh=YQla0TW59nexzECUIB8l6ijxi92CoG9Q1WVpaQ810fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03S1qvY0RwOGs4Or8BMkV+2Wm6jqYqEPYTzjo/MdEzgXafPTBRYQQ6Tf3P/i1JpaK
         adzI0oQ72BxcCnCdTUpaoOxAxCzvu7T+n6PzvDS5IoY+adHeDk6hLT+3gqkIVH/HZp
         pSvK7krkxqUni/Yzo2db9xLbTOe9S1RDcLfa0SNVdCxWfHtkswWPBJTPCSif7kUqS3
         Cxm42mtuMwn54yBaSXTFBP//DyKy9dQyWdQck+T4ygNPX4R3K/B82anmlCRQuBiiI2
         m5htV+QyF8UHpTE7vmV4TDmXrqXf4lpk/iJ6A4NC+3mHyU2P4aAy/F7fVf02CmUmXI
         DcnYoGEpx0ZWw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1E15FC009;
        Tue, 28 Mar 2023 03:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679967906; bh=YQla0TW59nexzECUIB8l6ijxi92CoG9Q1WVpaQ810fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAeSjQme87sFflbgUkx3kB1416Xzw3ceKJzQ9AVJOQz3o6AYMxHm0npJuYOD1A9Xc
         D19KzMpFdrUnl2NTJmh9xAl0icxnlBQIMKz6/+jYU0ONbigO1vvJQg8f3hiPueB2+O
         y/2qBj1BaO188TzZi4FhyfNAM3ELCtuW8rWhtJd1BxRIhYmJJ+eQQ/qEmu8dd+KDEQ
         cQifS/1kFEyHfzvDbLq2nMqLy3+WouRPTRVONfeHp+pK2t7Wz95B6JAdEvtaX496By
         B8ksb+/VA8THHIYZiRLgJz3Fo++9Px1FreRocMWmQJfGoMZ1ODTT2Sgr3hh7J0WmTK
         ofw02FOwJmjAQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 22878ea3;
        Tue, 28 Mar 2023 01:45:01 +0000 (UTC)
Date:   Tue, 28 Mar 2023 10:44:46 +0900
From:   asmadeus@codewreck.org
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>, lucho@ionkov.net,
        linux-kernel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: 9p regression linux-next next-20230327
Message-ID: <ZCJGjuOYR6nGXiAw@codewreck.org>
References: <ZCI+7Wg5OclSlE8c@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCI+7Wg5OclSlE8c@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote on Mon, Mar 27, 2023 at 06:12:13PM -0700:
> kdevops uses 9p for its client / host setup to enable rapid kernel
> development on guests using the host to compile / guest to install
> a read-only-mount.

Thanks for the head's up!


> I updated the kernel today to next-20230327 and see the 9p mount won't
> come up and so boot fails. I'm starting to bisect and see next-20230301
> was OK. So at least have:
> 
> next-20230301: GOOD                                                             
> next-20230315: GOOD
> next-20230327: BAD
> 
> Once I narrow this down a bit further I'll poke back.
> 
> What sort of tests are run for 9p before some development changes get
> pushed into a tree that lands on linux-next? If none exists, simply
> testing 'make linux' works with kdevops could perhaps be a start.

I generally boot a qemu VM and run some semi-automated tests, and Eric
has his own set of automated testing, so we should both be testing stuff
that's being sent to -next, so I'm surprised it wouldn't mount at all...
(and I haven't pushed anything there recently)

There might be some unrelated change that impacts the way we're
mounting?
I've just built Eric's for-next branch and I'm not seeing any issue
there, I'll be checking the next tag you pointed at next.


I'm going to rant a bit here, but my main problem with testing is that
there are plenty of tools, but I have very little compute available for
this (just a small machine at home that's getting close to 10 years
old...), as this is really a free time activity which isn't getting any
funding.
[read: happy to spend a bit more time on 9p if it's getting paid :P]

(Linaro offered me some resources to build over different arches a while
ago and I've maybe used it once, but I never got to the end of their
LKFT (Linux Kernel Functional Testing, https://lkft.linaro.org/ )
framework to see if I am allowed to run the kernel that was just built
so it's a bit pointless if it doesn't go all the way...)


Eric brought up that we should share more tests and I definitely agree;
my setup is closely tied to my machine (mounts /nix/store over nfs and
runs tests on 9p from there as my host is running nixos), but if we
could setup some piece of shared infra to work on tests together I'd be
happy to add some of my tests there.

-- 
Dominique
