Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96C5F8192
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJHA2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJHA2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:28:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863ABCBA7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 17:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36F3AB8248D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0077BC433D6;
        Sat,  8 Oct 2022 00:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665188888;
        bh=mNgE2nXkTehZ/QIDHWMVFeHv0G3GIrxjiqmHh4seiyo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VkGdBdaUKGEgq+KLdkuoMGMx6zvJaMc0bQf2qLbbf/Zu1ZJo7imdUjzWdjDVbZAT1
         P/k8j/YyjrLdkajYCP3Axovp5STtt297l7QsqZxFwz0S6g38cENP479LyFv17AgyyO
         62Iv4aUDtMCubFiS8mZWSaEzm4wJxLlwYgdP04hQFReqdZzJ30BnWX5JXFuvS9gE3t
         Lir8BoFo99/k5tM7haX42p9KX8uvYSGT1IwwSWHicGZMOckhbIDcHrSKG+rD/KT72D
         E6vETK6DStYS9WJLTsoyviuugG9fTnymhyS5iRmo0tyF5mEVc0oJTbhRShuOkwr6kW
         BXyuTrko6epxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E42A2E2A05C;
        Sat,  8 Oct 2022 00:28:07 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0BYiwvr4JZio4RH@kroah.com>
References: <Y0BYiwvr4JZio4RH@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0BYiwvr4JZio4RH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.1-rc1
X-PR-Tracked-Commit-Id: fda8c908bc2d523c0770ded667dcdad29c06ff52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8bc52cb8df80c31c73c726ab58ea9746e9ff734
Message-Id: <166518888792.15803.12742281160196833329.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Oct 2022 00:28:07 +0000
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

The pull request you sent on Fri, 7 Oct 2022 18:49:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8bc52cb8df80c31c73c726ab58ea9746e9ff734

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
