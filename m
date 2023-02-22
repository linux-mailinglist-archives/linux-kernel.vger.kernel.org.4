Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5469FE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjBVW1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjBVW1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:27:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A242BFF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B14F6615B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E7DAC433EF;
        Wed, 22 Feb 2023 22:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677104825;
        bh=PTJjIq7zVbGVVYy0E6lDSRLHfUUWskinBo4fchGug/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FCsS4Ahr8ECdO2JabOS7Pj8qNpQw6GM5Ih/XhbCQ+qiT9dAM1u0qrcS1njE7hiwGP
         nRyZ3EVIgqiN/cLfDPCa0ODyvfKJgzqYFoOzxKQQhWXuh3BniFcC/3JkL62Gv7U94M
         lrek8EgyvvbK3xABRI4x433fIy8IM2Wjz/BfD+xYBTG65QaN/kNXuiT0eXc/xIUkLI
         7Gbtlti4b3i8TTL19jwE98g2YHZZXRlQRA3FdL5rh+0YzlYxL5FdDCF6ZfGvGhihex
         tcroXT/W5yP00fPhh04Un1yMRJBYURwsvrFw9sz1xoVNJ6D1n/DHXR6+HJQ59X1z3X
         FHqXlz1QMlDrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B9CEC43157;
        Wed, 22 Feb 2023 22:27:05 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222120106.144326-1-agruenba@redhat.com>
References: <20230222120106.144326-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222120106.144326-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.2-rc5-fixes
X-PR-Tracked-Commit-Id: c1b0c3cfcbad25d2c412863c27638c933f1d911b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7ee88128242b3460b0016a7e42207c9799f73b7
Message-Id: <167710482510.21044.17503846130703204690.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 22:27:05 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 13:01:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.2-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7ee88128242b3460b0016a7e42207c9799f73b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
