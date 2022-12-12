Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ADD64A4C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLLQbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiLLQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD2DFCC7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38ED4B80DB0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03C78C43392;
        Mon, 12 Dec 2022 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670862669;
        bh=JjA2ikQRyxGnFCxes7YpG1DhcGHv6s77ClCOnXbgkTM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i5aCQTFL+2+lYOPTNLT6md6ZyT8UJKZ0rh1FdgOUaQrTiu+Vgx/CqTI4Fo8sz2R0/
         S3DGkeMnKnkfFN1p6Zidu1n9RsegVSi8VTHZwf/Y31Xl8yAUMzF7jOX6lPACC1zn8x
         IaVGSffzCMvulMBqlBEi2BS+tyWYrI80x7u+cBodtz088GgYUKAIGZ24muOtmcLjiW
         cfelkNc30Udl8leTRcPytGZn4MyQ1nemlPsz/emqVB0jkqd7waZzDvlYLj/cbYhDdq
         wd/cMiBJZxJt//j3uPvdWj+FHc9lQgl8fLWvmMB1MXWeAXe2hd1JkXtcuasMw+MhIG
         jFCaJ2Yy9PFGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5F99C197B4;
        Mon, 12 Dec 2022 16:31:08 +0000 (UTC)
Subject: Re: [GIT PULL] -funsigned-char conversion for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221205150116.1064295-1-Jason@zx2c4.com>
References: <20221205150116.1064295-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221205150116.1064295-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git tags/unsigned-char-6.2-for-linus
X-PR-Tracked-Commit-Id: 0445d1bae1cce00ae4e99c8cde33784a8199bad6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a28c2c89f4b412b648761430720d40a8dc326ef
Message-Id: <167086266893.18680.16269402751623561396.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 16:31:08 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  5 Dec 2022 16:01:16 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git tags/unsigned-char-6.2-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a28c2c89f4b412b648761430720d40a8dc326ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
