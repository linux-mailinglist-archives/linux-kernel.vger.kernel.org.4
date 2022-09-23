Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96CE5E7FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiIWQ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiIWQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B90121E6A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A17862892
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99422C43141;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663950358;
        bh=tXWGPTKniGXNmCmGNrAYElL5ayZzApq9NkraFI3R6iM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XCTdzz+kde0mSZMlHxx1sLlc1+OTzBSyq22MzlpoOwSzyEe/94l9Vv2cp+R9LDD4s
         tzMGr6MjvZU+wGPO/ntoBq4mv53Lilr5zysefKGIvrbRSgZ+7Ensrvx3tj1vNqMkzJ
         OXrbwrUwswUkfRhWx9YGJAkk+P5zVeSYmtJQdAQDBq8Z1cqdU10lyaNq3Ql1J5lTyq
         AWXIg3qDCViS5rRVg/BI834MrXVMG8Qo6unZ2reo0G+Z3zBEmj5U8I4DSXioClh5vz
         qD4Y8UEcY11EzQqq+ekZr1u2ZpMSL4CVl5eCWZ5fIRzWTlcadnk/a3/sf5AbZphbBI
         svhChsgdCzIMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 863B9E4D03D;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yy3MxlD/kXT2SreI@kroah.com>
References: <Yy3MxlD/kXT2SreI@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yy3MxlD/kXT2SreI@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc7
X-PR-Tracked-Commit-Id: d7f06bdd6ee87fbefa05af5f57361d85e7715b11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1707c39ae309bf91965aa6f04d63816a090d90a1
Message-Id: <166395035854.8411.1815691394664096206.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Sep 2022 16:25:58 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Sep 2022 17:12:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1707c39ae309bf91965aa6f04d63816a090d90a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
