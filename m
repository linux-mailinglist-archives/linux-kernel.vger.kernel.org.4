Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E5167A8B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjAYCXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjAYCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:23:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85C4ED12;
        Tue, 24 Jan 2023 18:23:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2154FCE1D41;
        Wed, 25 Jan 2023 02:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 576E5C433EF;
        Wed, 25 Jan 2023 02:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674613383;
        bh=CSTE5DJCXbzBtGITZ9min3sVYYy4xsqGZc5A41z+ZMg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pJUbMJ6Eo4ESVKPhZpfa7bbSGgmflzom4pDwWZGiaYB1tsgKDV0hn6byu23bCrSRt
         TlKaSLDRKG2BWykYPtkytBRO0g2jhQgTsqW1rx7p5c0nVlPbtzwWCyegonSYfkliFN
         8Q4QRBRS9bYVZ5tjxeUfU72Bj4kIHqN8QltvAMbrt3tfPev8ErC12sEKlM/KZn/Lcu
         XgUC1aS673EpAbcPgoCGLaalVhJ3OdxAI7UUn6gBs8ZsZGhOst/6ZNrLKbkeWyeDMG
         +dLqiw0JEHJ1/D9PZaCF71OuNTfPFPm1dpel1Lsz+MB838dB8dRin0kh3hdBp8GvzD
         n+RMhTlbSB/5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45F82E52508;
        Wed, 25 Jan 2023 02:23:03 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87b5e16ec007de3523fd78534a48d6244bda3f46.camel@HansenPartnership.com>
References: <87b5e16ec007de3523fd78534a48d6244bda3f46.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87b5e16ec007de3523fd78534a48d6244bda3f46.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 0bfe63d075789456e9589457b29d6f9c279e3252
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02db81a787e304e5afaa31dc66522d39d3f89f1a
Message-Id: <167461338327.26446.15357183691109954850.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Jan 2023 02:23:03 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 Jan 2023 15:05:08 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02db81a787e304e5afaa31dc66522d39d3f89f1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
