Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8065639CFB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiK0Ut6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiK0Utz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:49:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A2DEEF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:49:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C706E60ECF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BDE9C4347C;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669582194;
        bh=HL1oQAjJuQ5rvuKRBpShVoGB7I9OCIVuGV7lfz4UXDE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A3wRyXXJ/f7OX7OG2wGGZRT90xyVsJbTRmvhwX4TJhueJInG2vFrLV7hhw9VJh6L9
         RVbw3pAcXQYMD4gqAzgqEyISHRZAeKPnhSJHNkzhMTz39bV+bCkthqlU9bQBhhFlSH
         FQl4BQ1IG6aNlYnwsaD8jW5dHhojURG1yMvzUkRcoXCeu+0fW/naud9CNeLkvA4OET
         50S53cmVJQiP2GV2MwyoWCnOoiHw0h1sN6uAsPpzQyfivWYQqqOdxOP7gnQee3UTt0
         ZXi/X+dgKlK9Vxy886QvuD9QjHt/iVlIhMqz5QB9De5qGLHCcLIYksKvdZWwE0tVSZ
         39UltHDOFB09w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18D18E21EFD;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4NI1xw9d7E8O1Lf@zn.tnic>
References: <Y4NI1xw9d7E8O1Lf@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4NI1xw9d7E8O1Lf@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.1_rc7
X-PR-Tracked-Commit-Id: 2d77de1581bb5b470486edaf17a7d70151131afd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b465cf177377033f939224d8f16b5b1dddcd9709
Message-Id: <166958219409.7005.12886975768014113682.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Nov 2022 20:49:54 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Nov 2022 12:24:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.1_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b465cf177377033f939224d8f16b5b1dddcd9709

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
