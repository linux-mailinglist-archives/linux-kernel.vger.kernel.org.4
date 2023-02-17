Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B2769B5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjBQWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBQWrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:47:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A15FC4D;
        Fri, 17 Feb 2023 14:47:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43556B82D08;
        Fri, 17 Feb 2023 22:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07F89C433EF;
        Fri, 17 Feb 2023 22:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676674064;
        bh=LCS56TJEG+qQdEZ3CBdIWYo+Y/uMrtFGu0tQgaNL2Js=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YQ9RlnDSsiCyLx8E2NDG7uR+7iB2JrRA41ASOOSLaT6TCL2RBlDn7KsOAB3RLZP8p
         mh+tZUa6iiobrqsClq9joOBUAgthV1RVdQLVB8gGk/wDIMhrFxAYEC4IA4La+8QCPJ
         DS/48/CxWIQWQbLr3pawjbpIHvSTjIi8k9jsYhiJPEnrAyNAMKFwIQ/W35zpbyqeLO
         h1UNn2id8IzclPndLFcmriwsl+VKcj3NCnE2ZrqXDm+XURHtz5sDZMvp0udoI0UrBG
         xKsQY3p4VR5aP3re5Pzna/zsZlWT+8g4L5hLBQQxgOIWUgvPokNuE9vv+FUJgEbuit
         jvEXLAZTG2Hdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E919EC1614B;
        Fri, 17 Feb 2023 22:47:43 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.2-rc9
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217103757.61244-1-ulf.hansson@linaro.org>
References: <20230217103757.61244-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230217103757.61244-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2-rc5
X-PR-Tracked-Commit-Id: 3f18c5046e633cc4bbad396b74c05d46d353033d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bda6cfae33a541230970bad853c01a4e5bdeedde
Message-Id: <167667406395.13496.7002399768494513198.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Feb 2023 22:47:43 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 11:37:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bda6cfae33a541230970bad853c01a4e5bdeedde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
