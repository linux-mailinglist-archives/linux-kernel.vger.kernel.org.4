Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED07D6315BD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKTSxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 13:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiKTSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 13:52:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACCA1AF03
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 10:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64D6CB8092C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 185E4C433D6;
        Sun, 20 Nov 2022 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668970373;
        bh=tAsLytNsT00q5ZXNeBQ0dNLC/3Qs57UI8PbPdBxWzHM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PXoiJ0lFTiZgOqN75Oc7/LQrxdoXd734QjlqqOYQ6su5j3lLZbt5qX6zstZe5DtaZ
         sR6rImg/Zhvk6DMvnja3eia9tGaLZHDhq+PAV9TaxoLURZeIFaiybO8ij6YBME+exI
         2maJmCztzYWLcsdwpxcmeOgwtC3h4O4Al1Mu96Jf7qrYYwvx8SiquN5K60LWnmmE3M
         k8pwMI9w7lkn45vgcPXvmt675MQeVzEY3ohQ66urBUDVy82vZNuPczY28QQFH8IUPT
         QyYr2STD0oJxJHjcfmxjhNBJXWW8dHjPMtc5ALc+0Ku8nSmaubXLnGpLadgzC0vvDb
         wS9ESvrd8S1Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06BBAE270C7;
        Sun, 20 Nov 2022 18:52:53 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87tu2ucsth.fsf@mpe.ellerman.id.au>
References: <87tu2ucsth.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87tu2ucsth.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-5
X-PR-Tracked-Commit-Id: eb761a1760bf30cf64e98ee8d914866e62ec9e8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 712fb83dc3f688458ae91bb0a5c706b239ab4684
Message-Id: <166897037301.26274.3099075135802910898.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Nov 2022 18:52:53 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Nov 2022 12:34:18 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/712fb83dc3f688458ae91bb0a5c706b239ab4684

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
