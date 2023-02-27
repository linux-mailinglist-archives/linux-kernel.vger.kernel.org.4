Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E9A6A4978
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjB0SSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjB0SS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:18:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FACB19F03;
        Mon, 27 Feb 2023 10:18:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A52060EF4;
        Mon, 27 Feb 2023 18:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BFA3C433EF;
        Mon, 27 Feb 2023 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521904;
        bh=2656tG/Nwv2eCaX9p4L5jMe5pd9oouUX7YKh9Mo1UNo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PP8y/XfzKiz140GByZkdPQn+sJ1cr/m71CTedbcg+neB9Wr091jDCzWCY0RncF7W3
         AnDl5rYkgwUhF6e9xRB2Sa1fNqtX8uGbssYuPnjPBeSsauXgxv9CKo8Bn3zgPTjGbW
         E9rlhvPwQeDCIly6kmIsaajtOLyqEVhPWimfqz3hEaR97w2YEw+MBLX/ogGf1MiyVD
         gqqZJrHt97LQIhYPkr8gbBU1bgnJI9RaadvuBPUvPMpRPDUOAoQQ9tDlYe59W2OXsy
         FfQlMpnJA91r5tsNP5KFswqpg2rq/xRgIro8IsXaADsmV+yOlIUcct4lPNNN+MZJ0K
         zEKw7yXUdDJsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A453E1CF31;
        Mon, 27 Feb 2023 18:18:24 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230227145003.69787-1-ulf.hansson@linaro.org>
References: <20230227145003.69787-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230227145003.69787-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3
X-PR-Tracked-Commit-Id: 571f235163ac83407e212b78719175236962aede
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da15efe1a8513e0a949f429338155a56667dc9c6
Message-Id: <167752190443.27343.9337538945989806488.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Feb 2023 18:18:24 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 15:50:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da15efe1a8513e0a949f429338155a56667dc9c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
