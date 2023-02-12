Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14E16939A8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 20:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBLTeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 14:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBLTeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 14:34:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51982E3B8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A53D8B80D3A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 19:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E529C433EF;
        Sun, 12 Feb 2023 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676230480;
        bh=6upH9Afxd3IDmQbTJCQKaNCdDBY45kiucMk5NPnn62o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JiaNS7aY5T1AatzZDyf1qcj6zyPTk5i3YmhOQRB5RRB1nbcD2Ogv4ISPAMqZRpZJW
         G4JLTtF51yEegtq4qMFJcASPT8ZRX7tS/tngKfkXMfXyyYhOCvj94SA2HJ6ksyHU08
         b4U8wXLFLhjVWwyWUk+hPf9BdaquGumysDDip4QEBZVGszpS4Rm2CEBQgMnQyCBJTR
         vOU4iXR395gKh+koqBPK0fj08ATQqpHD+9s7vh8OtFVEoG2KYHt4IwwOXYMYAe8TyI
         htV9M2wnPm1zAaQ1I0yq0dqTkhjv7gLpcPQ1PBTMNMDQfUcoQl1BKo+3TZcO5r9kkF
         9D1Q/ZDCewy8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38AF1E21EC5;
        Sun, 12 Feb 2023 19:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874jrrwehv.fsf@mpe.ellerman.id.au>
References: <874jrrwehv.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <874jrrwehv.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-5
X-PR-Tracked-Commit-Id: 2ea31e2e62bbc4d11c411eeb36f1b02841dbcab1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49a0bdb0a38e222d35c50644468856e2408764f0
Message-Id: <167623048022.930.14072875760407623153.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Feb 2023 19:34:40 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rdunlap@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, npiggin@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Feb 2023 18:05:00 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49a0bdb0a38e222d35c50644468856e2408764f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
