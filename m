Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E366764EE71
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiLPQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiLPQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:02:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D623D70BAF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AE262166
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88C02C433F1;
        Fri, 16 Dec 2022 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671206421;
        bh=a2bt3ssJdPRv3ViouOAraNWuBQ2e3+pMiHngmtpfNBo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tDqYMiQZD1+feRqFTqO3Sut6s0tl3iESJP9R8jiWFQA8FxUcWkAOFpBO0xB1RtC9m
         K9s3ZDOOAa09Ykh5HNJ6AORi7UIlG4TUe4Ry598FF86Tk0xGx4dlghiASnFhGH60M3
         1cuH2f+kBmY1EuAlfivGST1pRm5CAzskJq783qNOEYqsEZkYHVW/m16LA0lUef3I23
         09E1TUnh+n5JQLTekmsgJfTNOLPFKEqZf5BVL/WmbJuCj8oZraSG1OQHE5C5UFi4Hd
         Gy1II2wuYYPQ7ZGfuWzxQ9Dfg43N//ctNhE9bSAW4iqcpGWSVnRYKdkZW04VQXLra5
         YGg0bMnD04WDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75760E4D00B;
        Fri, 16 Dec 2022 16:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5wwE2YWlzzG6VkA@kroah.com>
References: <Y5wwE2YWlzzG6VkA@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5wwE2YWlzzG6VkA@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc1
X-PR-Tracked-Commit-Id: f361c96c75184d0272572087c7d9874e0f64b870
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba54ff1fb662215de683777f815b9e96276d55cf
Message-Id: <167120642147.30725.10254793477948634057.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 16:00:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 09:45:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba54ff1fb662215de683777f815b9e96276d55cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
