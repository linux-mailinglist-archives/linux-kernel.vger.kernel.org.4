Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB915E6EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiIVVwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIVVwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CAD193F1;
        Thu, 22 Sep 2022 14:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35BEB60C00;
        Thu, 22 Sep 2022 21:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 952B1C433D7;
        Thu, 22 Sep 2022 21:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663883559;
        bh=ujKmTNIn7mi6zx2EojvxsNyv0E0/U+9Sx4gzniCZb7Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g/FJ+pKmUPkc7Ny3QK9bgoffZhwMnYDiRVMEvg9YYavqIC7MZDl1uYi1iHgKb9Vfk
         R3aVbPGLISaF/d3XCPTpJx3JkoHU9/xDBhwT1oC7NVNbaXBIyn4ehYnCEGo9AsaiRr
         zU4OPHETV9r8rofdiUzNVUEo01nhEOywsCyAhwFVgD3KAQ5UxBhnrt9cFtXPon+O2E
         2ge88SVyEoBB8XJ2grjPP8s2edOGYpsWmziEIBHSlgVkhM7Rq+IzyTSGNoAyKDi+3y
         kZkuyfJttgNQGgV5oIS2dgBlRH46KFl1BHsc5Uhj4R0Pn+L6D4h3j0dOQ8vys9Mx+4
         SjksEvoMkAkGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FF30E4D03C;
        Thu, 22 Sep 2022 21:52:39 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <72da0a69339074e2bad5295fe54a291c1e5cd206.camel@HansenPartnership.com>
References: <72da0a69339074e2bad5295fe54a291c1e5cd206.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <72da0a69339074e2bad5295fe54a291c1e5cd206.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: e0e0747de0ea3dd87cdbb0393311e17471a9baf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf682942cd26ce9cd5e87f73ae099b383041e782
Message-Id: <166388355951.15587.1956697213604770182.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Sep 2022 21:52:39 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Sep 2022 16:57:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf682942cd26ce9cd5e87f73ae099b383041e782

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
