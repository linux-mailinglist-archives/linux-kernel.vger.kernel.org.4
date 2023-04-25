Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346466EE7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjDYSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205ED16F3C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B6C6312A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01D8CC433A1;
        Tue, 25 Apr 2023 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682448708;
        bh=05VGnNy1qFfuFBE+5zo6+QY/jpWEFWZSIGQ8Sw9/H6Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=exqytgXRjhzipCy794ahDZNkRRxIj0ponERzXE9rSHsF+ZKra4LZ0PC0TZc/zB6U/
         Yt2ElzeEKUy/Ifi3bfTrs7UCK/PpZb3d2seCYyO8L6Rn7XpKiaU0cDc4s6wh8wXmyG
         csfAyWxcKcv93RVZxForhR9EyvVDZNrJ7SACIKdR6WeUnFj/YuSwDeXoASmMiiz0OE
         fJkH3QFiy0n/MQtFCduD2q2EDBpZiaD1ozXSNwul1X0Q/wzMZajvY1ogGhNmuUOeP3
         XofmdkjnL1MRzexrfrNwJwJPLVcYaXQPXypY7zqwjbo4U/H0HCRBQm1jN3bB78Pwu6
         HN8WzvtNQQXJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4070E5FFC6;
        Tue, 25 Apr 2023 18:51:47 +0000 (UTC)
Subject: Re: [GIT pull] x86/apic for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168235969391.840202.8176231027101593470.tglx@xen13>
References: <168235968801.840202.17752066425816055574.tglx@xen13> <168235969391.840202.8176231027101593470.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168235969391.840202.8176231027101593470.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2023-04-24
X-PR-Tracked-Commit-Id: 5af507bef93c09a94fb8f058213b489178f4cbe5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de10553fce40797313f980301af45e7398e422ca
Message-Id: <168244870793.5918.5757684078373826213.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:51:47 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 20:13:29 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2023-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de10553fce40797313f980301af45e7398e422ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
