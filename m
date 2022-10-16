Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011EB6003F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJPWkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJPWkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:40:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62482F5B9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 15:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17601B80D5E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D58D8C433C1;
        Sun, 16 Oct 2022 22:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665960045;
        bh=Y6ySpFQ1xIDOoy3WhpcbSIrBbDJYL2cTUm1Z4yy9Z30=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HyNQ96fB+HUo9B03VwIFIAScJsghwKRnmQoYDXGmJfPbesHRulYNpKowdT24hBll+
         AHQ2R7CD4W3oa6dH9oPRqT8rtAeSD0COH7H4Ix/pkSabCk4ZNh8+DQvcM3aAdd4UbQ
         9reP7kXSoS/wdCp1kykpBGYcdeUmqW7GgAT4bBY3RbkwyVDrJ4i2S5yMPIYODRshES
         ygLahgjiM0JTvEe7S26Z1l+B50JFGjZNLMUOT9BO6V4l+vxrVSnr8VT1PQo9DWV1dC
         E4jkogklVUT0BBV1cJPjnbyCJvyALEo0Gu5M+zUjDVQf8qel85tsPwxzQ9ylUzf/tS
         HDQ205gjCEiPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFA70E270EE;
        Sun, 16 Oct 2022 22:40:45 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 6.1-rc1, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221013005845.1325870-1-Jason@zx2c4.com>
References: <20221013005845.1325870-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221013005845.1325870-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.1-rc1-for-linus
X-PR-Tracked-Commit-Id: de492c83cae0af72de370b9404aacda93dafcad5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1947d7c8a61db1cb0ef909a6512ede0b1f2115b
Message-Id: <166596004577.22130.9006814183723817383.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Oct 2022 22:40:45 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Oct 2022 18:58:45 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.1-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1947d7c8a61db1cb0ef909a6512ede0b1f2115b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
