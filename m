Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2436A2393
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBXVQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjBXVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:16:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC69B3D0B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7196EB81D67
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32CA0C4339E;
        Fri, 24 Feb 2023 21:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677273362;
        bh=l6EcXf3awIsWH/5ffHZPcG76intVuHRAKUwQaIiTA5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IUDXYyz2jR3tshg4+w2XRVFPJHZidJ1DA3zXhYDeAEDqqCneXaGUkeQkPZ7yJY13D
         vOx+ukShXMzNnGoREbiWxGZJAgc55vomQvIjQPrb4ruEkje849qniD7xSAJosJPfQE
         YtBq9sU6Nw2lGvN2b6MqlwWWdAZKmYH3PHc0UOI/dxWTUXl4q0TraW8x2sbGGqoaPA
         EEE2WErnzu/P5BasNjZd+j9CTWJ4R6v7462I27mosKDal1K6r0aIK44TcHSIWSN3QN
         ceyaym2/SyrFvxs5xD7K+hT9WT3g9/OQwqBiZjHQkUNnsegZKKsKEFMXI1jM0hYAhE
         BWPHe4wPPgUJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22700E68D2D;
        Fri, 24 Feb 2023 21:16:02 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/izGr/4KrHkbHx+@kroah.com>
References: <Y/izGr/4KrHkbHx+@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/izGr/4KrHkbHx+@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc1
X-PR-Tracked-Commit-Id: 6ec363fc6142226b9ab5a6528f65333d729d2b6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 693fed981eb9bf6e70bfda66bb872e2bb8155671
Message-Id: <167727336213.26367.11949900365121826608.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 21:16:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 13:52:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/693fed981eb9bf6e70bfda66bb872e2bb8155671

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
