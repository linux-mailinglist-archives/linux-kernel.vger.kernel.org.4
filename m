Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956B3626245
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiKKTnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKKTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:43:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241B8637C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:43:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6692620A0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 19:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13462C433D7;
        Fri, 11 Nov 2022 19:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195817;
        bh=bGuqAjygKKEjAJRkKjOXIXbaIAATMKe3AxFO1v16Xnk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fPkPNnWlrNh1/NSZMplDX5IMv/BoHZh5Uzj20yG5s/2BMWbP5R3ptNy466aN/afPk
         fm8Vm6mdvxgV0Hi5255vVo34I80eolbWl6+kGxsSRz9fx8aVgir6WR92NOP3UEtUcx
         Ss+JzJE/tgFFf/z3/sZjGyed4jj/X5jI02ZY8pBAsCNlBlvmO8L1nBBnsUUD7XAyF7
         dUg0BaGqVP47AbUOB3nq9Uo5doPR7JHK0cpH7HQ+ao2yhQHDXDfPdrTIb/uQumi3sS
         fQSoKla4eEyxLvZs8cShxiB03/pT4K5agOTP7JV+Bp2dwdepUjbkWcE4qw52/XVp1h
         kj1EhJ0zoaiig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEC14C395FE;
        Fri, 11 Nov 2022 19:43:36 +0000 (UTC)
Subject: Re: [GIT PULL] kernel hardening fix for v6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202211111036.19260F591@keescook>
References: <202211111036.19260F591@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202211111036.19260F591@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc5
X-PR-Tracked-Commit-Id: 000f8870a47bdc36730357883b6aef42bced91ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df65494ffbb351115e01016c376474bc424427a2
Message-Id: <166819581695.6561.18134821942865665817.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 19:43:36 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        xiafukun <xiafukun@huawei.com>,
        Zhao Wenhui <zhaowenhui8@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 10:37:23 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df65494ffbb351115e01016c376474bc424427a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
