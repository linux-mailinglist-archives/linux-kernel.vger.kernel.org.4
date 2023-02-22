Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AFD69FC96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjBVT5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjBVT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:56:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366B13D65
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42C9B615A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21F32C4339C;
        Wed, 22 Feb 2023 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095633;
        bh=HGs31qSxmLLhd+T2XxTFyujnqkN4aKRJbcNnoeglS1A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XuC0RzXhPYzgpT2BHBURmVFQid/xlBEKnqRj/aWVyC6Fr/d908yJxIg4fIi05hF9m
         RiOPpKFpyPWf9oeVGn9WWKU7w46NpaNknzO7JSMlZEEGqVbDoiN+AvqlqGKJLA0Urg
         EllhAuDHJNcaZ3GZjuUZAjCa6ha9ajivvnKTSoWIgVeKxUClST5IbjmaEz43VYuZZ+
         UrRVGaAs8B8G8+dwrpinwLsDXOjqzNJ29W4sn1WSpf+P1SgWb69fEFCXrk5pGvFm0o
         pmfg2leMVi4EW9D5tTeYnog6fDQ3mYhGleWJrfTigBNmw0x2+pxYd9OZISB8QLYwyi
         MyaDAyYLOib3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12278C43151;
        Wed, 22 Feb 2023 19:53:53 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/YNPWfyZE4KteG2@minyard.net>
References: <Y/YNPWfyZE4KteG2@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/YNPWfyZE4KteG2@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.3-1
X-PR-Tracked-Commit-Id: befb28f2676a65a5a4cc4626ae224461d8785af6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc009f9382bd0704273c9a0c1cbf72020bbbe1f7
Message-Id: <167709563307.30115.3799041311740785834.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:53 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 06:40:29 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc009f9382bd0704273c9a0c1cbf72020bbbe1f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
