Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6935F488A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJDReT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJDReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3667161
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62F1460F1E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9639C43470;
        Tue,  4 Oct 2022 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904844;
        bh=tykbeOzubGNBTFUl6G7dkwIq/LjshCaEn2dPRlODSeU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eJBeFgPkkXvVr4WlAfSTsu7deD/+BPlQPS1WVacFe63qPRN52JFS/JCVBW/NPE9wr
         c16Grt6fIEUpyqTMzD3pws48cX1AnA6Vc9vNuIx2Tvaau4gYnvHKY+xW+d3l4IsX7D
         0dyFN3WJXTF6uuVydvNhrIULF0nO5TpilioEyWnPfNhfoxDA+KYBMbeQAs1JrudkjD
         5Y2SB9xvtRIrynhScm6FIvSf0bunBwgYTqiTL7QMjtshMZgLPA5izHS0OO0idZMA6b
         i2iJOl//CZCtcgg584Wq2d88QP/VSmwpq7vfsVlSb3Wq+2VgkvDFwu6oSXjNi9Qt5C
         YGznNivClJ/ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2EA1E49F62;
        Tue,  4 Oct 2022 17:34:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/timers for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzvujLPJUr0bHW9y@zn.tnic>
References: <YzvujLPJUr0bHW9y@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzvujLPJUr0bHW9y@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_timers_for_v6.1_rc1
X-PR-Tracked-Commit-Id: e1a6bc7c6969527dbe0afa4801a0237e41e26b1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8475a6749ae9727878c189bbff073a257e43cba
Message-Id: <166490484472.22164.10684096738339167609.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:04 +0000
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

The pull request you sent on Tue, 4 Oct 2022 10:27:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_timers_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8475a6749ae9727878c189bbff073a257e43cba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
