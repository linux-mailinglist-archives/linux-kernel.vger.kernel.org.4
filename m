Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699406A7282
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCASC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCASCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:02:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCF736095
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22C16144F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1721DC4339E;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677693731;
        bh=LpStxG0IjAy/LEOuBDHzbJ9MpA68B0mjih3rawyQLYw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gWAF2467fnFlclkzvSQB+DTOztfYPmFq+uZlHCR2OhnEcpejXYM3sU6I1T9fMGT2o
         WfTxGBGzIci7oXrc8rWqgF43ZMx0PPeuZDnTYeBoAu3UPIH1NFU7eRazo7l+jx2hqa
         +UdfUi7XRa+DOVzJua/3b2FOJ+BbTdDALukZdyyNmpO7V1NmZPlIAxia9MSo2RKP23
         n3ktsD7QgYe2+KrghF7noJaAwMKuPpVFiYwdqn75lXQxSIi+LKKjF2fzgcGBhkrkrl
         lR9DrRvK2zxWXy9wqa+k2ST7yh7C8XugKGPa7ED4a8HI6ZZ1JQMJZVyeMpcbVDM6PI
         nGuo8mbvkPGNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 031D8C41676;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS updates for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1115586887.187161.1677658022188.JavaMail.zimbra@nod.at>
References: <1115586887.187161.1677658022188.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1115586887.187161.1677658022188.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.3-rc1
X-PR-Tracked-Commit-Id: 8fcf2d012c8641c18adcd139dba6a1e556338d36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e31b283a58dfe50ab1641d8fd2ead9b62f9ab256
Message-Id: <167769373100.10213.18332230181152988117.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 18:02:11 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Mar 2023 09:07:02 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e31b283a58dfe50ab1641d8fd2ead9b62f9ab256

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
