Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA35F4889
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJDReO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJDReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E267143
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3FB614E2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A61ABC433D7;
        Tue,  4 Oct 2022 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904844;
        bh=HMHQk8h71dM5ZFMA8O3aZV3IP99epngLtEBZ830saVs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cK3ZOU2Cr70rvBMRWWcZVHoAbprbmzMOmHHmD0AOYtaiyjhJ26toXdqG8KezATk1D
         RCMgbfqHzGXHxi5tzB7Ughi6EO+Mm9ft5E5CMVsBGgfDgRfhtT/BAft6W95NT9Ayzl
         X6XsLKRaXpWk4GOb2RCeTkb0GFA8dpCg2u0Iq+XGDuWko+t6rpqnIswxEh/32GTYOq
         6jS8dVHfqrAVMM0jqOXVDg9ckJd9XOmwc4t4YcKTIGP6LDlceoKOCOpvAKdRUmYMaw
         jMpcMuZ32jemZVzHaEDjGyNqMIFLdLK9h1V1314wwe4p8FsAH7EQhghPLcwOKKGUxw
         3KRysxojQqz8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B418E21ED6;
        Tue,  4 Oct 2022 17:34:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzvsFowRDiuf6ThG@zn.tnic>
References: <YzvsFowRDiuf6ThG@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzvsFowRDiuf6ThG@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v6.1_rc1
X-PR-Tracked-Commit-Id: 81a71f51b89e84f39df2a3b1daf4274ae6b7b194
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3339914a5832cffdecd578931b3db20d3deba5f6
Message-Id: <166490484456.22164.2205296594237762704.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Oct 2022 10:17:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3339914a5832cffdecd578931b3db20d3deba5f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
