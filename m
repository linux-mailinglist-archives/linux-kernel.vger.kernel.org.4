Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7346C96C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjCZQVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjCZQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7368A1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8285A60F1B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC823C433EF;
        Sun, 26 Mar 2023 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679847666;
        bh=pl40sotmumH6DzyIe427v7p/7PbDphbs6dQoZyTi4ew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qx/UluQe8QBohAnWmnqui9gUe04faOVnpIWt0GZtjO6y+lOwaMmwOzTKSYvqLYXKT
         MTe+EW05DDLy3w24siqcfV8jsOyeBjTxGsu5mVlwlpKPHX70l5cRW5PwaAOrSnIc0J
         HqJ3oT/tbl1h+q8MeCSwJZsJa1Mq4wUhlLHEOIwp94eyjHNghnJGEX4N/hB8oJBbgz
         VvucTaWA5pbesjKmxBHUrCw7SMO30yG4syn8875a9u4Tx9DSiCOJlr50At0kUZullk
         Nj/qR0VUTZVhJV0++nIfsBj5OTvryEHTMkmo4FFCgYXq5HKQqq7IfpJz7JzFEwQwyo
         xZMOy6QlxRxvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA9C2E43EFD;
        Sun, 26 Mar 2023 16:21:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230326124050.GAZCA9Um6kWZByUU2q@fat_crate.local>
References: <20230326124050.GAZCA9Um6kWZByUU2q@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230326124050.GAZCA9Um6kWZByUU2q@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc4
X-PR-Tracked-Commit-Id: 62faca1ca10cc84e99ae7f38aa28df2bc945369b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 986c63741da243c68e1faa97064a1bb216e8d7c0
Message-Id: <167984766682.13454.174860326471894825.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Mar 2023 16:21:06 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Mar 2023 14:40:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/986c63741da243c68e1faa97064a1bb216e8d7c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
