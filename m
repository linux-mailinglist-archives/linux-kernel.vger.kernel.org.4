Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26235F1024
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiI3Qi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiI3QiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:38:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C701739D6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49DB9B82983
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12F94C433C1;
        Fri, 30 Sep 2022 16:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664555897;
        bh=8ieri8/I+T1xgWdJwomim/+lE0kO8LX+g6G/04fO3uc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S6Q749W/AwPZafqRjBwa1rO/SYPQvEc0EAySsKp9l7bCgT58wwUmVzKqzAw7ws6+m
         UPwmvY+dC3F3+lpqI27S/5Tsej06NUNT3Yqqa5kvdAQiurn8NBPZAcQCqPqmj+U863
         qtoMdTVh6Hk1e4E3RSAjurLUTjXuAoBUM14NkIvaSvsq+FDL8ZL9eQnCnE/ZfDIV+U
         nxlbsuyKmdhGgAJ5ntyeIi4ZwuuZnVAPHXiE/xO39Gbyi3BYgoJgIhWnGTu4L/y6t3
         4Y11Rxbzu0wlDx7Ewx4WCOB5pBzZJq/TVO4mjD6RRZU1i/jr7Unf2XNU9+BRcU9ARM
         K1H04jZRhGdzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEF62E49FA0;
        Fri, 30 Sep 2022 16:38:16 +0000 (UTC)
Subject: Re: [GIT PULL] pstore revert for v6.0-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202209300827.3E1707A@keescook>
References: <202209300827.3E1707A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202209300827.3E1707A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.0-rc8
X-PR-Tracked-Commit-Id: 40158dbf7eb2b13d8851fe0b875b4c3170ea15db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d649d2c49baa4336bf65a02fc8e9d42c8ef2db6b
Message-Id: <166455589697.13600.5700209483527530172.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Sep 2022 16:38:16 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Sep 2022 08:31:10 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d649d2c49baa4336bf65a02fc8e9d42c8ef2db6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
