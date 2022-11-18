Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF2462FEAB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiKRUVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiKRUVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:21:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B84E421;
        Fri, 18 Nov 2022 12:21:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D05BFB8251E;
        Fri, 18 Nov 2022 20:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83431C433D6;
        Fri, 18 Nov 2022 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668802859;
        bh=rS0g8f9P2O1DhV0yxSQp8kpo82MH8KbdqzpZovYn/YY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=omET5ZjH/WbN/mzCuoVpmhh/n4evmwnEQtm6iIdckc7q/lkeQl+GrI89SyhFNH+Iv
         VLOaRNMqvKshEAC0ywC3n3Pr1Neh3A5fChGnWE5VGHPYOVur72qnn9DYQ/QM2G1hTV
         86ZNKIf1nCqiqWBdZ25VAmUpt5sEfTWpuLJ7UlpfakhmFoD5lIHJRmE7IkG+tUtlfK
         a55Fa30bzZUxBqcDXeydxlLKSYQx3e45ig0chvexz7pIZ5RPPvJcVlWmiETUlayPBr
         wdW3eogow7a9Goo5vsTBMRY8ArWjlErfHlTl+sJRi1bYoN457Oklg/hZ16gF8zqd+r
         OcZsXhRJabvWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FE35E270F6;
        Fri, 18 Nov 2022 20:20:59 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221118093839.6361-1-ulf.hansson@linaro.org>
References: <20221118093839.6361-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221118093839.6361-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc5
X-PR-Tracked-Commit-Id: 222cfa0118aa68687ace74aab8fdf77ce8fbd7e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ab9ffda3f5a6f6964507f5b1b378a475caea27a
Message-Id: <166880285943.9331.702936276857954274.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:20:59 +0000
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

The pull request you sent on Fri, 18 Nov 2022 10:38:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ab9ffda3f5a6f6964507f5b1b378a475caea27a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
