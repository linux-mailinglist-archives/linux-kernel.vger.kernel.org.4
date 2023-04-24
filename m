Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C76ED58A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjDXTuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjDXTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90376EBB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5A4628AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D513C4339B;
        Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365745;
        bh=Amzz1tTFXMFXAImuuoYF+IZoCCl2I4YSgqkvVZ8g3f8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E7MGJsKcQ+ldOT5iTUCEOuPdBZKQ0zv2vwErhNHQ/aoqjWGxfuQ2UomoHZNzlfzsp
         opdnOTiQdhhbwRu6AwBhO5emjKhAcQ5CZHxGTwplPfla7ip8DLZo/Ubie+vkf/iLLM
         WqAYcH6zRGsNBd0SYNPyc++I+3FkRSjK2x94HiEf5ltZHofD2jvDZxJEya3ofA4ztI
         NZ1XmAyDR215cUObfYsIEVQqogsZL2dnOAvd9CKBDaqnZ04hCRWSLd0oe38/tFoJaz
         ee9iZ+/ucXX6Xf1lkpSLm9ZWcQcXmBojNO+xBZXMq3cBIJI0R82j56s+zgJcIylNZ2
         E9UCjH3HwK+iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE606E21ED9;
        Mon, 24 Apr 2023 19:49:04 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <628d04f3-8bd3-4950-bcbe-49ff52ec408b@paulmck-laptop>
References: <628d04f3-8bd3-4950-bcbe-49ff52ec408b@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <628d04f3-8bd3-4950-bcbe-49ff52ec408b@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.04.07a
X-PR-Tracked-Commit-Id: 57373671d5f5a92ee02d32e0b8506351ae30d33f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 406037351e08dea03735178bf11046da85f00125
Message-Id: <168236574497.6990.13760065452288088837.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 19:49:04 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, stern@rowland.harvard.edu,
        jonas.oberhauser@huaweicloud.com, joel@joelfernandes.org,
        rdunlap@infradead.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 16:10:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.04.07a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/406037351e08dea03735178bf11046da85f00125

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
