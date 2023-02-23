Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857576A12BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjBWWUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBWWUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:20:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0763C5C15E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 972A7B81B4D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 378D7C433AE;
        Thu, 23 Feb 2023 22:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677190809;
        bh=UKJQjVigqv7+aht9rpn3TmasQdauYPxs5zce/zNs+WA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oG8uoWZOMM68T2MX57nvBJpdRGpLlDOKF7m1j8ZEJW3noZnxQxzJ8EHOUWFyAgsxS
         O/IGKFvf4SlbmgW6aluBgmDJBaDLGoyT/k2k8wO27RIhg4CtK27evyZplj2OwGXapQ
         +3ctl8bLE2cohO/ssApuqYsMBUmokHB6HJETA7Ny7NumDcmVPBkH7LCJTUUgnW2QbP
         V6bN6bSaVVcnHVTYYxoBznV5tKcpaymWu+gvVsVCJ8XB8Ogz7qjoWGxgPbNulEFVu0
         VE/JpNwJw0LOO6abURp+xyaQsiW7ovBZsHCN9S/tVww/hx1Y1ENMvfk4yZB2hdoSiy
         Ka02xebW8Rzsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24C6AE68D32;
        Thu, 23 Feb 2023 22:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/afW5sNLrLRbDho@bombadil.infradead.org>
References: <Y/afW5sNLrLRbDho@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/afW5sNLrLRbDho@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.3-rc1
X-PR-Tracked-Commit-Id: f1aa2eb5ea05ccd1fd92d235346e60e90a1ed949
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcc77d7c8ef6478844547d50dd3d03270c86116c
Message-Id: <167719080914.29288.10331449105603793359.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 22:20:09 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, omosnace@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 15:03:55 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcc77d7c8ef6478844547d50dd3d03270c86116c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
