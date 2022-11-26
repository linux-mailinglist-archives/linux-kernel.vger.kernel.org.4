Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6863935A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKZCZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKZCZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:25:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E3303D0;
        Fri, 25 Nov 2022 18:25:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DFBE9CE2E61;
        Sat, 26 Nov 2022 02:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B16EC433C1;
        Sat, 26 Nov 2022 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669429539;
        bh=rqSJ9+Gremq2STOOSCEkdIfkJu/Lb9mJaGMYQxZsp2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W5mcf1UZ9ek1VZoOg/VJ/sPG/LertVGww+TEIG9Air/cHYuvCG/Lt0yIy1AI0wmvT
         6KsjgWqkqtPVTmT2YwlggwsOJip9RqGHCO/RrTpDIPYGpF/GADqXZvlwoYVTLEf7fd
         r9dDI5aGy+uMALYBgwwA3Gz4I/F5JPrTRb50MbKwYzOeqoWZ3l2Yk/BmcM1nr3/hTO
         X4Kfz2Rw+5hOla1cTgw6zL/bmDBSRGA6VRt9rKIFTbu0DzhPEeRt26Cjh2IYGgf/tg
         +wbkLy1NQK7tSVzu6tu0IW2O75mWRr0SxeccJmVH6KaK3k7UBg5XTJx3OvSfYklwfR
         +iiu47IDv0nFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02710C395EC;
        Sat, 26 Nov 2022 02:25:39 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221126010441.kkp6iavyvlcporpy@mercury.elektranox.org>
References: <20221126010441.kkp6iavyvlcporpy@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221126010441.kkp6iavyvlcporpy@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.1-rc
X-PR-Tracked-Commit-Id: 767e684367e4759d9855b184045b7a9d6b19acd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 644e9524388a5dbc6d4f58c492ee9ef7bd4ddf4d
Message-Id: <166942953900.27056.2773363292394661500.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Nov 2022 02:25:39 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Nov 2022 02:04:41 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.1-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/644e9524388a5dbc6d4f58c492ee9ef7bd4ddf4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
