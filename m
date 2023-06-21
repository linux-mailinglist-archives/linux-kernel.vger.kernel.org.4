Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD35738D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjFURjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjFURjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7037F1;
        Wed, 21 Jun 2023 10:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B47C61645;
        Wed, 21 Jun 2023 17:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95190C433C9;
        Wed, 21 Jun 2023 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369146;
        bh=i4tEjoxMKy7VOyEzuM7hA8XJUK/Xk9FgGfxvxJfNxzU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CPiAhCAPgCEsZzH9Q4sgEqHPv+A/u93j8aOgCooBjPBEP14KUn0FLHDTId3UTja4I
         uXmPtHD3eYeQJEIgh0n4ZpbrTm/w+QSQEZHh4HUfj9RvZVZ4esAa6Y0RfJ/h6qZYGJ
         iE4Gh+gtergx2Bja/eBJaJedugSnyFPDWvNCRDVbAhflYzO8CZfFi4zJCcxre4Prx2
         WhwEoxtWtE+MSJTel3LAVUCPC6NitaAo0LbiHXj4687gJLBiM0QhJGOiujWk1YHa5S
         t/ir/eIK42GtHmpgVYbgkH04AzqeSJnn2FTzWtb33mewcdT7/Sk7SB0GX66V/I1sJ0
         JQRCKSkKgoufg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8272EC395C7;
        Wed, 21 Jun 2023 17:39:06 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes against 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230620123828.813b1140d9c13af900e8edb3@linux-foundation.org>
References: <20230620123828.813b1140d9c13af900e8edb3@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230620123828.813b1140d9c13af900e8edb3@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-06-20-12-31
X-PR-Tracked-Commit-Id: 0518dbe97fe629fea255318841cf3ef1b4532d66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ba90f5cc71701aa262f222effead02206b04227
Message-Id: <168736914652.5231.18329686904887773536.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jun 2023 17:39:06 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Jun 2023 12:38:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-06-20-12-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ba90f5cc71701aa262f222effead02206b04227

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
