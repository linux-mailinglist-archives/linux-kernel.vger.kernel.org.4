Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF156EEBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjDZAuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbjDZAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1403193EC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F80F6322C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D038DC433A0;
        Wed, 26 Apr 2023 00:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682470179;
        bh=q4N0gmgOKDlYSemJEcaumEBnPeh47zgbeLGdcxXwBL4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=arKavoRxOlcnu/IeW4V6LCJ0GI/X1BQBMnKO1MTj5qXmY9XjBtbUOrDr8CWFb0u80
         gR6pHP52din2dDYfn6DNIzxGXi2Yt/DR4jB4BX9lZ6d5KeyZa6m7I1NN8IIAuidI+z
         sCswgVL6h9Te3AV6lOdsBVgTh+l2Vaegx9eJ9nvhaCOqoonhk1CtaHv3BVDE/uhoif
         DKKJoM+YmIad6oqyVzlYUG3AAPqcpI8qtKuukAZ7P4vRpaUtIW6AmWfKQiv8thbVsI
         Rzuxo/VbW592/MULb3EiOAl+TORTlZTizoOecRkk9+wySUfxeD39qTj6UQ2SMt2IDT
         fO0zTIaIa+1Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD814E5FFC9;
        Wed, 26 Apr 2023 00:49:39 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424131035.E56A1C4339B@smtp.kernel.org>
References: <20230424131035.E56A1C4339B@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424131035.E56A1C4339B@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.4
X-PR-Tracked-Commit-Id: ed479907ff79007548c3bd1aed387f8cf0a62065
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d84955790e16588774c4365ba0d449e8a2aa46d8
Message-Id: <168247017977.10866.15441696389263798991.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 00:49:39 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 14:10:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d84955790e16588774c4365ba0d449e8a2aa46d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
