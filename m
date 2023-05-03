Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC226F5DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjECSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjECSdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:33:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE57A87
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 11:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6CB662F61
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 18:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27832C4339B;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683138742;
        bh=KkRexol8rqSfFiweVA984O6MeZg980x3q8wOoY3/CMI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a6Pb9wRMrhsTG1yoMAXnc0iQxk3nPgD2eYQIdXHVkEEO17GZCpLq74+o1w38KO6Z3
         vR8R6SqBQOoqLs9SAYlysbIb4yO1UqTtzxazwAqg6XoOV41WszcObBBXZlOBwvgXH4
         T1oLKNt/PHFKuWo7QjQ1uvHSPAucMDqwIhIlHVqAgadSZ3eLOMGxgGBfDzqNJLMPBR
         GkR+wAzS/SPk1j8ZcX9+UbYNVfPDBMxr0XUBnVXe1oXokwiXYZxbT95I99mWGpjwDk
         ZGoKsZH4/E4fMrI3HlMsXGk55+Boq0b4ucYUzGqzS0woUGn/lg+H2omqPz7BEXDHx6
         ISO4ElFT9uVTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1714DE5FFC9;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
Subject: Re: [GIT PULL] hte: Changes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230503032947.23384-1-dipenp@nvidia.com>
References: <20230503032947.23384-1-dipenp@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230503032947.23384-1-dipenp@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.4-rc1
X-PR-Tracked-Commit-Id: ca3d1a4b419acad3fca6828884acb03614f7558b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29ee463d6fe45adde02098b3aa1166cd65fd2739
Message-Id: <168313874209.23026.3621881726709996863.pr-tracker-bot@kernel.org>
Date:   Wed, 03 May 2023 18:32:22 +0000
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dipen Patel <dipenp@nvidia.com>, timestamp@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 May 2023 20:29:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29ee463d6fe45adde02098b3aa1166cd65fd2739

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
