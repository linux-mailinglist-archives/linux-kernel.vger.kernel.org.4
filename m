Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48B16F632D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjEDDNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjEDDNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F0DF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 20:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E0466312C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71DA2C433EF;
        Thu,  4 May 2023 03:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683170011;
        bh=11kUb1AcjFKQBpL5XbdAhEqcvmUd3qcyAJSjY3lVlks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ot/pqkKfG0neGSV+BnsFJvulSw5JOmc0GS3Xd0ytBaDBxL9y8U6CIpomVFBsGydP2
         Gx9PLezIAzICxKODUtmSTawBQ60kKN4IiK4N13Q4zGUpjmOkWv6ftkzsnpkBD5IgoO
         YDLMFsnaLNUT1MncwgY9DAwkTBQ5lZAm7lwqolPPZKY66lIQ0yVWZB0hAViqPpDfcl
         pCD2fW3I7pOpSM/r0dOKU4GZY2K+vII6JvrXwXDO7E6pjXyQ6gW5+Gyj6mzvijohRP
         jTT/GgPXcjzgwRFcqwMnmSTD4JhKEP+iWzKCbmydVRVWwfQ1EXCuH0zAzASeyW/rqy
         xLyHxRrbu8zzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61CD2C43158;
        Thu,  4 May 2023 03:13:31 +0000 (UTC)
Subject: Re: [GIT PULL] UBI and UBIFS changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1235201236.2692346.1683141945109.JavaMail.zimbra@nod.at>
References: <1235201236.2692346.1683141945109.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <1235201236.2692346.1683141945109.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.4-rc1
X-PR-Tracked-Commit-Id: b5fda08ef213352ac2df7447611eb4d383cce929
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f2692326b9c6db8d0e866d555606b12a507a363
Message-Id: <168317001139.23861.8677898081963620103.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 03:13:31 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 21:25:45 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f2692326b9c6db8d0e866d555606b12a507a363

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
