Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CC564A953
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiLLVNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiLLVMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64171A205
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4047F61232
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A55BFC433F0;
        Mon, 12 Dec 2022 21:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879508;
        bh=Tx9nRv4QJ0E4S3NmbParxVXDBtsa15Esd5Mh/Rs6o5Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cdmisbeQ4bopQXtSJCnRmOBODF+GRM3SC/Yc7f/ZxJsiaplsoByjXHzz88nyUWIH+
         oDSi/gh/BiGmcTT8EZ4nIpjrhknXA2WvVFmNnoqOkjkpOzzWfJ56fMiK/xnx9Wlzld
         6bOkuQMvuZ1JvY6tBqTAbfq/XtihUZGzaKYt0Jon4QLdsvyfISEJ6KUJrBYaxq0F8p
         cuyFzMbccM4/Yvj0rluJq3VLfdfu4TXdXT/+cCb4r6MrIFOKqZOpTt3DU+S5vQ4Z3t
         Mj4Cgdtltsg+bCVlQ3+Vx8r3/glrHFMBS17EPbBaYzGw0w85Vau3xLttSvQnUdHfbm
         sqRHDpzKJv8iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 942C6C00445;
        Mon, 12 Dec 2022 21:11:48 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167083907908.564878.17662405881760397931.tglx@xen13.tec.linutronix.de>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de> <167083907908.564878.17662405881760397931.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167083907908.564878.17662405881760397931.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2022-12-10
X-PR-Tracked-Commit-Id: c4db2d3b70e586c7c856c891f4f7052e8d789a06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f10bc40168032962ebee26894bdbdc972cde35bf
Message-Id: <167087950860.1809.17431042520103849917.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:48 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:09:00 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2022-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f10bc40168032962ebee26894bdbdc972cde35bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
