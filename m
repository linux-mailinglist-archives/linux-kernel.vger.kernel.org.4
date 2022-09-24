Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463A45E8E28
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiIXPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiIXPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:48:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83830A0313;
        Sat, 24 Sep 2022 08:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2665B810F3;
        Sat, 24 Sep 2022 15:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94480C433C1;
        Sat, 24 Sep 2022 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664034529;
        bh=IXg2iWJ7jjOL+ra7uiFXqgJZBh8yG2RGJMjs3vBlJvM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HkNbc6QdGIKPKzSS+4o8YnNOWYU3+nXG7LCJCblAXHgEwIYXujer76JmllLa4x0QA
         yf7ouUiU/9WfFl99rukl7H9ydQamp9oUe+zuhb8It2R89Gvio1ev2WIVCQ7bBnUP8B
         PKaeLFfr7SRXO0MseQITYx3Qd1nJowLu3d4wdr03Y4+I6PL5cI6pLRxJzJ+judO9EX
         siT5cJSQeQJS6+VDTTVt9eNEF6k/NLeNOIZoJZXYnWxixzaHjVy96NHZ+dyiQgRqxN
         FgDPjwKND11RCjAe41CApIcsvLTSqx//rSu4FGh/q1tbhLdY6TKDYuBV94VstAmXWd
         7Ipo9zYjgpYoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83997C072E7;
        Sat, 24 Sep 2022 15:48:49 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yy6+jsGstABsKP1X@kroah.com>
References: <Yy6+jsGstABsKP1X@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yy6+jsGstABsKP1X@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc7
X-PR-Tracked-Commit-Id: 643792048ee84b199052e9c8f89253649ca78922
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e2cd21e02b35483ce8ea88da5732d4d3ec3a6c9
Message-Id: <166403452952.2421.10947971564971798020.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Sep 2022 15:48:49 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Sep 2022 10:23:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e2cd21e02b35483ce8ea88da5732d4d3ec3a6c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
