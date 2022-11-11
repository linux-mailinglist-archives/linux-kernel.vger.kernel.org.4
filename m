Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0916260C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiKKSDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiKKSDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:03:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3839963CD8;
        Fri, 11 Nov 2022 10:03:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8FDD62086;
        Fri, 11 Nov 2022 18:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38ED4C433D7;
        Fri, 11 Nov 2022 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189779;
        bh=kRrN97yyGBeeQZI+RHL5L31upcr8CzZfwvkRpMaJYq0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YQW2d6cXqic7I5Zw5xWfODy9Q25hT+PN/4tP/5O6BHPtA8quXsbhYIcx3/ckZQQl7
         Gi4Fb1cZOWGIgJyaLzt7xCvYljMw0ofT9I4TUrAc5QmoIzTqARupiBUclOJv/EUBYc
         Chix/PT5ANmIMauD0l7Dbz6ypsF2XDCu0AxxF2VzQsSBcp+25sHWXkdLQOSwF5VCSo
         XWKYQlfPr/LYFOQAS+Lv18FHCOB0GWKl3OreJDznH5XUo3guG13aIrryIZwPH+3azB
         H4ie7HOv/LJluPyA4QGeS6Ao4naPob8bBMTeLI6Z5U2I8RD3zWde16BBLoiINj9ElN
         oh6Pp0SHuu31g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29B85C395FE;
        Fri, 11 Nov 2022 18:02:59 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221111122554.112164-1-ulf.hansson@linaro.org>
References: <20221111122554.112164-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221111122554.112164-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc4
X-PR-Tracked-Commit-Id: f002f45a00ee14214d96b18b9a555fe2c56afb20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c42d6f5e663f39bcf56d08685d84a7b1d011c77
Message-Id: <166818977916.15878.14095937971424375358.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:02:59 +0000
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

The pull request you sent on Fri, 11 Nov 2022 13:25:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c42d6f5e663f39bcf56d08685d84a7b1d011c77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
