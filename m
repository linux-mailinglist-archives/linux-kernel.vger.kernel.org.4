Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC20613E83
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJaTn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJaTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFF613E3E;
        Mon, 31 Oct 2022 12:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7844961448;
        Mon, 31 Oct 2022 19:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD0E3C433C1;
        Mon, 31 Oct 2022 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667245430;
        bh=oVyc0ZyVikGM8WwPWa+32t1ZcvpuEt5B1380fp+C948=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kl6b7Q27SxODub49QfW2y86Kam4Ra22vWBtZBsXomASBK2YiN8yiM1vxeFKc/l8nW
         StIO7PhzvM2JXYh2sq06ilW8Gftya3Cbh4otVooMkw3oWC42HrLSNt4fHWoswBt6nE
         5MLHvF2Iwu8W5TSK3u1x6WL5jazL34r2CLRJkciEzIW6W67Cbc0uMHd3c6MlAjKBlx
         8hP3ORMBn0q3hyVJkUuey6mMYur3RFr1XtmFfLxXhEv/bLX5Bt5KPpvERkcDdp9VKB
         I6+DwxUDg69NpzDwQTauEOxozFHQaB6+Yg9nkycHnR8U02C/Ci0+gaAbqYSCrO1IpG
         1i/7FatYQslOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA818E270D6;
        Mon, 31 Oct 2022 19:43:50 +0000 (UTC)
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
References: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20221031
X-PR-Tracked-Commit-Id: 8cf0a1bc12870d148ae830a4ba88cfdf0e879cee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78a089d033bf71d68d978ac4cc73070f3e71c736
Message-Id: <166724543082.6677.16142164161166851122.pr-tracker-bot@kernel.org>
Date:   Mon, 31 Oct 2022 19:43:50 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Oct 2022 07:07:15 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20221031

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78a089d033bf71d68d978ac4cc73070f3e71c736

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
