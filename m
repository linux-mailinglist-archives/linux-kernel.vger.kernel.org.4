Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D164BBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiLMSOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiLMSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449223EAE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:13:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE79616CB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 390BAC433EF;
        Tue, 13 Dec 2022 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955224;
        bh=/dINp4xpfEV/IpwuL/ayc45NulJOMp/LAW+wQfbp6iM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fZ/1YvJ2zb1zwYo7EJOMN3ttuAc0Y9xuIxY6L88Q9PdEdVLrS+k+6Ex/BOFwTpO6w
         iDakGiOmikhHGjxTsp7M53wToe1NhaqIOU8iS3d2QfyrHgY6Cal6TM0GsdczRpzwaq
         ZEKDT/zvz7tCOVPY5SKpLV3AX+BpFeSA5qVIwaXD16DprMdKR2bDender24Z1/6G0G
         UepXnY06FhUjWFehcjKyK/BkWAmlMnKgRgv0GhKiNLnkQ96hMyL1WA9LFLtLkaBkXU
         +i3lV8jIst58zWZeKjWwtI/q7cboyqwqSqC2LF0LifR1sxW9tRPIHNCpCKBesQNzds
         GfdulEHcWc3yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 284D7C41612;
        Tue, 13 Dec 2022 18:13:44 +0000 (UTC)
Subject: Re: [GIT PULL] configfs updates for Linux 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5isPdnDCpJ4cL7g@infradead.org>
References: <Y5isPdnDCpJ4cL7g@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5isPdnDCpJ4cL7g@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-6.2-2022-12-13
X-PR-Tracked-Commit-Id: 77992f896745c63ae64bfccfdc429ab7b3d88da5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a24711d5c0bc8fb0fc49def433ab89ecbedf095
Message-Id: <167095522416.23919.1317852916147110936.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 18:13:44 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 17:45:49 +0100:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-6.2-2022-12-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a24711d5c0bc8fb0fc49def433ab89ecbedf095

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
