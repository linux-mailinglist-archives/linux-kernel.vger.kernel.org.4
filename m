Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2315BEC17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiITRf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiITRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:35:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D304AD47
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B147E62BC4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 180EFC433D6;
        Tue, 20 Sep 2022 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663695310;
        bh=tkODw5LIMRjsHsOerdVugr3CZIz6j5ANyQ8hT40L3WI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IsQX8hlJ/sra3iTkosMkr1aDTy6AMISChX2zPSbNb5mUIYlspPRVFYRcdd09XcncD
         M+SbGK0OwzVwpGRZiH0zRbjVBdcT2B+YlH3opxFT51D1PoI5mF6oTELoQsIpeP2PNu
         gLx7HDsp/xD60cLa2UYywMuUdfgrhGLhyVN3M3JwooVbl8i/G5/hwhg7RaEII+Ls7g
         8SvvBSn6Tx77PWlRm/XUXmFDR4z0UVzKZtzgCNKK+SYIIt7c3KLh8a6wAvV25TLOUj
         gYUzf58DlmXxE6UN/xiGKeT3w8N4NIICBzXmGHqqCT7d9XR8xL9cCDe7w5r0DFfgKA
         qmxCDUxMCQwvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3036E21EDF;
        Tue, 20 Sep 2022 17:35:09 +0000 (UTC)
Subject: Re: [GIT PULL] execve reverts for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202209191245.B40A17BA51@keescook>
References: <202209191245.B40A17BA51@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202209191245.B40A17BA51@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.0-rc7
X-PR-Tracked-Commit-Id: 33a2d6bc3480f9f8ac8c8def29854f98cc8bfee2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f489921dba468b3d208a5234dcbf7f21a615f395
Message-Id: <166369530998.7287.16656226590105129494.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Sep 2022 17:35:09 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Izbyshev <izbyshev@ispras.ru>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Sep 2022 12:51:46 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f489921dba468b3d208a5234dcbf7f21a615f395

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
