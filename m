Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC15FA39A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJJSsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJJSsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE72753A1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7AD60CBA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2620AC433C1;
        Mon, 10 Oct 2022 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665427681;
        bh=h51K/rqs+s4fO8CPE65J7BR6MKGYPeaRplIMtHznXis=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cFLITsGAx7BWiKdGdj5JKJe18MrHmmCElIhIBS+ddc5JbZkU+TdN+RlcGVkmLosmx
         76xp7D1CATaDPZo+80NoFT5Rofh/gw752dF2kHCBSdev6JNDpcL3AKGE41DGfmauPX
         Ok+MPg1fQji7vVLfPutnHjSkWahXOpyd8FqVbOrx5N5//jckickFe57MTIPAtzsVVl
         0QgycArJuqWoHq2PEo+2qO5JiOuYPXL8QZV86dtylHbH3n7HnSk2M/5oMA/Iv8bgbq
         LgsR+D+miNc1j9Sih7j6suTuipLlkM6R171qVBiEdXFEshQuAfpAMYVQiTJM2FQUrh
         qmdnnMZGbpUIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 164DEE4D00E;
        Mon, 10 Oct 2022 18:48:01 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003174431.1189919-1-Jason@zx2c4.com>
References: <20221003174431.1189919-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003174431.1189919-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.1-rc1-for-linus
X-PR-Tracked-Commit-Id: d687772e6d2cbffd91fdda64812f79192c1e7ca0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a890d1c657ecba73a7b28591c92587aef1be1888
Message-Id: <166542768108.29715.15403427890450823622.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 18:48:01 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  3 Oct 2022 19:44:31 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.1-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a890d1c657ecba73a7b28591c92587aef1be1888

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
