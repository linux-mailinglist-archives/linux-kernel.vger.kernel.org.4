Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA336E3ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDPRnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjDPRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FA91993;
        Sun, 16 Apr 2023 10:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B70B8611CC;
        Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23945C4339C;
        Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681667011;
        bh=6NX8o3ktcWgeYLlUWfELdTGy2k4459H9EYi3bagAUUM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TgkvQI6wE+DSu8D4dY/XdePKLzw+HXF6G3JRoYMx7V2wRpe7e4pFdyzpkbmFX7RLv
         QLgaSXruzzEg8DafJewU/EDibWATbF1yHE8oWtXranrsC3cqy7xwuuIicgkIZAYPP2
         ffGcC/j2AvxaH/h/j9YwPRBc/upb/CX+Pb2OcNwvEQit3MZfFXL4B6OFwCuKMC0Cui
         ws1PsH+mBXbTN8XiAHLI3RXPiSphPRT1BqlfT6vcqD2iViKaa1Jshg8dyLbZnYsLw2
         mkC8bRKzdKLEx07VUVs0Qly5dalWDKidp53SXGy6wQnHQAQP6yJgNYzaj0NWulgDyo
         X+5h84vbaXG3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A3E6C395C5;
        Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATfEXPreAvHcLdzBrRX8ucYWM7t4_VxSLTLdcxPxVaU-Q@mail.gmail.com>
References: <CAK7LNATfEXPreAvHcLdzBrRX8ucYWM7t4_VxSLTLdcxPxVaU-Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATfEXPreAvHcLdzBrRX8ucYWM7t4_VxSLTLdcxPxVaU-Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.3-3
X-PR-Tracked-Commit-Id: 3c65a2704cdd2a0cd0766352e587bae4a6268155
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0dd81db3eac4b9455be5ce40d36320989024593
Message-Id: <168166701103.4218.7140217145570725799.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Apr 2023 17:43:31 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Apr 2023 20:34:10 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0dd81db3eac4b9455be5ce40d36320989024593

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
