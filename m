Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30076671E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjALMQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjALMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A85C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6E55CCE1E25
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FBAAC433F1;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673525767;
        bh=Wyr9+TwfYppVd/Qg3eDLx0q6Ig9jky07nhXMYkVMzEw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VgcEZ3fHmBQIduJLlG3jb8AssEuNnlXkA4qqHgPFI4y97Qqo+pKBNMpbrk8ymjGJh
         jnsF7Htjx5HItw3XZoKeMkjpQc9JPTJRLuytI39UG8pvo6alwGhEcpeXNs/skrW6xi
         FEF7dQjavG09PJTsMmlHuimIYYvTkD6xy9T06Bpv8xQ48bDsnlR0zwr71y8yvD7J55
         6YPLsTfdzJpq3GmkOOjIH9YaguSfEuY8rxqqit9MfdTFW9a+Tr/mV5mQeXwey0BIrB
         stgsbcIlhdsxPhxQz4JIf5wZLnj1Mx/pbgvy2RXCvRWxTFTxbjCvBxWNOANVczjHXT
         zBWTphAic3qjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66817C395C8;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230112113311.98C9FC433D2@smtp.kernel.org>
References: <20230112113311.98C9FC433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230112113311.98C9FC433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc3
X-PR-Tracked-Commit-Id: f528fe213a6ad21a6e8644dbd5de10dc264a89fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf9668a2f2a6a82d5b03894a5f5ae98d17596982
Message-Id: <167352576741.4374.1578724210259555974.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Jan 2023 12:16:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Jan 2023 11:33:00 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf9668a2f2a6a82d5b03894a5f5ae98d17596982

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
