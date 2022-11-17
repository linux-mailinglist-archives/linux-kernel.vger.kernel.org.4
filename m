Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32962E72E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiKQVmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKQVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:42:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF268687;
        Thu, 17 Nov 2022 13:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF02B62260;
        Thu, 17 Nov 2022 21:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D603C433D6;
        Thu, 17 Nov 2022 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668721350;
        bh=5QG3VJd6xL868H905CNyv/waGZm4KCXynGmbCyXmq6c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AoIbVAFPtxxTLT4rUN4POYWSsVeoKWaLTFenBonQjzkeCOD4bsepnhPRe9V0U7kZr
         LrGTtR87F3SsPeFV7ZBr0bDNG7n8nASOUSmCtXhEvpovWq3TZXBJvXFRRINlNGGc21
         Aei5KtVBwMqb6PDjmf6dnGdC+qVc92TR5qyxETJpkRA+XqjCBbb4Ckligul5M47Vdb
         v7IlH4MR45ZTRs823VGYdBZmJCh8IN7rVdxTjISUUXt46UrKJeiF2kegxoz+k4xeSj
         DrzvdsJm5kMOhDvO3s5cml+GH+DLHhlRFr6dDw/jE6hk/DB6lQ418Zw0AJNcR91d0s
         DVNg33PrRuDmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A2AEE21EFA;
        Thu, 17 Nov 2022 21:42:30 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221117212443.16138-1-idryomov@gmail.com>
References: <20221117212443.16138-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221117212443.16138-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.1-rc6
X-PR-Tracked-Commit-Id: 5bd76b8de5b74fa941a6eafee87728a0fe072267
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae75334011d3c9f8b859ecb5f63e17e72023051e
Message-Id: <166872135022.1070.7716442464810740038.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Nov 2022 21:42:30 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Nov 2022 22:24:43 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae75334011d3c9f8b859ecb5f63e17e72023051e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
