Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C226EB044
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjDURJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjDURIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C259916B11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8747A65262
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E802EC4339E;
        Fri, 21 Apr 2023 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682096883;
        bh=VTkqfYlhflWGE0HDQA1Ob12Jyq2h3ftfJbEiVCQJOuQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hNsT2zhJJpE4+313goO1sLoC9HhB+h2GwoBqUrh1LhXOgm+odg5blft5j8Adf3/uh
         R6ZddwHB4ANfVEn9exg0+3fGI0tjWYGdEOTzUjtYrFpYekzbZ3pKPoF7E/bEaUnZMZ
         NwQEciRQ7XTcf3mQrHAXUIUCcMwwTtTA+TYVLXQL+Hz7RiI5d+NyoFUljCwuRtKFmw
         mv8rhNzB1huSBv/SH4inyQjD3wPQqJCiKUw/tRBOy6acgZ7Kb11a+uZzYWJ+dx3RGH
         1oP6iJi8TbFqV8HaCS0bpk1yBt0nrKD0f99bppBe5UWP+ROb/o5RPJuqRzx72hK069
         Xbms9SInoPrlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF9A9C395EA;
        Fri, 21 Apr 2023 17:08:03 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.3-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEKE3cyac7wCBgvH@kroah.com>
References: <ZEKE3cyac7wCBgvH@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEKE3cyac7wCBgvH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-final
X-PR-Tracked-Commit-Id: a042d7feae7eff98a9ad5a9de5004e60883a96d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fd06d441e35cc9543b410f9cb9aaa8e54ece38d
Message-Id: <168209688384.21086.14290330364916536678.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Apr 2023 17:08:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 14:43:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fd06d441e35cc9543b410f9cb9aaa8e54ece38d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
