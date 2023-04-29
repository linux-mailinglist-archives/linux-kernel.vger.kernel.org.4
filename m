Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6D6F25CE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjD2SUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjD2SUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E31F2107
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD3A61633
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 18:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D64CC433D2;
        Sat, 29 Apr 2023 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792421;
        bh=YjKzpXnG45wrQrTG05cdWkwH9uT6ls4HvXdkA8Dnhuc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lnP+Iq+dG8pMALHGJ5TVF6jBO0FFZuALLkwWmGSahWuR80MW0imsCBSHbtJKd6jWX
         Va5trkIDse3g8u9IRfzUB91j4NwMteE5LnnU9sp/EMyMWfSCuhtHB7h6zNq71gm/vy
         Ypoqx24CwDm6Ah1e0VhehW5F2lXFwDdzua0oxFj2rJ5AP/fxhNogHNqjUU0+uVvFWn
         tT5YDGopwNq8ScirkM9mz82zDlc8t/2k4NgGP3EBM5yUuCJzXGntWGjHtfNLzENmwu
         YaKv5rLE1L9u3GJOULOVNxF9rJ9gYu1vlfjTDBKfZ0PJVU0GL2XUSDWvSKcoxTvDfA
         YzRCesobGk4jQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3523E5FFC8;
        Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168268425233.1877133.18332460532605313393.tglx@xen13.lab.linutronix.de>
References: <168268425233.1877133.18332460532605313393.tglx@xen13.lab.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168268425233.1877133.18332460532605313393.tglx@xen13.lab.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-04-28
X-PR-Tracked-Commit-Id: 158009f1b4a33bc0f354b994eea361362bd83226
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d8d20191c8557584269b6ba8eae5409564dc84b
Message-Id: <168279242099.22076.8358812623609544256.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:20:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 14:19:15 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d8d20191c8557584269b6ba8eae5409564dc84b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
