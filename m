Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9068A22B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjBCSpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjBCSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:45:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8F9A82C;
        Fri,  3 Feb 2023 10:45:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F85461FC9;
        Fri,  3 Feb 2023 18:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6810C433EF;
        Fri,  3 Feb 2023 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675449916;
        bh=WJ1jxG1UPaju0S68jvgkS7JBI3zPQQRBZzErhye/NjE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T+hV6e5N0LpRjc2LLd/xOhlcu+EINuP1isKWlcnrVE5sttzv1vnaDewH2yV5KlFOz
         cgGanMTJIIWARubPVOnkegJrHx5bdGUz6QKqSnFDmWh9eOPK3J91EmWL77NZxPxNLf
         aclnW39k4n5LdZVDedgE1r3Wewqb7ZhLYkOGcsQ6mjq52qH5RuIr/EAf9kP2NV7VfK
         M2JkvXdcug7NYXVowRKKnhbAdA0HxIAOvbMa29qLdg5KhZ13AY6lwi6xvXm42U11t7
         fZX+xlLl46bzNJlGbnyWpmsQ2P0Wwv+TKLw97R718RsQC+/c36yi+Mtgxui4TnoJ/H
         G84WFzyYO/pLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93D18E270C4;
        Fri,  3 Feb 2023 18:45:16 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230202193214.646203447dc16ea4c6b835a4@linux-foundation.org>
References: <20230202193214.646203447dc16ea4c6b835a4@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230202193214.646203447dc16ea4c6b835a4@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-02-02-19-24-2
X-PR-Tracked-Commit-Id: ac86f547ca1002aec2ef66b9e64d03f45bbbfbb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c272a1d33965627653f4fafd6eab55d0d50f21f
Message-Id: <167544991659.32203.15927463347097984393.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Feb 2023 18:45:16 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Feb 2023 19:32:14 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-02-02-19-24-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c272a1d33965627653f4fafd6eab55d0d50f21f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
