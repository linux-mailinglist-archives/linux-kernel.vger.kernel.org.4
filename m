Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998A744A8E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGAQfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGAQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:35:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1367F1FE3;
        Sat,  1 Jul 2023 09:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9872360AE8;
        Sat,  1 Jul 2023 16:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00EB9C433C7;
        Sat,  1 Jul 2023 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688229306;
        bh=0ez9MoDzWhAXWTZ9Cqjw31eoych9yodX6LQpyYYie5I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e4CfBUHnCVs7ARliCgaXbCFWTX6B2a221sUpjaLMyg7F2hyIWExKvv25fHF/N40xA
         Vb7ko2cdBicgHtx10p+9vnxYutSMq/VzQig+PjBLCPp6EY8G0z8zkGMXbrDfSDiNj0
         c8qw2PS0IBgthsVKo71bIqTLug9l7xulDN2NarSSbV1ZzXdRp/YNidmIouACuBozKw
         uPG1N2OMY2rFrob0yF7lzzU0XcvgFvbqTZmyeTABga+PCQvcn4qY5FTJiF4/PsBFZX
         z7AtIaf0pInWmemmY9yvmF7NRIIWv0imBK3U+XSuoO/IErH9qSavX1ltvOVPqO1Jof
         YjENKPDK6P0gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7B35C0C40E;
        Sat,  1 Jul 2023 16:35:05 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQEm1K9VLuo7XqxYKnyvqfbyWKLuEVmxfex7emow7idXg@mail.gmail.com>
References: <CAK7LNAQEm1K9VLuo7XqxYKnyvqfbyWKLuEVmxfex7emow7idXg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQEm1K9VLuo7XqxYKnyvqfbyWKLuEVmxfex7emow7idXg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.5
X-PR-Tracked-Commit-Id: f5983dab0ead92dc2690d147f0604a0badcac6a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad2885979ea6657fa8d3da51a301ec0e998ad8e7
Message-Id: <168822930587.13164.11567286196896365671.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 16:35:05 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Jul 2023 18:01:25 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad2885979ea6657fa8d3da51a301ec0e998ad8e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
