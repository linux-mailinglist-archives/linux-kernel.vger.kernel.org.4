Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29F5F488B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJDReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJDReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFF76251
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A1B614E8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1842EC43143;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904845;
        bh=VT8HuXNks2rSjcMz70k3HF8Tklir/S08l6M3SuKVz4E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uir2mA4P0C0Wacz/US0QEkFjc+k6dLeJ8Seu1u+B2ybTyx45SpsEH29SzF1kx6+ZI
         pNMbo+HUn+U32O6xj/oyR9TdB4IuHigTvkZJyRYY5PK8H9vQm970xXMZKGoBg4bOVc
         wg9arbquYA/iypE1Kb1pmsbiY4rF9DysdyfpyCZV0isK2ljrsLMhKbickcOyhgM2hA
         7NC/E+aMJcG47riosMXa+rx1mTEhSKB6LO+QK12i7VGjDk183u29F8Lm0zDsKpIBDs
         ji30y9PNEOV6xqlokHT5Jq+Z+ZAXcVFLbHFI0ygEUBMbqgBtQFmHjzgcuk4Eewuy26
         zV+6vOeSRoyYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 015C3E21ED6;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzvzxYCBAPX47PTf@zn.tnic>
References: <YzvzxYCBAPX47PTf@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzvzxYCBAPX47PTf@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.1_rc1
X-PR-Tracked-Commit-Id: c926087eb38520b268515ae1a842db6db62554cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7db99f01d1879f30af95f14dfd5cbcf009d15166
Message-Id: <166490484500.22164.1786201671630735821.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:05 +0000
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

The pull request you sent on Tue, 4 Oct 2022 10:50:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7db99f01d1879f30af95f14dfd5cbcf009d15166

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
