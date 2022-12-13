Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4D64AD42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiLMBkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiLMBkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:40:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9753064D9;
        Mon, 12 Dec 2022 17:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34ECBB80E06;
        Tue, 13 Dec 2022 01:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D758AC433D2;
        Tue, 13 Dec 2022 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670895595;
        bh=8UmF9jjBroN4Tr4SuCYDWIeZg3AU5ssgIt++syYkz6k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CeKPRhaLkbVm2pzmVuKeUQFLMb9QapIbMGXna/So+7kAX6fiyvrbaUri6WU3QEokX
         q1JTh/M8MCo6Q1q45NreASJrjDoJV8REX5Wk/CGDP7FcBW1KVjpMlsQ9uR8PQY17Md
         dJE6CUSWSiCuNR1qq77OmRSLlZ3WgnVdh5hyttjgtFM0vgUBJVwTg5EU2l7oaRWzB+
         y9ZyNuU5a35frOhJzPSJKzij8VDVoN+SLL7JJ9AOKAlLRL41tJw03qgieTg79gsfez
         No8s40mWByZHQHk36M32qErOLSPskLRf7GZLh46XcNsb9qgAJPxkhxmEfl6N25eq62
         XkT9juARRhZqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6703C00445;
        Tue, 13 Dec 2022 01:39:55 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87359lj7nw.fsf@meer.lwn.net>
References: <87359lj7nw.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87359lj7nw.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.2
X-PR-Tracked-Commit-Id: cc8c418b4fc09ed58ddd27b8e90ec797e9ca1e67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7cacfb0688e3988660e90fad7017cc9a18ab390
Message-Id: <167089559580.7166.17194635521272009177.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 01:39:55 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 02:25:07 -0700:

> git://git.lwn.net/linux.git tags/docs-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7cacfb0688e3988660e90fad7017cc9a18ab390

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
