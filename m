Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE966B140
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 14:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjAONZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjAONZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 08:25:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E82125A0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 05:25:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2DD360CD4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 316DAC433F0;
        Sun, 15 Jan 2023 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673789120;
        bh=Qk1JkVp42F67hUb451/6DPw87W4Wgr3dMzGbhRPONek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wbn2CuP41Lz28hS1hA85k6cFH6xoOp/TBxbi9vexTImsVmENDS+YM4ihDXOJQ1w7v
         i2zsCQQ5l1yeoIWYHhVDib2NeSEAeGY45U26TYfiRxEbMpem6Vj6opDb7COyFj0h13
         5PY2IvJ4/orvON7NAZz1prdZ20KbrghYcatLtecMJ5Fx6JG8o4ggVRS7hcFDbMVq70
         xHLN2GV40idZIvxxGpQG6+0q557Ih13zv5b07M1hFP9bvUP6oIOfs72CgBB+/v0Mez
         D60JtUm6iHe20e2o7LNPvm4apmP/Ij1tXb9TdCcch4NM4i79qNgbKfl6MnsvGZyIga
         nCy7UcWTKP3iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A3CBE270DC;
        Sun, 15 Jan 2023 13:25:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8Pnsx1k3TN/GWlc@zn.tnic>
References: <Y8Pnsx1k3TN/GWlc@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8Pnsx1k3TN/GWlc@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc4
X-PR-Tracked-Commit-Id: 26ce6ec364f18d2915923bc05784084e54a5c4cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0f70ddb8f3bdbe670b1fab07271dd772e54c341
Message-Id: <167378912010.21615.2223574996578130542.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Jan 2023 13:25:20 +0000
To:     Borislav Petkov <bp@alien8.de>
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

The pull request you sent on Sun, 15 Jan 2023 12:46:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0f70ddb8f3bdbe670b1fab07271dd772e54c341

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
