Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92FA6DCCB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDJVVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjDJVVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0F01BF7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F151A614D1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FC03C4339B;
        Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681161675;
        bh=s3PzlJPZmrchd9ttp90LKIJ9fi79LAf3Smf5a7Ie4no=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fiK7+g/rJWELGlqmPOzbL3Q5lO0vaouVQtUeYh6cXQPu3omP2TdC2QHMu3u6AcooX
         9IL3/v/+sQT/X9HFJKi6Gn3pY374Bn1aIYZF+OrJhYtSOk1Av+oTk08fnX5E5VzZVS
         FMcOl380n2KmPPucyspM/mKyJlJ1IK8BkkdSdylFU9Q6goeiEiHAHXQvP9Mir1AswC
         XizIBbwJgw4c79ouKrllFVNfh2K1+Iw2U6L+p1VPCH/npXebwA0tjV2rX+18G5OCBB
         JxOqyjK7RpjuLi6jBkxVNxCkX2ZNAAOHisE0Uh35noeF/THNq9W9WC1yZagkdja1Zj
         J+0c1gZstuYrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4320BF8321B;
        Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZDM/4C0PlbbzV/0R@7e9e31583646>
References: <ZDM/4C0PlbbzV/0R@7e9e31583646>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZDM/4C0PlbbzV/0R@7e9e31583646>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.3-fixes-rc7
X-PR-Tracked-Commit-Id: 347dca97f75d461ac2ac256b68e495dfc6f14d61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c118b59e71d2a910ee300f8be40fa864a91bb6ca
Message-Id: <168116167527.31176.17427545781211200295.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Apr 2023 21:21:15 +0000
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     torvalds@linux-foundation.org, v9fs@lists.linux.dev,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Apr 2023 22:44:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.3-fixes-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c118b59e71d2a910ee300f8be40fa864a91bb6ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
