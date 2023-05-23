Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C759270E928
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbjEWWjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjEWWjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC63BF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ADD761B56
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81C8CC433EF;
        Tue, 23 May 2023 22:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684881552;
        bh=EIpTA6BatjNrPgXCu0WMjeTq5QTgr8pS2bG5J5Je9UY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b88VEPPe1yN9fsbCtbPo4h/KDwMWSPeTVf8TkG4d20W8pUy/pOPVY2aWjnRqbL6dB
         +lUzKP9GkfGEUXdJfQ+G2ZyRjjA9XFvO+lJqT9kEMns+aNah0Pa51aZVySw0ziry3x
         wBIksor2G9MzZ37sDQZOOy6xQISKZM/GsaL0IimY5D77u7AP3IC+35bB0dcbwOfaPx
         P1/34obfY//LMnwLhpBf6BitYfmuET1gMVk+goMlZS2gH6QZTmm/nEtjr4HkdsH07u
         tC29ZifxemDAoHWbNXv3NOkERBYd03sdwxhCFKeRd19flMd4VjEXI0RO4gRcbhowUw
         d4Vt//Zw/98jQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D844E22B06;
        Tue, 23 May 2023 22:39:12 +0000 (UTC)
Subject: Re: [PULL 0/2] Xtensa fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230523204131.1898839-1-jcmvbkbc@gmail.com>
References: <20230523204131.1898839-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230523204131.1898839-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230523
X-PR-Tracked-Commit-Id: 034f4a7877c32a8efd6beee4d71ed14e424499a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27e462c8fad4bf04ec4f81f8539ce6fa947ead3a
Message-Id: <168488155243.31057.14379261205571777179.pr-tracker-bot@kernel.org>
Date:   Tue, 23 May 2023 22:39:12 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 May 2023 13:41:30 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230523

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27e462c8fad4bf04ec4f81f8539ce6fa947ead3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
