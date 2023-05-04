Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225F46F7855
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEDVuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjEDVur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A7F1154C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9940E63A30
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 21:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0528BC433EF;
        Thu,  4 May 2023 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683237046;
        bh=WFw20QfDsL/6GRIEPbeM07zo/huuezcbqE4ZIGNkScM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W5laT6wzhQdLJudq8X/cBo1EovTGXsa8A/V5NhBYNlfqyAtlmPtd04UqjcpH8K6zw
         bP0EJNipwDs2Ixlc2oHBxFt/ML/NLjdYGiGyHPYNY+7nyb0HRS3EneMEwbuP/lfeA9
         NFk+zUbc+FmoBJNsEcbEubiActZJogU972sL9AJs6Nv7Q4W9XxVZO5EiXP7EPJXrUt
         vcuFRtKgsuPoR3qkhwFeorvBhQxldT4w+zu2N0hTlFhh+PLMEzDLEwbXOmxC1XApQT
         PFvTuxcjuEUKCyf4xN319zoABALisbcavpDhkx4bL0mvL+8pSbMHipRy3gX6eDJGdB
         k4+xuJadDaNuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9D4BE5FFC4;
        Thu,  4 May 2023 21:50:45 +0000 (UTC)
Subject: Re: [GIT PULL] 9p patches for 6.4 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFL+Pg3IGWeLsQOo@7e9e31583646>
References: <ZFL+Pg3IGWeLsQOo@7e9e31583646>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZFL+Pg3IGWeLsQOo@7e9e31583646>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.4-for-linus
X-PR-Tracked-Commit-Id: 21e26d5e54ab7cfe6b488fd27d4d70956d07e03b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e15605be8baeb9e3957c268c7d6f901c327ad5c
Message-Id: <168323704588.23044.5518199268556560774.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 21:50:45 +0000
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     torvalds@linux-foundation.org, v9fs@lists.linux.dev,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 May 2023 00:37:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.4-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e15605be8baeb9e3957c268c7d6f901c327ad5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
