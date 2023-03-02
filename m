Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADCE6A888E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCBSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCBSeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:34:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA58241C5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AB561625
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 128BEC433D2;
        Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677782047;
        bh=So29duMRmwjPq1SnrG+9RZOx5g0QTJtZxrHgBKyWQLA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F4KGNCXQh2Po5ANh5NyjtNGX5rYrijtV3eZkPkTzxMdD+ZxB/P0MySGIEGz9uDkvU
         el5VY3ZkqKMfVuaeFY26pUFgCKctq29KL2k83CPrquCzKdxMh4ag+dUAxqaLtBPuRE
         Bi8TxbNB6YObcrx4qTioSZfgXHvZBUqjcF2L22AsF/tPoK5fiFVUuqqa8IPXl7UJ0r
         VaZKcM/yV4vUIRKLTobJFiD4T5iDbQcFrW30sETUBcG1RnlejhL71gi8KRljcZKcxa
         UQPsyg1MbDGcIF8Ic6VC1ISdVT7xaqQlJ8ODghaD26jc4ASutnacuxudf+2hP46GNf
         MzhVv/9EhU2cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00946C43161;
        Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230301203453.E411FC4339B@smtp.kernel.org>
References: <20230301203453.E411FC4339B@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230301203453.E411FC4339B@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3
X-PR-Tracked-Commit-Id: 80d2c29e09e663761c2778167a625b25ffe01b6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd7ee8de984efcd31b8f5dce9e340ccd59eb436f
Message-Id: <167778204699.4243.6019367533386419193.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 18:34:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 01 Mar 2023 20:34:41 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd7ee8de984efcd31b8f5dce9e340ccd59eb436f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
