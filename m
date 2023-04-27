Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB76F0C80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbjD0TU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244530AbjD0TU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3147A5249
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0467463F56
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9A7EC433A1;
        Thu, 27 Apr 2023 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623219;
        bh=RV7uAq0G8qeNTAXi+VWtPjfbxJnbUnkixwunlhqOhcw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mAGwV/86BcqYEdblf1KD+rrO+k2ofFWcB99ZZajj33sJkB7xfygyFytYWqDyOoCqu
         3+Q3Zc8PE7qRDYXFzKm4k3dtmIstXwi+5OjOhDP9Pq/MDh1Vphz9Q62kwUj6HIvzUK
         fXGZXgsiVbvR0cXsT47719vzbGMtZX3fweBRdOsRFUwMSeLozq3xIsEooN0ScQAKgG
         UjCfiwYVFuSWZ6P9KsvYNeLFSmq6xKoXIfsIjUAnuKU97HDJq/kEJKr4i0Ij/qxt7A
         sd7t4LDEaw30oFj0pwn69yTZ9807qij7sHPBd6c3Jsgv/7MWYc7v+3i2lsTvltq63z
         Z1UMY7GpgxMvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8F1BE5FFC8;
        Thu, 27 Apr 2023 19:20:19 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZElo9Dgm1JV80b3h@minyard.net>
References: <ZElo9Dgm1JV80b3h@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZElo9Dgm1JV80b3h@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.4-1
X-PR-Tracked-Commit-Id: d08076678ce72140a40553d226f90d189fbe06d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d91f6a7307d27eae7b954c82bebf55071914c3f2
Message-Id: <168262321975.21394.1069081413213444238.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:19 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 13:09:56 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d91f6a7307d27eae7b954c82bebf55071914c3f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
