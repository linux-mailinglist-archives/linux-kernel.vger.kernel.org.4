Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458C8611C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJ1VLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJ1VKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D6815A326;
        Fri, 28 Oct 2022 14:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FC5C62997;
        Fri, 28 Oct 2022 21:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 748FFC4347C;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666991449;
        bh=pm9YjiBIZ/pZWMh28pBsYMIyq6sqPGGQf5lKEbeL+9U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pVUeRpPlOKOdUhOg2u4SXrYpwA+VekbIrl5TFgeVyoK0EtYzR/x2zAfU17u2ckytf
         rPt7HpJke84/A1O5fe/TTopGLETiGfIPaTEnudILcqeds+IMzYLPkmLvAhe9ghgc7S
         qxQMuUCWC7NLVDeC41NOQ0zArsO5h9URHZRXCRUuZRI+s1xPTpXIiW0X4Md+dYOAv+
         GbpfU1UcOGItzSWTVr31fscy70u1r2ReC2VRpRlXpJUoTm98wYPR/oQZX199HSMyXf
         JHPdPVg19vf64nypIvd6ozh7ET4A2gUO8jYRBtYFfDEVz8iht5rl07pA88DiWQEULY
         q/iWNluRvVT4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63A1DC4314C;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221028135255.8070-1-ulf.hansson@linaro.org>
References: <20221028135255.8070-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221028135255.8070-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc1
X-PR-Tracked-Commit-Id: 8d280b1df87e0b3d1355aeac7e62b62214b93f1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18937b04777404f628d32206170026e84146a352
Message-Id: <166699144940.13387.6664745745855822971.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Oct 2022 21:10:49 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 15:52:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18937b04777404f628d32206170026e84146a352

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
