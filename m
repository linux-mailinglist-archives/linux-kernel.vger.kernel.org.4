Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0030164AE73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiLMDuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiLMDtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390FF1E3D9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:49:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F029DB810C2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5B32C433D2;
        Tue, 13 Dec 2022 03:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903377;
        bh=J6hXfOc9p6Chkk79p+0XqEi5Mi87+B9hMZxv9MMay9o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GPRE1Pd6s5xXbXpwqk+Pf0gqIRNXEtYkWdTBewQDaXcC2PPlIN0VmVCLIy7lB3eMP
         zp5W4JcsMwvx3jbxE2zjKE1aH0Qzlvw29DnVaz+DLQTIWImMJfg5FK7I+2YEbWsXyJ
         +OqVhrTOCLPJoeqdE9bCNSYPQX2MdoqqZtAf+4i8HMcVy08DwqJPtImi7qR6KHfR6X
         i26XGel9JK/926AqcoAq96vh36l1GVUeIu/BOUT4jLBbCLC6MU3sljm2xihPBHd5cS
         hBnKtTk1HWU/bv9NW/txyQ6cOVUSfZNI/0t2bShYsOETBAAuA9zGIcKLekiBW66sIb
         gHZdTJvO58t/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A408CC00445;
        Tue, 13 Dec 2022 03:49:37 +0000 (UTC)
Subject: Re: [git pull] vfs.git elfcore pile
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5Z0zPBjWtXTWxLF@ZenIV>
References: <Y5Z0zPBjWtXTWxLF@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5Z0zPBjWtXTWxLF@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-elfcore
X-PR-Tracked-Commit-Id: 38ba2f11d9ce0e7c9444e57cb1bb418d1979534b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 405b2fc66333cf12e613634d49de301658e26426
Message-Id: <167090337766.3662.6535022119469179208.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 03:49:37 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
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

The pull request you sent on Mon, 12 Dec 2022 00:24:44 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-elfcore

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/405b2fc66333cf12e613634d49de301658e26426

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
