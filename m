Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B36DBCC8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDHTb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDHTbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:31:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B140BBDF3;
        Sat,  8 Apr 2023 12:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC114616A7;
        Sat,  8 Apr 2023 19:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DD8BC433EF;
        Sat,  8 Apr 2023 19:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680982269;
        bh=5224IyhGVOb15H9Nm3OWi3UBPjYrZZgAUCAt8F+j8Kc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iLLZ8LpAg0c9PNjihOb9N2oEDX5jR7nuTrlopxAMyByIyFwxq/sZ6To7C7GJBQ3Af
         0ZpLV6f81+YCt+DdHKpeYbo44T//WPTk6zDdOjheYfIL8bbOuhvtiJqjHwVmAE5u2p
         h0UKYTbKp7mm2FaWGC3uHKpMY984xnSFs4qNkCcnmNE4lTrZIKqHJFhYIW4AXCqAJR
         TBYChFucnDJ2DHfeRQNnwQj8BxbQ5+EmFVl+OiQpQSQvOEEORlxaahrWaylkiABzdQ
         kGCTc6DBayy4JJy7572DX46Z6E98z0Fg9RqdKzz4x2fQnZnaJJ/Oj5yIBbIX1Lozem
         I+zK+MZEitmIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C7FAC4167B;
        Sat,  8 Apr 2023 19:31:09 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZDFUfXFg3s03QbsL@kroah.com>
References: <ZDFUfXFg3s03QbsL@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZDFUfXFg3s03QbsL@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc6
X-PR-Tracked-Commit-Id: 1edf48991a783d00a3a18dc0d27c88139e4030a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a211b1c05d487dc9f78688ac3058d2d7a4581807
Message-Id: <168098226917.15421.15703434838357923152.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Apr 2023 19:31:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Apr 2023 13:48:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a211b1c05d487dc9f78688ac3058d2d7a4581807

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
