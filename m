Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A465F94B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJJABA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiJJAA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7656D3ECC8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 16:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1390F60C2E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D14C433C1;
        Sun,  9 Oct 2022 23:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665358401;
        bh=se35KNSKJAXpxUJHlCsBcU8Hn+mQsEdL8kz62iPXXy4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RlpznRz71OFNS97ZK+aSkZB2/Jmx5pWit3wW3s8WBXD212WPA93E+4yMrGJQ00WBx
         EfDrJKIu4Vrjrx2NqcN+T3xRoF7JiqdUeALSyqPJykDEKc3ctrpVFXPyC0skb2xHsQ
         ZDQ5NbOyTrLLkZVxSGk9F5j9D6DEMB2N17EikQiii8ZyW5pO20YzwB3bTw+grdt9Sw
         SZoe1BEYbhZleLCFOJAgUpGRDYNoI5tb3e/J8iK6YWagBckXaw5Zgoh8Snw0lVzbeL
         p0T6Ru/11IEua/h/zGKQQRr4fGMutp7wuxEthylrpqsq6Y8IVNEwKb+Emp8a1bvE/L
         d93swnVgKvU5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63544E21EC5;
        Sun,  9 Oct 2022 23:33:21 +0000 (UTC)
Subject: Re: [GIT PULL] signal: break out of wait loops on kthread_stop()
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877d1gy3vh.fsf@email.froward.int.ebiederm.org>
References: <877d1gy3vh.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877d1gy3vh.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/interrupting_kthread_stop-for-v5.20
X-PR-Tracked-Commit-Id: a7c01fa93aeb03ab76cd3cb2107990dd160498e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c71370bde7dbd3aefae0c2e8dd643d68fb2c51c8
Message-Id: <166535840139.20820.3563420364201165944.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 23:33:21 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Oct 2022 16:49:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/interrupting_kthread_stop-for-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c71370bde7dbd3aefae0c2e8dd643d68fb2c51c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
