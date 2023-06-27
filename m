Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9227402CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjF0SC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjF0SC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A2C4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28BCE6119F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C57FC433C8;
        Tue, 27 Jun 2023 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687888944;
        bh=i/le9p0xhry2MMoPzomlBnFZuOaZ5ec4cxbSu+A4ZjY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e2Rwlrt3GJ+xmd1Z2CtV9oxc1toEoo8FB1RV2Gjwa+k8jU+BUmcXADm3Y+MFw/FMt
         nnQcI6kN8PoetYQdj5er/ZOjwQuoiXjWVWbher0NPR1GuxQ0wYrb+KN5TWRymOhUW6
         Oqzr/w+An5h5JQ6funbFFDrvZU5x2qL3Jmn6WgMM0vwxq58OSm+2CR1Ehjo7s7sIKw
         tDq39dziUiZXXBCbFI+FcaqSrs+ONzlcxda4ab8uh9kmI6NO9YxUIcPsCfjPBTHgCU
         RIczN/JRbHsKnSiNGQcrS/XHbFCOmKAgPR6+J3j+LptSQjBD7GzH6wPk5xXx6NSYwY
         3BBFOkW59y5EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72C84E53807;
        Tue, 27 Jun 2023 18:02:24 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <85e93ea8-7cb9-4848-88e3-c3437ccc309c@paulmck-laptop>
References: <85e93ea8-7cb9-4848-88e3-c3437ccc309c@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <85e93ea8-7cb9-4848-88e3-c3437ccc309c@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.06.22a
X-PR-Tracked-Commit-Id: dd58d666ac08eb5eb81e4956172fc52b3bf0ab38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b19edac5992da0188be98454ca592621d3d89844
Message-Id: <168788894446.10734.17945650923335530007.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 18:02:24 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, w@lwt.eu, gwml@vger.gnuweeb.org,
        linux@weissschuh.net, broonie@kernel.org, falcon@tinylab.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 08:39:52 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.06.22a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b19edac5992da0188be98454ca592621d3d89844

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
