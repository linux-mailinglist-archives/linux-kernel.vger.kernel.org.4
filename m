Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482166A3404
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBZUkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBZUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:40:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DEB8691;
        Sun, 26 Feb 2023 12:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6662CE0F09;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ED98C433A8;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677444013;
        bh=MCeywGqJV7rj79oAKjlVvpdf14RoFC61p57a1nj7YGo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JogyUwGtQ5UnWJcI9p/Oo2HBO30L9aedPMUhD2s+j69LJAUP+zFqBo1AuobKLW48O
         5+23q2PYGdtOrtePrv333R9NwNDVZDJpd3+BmVnMatW6ty6ofNFB5m81z+OgKHsxpf
         Od5UF7wGzdaQo3Ya2Ja4B808Fi6pdsW2lNHi7sBi62yzXuFDOtXTKeCxw+xtc8j7t6
         CiRTxVE8ieHWAQU7itn/p6VyKuVxTB8GMYsDvqakbir+LGDPTBW2Qnr4WM/F0joRVu
         uAAbiJl5H5rrEDWFdcZxOJzyhpMCTlpmDaYM1UXYd8IDPTd5QY2EsbGmhCuBrJXbpY
         ipgiI/kkuVQ+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A70CE4D010;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230226171452.298931-1-andersson@kernel.org>
References: <20230226171452.298931-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230226171452.298931-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.3
X-PR-Tracked-Commit-Id: 95e158ec843666d76c09900507db08b76d77ce3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b0b0dd857652bf77d5350c6aec6cae767c48824
Message-Id: <167744401330.16333.4941422089815556610.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Feb 2023 20:40:13 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bastian Germann <bage@debian.org>,
        ye xingchen <ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Feb 2023 09:14:52 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b0b0dd857652bf77d5350c6aec6cae767c48824

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
