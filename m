Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B165E65230D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiLTOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiLTOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:48:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F81C939;
        Tue, 20 Dec 2022 06:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92CC6614AF;
        Tue, 20 Dec 2022 14:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02792C433F0;
        Tue, 20 Dec 2022 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671547693;
        bh=W5p3YkDfL5UHao8USxkt9TyDylzyXFtOKpEcm0cIjcU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MtfAKCLVtKLY3RZeOgWMaa2T/ENwERv6lDuIXOzjWwQhvMxKGIpCKfRjwNIoy1ImZ
         TpzgGObI5pRE1mY1T+XzHxNK8rDBXeK2bT96WGdDYbGUjqZGP0O+8PAGPEmNUCI9AN
         +Y1jnhlf9mu1kj2uNmirpOfTya1lBjq8lap0Ue/flSPFzp9QGqqtde5XJ4vs3ZZr6u
         lJHKKlckUHgb0d9IXjqbxpo1W/2uR9d+HlJ/hfhoy+XFtLvz7MxyZlY/oRxp2po8GE
         o6lWcrtxRB/DxMsWND8G4IYKATqfemAC1LSBi3JhA2WWS9Q8QJCjJTjMjpz/4B3lED
         W9S8RuE0k2THg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E41E6C43141;
        Tue, 20 Dec 2022 14:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y6F+XbLE2B7oPY6J@p100>
References: <Y6F+XbLE2B7oPY6J@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y6F+XbLE2B7oPY6J@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.2-1
X-PR-Tracked-Commit-Id: 4934fbfb3ff09b8500f63d4624ed8b41647bb822
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35f79d0e2c98ff6ecb9b5fc33113158dc7f7353c
Message-Id: <167154769293.15660.6420083007586291045.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Dec 2022 14:48:12 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 10:20:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35f79d0e2c98ff6ecb9b5fc33113158dc7f7353c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
