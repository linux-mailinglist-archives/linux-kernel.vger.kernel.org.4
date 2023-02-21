Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28AC69E5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjBURZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjBURYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:24:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C23728B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:24:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F65B6116F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FB17C433A4;
        Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677000284;
        bh=P9+V15zEXAO9sFcpG2nrEtgu/m+bE6AZgsYppCWkUs4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hhmhCdLlLQHxHsZD6dDpP+HE27X6MYHAaEqAc8/sPGNwygKlmsb/zsi3tRDl0qydW
         epXHiGil9yXNYlBWBChAgPrYe2sou6UMYE1EUawXxni+fRBi7nJEq4gJPc0TYeuaYX
         0G1gXoMRnvCH/u4sGpNj8k9ac17k/6/x5j0uVSei3Qyu/GPecMJTYvx6dWe1uLDwwy
         9cyouMyN+bV7AEQmZ+OISdCUXqj464QtrZLdF/0l93SDWrDQxC0NePlzNWksMcGGlO
         VPkGYJQBOND9bsBxYS69TcWNlJXlwPIEkKvJ8m0BUagTVEsk9cv7lYKsn1dpWiixt+
         3DcDIRWVHTJxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DC62C43151;
        Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/O0nWz6/zDIxp7z@zn.tnic>
References: <Y/O0nWz6/zDIxp7z@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/O0nWz6/zDIxp7z@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.3_rc1
X-PR-Tracked-Commit-Id: f33e0c893b22bf94d7985f1f2aa3872237560c74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efebca0ba9cfe2bae79dba7b2b09b129c41cfc8e
Message-Id: <167700028444.32027.1956991418582846522.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 17:24:44 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 18:57:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.3_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efebca0ba9cfe2bae79dba7b2b09b129c41cfc8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
