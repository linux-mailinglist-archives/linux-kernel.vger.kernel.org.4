Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3569FD43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBVU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjBVU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA3244A1;
        Wed, 22 Feb 2023 12:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392756159D;
        Wed, 22 Feb 2023 20:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE8BAC433EF;
        Wed, 22 Feb 2023 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677099535;
        bh=Yp7e/MWz5zZRQ0con+j6u5KJ+0Zn2w6PVIxUBfsHPIs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CPyqrq7b3qrNvFZfF1oSRqYHB1fhPoenWp2aqJDpT+jiHL9Pi2lJpniUo4dYvUF09
         OlseTfRsV5pFeACsSZiQblMbtiEsAa2XJXARzsHWtCGVQgdhDran1w39+Mx6sS8Tkt
         ReN032vgIBec3Pd5gxhEBjjK0zo6laUNRiphk9arc/PFygjgunUubqE7Ap1a9VYxGt
         nb0mQjjhe0gEgLNCRbd80oYJAAMWtOr+n9eOZGlN9VSFMwst55yWlmk+3kfpZnqS/T
         sYJ6FA+NwO65F6gZYYIstAaGYkA+5Zif/tIRX1b0qXamuepmnd80h2CuwMPOkz10qV
         XLn/6jR9mRDYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DC66C43157;
        Wed, 22 Feb 2023 20:58:55 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220184722.573397-1-mic@digikod.net>
References: <20230220184722.573397-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220184722.573397-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.3-rc1
X-PR-Tracked-Commit-Id: 1c1ea1c3e21d5ba0867f84f6ad04090bd477df25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 291a73a8e63a6a00f2f6863989cd1652a1f5b9a1
Message-Id: <167709953563.1614.3807964367231103143.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 20:58:55 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jeff Xu <jeffxu@google.com>, Paul Moore <paul@paul-moore.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 19:47:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/291a73a8e63a6a00f2f6863989cd1652a1f5b9a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
