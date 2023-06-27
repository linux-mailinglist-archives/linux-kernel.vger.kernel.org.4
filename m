Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A608674054C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjF0Uwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjF0Uwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244061999
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13DAA61228
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D4A7C433C9;
        Tue, 27 Jun 2023 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687899150;
        bh=Pu54VLcEp/dhoFUUeR1k/mgmd8XQq9gqtDfs0B15WWo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NJsBBqyzQA42mKMOw2HwuX+Hu5TuC2dhZTolt2wGNVgsaC9CnUJ8w7JS5rCMuZ5C0
         Pw52ibSbYwVnjBvNuWO501yE8b/zyPdPu6W3LJ3QUNKXFJ753yhAJ276niUhfgH+2k
         A1TnoB1NRTUPsKFXzilEp9kKZN60XXv0/XvIL992ZowtB3VT1D5iNgfNXvtpdWYPvl
         dyv3DPFbuPiooLJEXnpW7A8pfX+twULdkGWIqDfbETdxJpYxjHVBTkkjLxGU0mj1BQ
         pMIzcCxrIL3yxd5OKDrFY3JqrKaJsM9u1OwYjroChPXd7s+FTMppraTDLd4Fpq9MuW
         epU/tgBo+rZSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A637E53807;
        Tue, 27 Jun 2023 20:52:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.5
X-PR-Tracked-Commit-Id: 5516c89d58283413134f8d26960c6303d5d5bd89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4baa098a147d76a9ad1a6867fa14286db52085b6
Message-Id: <168789915042.12194.13988158753609530449.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 20:52:30 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 13:00:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4baa098a147d76a9ad1a6867fa14286db52085b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
