Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C1721720
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjFDM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjFDM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E991
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 05:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AAB60CEC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42A2DC433EF;
        Sun,  4 Jun 2023 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883541;
        bh=TIpHurWDl1agQaI7nN++gIc388dZOYbC7RiHL6JrGIQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BbGVzNmADXU0AHnJYJo/uu6CvOLk/CtqBtJgLPSk/reX4GiUUn2+V8hQ86/zhvsaj
         z2ybQh+tW3X8DH+i+LrQMYNuRO4+HpBJGBLNs1DS9g7/Z11BYfReg3tTw6ZzQjzcoy
         bvaXQfPCQCpwyHDFD+xEsSNwd+MYxw3qBMrwjzhMZmQmhZa+uPDf4JT0VZExILD/5S
         MsQwx+EDyqfgr3dT9XBE2moeOIBc56q0Ic6f06f3nM9YrZi2M52cILr5RabUoSi4N8
         xxT+c3oe6Ld6i37O54NLHb7YEzu4RMV7DqzPGpc5gMhNL2Lc/Y7V2r7xBF1SEVHTgC
         tBo0p+Rco5P+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C852E29F3F;
        Sun,  4 Jun 2023 12:59:01 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHxFsQHCXZ9Q56uu@kroah.com>
References: <ZHxFsQHCXZ9Q56uu@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHxFsQHCXZ9Q56uu@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.4-rc5
X-PR-Tracked-Commit-Id: c26fabe73330d983c7ce822c6b6ec0879b4da61f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41f3ab2d5ded530f2b2c19cd3d27f072f908c12d
Message-Id: <168588354117.18655.9295096678761696696.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jun 2023 12:59:01 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jun 2023 10:05:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41f3ab2d5ded530f2b2c19cd3d27f072f908c12d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
