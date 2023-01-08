Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044AF6615BA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjAHOLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjAHOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:11:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E246DFAB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:11:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0CF360C70
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32022C433D2;
        Sun,  8 Jan 2023 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673187072;
        bh=wWoyI8cGkdSrSyjkE2bFbFrETQ6VJ7n9DreCOGIemVI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HwAywhrnYuHaeFBZBrhy6kAbPc+lUgGbHadhWtqsgM/oI34ESXtmEt7ZhoM1na3ef
         okpfopC7l5QVtPG0hiiNP8Y5RcS8tS2/nAeFjwmYijY0v4Ym1uxcQOeKCO9gmVJOFL
         vNeGuclR8RUZFZhAikdBzjp+HKoziQAJwWvMqgxtrcQU22ObHtL97diO6OfQFLZCoH
         p0HLs0CvTIiI3NlGSdwJuPdZ+iSNab5nLEhCkrQy9bzFZ64LrRAjkRk6BKu+tgSe9E
         wdcoSUJ4MyZNHiIzRJsAg0rlhhb3wGYYzAgv8BS4CmTeVDf3q18xiAT15LNWu7mm/l
         jPqS0mzuSVr9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FD53E5724A;
        Sun,  8 Jan 2023 14:11:12 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87tu11gped.fsf@mpe.ellerman.id.au>
References: <87tu11gped.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87tu11gped.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-2
X-PR-Tracked-Commit-Id: be5f95c8779e19779dd81927c8574fec5aaba36c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93928d485d9df12be724cbdf1caa7d197b65001e
Message-Id: <167318707211.25303.15442437836280597984.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Jan 2023 14:11:12 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Jan 2023 23:51:54 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93928d485d9df12be724cbdf1caa7d197b65001e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
