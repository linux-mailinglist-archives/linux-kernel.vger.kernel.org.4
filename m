Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDD6A14C0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBXCFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBXCFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:05:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9B83801F;
        Thu, 23 Feb 2023 18:05:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828BE61805;
        Fri, 24 Feb 2023 02:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB0BAC433D2;
        Fri, 24 Feb 2023 02:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677204331;
        bh=IqyQu9FBJoc4bfKDUQjzsYrQ/fjud+dayE+V9NoTNME=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MIEDDDI+G4SSmJOlumDEce7yIsK25gFvP7lZU5a6kKy3Qg/7xUMEogFdIyJFcUqPV
         PDlhDZvY2uBJXpw9Yaae8tQeVGjuu4OgB4e4xfXaXMEkaThqOm+rEHaQhEeI6LoSSO
         jypC5IVK6M6wYDrEnuYL9uaWQRUK2vzNmHsmKh13G1yRueogMN0xpNZigSdIwF9aO5
         LIFHmzxozOZwtZYWWgZKJ7K5ZB6+e73qzd3y8SIkn6TxBnv8+I3EfI/TjJceBlRyns
         QA7aCJsOjwUNZIrBeBv7yI3Z2M0evrG9IbKLEyJlTiDcw8rGmuRmHTVyLkN0q0Y8it
         61ePsk8IQDrzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7A0AC43157;
        Fri, 24 Feb 2023 02:05:31 +0000 (UTC)
Subject: Re: [GIT PULL] Non MM updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220153501.19c3ba46c67612f1cf1d7d08@linux-foundation.org>
References: <20230220153501.19c3ba46c67612f1cf1d7d08@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230220153501.19c3ba46c67612f1cf1d7d08@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-02-20-15-29
X-PR-Tracked-Commit-Id: 817013880a6883f7ab08030d1f8cfef5f07ba467
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2980d8d826554fa6981d621e569a453787472f8
Message-Id: <167720433174.21214.110796315896899755.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 02:05:31 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 15:35:01 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-02-20-15-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2980d8d826554fa6981d621e569a453787472f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
