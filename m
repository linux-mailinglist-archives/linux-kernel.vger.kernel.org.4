Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6386953B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBMWU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBMWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:20:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93AB1BAF6;
        Mon, 13 Feb 2023 14:20:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80427B81986;
        Mon, 13 Feb 2023 22:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2287FC433A0;
        Mon, 13 Feb 2023 22:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326852;
        bh=t7yk4QfjdKebtkFOT4hKLNy2o+tR2q7g/yGYYxojAQk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=quuK3qnzHMerC/r6syHr/WCZ0q0SOEjwet9YTwZQDKrGSYG31G22nmVw8d/KtBgFp
         APIcYHejuKZddAixlxSV07Jr2Vnrp97gxddG7vtrcUGYJO9TP9DObke+NILsGvd+Gf
         H2WKZ9xz+1kwpFU45HpsTWM6c8+h5KGiaK2whQkUxiVVV0Xw5eCmiie8nzNTTEoiXk
         VZLrQfDgSfZ8f5YgKMbYZsWrLJzbEmsVHsICt5cyhl+0vQP167QFym+q2KOv3CZs4Q
         vB5jS027N5uHRYugnHCpoMRirC0jFHbu/AQ1POtkngFHj522AkOm6qtB571brkWhXh
         IQfYoYAPH4jOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 109ADC41676;
        Mon, 13 Feb 2023 22:20:52 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230213140812.db63c7146ebc396691594b73@linux-foundation.org>
References: <20230213140812.db63c7146ebc396691594b73@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230213140812.db63c7146ebc396691594b73@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-02-13-13-50
X-PR-Tracked-Commit-Id: ce4d9a1ea35ac5429e822c4106cb2859d5c71f3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6feea56f66d34259c4222fa02e8171c4f2673d1
Message-Id: <167632685206.30028.16383204020347410670.pr-tracker-bot@kernel.org>
Date:   Mon, 13 Feb 2023 22:20:52 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 Feb 2023 14:08:12 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-02-13-13-50

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6feea56f66d34259c4222fa02e8171c4f2673d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
