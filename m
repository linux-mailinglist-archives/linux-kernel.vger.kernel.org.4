Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADDC6E82E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDSUwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDSUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70F198E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C40464251
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 20:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4070C433EF;
        Wed, 19 Apr 2023 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681937533;
        bh=yxEEJ6WcZBfVM9gPxP0+439mL0X9TS20YaD5VZ/UScE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SDJS6HAysVkvwQJw3TH0ixB2zGDTVB6RpL2sfBzThwGzCNeQVQ2MrmxmqaGigxGRY
         PV+0mcz80q3YtFhXToYBPsK4tIEYxjTxOU74XdPPs4qWtSfDiyddaZZhchng7xesO7
         tcyAVdgh6PPTQLact8oJZ/7u7oY56bzaPsj3EXU2Mp0vFRF1VJZ37nM2kVto7fpb9b
         Df6vgD6GB87f3ZOXMk6Dx6z0dJ4JTsaXIc/kXKqJevrKQ+iHPfOU7vCx4SkjbEkGwA
         YRI251gciSF8o4Xu4AYWi0IUNsA4emyriGuxcQcVNRKF/9CB+KIM/YU3rLEF2zYTfX
         2U98XhoJJaE/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F7F9C561EE;
        Wed, 19 Apr 2023 20:52:13 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230419202440.9B2BCC433D2@smtp.kernel.org>
References: <20230419202440.9B2BCC433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230419202440.9B2BCC433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3-rc7
X-PR-Tracked-Commit-Id: 7c7504067c709905fc188c61ac3072d6022d1209
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72b4fb4c883d5deac74f5267e486f5dee1bffd5f
Message-Id: <168193753364.29762.14253200290082914673.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Apr 2023 20:52:13 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Apr 2023 21:24:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72b4fb4c883d5deac74f5267e486f5dee1bffd5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
