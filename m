Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72196EEC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbjDZBwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbjDZBwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208AB49DF;
        Tue, 25 Apr 2023 18:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14AD863250;
        Wed, 26 Apr 2023 01:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 798A0C43444;
        Wed, 26 Apr 2023 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682473880;
        bh=3xA+wSOHMJ8A/sQYNiyGeFEq/ri3zjrXyAtEYxwpwRk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LAwi5+zF+SVeKwfu//TyCe5SczP03j/E1ko+7bFkOJK9oX3CnNGMSYzMcVQWpFtkS
         DrWj1ycO0MI7qLZM8TSdaCTPxR9i3ZzAKTsawmdvORLYGmXS0doSF8v8tAAJS/6xty
         qnDfx5o0J73nPKQ+mVsjeUpZ36mxBrS9rrAjVEn4uNnYdyskPj017WeVWIRH6WDdv0
         1MEExaQ3Ag1JNboJffW/JCbyOmpolGaEku+/DGLJmHYJolsXwGo71ZILs9J7m3O1MG
         WJVLbdGSXQsC4DgKvtISwsFHvPt13PxErIXdckssgVdyCtWxdEX7SAq5wRs5IWK0Wt
         LwW9PbMTceQQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F017E5FFC9;
        Wed, 26 Apr 2023 01:51:20 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h8Biaa+9GMaXs4N-OQDKa=k+fPO5zgzroATTUaaay4Ug@mail.gmail.com>
References: <CAJZ5v0h8Biaa+9GMaXs4N-OQDKa=k+fPO5zgzroATTUaaay4Ug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h8Biaa+9GMaXs4N-OQDKa=k+fPO5zgzroATTUaaay4Ug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc1
X-PR-Tracked-Commit-Id: 4f810294e00bd99da9ec3c8fe3185a73e39bcd6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 793582ff47f8b73be8d3d925d750bf3ef79f33c7
Message-Id: <168247388038.11449.2826587541321393259.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 01:51:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 19:51:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/793582ff47f8b73be8d3d925d750bf3ef79f33c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
