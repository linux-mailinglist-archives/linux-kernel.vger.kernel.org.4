Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A285FBFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJLDzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJLDzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:55:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9522B1B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0600B818D8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E56BC433C1;
        Wed, 12 Oct 2022 03:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665546904;
        bh=BI0ct6d4ungEd9u2K6tVYNhRP7LFScLKt5luEi6ouCA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UubZs+Q27b3MzJgaQ2v0C3wz/NM98qywAO3wUOPwpOyPnuga1T3ruPviruCx+qBg7
         UH4SFgQ1jB1zVUuDCCGsH8fZSdnI1zd9R6GGEqnkruyG4dZ8G/ZbJFUpvh1jOEPaW+
         ckMr4rDG1QzvuL/vX5iwm92yLj/LEXdW5XwHhGy4d6bq16J5n+eN1r8keVwgC3cMbA
         1tXYK6J+yTmaoJf784/dksnonsd7oZQtnEo2QK79zbCyurq9P8Wv7h5NFM/8LVT59I
         fcY1pGvZLyy3oWWGupnak1p55lmaJA3b54Hz1aL9/yHlpd55dgEoHQQN1CdMEOJEXG
         gJyeq3s1XdaiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58A4CE21EC5;
        Wed, 12 Oct 2022 03:55:04 +0000 (UTC)
Subject: Re: [GIT PULL] memblock updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0VHfYkFUqYwVAru@kernel.org>
References: <Y0VHfYkFUqYwVAru@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0VHfYkFUqYwVAru@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock for-next
X-PR-Tracked-Commit-Id: 3e4519b7afc2f9d99f9303468ee0b23f88399c8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49da070062390094112b423ba443ea193527b2e4
Message-Id: <166554690435.31218.945067918558658434.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Oct 2022 03:55:04 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Oct 2022 13:37:49 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49da070062390094112b423ba443ea193527b2e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
