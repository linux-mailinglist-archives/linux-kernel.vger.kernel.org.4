Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DCE7325AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbjFPDKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbjFPDKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759002D40
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08E862699
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37E65C433C8;
        Fri, 16 Jun 2023 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686885019;
        bh=N6IOG4FSja+Pos4yW+lCDNslTTyTUlUBbTFCxFB5hQU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WpGKHk6X/r8fiAYoQtQ7EC/YXt5wmlzbyn4afJH7K6M4zkz/0wuyEGzV3JLo0zqvn
         GDSnttoGT36abAclLYiZpxoi11iH6+Y+PoBB1av+myiW3IyHF4eoUvBaPl7zHypyDd
         RICMU4ak+fNvZLpK8Scy1ABnz8d3960/c/MCLJ7ub3TndAGJfB0LA1CEXoFEpGmllF
         IBbaQWGrC3C2LskyGh7yiMmWPCNUm9yzY+HI8f315FPy3w/uPFZcjUv8S7DPlMIrfA
         rK2qgYtgxjCxW64tpjmljX+GYWkBUjxhWtO9WLI0kr3tDOhZQS2g2RtEiBepZSpSSh
         AidZajbnq6c1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2018AC64458;
        Fri, 16 Jun 2023 03:10:19 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230615114317.4B9DAC433C0@smtp.kernel.org>
References: <20230615114317.4B9DAC433C0@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230615114317.4B9DAC433C0@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc6
X-PR-Tracked-Commit-Id: 44e46572f0bae431a6092e3cfd2f47bff8b8d18c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 231a1e31574e3584cd2c297c98a5afb364715b3a
Message-Id: <168688501912.31465.9284681317757151603.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 03:10:19 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Jun 2023 12:43:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/231a1e31574e3584cd2c297c98a5afb364715b3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
