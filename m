Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6E68AE10
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 03:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBECpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 21:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjBECpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 21:45:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B325971
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 18:45:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F21A260AB3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 02:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62B1BC433EF;
        Sun,  5 Feb 2023 02:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675565109;
        bh=DhIbnJEYBJ9wICpJSXHDUB/XzKE2Qwka1sBouhxW6Ec=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PKEMF13qA2dgrqhwnRYeDaJ8YwsY84UO+7Axz71iO7c3LQAo2+ryUKlTbBI+veGQ+
         LJZC22uUmT9tvr2WAPT+mvd0eIy0Zf9vouff1hiMsqS0O2VpJ4xqZ320zvmB6JGVwu
         ZveHw0LNdvixrMZ29ADuKugJVInWDWgSEGP7bTbJGPQgS0q/UdPCVuoQT+s3J4IoUN
         6fAtOWrkpY0quAWbPDj0ejSaX57WfgrRYYygiREYJU05UF/bh0y5qJhWKMhEkgn2AW
         Bcuc/waTZe0Wq3yhQKLa7iVEJ404jDzAlfLN3ioyyjmHwDTZfX92MPe0qLeBvA0D8m
         0Tz4rKb3Td/gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DB90E270C5;
        Sun,  5 Feb 2023 02:45:09 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y1pcewhq.fsf@mpe.ellerman.id.au>
References: <87y1pcewhq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y1pcewhq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-4
X-PR-Tracked-Commit-Id: 1665c027afb225882a5a0b014c45e84290b826c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 837c07cf68fec9cad455d5fc86aab5350cc06c53
Message-Id: <167556510929.8399.6294213822451226997.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Feb 2023 02:45:09 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, sourabhjain@linux.ibm.com, sv@linux.ibm.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Feb 2023 12:23:13 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/837c07cf68fec9cad455d5fc86aab5350cc06c53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
