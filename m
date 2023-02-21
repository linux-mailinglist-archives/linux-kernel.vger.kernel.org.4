Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0B69D928
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjBUDHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjBUDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:07:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A3234C9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:07:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2EA60F84
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4806CC433D2;
        Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676948845;
        bh=SFNl2klY+206UWkosLvSyGZY39QzHHmTb8ADBjMqX54=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RRkYpPqsqbjkUJl0joPUMwuBUiPMqEWoaS9QVA/EwNhOhWcl5AN2Vdxx/68Vf8zZA
         eYXf+4O1mpH//z58V4AzIZdVH6mJZgKckI7wepptAxwQJ/hr4qYlkUzTcCP6FXxeny
         dmHC//iirD8kQHaKaECJOOs/2Yab1imcs8QB+NrVNPSqWNs8PF9lRcZgzuVrNfgu6D
         gOWHK4EC5HbscfoTiaNW3NvqxrMHZUHFA9n2qsPrLQSGwywpl68osQrdB3R4+Oxhax
         j7hSLRH8umTyBqPwMbp7ZiyeMZiliJA1cDKKdWfE0spmzLAcrLVNeXOzSyqz+eRQ/W
         hB0fQp+V43h/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3443AE68D20;
        Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/N0VZlRQc+f8+N/@gmail.com>
References: <Y/N0VZlRQc+f8+N/@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/N0VZlRQc+f8+N/@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2023-02-20
X-PR-Tracked-Commit-Id: cb3ea4b7671b7cfbac3ee609976b790aebd0bbda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e0ddb34e5a392ad6bd6a5ada38aac53a1cc0d1a
Message-Id: <167694884520.12895.14161167092666907733.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 03:07:25 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:23:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e0ddb34e5a392ad6bd6a5ada38aac53a1cc0d1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
