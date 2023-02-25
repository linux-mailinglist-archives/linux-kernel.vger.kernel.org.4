Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1D6A2BD2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 22:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBYVKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 16:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjBYVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 16:10:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB638D516;
        Sat, 25 Feb 2023 13:10:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6F45B80B37;
        Sat, 25 Feb 2023 21:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BDD4C433A1;
        Sat, 25 Feb 2023 21:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677359402;
        bh=xlnEzJJhw7cAjXuX8/9LTNcyUSy8gOui0HbaYzuh2bk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B+Zxe6xX2kernp2/mc5zxNJN7CoGGbhW1Ue9G54mX1PhqgrKV5uOxSUrHRTfdOxku
         tz81MB38lKy4IMGdLYkSDvX8rzhcGX1pM2VtCrmzb5jm8/0t+950eLx5+aZB466Vhc
         ZhukL2Foq73FaqlhBd+bUhbORds7cS2f7xbEFtDQD3bewBxBy5vwRHE/7P+4iDWilf
         Yjow1MD28/O8ri7+oopsyN9/BcMsg+Q+Fc1fR9PuOyjNHqnzjlE2kxNkdovIslYR8Q
         J9Smf9amOqQLqo0+oY3OuXHPV/PNDMvtk4RV7JDrwPhIETUjK1HZbIxoG5yGnEeLKF
         bUh8tMLonDzvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4236AE68D26;
        Sat, 25 Feb 2023 21:10:02 +0000 (UTC)
Subject: Re: [PULL] alpha.git
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230225204001.eostfx5mcba5vaiq@framework.mattst88.com>
References: <20230225204001.eostfx5mcba5vaiq@framework.mattst88.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230225204001.eostfx5mcba5vaiq@framework.mattst88.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus
X-PR-Tracked-Commit-Id: 290ec1d58049e6203062d5fc796c50852112ae00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e534a583cc438ec2e9a7dc534c9d80d14b440718
Message-Id: <167735940225.13638.11040118266112888511.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 21:10:02 +0000
To:     Matt Turner <mattst88@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Feb 2023 15:40:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e534a583cc438ec2e9a7dc534c9d80d14b440718

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
