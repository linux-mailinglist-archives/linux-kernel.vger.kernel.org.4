Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3D6C89EE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjCYBTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjCYBSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:18:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC621A960;
        Fri, 24 Mar 2023 18:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65A0DB826C4;
        Sat, 25 Mar 2023 01:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19974C433EF;
        Sat, 25 Mar 2023 01:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679707124;
        bh=heXzdnFpKeRRVoxtsaaJ4W944gZQE2B1WrjbSjScm4s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pwQGALRTnmOpaeoikQoszcjlaTCtNO8P1jjra70eG5/sVuq3Z8ZavTuntvn0/RBxq
         2eLn6qIqHx1qP/D7Trm7zmWVQOb4B4lLaV8ebLTTvAThSjt6V3JvHbwC5TliWR0Bdx
         aQZqt3D3UJOK/7h9QH0AN6yS6bGbsKg6dJsws0imAwGswiDGYkntSDIp/ajWowpSLK
         VhV1gUFCZ/ISsKGshBbj/YUhsvZqrMNyEKR6bheLu44iQxcGkRlX5ucvK+FlrE/BO+
         F9rzz4ZTSwSQxRcTmPVPo8M8/TxW6H4r46si4JEZNQtPjaWQyZzTolHcK9dFjBfUJc
         vs9s1fKCRzIaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0907DC41612;
        Sat, 25 Mar 2023 01:18:44 +0000 (UTC)
Subject: Re: [GIT PULL] more hotfixes for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230324171557.a80213794c8101d0561d9e3e@linux-foundation.org>
References: <20230324171557.a80213794c8101d0561d9e3e@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230324171557.a80213794c8101d0561d9e3e@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-24-17-09
X-PR-Tracked-Commit-Id: d0072ca529674c36421023ffe90837a7de9387f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65aca32efdcb0965502d3db2f1fa33838c070952
Message-Id: <167970712402.29265.16333641051191369461.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Mar 2023 01:18:44 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 17:15:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-24-17-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65aca32efdcb0965502d3db2f1fa33838c070952

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
