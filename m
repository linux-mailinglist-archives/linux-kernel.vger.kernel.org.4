Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C16264BEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiLMV4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiLMVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269623163
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:54:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7F261744
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4331C433F0;
        Tue, 13 Dec 2022 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968441;
        bh=H7xHnyyujCrelRmUJIHgdtwXe4O2BbG6AyWSJ1RSxVU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R7q2DnkUqp2PGg6jXgBLcRawIYl/sWMpFZ4BCdHScb2AbT1W8dJhKzHnTzqZISRRa
         Orzqb+8qBzVXlFLdGxutoz0Mje0X0q+qwRT+qjE6BydknX+UojsPv7kAi3588igzv+
         8MCWZNO5kKwp3Njs/h43MbTZX6OaULuQNp6qMdWAfQ1GleYfPfED5rlsVrZWCGjscC
         YtejZ89Qz+QLQT04rfb81QBSMEw4Escakj4LV11hfw1MsWIpbOSlpC3tj5MlE48sQf
         fiMkA/6dkaAuxlKtncV4oyBjUUUj3rpXIuvwIqFLrZsxPERWNwcjth5W2Ka3EIVY6w
         peWqB9/UdVaLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93963C00445;
        Tue, 13 Dec 2022 21:54:01 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212131604.BBF5CC433F0@smtp.kernel.org>
References: <20221212131604.BBF5CC433F0@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212131604.BBF5CC433F0@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.2
X-PR-Tracked-Commit-Id: 8f3cbcd6b440032ebc7f7d48a1689dcc70a4eb98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5589c436d4646e0dc23f64264db8e04cf67c88f
Message-Id: <167096844160.13204.1583833685102955396.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:54:01 +0000
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

The pull request you sent on Mon, 12 Dec 2022 13:15:53 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5589c436d4646e0dc23f64264db8e04cf67c88f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
