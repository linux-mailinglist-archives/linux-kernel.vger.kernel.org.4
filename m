Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E9D5F4898
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiJDRfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJDReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD166A75
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11420B81A1C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1778C4314F;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904845;
        bh=z2h8DlnGn59VhWUzJZ2hDkibZ76jka1wjUIj/IqE1kM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ge7ZfTQZ2rqGm4aCFW82qubVyQJ9sXdCP3GAtsF4jfo6rQfVpyEssuB3rvQX6I8W7
         4Yc4C0Tqn+pBbuLBbWPr/XCrgckJs43ZHFF9n0JKsUKKQeBx/E6jssh6em3QxT6mZw
         bBpqh8zW7kZ4+AOoty3b3THBSiuINLuVK0rPh0KwVF8l2f7ZARowLfiA94EUXq4ELs
         Q2LE4aE1fa1DzeMdRnvEPP/utRKIfLpVhzeY/vpTD0vPP2RD2LrEXoIkqTUu5N8dKj
         SvHzeryAtoxF6A6TIn9u2pa9MCjZy5GTeaeg+DgK3ubCZ+hZUcriEI/zI15STabD+q
         SAMGTp7seuAXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1F6BE49F62;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/paravirt for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yzw/1M8lEiLriU57@zn.tnic>
References: <Yzw/1M8lEiLriU57@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yzw/1M8lEiLriU57@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.1_rc1
X-PR-Tracked-Commit-Id: f92ff8f5dca2acfa475842c71212657b0703c3be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bf445b65dd7d4c7d0e4efaecf38525abbbe74e3
Message-Id: <166490484565.22164.5359835772196598612.pr-tracker-bot@kernel.org>
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

The pull request you sent on Tue, 4 Oct 2022 16:14:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bf445b65dd7d4c7d0e4efaecf38525abbbe74e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
