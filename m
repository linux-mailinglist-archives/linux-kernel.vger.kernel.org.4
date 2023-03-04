Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37706AACF8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCDW0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 17:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCDW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 17:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF013515;
        Sat,  4 Mar 2023 14:26:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84B2F60A66;
        Sat,  4 Mar 2023 22:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBC31C433D2;
        Sat,  4 Mar 2023 22:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677968777;
        bh=bzd+2U/x7f8F9d0uIQr1SDlik/atr2aMWvcCO/U/CF0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KaphlxZmHWzh1AY6iwUjBqkQqqkiQ6eARDCiWRjURIZjHitIy1HC6M550JQ4XIfTG
         YRDo2NtbEBd82MWHQHwq3uY3AwI8TLQxVN71/ovXD+eoeY73Fbq/xm5XYZ+YBwt5Ha
         07du36+FcCk8LZdWha/AHsgPETos9gZVd2+DaYYlTY72d7Mke/q9WUMKREOcTUujd5
         oR9Ft5sLAIWhpNOjUM86EwH8tuX6RmRR5GpAWigDxGxnmtsyIEUMMGbrvnmTAZJ8/A
         KFnKp7Igf/d2aM3l9MRT40kjOxjDjp/cWGrA9hqTavtFZB1576ernSM7pcNSCQqVgb
         bLaQjl1NC02aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA547E68D22;
        Sat,  4 Mar 2023 22:26:16 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
References: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-04-13-12
X-PR-Tracked-Commit-Id: ecf1d926661bec4080a79c0ac9dbfe02b31702cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20fdfd55ab5c3fdff5b43de632a8d8fb7744e186
Message-Id: <167796877688.30591.533179486365213529.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Mar 2023 22:26:16 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Mar 2023 13:15:28 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-04-13-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20fdfd55ab5c3fdff5b43de632a8d8fb7744e186

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
