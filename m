Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED65F3AB4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJDAhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJDAgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C06286F2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8BE161234
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46356C433D7;
        Tue,  4 Oct 2022 00:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664843808;
        bh=VOSqvmKlOlcqxfUXv4YLC4AQcNzmP+/x44Rtzz1UZjQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FsC78kZNxcF9u18zZbfDTzBauOt3b6ZgVZAm/cKcru7uH/b+zaKu6LbdSsCZZoyi/
         Ln7XhE285hX2DMC/wZFAagDs6zoDLAezQ6P/TdTvatno6p7I0vOGyHb3sl9f3pdzC6
         6SbabdbloIz9z0xy7igtfBfjTZILlz7nTi/VbFZbEDnpve3tkUyAC4wPiOrE9nfRW9
         tr+YwZFX8WDQr1XNSm/nbSiaADpFLB6LsbG0UmtR9jaI6O9wjDL1Y/qCWFlFrd4DpD
         1Pq0aDEw6Zov3lpksuSmQr3jv39/2VUhf7wz0NmeXdal/NtRx/VhRTozBOwyUvHiZG
         116JsuoRiqBgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 330E1E4D013;
        Tue,  4 Oct 2022 00:36:48 +0000 (UTC)
Subject: Re: [GIT PULL] kcfi updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202210010918.4918F847C4@keescook>
References: <202210010918.4918F847C4@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202210010918.4918F847C4@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kcfi-v6.1-rc1
X-PR-Tracked-Commit-Id: 3c516f89e17e56b4738f05588e51267e295b5e63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 865dad2022c52ac6c5c9a87c5cec78a69f633fb6
Message-Id: <166484380820.25503.15203283277776477703.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 00:36:48 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 09:36:06 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kcfi-v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/865dad2022c52ac6c5c9a87c5cec78a69f633fb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
