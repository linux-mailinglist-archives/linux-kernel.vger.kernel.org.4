Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE35B41AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiIIVst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiIIVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:48:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF66F22F5;
        Fri,  9 Sep 2022 14:48:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A112B82320;
        Fri,  9 Sep 2022 21:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBE24C433D7;
        Fri,  9 Sep 2022 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662760120;
        bh=faNyvVTtA9QVwsXzpsorT5yjPAXHpaEUefjieYo0pkw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=am4GC8KpkI4j3383Gk6HeERUNtmcFd6apwv5DqdmduC0goksOgT1cKBM9Ot+AXhpc
         VaASEWe62FznItw6PtkoqzKVPaVc+cygdMhM4XO5SNYKSZ4Ql4fZC+IkhYBG7MiS8y
         HEKaWQlowrMkcPvxfFHRgd2CXU/5DlejtvhGMBywOhSsn5UuK2Sn35f4J5MgWPM9wH
         mqQMVpqd6+YOMyIIDf9HKZibtdVGCg8W2k4Xp11iPg8+Ojws3MeBHTEmK1lUposUn3
         y1OejvGmnvC9Gf/99nrdoZp5JXKOPvHoCVMqkT3yT0e+HJbk8iHh0LDsnCfcRnMNmW
         MHZ7ExdfMmHow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA64BC4166F;
        Fri,  9 Sep 2022 21:48:40 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1dd06978292c5c1979b79b1a94b4af4d7175d7aa.camel@HansenPartnership.com>
References: <1dd06978292c5c1979b79b1a94b4af4d7175d7aa.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1dd06978292c5c1979b79b1a94b4af4d7175d7aa.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 991df3dd5144f2e6b1c38b8d20ed3d4d21e20b34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce888220d5c7a805e0e155302a318d5d23e62950
Message-Id: <166276012082.19580.866003150784058636.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 21:48:40 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Sep 2022 15:42:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce888220d5c7a805e0e155302a318d5d23e62950

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
