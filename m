Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC66F8A37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjEEUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjEEUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421804ED0;
        Fri,  5 May 2023 13:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2E7A62C7F;
        Fri,  5 May 2023 20:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33F84C433EF;
        Fri,  5 May 2023 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683318793;
        bh=QgYpg6VG+GVY/W0oJGLPvv3HDUz6MXHNYh6Gisp4YAY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p2C5OY2DirvcMZVr3CmOsSaaeOkS9JcyxEzOFFkuVbzasbcgpWgkeEIPsFasb6gXt
         G4EwLmicHK2eUrDQkhA98D7CXV+PKovxVW3LUQP95ykyibop7qCMhl025fbvGi8rpn
         +mZ8lGJaP4NHu0UqsMV+DVSMegM3mpkDhIMOQQv76+WxBSD0h1gUfLfD+7KbXVZuY2
         fllMOiTteKJUzCK+jPp9h16C3IgsZ+D6CzxgUNOAMZ1PNsWSRQJckmRWxWKNc1lcfp
         P3wZF0KH4a4WQyIEOTNwImxjYPRUn6MgeLgBT6bQ9SYg+++LanacVV4dMMTF0kHFzI
         Iw9i7ajDqtbDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D3B8E5FFCE;
        Fri,  5 May 2023 20:33:13 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation stragglers for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874joqmxn5.fsf@meer.lwn.net>
References: <874joqmxn5.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <874joqmxn5.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.4-2
X-PR-Tracked-Commit-Id: cdc822dda6f82269b94d5fa60ddc71d98c160fa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 647681bfa678400f0117d214313005cbfaf79f48
Message-Id: <168331879311.21250.14911048555448450794.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 20:33:13 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 05 May 2023 12:38:38 -0600:

> git://git.lwn.net/linux.git tags/docs-6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/647681bfa678400f0117d214313005cbfaf79f48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
