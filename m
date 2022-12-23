Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B865541E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiLWUIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiLWUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:08:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AF418375
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 12:08:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BCF96CE1D32
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 20:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0864FC433F0;
        Fri, 23 Dec 2022 20:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671826114;
        bh=e9ifg5+c1hF+RTP7YrC2ftJVb6Ej3/BOQkP7w4Y0aeY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cfG++YMWEW3Z/7jMug/hIId0r9vu1yBCiUq5trKyBS3ysmtfywqOOUMq3p+431vND
         4ppbT+KVC3ECJ0DyUuXInNkvnbvbRlmRT6nLJpabgv7vj5pneybm21eXmxJUyQoBeE
         AaEQCg5rnQhR3Ne0wCoVX+Hc7qQ4V8Tg4im6kK2txiJ2bBX/IZnZIRkb4CU95rdLgz
         uMktvs3c0dNVu2CHJtkNGdzGjSSEeHRAvhpk7L/xp47hgPjUKGfy3GQrJWZ6twckJU
         ygD3uK/WNQGfe0tD+QaEa9NdTX8Hax0T7PWW/S0M57Jd8bzmDWqajRqB1DquCmPfIF
         EpKFA1oBnXeVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8855C43159;
        Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v6.2-rc1-fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202212231038.955181AC@keescook>
References: <202212231038.955181AC@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202212231038.955181AC@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.2-rc1-fixes
X-PR-Tracked-Commit-Id: beca3e311a49cd3c55a056096531737d7afa4361
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edb23125fd4a79003012bc619d2c604da922865e
Message-Id: <167182611394.4135.7004156770187724616.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 20:08:33 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Connor O'Brien <connoro@google.com>,
        John Stultz <jstultz@google.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        kernel test robot <lkp@intel.com>,
        Luca Stefani <luca@osomprivacy.com>,
        Midas Chien <midaschieh@google.com>,
        Tony Luck <tony.luck@intel.com>, Wei Wang <wvw@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Dec 2022 10:38:15 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.2-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edb23125fd4a79003012bc619d2c604da922865e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
