Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C00C748BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGES0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjGES0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8399D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A6A618DC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 058CDC433CA;
        Wed,  5 Jul 2023 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688581143;
        bh=SDZFPJ2gSAtIczZhtVY1R9JJaS2oslw4J+Myw6W+Xv8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s7sUb/RChONxlO3lTPGY2kkQgpjrqVAXKnC+KDL6ltsEC4zCGV7AngynY2qlFAPxS
         +/oLfSE4n3Z+w09q3vE3kWgpEAOjkNZFHJRnXMCLoI/wiV4ONVlHpptKG57+RIUKRr
         Teg94GQhWuMFtAt/2/XKd24ZZLj3PSDZ6VUU4cRGHrohcMz1kqvPReaRZ5yr90yinc
         Vnsp4luG4A4+L4TDCzbfUj46ixpj5BvJLrm8Ozg7VStvZUidouyKUvd05SAPN/ghzO
         3K1K5LBFdQ0NTglDQ3QLRY0ebPfnlAC/fMy7MJxQ/t/8G0MkZncjC7aIqsfO+OWf4X
         d9C8QUIZiu5dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4EB7C0C40E;
        Wed,  5 Jul 2023 18:19:02 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKUfH+9OswEIGEyR@matsya>
References: <ZKUfH+9OswEIGEyR@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKUfH+9OswEIGEyR@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.5-rc1
X-PR-Tracked-Commit-Id: a4857d1afdd1fa7ff763e1d07b1c2db521a5f9b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe1de55167963a1c0ebe1579e37a8a41495f0a81
Message-Id: <168858114293.22216.2737603356142237545.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 18:19:02 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jul 2023 13:13:27 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe1de55167963a1c0ebe1579e37a8a41495f0a81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
