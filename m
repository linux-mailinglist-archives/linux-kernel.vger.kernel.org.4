Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402E066AC95
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjANQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjANQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:21:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CDA46A9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B87D460BE9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 16:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BD95C433D2;
        Sat, 14 Jan 2023 16:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673713265;
        bh=E535VACCB7zAtMzLDS81YdO7Jiihz4IIeOWXsayeKSc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s72j3dd/9pLd+zMKq+j0FvaRe0O/0GoPbYDDXKbJBIdZFXaU2LcgiNPxan4dOdgoK
         Zd9m4MgarIZD4IgdQJnwR/xtsy6wTkH7OPmhTaulVKyttKHTPxnSOcwCFOSEwPsvi4
         3JMWUofUuPOYcW89b4NiDcYYr8W4L1mAS7kOODv6zpYC8nr5bbItH6IsmPzdFuPUb4
         2w/aWVq4OSOHgzJcyZU3jzJ57sMnrT61nCJ1tw+UD0dVFL6/yhkxVnGKFRlBz42BTC
         7gRVMi7TFA6Y3aFT3Di4NGDVj+kt6LpZB4zCxdh4Ojju9wodpbLKsTlsICWy/+don+
         b+JnbDql+B0IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 079EEC395C8;
        Sat, 14 Jan 2023 16:21:05 +0000 (UTC)
Subject: Re: [GIT PULL] kernel hardening fixes for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202301131526.28719A40@keescook>
References: <202301131526.28719A40@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202301131526.28719A40@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc4
X-PR-Tracked-Commit-Id: 42633ed852deadc14d44660ad71e2f6640239120
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 880ca43e5c334c32a8af125e456d1a23314aa416
Message-Id: <167371326502.7515.9858057423851467431.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Jan 2023 16:21:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 15:27:05 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/880ca43e5c334c32a8af125e456d1a23314aa416

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
