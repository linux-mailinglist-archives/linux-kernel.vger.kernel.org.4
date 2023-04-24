Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCEF6ED6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjDXVpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjDXVpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AEF526F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAD0D6289E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 21:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31684C433D2;
        Mon, 24 Apr 2023 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682372735;
        bh=HUnZzgCKUHUfilPp2qY2dzIsVqnaG0ylfpU11ZB8bCg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cbfBMkx+Q5/NIKyBTVZcugifVtQgjAaEpYHQB00MzMVP5fPRHoYmduczA4juc0DJx
         5LLY8Ojr23P4Ynp1ZFR5chfjQ61JQa4FKhd+VeJJEnWzqJ7c+X2oxLR2ZLkZYjIyPg
         K3W9WUtCgrGALzJOEzBaQkLrLctTGuuMSkU/iJ+3OxxXrB/jq+GJbn8dlCTqOMeybb
         GyGX+rove1lpUuTxkEkv04btm/1LczZZMIlN6zbr9yVihfqd/2CUikWgfYHUX+4vfO
         H8eIzs7gBF5ShUXo0vdk+HXphBXZUfeOynO3L+/h8g98gKOTCOYmRK0S2yhw5yeucK
         lvevqI8bEMjpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DDB0E5FFC7;
        Mon, 24 Apr 2023 21:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEX/1kWqrA8pU/g5@debian>
References: <ZEX/1kWqrA8pU/g5@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZEX/1kWqrA8pU/g5@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc1
X-PR-Tracked-Commit-Id: 745ed7d77834048879bf24088c94e5a6462b613f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61d325dcbc05d8fef88110d35ef7776f3ac3f68b
Message-Id: <168237273511.2393.17852620444983688131.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 21:45:35 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
        linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 12:04:38 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61d325dcbc05d8fef88110d35ef7776f3ac3f68b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
