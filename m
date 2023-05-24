Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09CB70FE01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjEXSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbjEXSsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685112F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD0F64035
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E39E1C433A1;
        Wed, 24 May 2023 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684954103;
        bh=LOGXkJ3q0b6+8QB/qcv4xMbA63kEE2dqiGPVmSnJQdM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s7JPMcfitegDzOwt7OJ5NB0kEejSpYVl8cRc0F2nGAK+dEwFtXvO/VS1GwzkOyq4+
         12/MKLondCu9m1PPCb+WUfGDPZA6OGKDzJ7Jqg1sg2klzHjteekU1wk0O6RDrdHWXZ
         D8cwsGj/Qaf7y5g2yTVP56VMEvZtK63LsDP15BqZxNBDatOFRegq9MBSNz2aC950Yn
         g3l62rLwygy16tpinxLUhxGoz+OepzBkq2ywUAs8yvwOaIS5SyNVGajhEo6H4P9RoT
         lqgUq0mgrPK20VexDFqC4v6yMokWmBEZSM7+pJhOYhzslXtAPZ34WauRcmpu94WpO1
         uH7fQLX/lK5RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCA29E22AE9;
        Wed, 24 May 2023 18:48:23 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230524101308.17016C433EF@smtp.kernel.org>
References: <20230524101308.17016C433EF@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230524101308.17016C433EF@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc3
X-PR-Tracked-Commit-Id: a511637502b1caa135046d0f8fdabd55a31af8ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f767b330d8d7c27d6cc0abe594c0ab24e7f6e429
Message-Id: <168495410383.10364.11425906405482799432.pr-tracker-bot@kernel.org>
Date:   Wed, 24 May 2023 18:48:23 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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

The pull request you sent on Wed, 24 May 2023 11:12:57 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f767b330d8d7c27d6cc0abe594c0ab24e7f6e429

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
