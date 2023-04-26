Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA856EF8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjDZRHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjDZRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2887DAC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A82A6226F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C348AC4339C;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528793;
        bh=H7CqWFVpUAw/7Vebh4PMhNuemBm3Kab4UTdTT4iLd08=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DEMYUFhQsMwcMQNy5WQIluRStVTy7olwjSAvWFsxPtCnjPwDeumiltCpE9b5Wy+cv
         r5m6tfK+OoBGkMYuVExI7id3ljE0WaAeqcj+uADGn8NGRlqSktNBUWaglEYReGccQV
         2bZ0EWIRnL8tv+MJ7pTxillWesaqJyGnDAL5cLDic14f69ho6POULwX1d8BMCeUEQj
         FqSENLMcPbxaVng/QqEnaSFVEGej70RXyblsG+A3OJROcliyE2IYhpKYT6KS1RRMzP
         /+8rRyw5tm8pIbwiKOvpm6T9vBOFybOFDN5rGIHut2JRoqppEP+JKO8JStnaQqhDYi
         7LBiVfXJTOn+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD487E5FFC8;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs update for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEgdmJWhJX9NJ0fG@google.com>
References: <ZEgdmJWhJX9NJ0fG@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEgdmJWhJX9NJ0fG@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.4-rc1
X-PR-Tracked-Commit-Id: 8375be2b6414577487486a92995bdc97a7934033
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c7ecada25d2086aee607ff7deb69e77faa4aa92
Message-Id: <168252879369.19907.4817770283995017833.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:33 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 11:36:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c7ecada25d2086aee607ff7deb69e77faa4aa92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
