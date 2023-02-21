Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335569E845
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBUTaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjBUT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:29:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B310A2B618;
        Tue, 21 Feb 2023 11:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C663B810A9;
        Tue, 21 Feb 2023 19:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 165D7C433EF;
        Tue, 21 Feb 2023 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677007789;
        bh=IT9EKID+Ph3Gf3/paKBi2ouHoR8pyX2t3S8zj16/NJI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QDBfj75udVhL4U0fNWCxxWCCVqjDgIeyl1oDhqnDFxP2/MhIXUp0ozGWxJeHtIVe7
         WIO0XmvoaGebxbrMfoC8nRADGBcLbXPe5hWMNv9QXwzUko3Jw7uFRkaMEeJ0FzoUeq
         MW7884fX/Lgk1O/8gQ58+JaGlQjk1v5dO7zsGglCE/KteYOy7CZv+iGehrEl/89WXg
         wsYR6kCJ6gaLmYnA1PG6FV7HipuaG3RUF04Pa2YNuwvPLs7efzf5TY2HeN8AkBN5SQ
         rtxzzVPZYGzDnJzha6wUj1NXblnYBoVP2blKU2FVWeWEyHWVXAEsmYIdN9AQgLGJNS
         QvvBUFBBldsGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0572AC43158;
        Tue, 21 Feb 2023 19:29:49 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <63efd7ab.170a0220.3442b.6609@mx.google.com>
References: <63efd7ab.170a0220.3442b.6609@mx.google.com>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <63efd7ab.170a0220.3442b.6609@mx.google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.3-rc1
X-PR-Tracked-Commit-Id: 78f7a3fd6dc66cb788c21d7705977ed13c879351
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a7d37e824f57dbace61abf62f53843800bd245c
Message-Id: <167700778901.6594.12988996476611010913.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 19:29:49 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Sam James <sam@gentoo.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 11:38:18 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a7d37e824f57dbace61abf62f53843800bd245c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
