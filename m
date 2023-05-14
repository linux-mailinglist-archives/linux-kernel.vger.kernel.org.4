Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2861701E33
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbjENPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbjENPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDD330D5
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 08:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D5D61804
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6F2FC433EF;
        Sun, 14 May 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684079730;
        bh=vOGui1aqRz10lkvq+AxGZZpOhY+gtIFH9/sahlV4nnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UmXeLNAZBuXV+5pwjI+9oQ2E3to0KIHOMLubW92nVXT5lsazmqqVY8O54JhGGphgK
         +6JLyyRvpQkLWlxl+Dec+VBYe7+GiY3W/Jj8XV5mL2WDB/sdEhw8Vw2IKsi0iesl8N
         MzrgkW3TTPpKwqnRq8+7ZSbpJLKYrhIQjOWUphXRpy8i/r0+67vy0LXtk6kOVpr6Ds
         P41PmMCoRvwhg8bpEQtG3+2OVtGs6yXIrxYjXXalsIv/b3RFDbpaX2e8y9nBv9awRo
         lANa8W7e13vbpKK/XWFCuIZQUPDUCAAHXAZnRTNjJ83xeGZ6+qR1sJBP5GoVCnq+tt
         uQgOcMBCZiQjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DD40E501EF;
        Sun, 14 May 2023 15:55:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230514114747.GCZGDKY0ismqgQJXIt@fat_crate.local>
References: <20230514114747.GCZGDKY0ismqgQJXIt@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230514114747.GCZGDKY0ismqgQJXIt@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4_rc2
X-PR-Tracked-Commit-Id: 7d8accfaa0ab65e4282c8e58950f7d688342cd86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 011e33ee48849739aab1d25b9e41c824fb5383a9
Message-Id: <168407973064.9046.17943513523813074571.pr-tracker-bot@kernel.org>
Date:   Sun, 14 May 2023 15:55:30 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 May 2023 13:47:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/011e33ee48849739aab1d25b9e41c824fb5383a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
