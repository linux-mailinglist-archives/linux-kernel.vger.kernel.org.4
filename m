Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A856A6411
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCAANl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCAANi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:13:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760113756F;
        Tue, 28 Feb 2023 16:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 134D5611FB;
        Wed,  1 Mar 2023 00:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B07FC433D2;
        Wed,  1 Mar 2023 00:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677629616;
        bh=x6C2q7vMYYC4+xHxP0ORcoPqI8I/HynO4vnUcxmwssE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QQwFpaOKmm6mFt0sf/nsX4H62iRzFBxuDMy5lAW3YNFxkkNg5qiMpzoGWgOddRzVx
         2TpPac1Fwp93NQ79y0MpeZ25jn1aqaxmrkd9Ve+iYKSk+KjLd+nL6VLPcbdBrG3ML4
         EpGoacQVF3YeC8EAPJZRGh9X1sZjv8N6jYnDPFxYlVOBsubuZn+QMohfvnr8yh0hDK
         hzCnfZr8tmCvcygowWgsxoMyp8GLj2DuN9THqZlAhwwbz3LQ9rGFkhdAPiFWRB/xEA
         7+t8f+j7imfgAwlJLV4BVWNwoqZvAIWCRgqudFOd4EFp8BTdNc+Wrl4nN0vueyclRE
         +OWYjo6elggHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68637E68D34;
        Wed,  1 Mar 2023 00:13:36 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation stragglers for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sfepwgpk.fsf@meer.lwn.net>
References: <87sfepwgpk.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sfepwgpk.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.3-2
X-PR-Tracked-Commit-Id: 901578a45950bcc4d5055a24e9016d61b84dc1a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1f1382a110bca1ef52234e889246a90f9a0d69b
Message-Id: <167762961642.26350.4906928327370194281.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 00:13:36 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Feb 2023 15:47:03 -0700:

> git://git.lwn.net/linux.git tags/docs-6.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1f1382a110bca1ef52234e889246a90f9a0d69b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
