Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E19064AEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiLMFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiLMFAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556C1DF13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:00:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA3E61315
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81CC2C43392;
        Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907613;
        bh=n6K4K3F/lIcUGemRw5XE5AowxW+oCxajCk1ReJrOnd4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WdLezrGFG4BIJn0ODrLSgOuI9wB7c0xQ2MG/vYER5p3aqpdGLZxyd+M+HXNrt6w2o
         tGtPM+Rp/JOXyLF8+bjOmLbI+7RVY6X2Z+rgNi1TTpIBauQftSaYULkJNcA/Hx2vr+
         pcG9pB3Yzmx7Z+63qYVmtTJyWpdKCTE4Bn+et8xaryU4ncbzlQVqYAfcTXGrijqasK
         fCprDtgNtKQqK7bmXu7rCXqfFZyE64b+JUcgPQUwqllfT/wH5fit5w0jsQxUfoEXvr
         iqpx8K6uOu2c5pBXvPP9zCL853QnsrE7d8SBED8PqkrXA9AEt+SHGhMpa8w8hmJ7RT
         Fn83rE3IlAurA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70243C00445;
        Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212174332.GA9261@redhat.com>
References: <20221212174332.GA9261@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212174332.GA9261@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.2
X-PR-Tracked-Commit-Id: 7a5e9f1f83e3271a9f05933a80b870fe55ebbb3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97971df811b8854882c0f6c6631e23ab8cdcc44f
Message-Id: <167090761345.4886.12382800386382518576.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:13 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:43:32 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97971df811b8854882c0f6c6631e23ab8cdcc44f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
