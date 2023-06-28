Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46AF741A67
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjF1VKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF1VJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999791FE3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3803B61460
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99ACAC433CA;
        Wed, 28 Jun 2023 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687986574;
        bh=ZaLGGh76WFOG/+DKUPINFY/cQoKHfquNPr73rFSBYNc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CWPTBgyPSni5qmL+bkL4lQ2AR9rUMTmPbJphtgvLvHAzQN20+0snyfNT5Ahk9NVJZ
         OAcShGKAj7AgeODve57x14U1QJmyP8p+KXLnnObb3aT7teHNm6r8F9HBGVE7EiFBA3
         okY5kBqyXeVuJowhd5hVogEaIYaNQ3gugiSgV9CMu55B/uAw/gOnmI/u6uV7f9poNL
         1ELcCoF0v+Jr4iR04HalxRobjZk2I9gcUTTl/ArLW695SaA6gbkcsHjVRKuZVHu3Nk
         CRZeVk+Cqoh2hrCsZ5uTO540FGgBX4v0JKzQMzPLnw4W2Z8iri9Xh4vhLRDGS3nq0z
         V2kwp5Myf3eoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 881C6E5380A;
        Wed, 28 Jun 2023 21:09:34 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626133326.C5BFBC433C0@smtp.kernel.org>
References: <20230626133326.C5BFBC433C0@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626133326.C5BFBC433C0@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.5
X-PR-Tracked-Commit-Id: 54e47eade73046e860634736d2651ddc118ca694
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 362067b6d5ca5b59a849a8e1183fb51d616fcf19
Message-Id: <168798657455.29247.4138091011701896847.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 21:09:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:33:17 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/362067b6d5ca5b59a849a8e1183fb51d616fcf19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
