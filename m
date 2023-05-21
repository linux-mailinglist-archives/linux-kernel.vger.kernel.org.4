Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1570B097
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEUVE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 17:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjEUVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 17:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B8FDD
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 14:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7DD612A8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D308EC433D2;
        Sun, 21 May 2023 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684703091;
        bh=fJS5rbYIDNbLQX5J4VmvwHyFPCLIwLhwflXUWTy+wbQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gLfeCajHKPXhYwKyQnLiHC4vORuaGY+AbdIR+nTQiluObAwyV33385YAz1Na0P6+C
         Eu/qWZSxcLk7ZW7nr7r8spX+dwSlwUynqysPss9RNjExFhzXUqCSSvBICx4ZLLfA+n
         44TLEz/aJOtD0gC5D6j0wcn7UxBvAK5HPG+XaEU0x/x103ECYZRsAMAY2r3mALYli0
         VKf9cj1U3l3h9kcY+azxk2wRczs4dYaC5g26brTgq6Azsb6EObzhjcXdXacRVgFZuE
         D1buRjOof87PDGLkdniqcsqR7AD/+VOjL06XBvSjevHeK/UW0fl/ZJ8y2ScNZkZ4lD
         9wvpw3pin+DAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE0E4C41672;
        Sun, 21 May 2023 21:04:51 +0000 (UTC)
Subject: Re: [GIT PULL] UML fix for v6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <541536756.9328228.1684699797626.JavaMail.zimbra@nod.at>
References: <541536756.9328228.1684699797626.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <541536756.9328228.1684699797626.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc3
X-PR-Tracked-Commit-Id: 73a23d7710331a530e972903318528b75e5a5f58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa4fe8ce4256bee870eae1c4a5b33ad463590230
Message-Id: <168470309177.10838.17577002282279990550.pr-tracker-bot@kernel.org>
Date:   Sun, 21 May 2023 21:04:51 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 May 2023 22:09:57 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa4fe8ce4256bee870eae1c4a5b33ad463590230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
