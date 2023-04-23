Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0846EC0E3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDWPuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDWPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:50:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357EB10E5;
        Sun, 23 Apr 2023 08:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E29614A5;
        Sun, 23 Apr 2023 15:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 353E8C433EF;
        Sun, 23 Apr 2023 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682265006;
        bh=BQkeag8jG9z6sONsx1ebiY3m5AuTkbm/qnSV+IvhQVU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r0kNTs3z1sWRz/cQYr3JyqOKOBBeeJu2Fwkin5NHf8+6aKmFjb8ckajuz82kmYgrI
         LowK49gSe4P2Q9MsW3clfZidwZH068TFtyb2A6Hm8ASyEZa7vsT1j6Yi0drFyWkq3N
         Cnlpa5l3b9xqSDQtteiZ4GZDP2T8fD0udxSUUBy9HuhpxtzjTUNlIaC1uyDUgrB6fD
         gUBox9l4iY+1pGTUtUnGv4LHy1l5LlC6M5OjHXZIpPW0CEkzDcnLStGUn0FyHoBIPR
         lZE0oWNMQjGuMXjAfbou6dfSlncDHd+bOPgMOU6PLlMj55JQgqDqEbILSfdQ3uJrqO
         toC2wsgHpeXDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 194D0C395EA;
        Sun, 23 Apr 2023 15:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.3(-rc8)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASokmOqPSzuaAf-vTdNM7jKRW=9Y8S6pZzkEWf_6HLQeA@mail.gmail.com>
References: <CAK7LNASokmOqPSzuaAf-vTdNM7jKRW=9Y8S6pZzkEWf_6HLQeA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASokmOqPSzuaAf-vTdNM7jKRW=9Y8S6pZzkEWf_6HLQeA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.3-4
X-PR-Tracked-Commit-Id: 9cedc5e89a59da72bfecdb76bfaa5a28a273029d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8296ac9256aa1e9305033720de77ee5419a80f6f
Message-Id: <168226500609.30883.6802184678254356051.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Apr 2023 15:50:06 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Apr 2023 21:41:15 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8296ac9256aa1e9305033720de77ee5419a80f6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
