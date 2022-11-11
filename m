Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B719A6260D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiKKSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiKKSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:03:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E66D76FBA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0AE862088
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14188C433D7;
        Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189783;
        bh=x96npkYzgzB8dcFmi6WgyvnHeS5hIEp+2WM+qqgihUo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S+dY+97/1ReCXNubqsZvNN5eRo6qOUsDA7s9LNMzGTLbf9zxbEnDN9d7AhmLqUHz7
         YOAx49jL/hmnxC6+JQEq4qGc5EwXff9E11jUXc69D4XS9Gpek6pEk9Fgas3dzpMBxw
         Jd9cMMN4ZXbun5E54nPCKkjO56WcCrlzxAOiblv8PYiIDskXQ5ASB0ZlKDtE8J/5u2
         F0VgH87daO4jNB4dmi8hfzLk5D21cpX2PlFXhoUMRkhzwXFcgq00qWIlu4qBbF/DZN
         nDaLTpt27QUjMD64Zx9o5L8j7XisCoieYqC48FGobIPuuNxVxUaX/8BFARE43xBdgH
         OsLLdUm+YAyxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00369E270C3;
        Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fsepx42m.wl-tiwai@suse.de>
References: <87fsepx42m.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fsepx42m.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc5
X-PR-Tracked-Commit-Id: 9a5523f72bd2b0d66eef3d58810c6eb7b5ffc143
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64b4aef17ea65c423fbcdee323b503d8e3ffb3a2
Message-Id: <166818978299.15878.8551955299415925848.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:03:02 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 09:56:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64b4aef17ea65c423fbcdee323b503d8e3ffb3a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
