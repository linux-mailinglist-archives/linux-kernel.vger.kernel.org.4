Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B06D26A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjCaR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjCaR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:27:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C491CBA5;
        Fri, 31 Mar 2023 10:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16319B83127;
        Fri, 31 Mar 2023 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC601C4339B;
        Fri, 31 Mar 2023 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680283616;
        bh=0K3lKZkaSyzOIAjl3ox6EYHDy2XrJ+pjtK0I2XAjl2k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UflxRHv34ZHmDzLduv4RLk8DNUcwQESq0/TTvIOPu/k5Dm1Inc78boWWawSG3R93H
         1LSyewFCBfKq8zKLBHI6Wwdeg/ZwxnIEQ/RJSuCudloui6jUvT6qyV3DybgFyptJLS
         94tgyHhTiaKPPyFaXMiulrBbSrIxE6BWXDuvyzoapQaU/16bpXn2Ar4CgmCfArR6RF
         tKdwjhcl+ZFnZ/B2PbTibTxoTHlXF6nvX9xr2/R/e3TZfHFwS/0AaNNgu/YFGwwtPs
         eDjX6xnXt7HJnaMZudBmHBPDQPKCLd42IK92sWtN4CZCojW8i7qcUcdHwI2I1n4Ufk
         U9w9FfwN4NrUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF7C5C0C40E;
        Fri, 31 Mar 2023 17:26:56 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h3BUjDHvYHeyGisArck+BF1R5JmGeD4L5Seo4xQSpM1w@mail.gmail.com>
References: <CAJZ5v0h3BUjDHvYHeyGisArck+BF1R5JmGeD4L5Seo4xQSpM1w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h3BUjDHvYHeyGisArck+BF1R5JmGeD4L5Seo4xQSpM1w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc5
X-PR-Tracked-Commit-Id: 896c5150edfd5c01ed7abfcf02612f4aac6296b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bac7dc169af3cd4a0cb5200aa1f7b89affa042a
Message-Id: <168028361671.4567.1602530934806269154.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 17:26:56 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 12:14:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bac7dc169af3cd4a0cb5200aa1f7b89affa042a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
