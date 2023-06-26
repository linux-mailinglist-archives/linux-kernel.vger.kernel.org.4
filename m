Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76A73EEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjFZWyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjFZWyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4954EE5F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD1AC60F79
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29CA8C433B9;
        Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687820050;
        bh=1WyMCAyBimsx8ejSeVyDHbZnXxNQlFcf6vHptsG8hUI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sxldCYLlDJWh5NDyTI+3L6q9ZUFUCBcw55ZMQDodfsjXgfZfQ/A/KUqdFUU2WMGlC
         SbQiHpIR8tg0cLfSIoMTZMo63X6oiGxVviNV5/xobpdPOCjK4sD3MYLAyr+YjrYcXK
         5wIrIF7s0y5KKAK/Pu6a6MmNqrCE/x9qi8FzouLHOwUWFeI1TxsC7qbrCUSDrZZbyf
         YDYK6Kzc71gwMuSPhbBKJw9l86K3Z2HWWyGObyZ+tLboDmdhREv2ITNCpVWGZeT6x9
         +hJyfwzqPwRGtLKt3I3J26rZbUyDsZ0ZE+3/4O5rw6IstNsECMOb9Zm6MXdbL5MyOx
         0bVzUAK5jld2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18CD8E537FE;
        Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626174107.GIZJnNs+znIs2NuiTm@fat_crate.local>
References: <20230626174107.GIZJnNs+znIs2NuiTm@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626174107.GIZJnNs+znIs2NuiTm@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.5
X-PR-Tracked-Commit-Id: e0a6ede2dd884adb73a7dde80444185b655f7c79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e5822e0f99e429fa8b03c956dad890179b5b3b1
Message-Id: <168782005009.10634.4826497575886761894.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:54:10 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 19:41:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e5822e0f99e429fa8b03c956dad890179b5b3b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
