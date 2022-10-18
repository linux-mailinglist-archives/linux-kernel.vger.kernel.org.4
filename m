Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E38603307
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJRTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJRTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:06:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4F6F572
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5823616D7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3654DC433C1;
        Tue, 18 Oct 2022 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666120009;
        bh=AhZSPrQ+ySyLQOwegsh0IpWm98ikHtRgqAp05ODo4K4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i+jeyJtA8NDTpBqPAMXKb64ElrntEDRYo8xZsoQzFVPPsfl570+eaHlIsPtQf4TkA
         fbkBE9Fh+cY+6PqKIOf/WYyC7IzkCMiSiHjhK29V4Q115mQJU9u2dwYg8WGhDSzhQt
         KzaWVdcGExDn0qFrzkiJvJf7iUlSyJMKXkR0hJniX0QUxjlE/3fLC9Q3uOrfnWqdWI
         B7LlJLjXOdldAxtrMThXK71GEnKbIylO+s46N014uoOCVnSO40Q/U6Bo805GPsNfj8
         Vft39g9mhc6JyM7mervO0qj0VFm9001vTdsi+A+DQlfxtGQ9bSOzJmqymAMAFgEQgL
         2QDm1FBeNeQ6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2336FE21ED4;
        Tue, 18 Oct 2022 19:06:49 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y051uhn/opotPmAo@hsiangkao-PC>
References: <Y051uhn/opotPmAo@hsiangkao-PC>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Y051uhn/opotPmAo@hsiangkao-PC>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc2-fixes
X-PR-Tracked-Commit-Id: ce4b815686573bef82d5ee53bf6f509bf20904dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ae460973d3455371a1182297357eeb9fafb0227
Message-Id: <166612000914.5469.8048419574604088110.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Oct 2022 19:06:49 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Dawei Li <set_pte_at@outlook.com>, linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Oct 2022 17:45:30 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ae460973d3455371a1182297357eeb9fafb0227

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
