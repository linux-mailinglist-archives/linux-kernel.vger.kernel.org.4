Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6A6DCCB9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDJVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDJVVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB25E73
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE6C611D0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CA6BC433D2;
        Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681161675;
        bh=GQTjWmQAYl0Bg2Q6G9vHO18Jx6bb8XxaEpN+pDKGi2s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oU7NEJDsVf1Axh8FqwBn/NxqLPB9F9nXT+nVPdEsCYb7zV0N+EdreqhaxWHp7OY0q
         sfIB3chokYG+vkR9cTuq4kaTFU7+2Y4TUjw+UbirP2huDugkSaQIP8LSZ0MeIhSGmc
         sBq94qJkvCuR3fOl0OI5FHnGRHdoYBUcEnLlkbzrvfTGEr30DO2XPjCFY2QPZRmBhg
         U7T1SRuk1gcIVIqgZq0U5g0L3g8R2LWFmMzUEfRCLL77MJsBARsoFVZnoLthhOrbdh
         6SZa51ZH2SnUOJfwxTOJwCNdxNaLYngPJL3ZQmWepdDtvsohN6JUWwKqEPafPir6dq
         UJYbxJrZbj5MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A57BE21EEE;
        Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
Subject: Re: [GIT PULL] UML fix for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <272357376.30348.1681071196889.JavaMail.zimbra@nod.at>
References: <272357376.30348.1681071196889.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <272357376.30348.1681071196889.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc7
X-PR-Tracked-Commit-Id: a3046a618a284579d1189af8711765f553eed707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 411eb014108594d160a20381e8738de6c62e2e5b
Message-Id: <168116167516.31176.14322304442055505493.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Apr 2023 21:21:15 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Apr 2023 22:13:16 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/411eb014108594d160a20381e8738de6c62e2e5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
