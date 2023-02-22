Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DF69FC93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjBVT5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjBVT4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:56:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1864A3;
        Wed, 22 Feb 2023 11:56:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AEF96159A;
        Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA90FC4339C;
        Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095631;
        bh=RLtLldNZxw0Am+U22B1+G58UGoR6BMev6d8usxqee/s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nhXF8QcDUdIh/ExKFBLu8svCvGKexp3IQU+1KuSALVhx6rybOiOpUr8HNQFCRucH0
         8U2n+LXWxSHfPSXEyXtctSNfSTIBFi4NqSIjPW6Br3hZnqK87yJ+Bcmp9V/U0ZmpJ6
         +1qDMFrzADWRD0kCDzdEb8yC0OqXhT38RzHKFFBAaGxhGqi21GxwjaR5OhhUZCDxE3
         SOnr6xnmlD6VASvM497gDoyRBOqkzNNne5Za+KIsK+IXReQDC7RFkl6vEPqTh4WOz1
         q3wjwFsr2DujHsCLMWzmYYUGOexKPnntb7eWBB7hmXE50F4R8H7IK50EhskeAEjzTu
         3J0Pj5Y1lHyJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AB67C43151;
        Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220143415.882B2C433EF@smtp.kernel.org>
References: <20230220143415.882B2C433EF@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220143415.882B2C433EF@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.3
X-PR-Tracked-Commit-Id: de82c25dab9ac0fa01c95b8914bde8d9ce528e93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13e574b4941ee1931f8c70f33c3011f74e5fbd30
Message-Id: <167709563156.30115.799080278646131858.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:51 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:34:04 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13e574b4941ee1931f8c70f33c3011f74e5fbd30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
