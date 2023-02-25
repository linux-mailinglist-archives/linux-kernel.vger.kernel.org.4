Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208D36A2B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBYTUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBYTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:20:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F701422D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:20:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6784FB80B2A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C60C433A4;
        Sat, 25 Feb 2023 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677352804;
        bh=/qP/wNSLKQN26nfIYrHRDuGuTrlRhIpDLvurGoCzVZU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h9OeX7TdxgUF6wui9wk3I3F3FCh3qnlCYvmTez5Kj+6MbdTT8JCHAbdxLjBzss4kf
         FEfAsOBsix5ejHIR0QA2fUulnh7C+KlfJrGMbi9QA3hKflo8CG9uiKf3uNGxzZH8D+
         CM7Nott39ETSwv6kk+x9V/OJMZ9A5jQGKnM+KZ8HYUtWa7uywcDQKLYNDxCcIqZsaX
         mT6RdGzGd/4OTD2QiUMLezrYtFIUemAC9XucK2nIyQAS1IAN1GM997XLD9JxB42Q2D
         ku0kem0D7lGoZdPxFKry4NhMhusiFjCaS65OS9SiS2EVW2srOtH/9zZm9R2LHSk17P
         9daIABfBOVvtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB96CE68D34;
        Sat, 25 Feb 2023 19:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.3-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v8jrai21.fsf@mpe.ellerman.id.au>
References: <87v8jrai21.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87v8jrai21.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-1
X-PR-Tracked-Commit-Id: f82cdc37c4bd4ba905bf99ade9782a639b5c12e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0a32f5520a33e7f2ace396db6913625e0d29544
Message-Id: <167735280387.23615.5142912608434972331.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 19:20:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ruscur@russell.cc,
        song@kernel.org, bgray@linux.ibm.com, anders.roxell@linaro.org,
        nayna@linux.ibm.com, ganeshgr@linux.ibm.com, nathanl@linux.ibm.com,
        ajd@linux.ibm.com, kjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        nathan@kernel.org, rmclure@linux.ibm.com,
        mathieu.desnoyers@efficios.com, skhan@linuxfoundation.org,
        jpoimboe@kernel.org, hbathini@linux.ibm.com, geoff@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        sourabhjain@linux.ibm.com, fbarrat@linux.ibm.com, sv@linux.ibm.com,
        pali@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 13:55:18 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0a32f5520a33e7f2ace396db6913625e0d29544

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
