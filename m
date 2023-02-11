Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F058669334E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBKTYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBKTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:24:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF68193D0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD22660B63
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 19:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 272E2C433EF;
        Sat, 11 Feb 2023 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676143477;
        bh=OgSbgxdHxBCbAQ4gDnV5jgyyzQ9QJprgoFQesc5DYCk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ssDHHY2bdTmJm27ukJRUfS/djrgeyxL/8rf7oAMMPcPPhsPAjev2gcfcoy+yGyYmx
         29ssz/8SPvc4W3OjOMYNBYT6YNDSjz7s9DrKaUJYYAIVkxyuMg6E8c2jYiakaH5rQD
         k8AmxC49qpnsY47qVr4z/1GDAdYHtghwE/CBl1rM6QdrZl98s56nmVdmQhEHEhNy6G
         pKNMWwhIC9X1I74CQbIUrVsW7Th2EiZIT9As4ACuuS0YQDMX6IZTm6UbC9uUrbadA5
         uAQNF8bzalQUnale9A7KYC07c6kuD7jTtrM60tR24Xk2yhWIr3by9W9lzz+tbvxit/
         yGZz0IZHVI1KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 120B8E21EC8;
        Sat, 11 Feb 2023 19:24:37 +0000 (UTC)
Subject: Re: [GIT PULL] locking fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+dXxGNISTLdmh/U@gmail.com>
References: <Y+dXxGNISTLdmh/U@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y+dXxGNISTLdmh/U@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-02-11
X-PR-Tracked-Commit-Id: db370a8b9f67ae5f17e3d5482493294467784504
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 338c84730406c30185d54b565d670e7e7c96967b
Message-Id: <167614347705.24193.12814257598103521635.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Feb 2023 19:24:37 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Feb 2023 09:54:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-02-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/338c84730406c30185d54b565d670e7e7c96967b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
