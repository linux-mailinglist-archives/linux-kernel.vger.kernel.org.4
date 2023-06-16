Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB273388E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbjFPS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345310AbjFPS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669183C01;
        Fri, 16 Jun 2023 11:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEFFE630D6;
        Fri, 16 Jun 2023 18:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5445DC433CA;
        Fri, 16 Jun 2023 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941847;
        bh=QuJGUVl5Vy8SP0NMtMAmbmMm10oshuwxE+dK2mF9Xfk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OGQFRgPnjMNgn+L18N+vs10/baJ6lengkbypqG/OotJSGSgfd3M+6MlJCQl6AjB2b
         gUq4VSWpzOk3alNXXceHKNoNuETS2pW0jj3Yh2LquHzSPcGW52MmrZwHlBV/V9mKJ9
         e/mAxMhRi7gh2Devhsn/P0rHcBJXzdqOy6SiIs3Jw6GjGML4Th6pWuSQhRAqfY+Xbe
         hFzgShOjP2bvMFcu07xgMv6cCL1QgimYuOifcCpg3LBv2cwOSHZeuvplRcPZAAnL0/
         FMlPH60xHqAgM5c7YEwhuSeryIbMHDNdodVU+ckGXyhnL11KMWl1u3DSxgSfYJ0KVm
         afksjn5Ht22aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C798C395E0;
        Fri, 16 Jun 2023 18:57:27 +0000 (UTC)
Subject: Re: [GIT PULL] RCU regression fix for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
References: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.06.11a
X-PR-Tracked-Commit-Id: de29a96acceae732c68a4094d08dc49079eefa02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b73056e9f82ebdf9f5dbcd378e5e51ae95d5000c
Message-Id: <168694184724.2801.304043036098796333.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 18:57:27 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rcu@vger.kernel.org, jonathanh@nvidia.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        rafael.j.wysocki@intel.com, mirq-linux@rere.qmqm.pl,
        dmitry.osipenko@collabora.com, sachinp@linux.ibm.com,
        qiang.zhang1211@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Jun 2023 09:34:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.06.11a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b73056e9f82ebdf9f5dbcd378e5e51ae95d5000c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
