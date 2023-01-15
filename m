Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB966B141
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjAONZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 08:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjAONZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 08:25:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AC1258E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 05:25:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D57CB80952
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 023A3C433D2;
        Sun, 15 Jan 2023 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673789120;
        bh=9l/syxlBiOpbdy+hFDWVt7VQ/bqMhJOapl0FwuuRzDc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h4zBeHr6Oay0u6mKkNmi6aCKJOjfI/4gISwzVS5d/aaiEcTSiY6u0WvfwkUvoBTnO
         bWLpEaJND1sIpmLFnguIyXyfZilOsBFecjMAxDo9v77wk9K6fKNPn7aXJKWAfsgtYs
         fvtAwLgg1KUox+5berz2d0ZMP15ubRp7h/Dec9+NevsCwEd4Oe2GANPKKWs/r2jhE5
         5NnskqRvRfULZm4P66N/7+fyJitN4/NCXYMY4hHNXqDfJ0ovPBGoT+FX/phAGUpNwt
         72mcnZrjVH5OvOMaaDkq2EDLkhvNpefPsSmiudzhznHy3eltdO1Sgr9kGGzGx0QyRc
         ldGzuKbUovqhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3BACC395C8;
        Sun, 15 Jan 2023 13:25:19 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmbg9ic1.fsf@mpe.ellerman.id.au>
References: <87pmbg9ic1.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmbg9ic1.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-3
X-PR-Tracked-Commit-Id: f12cd06109f47c2fb4b23a45ab55404c47ef7fae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1d63f0c777b6df1ab53c5597d5fc25753f52f07
Message-Id: <167378911992.21615.18026502937435227500.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Jan 2023 13:25:19 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, ojaswin@linux.ibm.com,
        yangyingliang@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Jan 2023 21:56:46 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1d63f0c777b6df1ab53c5597d5fc25753f52f07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
