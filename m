Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F210611EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJ2APi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJ2APe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88093659D6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39CD062B30
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CFF9C433D6;
        Sat, 29 Oct 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667002527;
        bh=EeYQrSSYue092zsjVCa6RxdEJgvrjxuCmZLF12ktlxI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t2g+lelkNd1B+I0AB58Crnay+OQBxkfKSeAiRwDEPyWSjgmcNULvNzKBit6Y/Crng
         FLUoP8cs05jx/fZun8trqiPyhnxULY8R71M5/hnbwK3r4ZB/VbBTLtyiW44j4VdiJF
         8NiY8dto9FpMiQoZUA8YsYnBgTt6+kzj08BvjMZvGo+hnZgIfnFWUrR712zJod43o5
         1hnK4J2QJgG4iA6DxmssFo3gHPKbuPHeYYV8ZWRg9qkXYzjxrhxPXJbBLVXbOq59e5
         7/NlRC9Ut0DQ+RX8Zxfrw/WervYqJ6febdsCOQMSrROwPEgoKj6CiE0oQipifrhuy1
         5MOmMQqVzFdUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BD61C4314C;
        Sat, 29 Oct 2022 00:15:27 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d47a53b0-2125-467d-a9ff-c17fd41d646b@palmer-ri-x1c9a>
References: <mhng-d47a53b0-2125-467d-a9ff-c17fd41d646b@palmer-ri-x1c9a>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-d47a53b0-2125-467d-a9ff-c17fd41d646b@palmer-ri-x1c9a>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc3
X-PR-Tracked-Commit-Id: d14e99bf95510fa2d6affc371ad68161afc1dc8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 283f13d43bb4187bad3479f96ce7b4582ef4ed17
Message-Id: <166700252756.12440.12917889714759364259.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Oct 2022 00:15:27 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 11:41:32 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/283f13d43bb4187bad3479f96ce7b4582ef4ed17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
