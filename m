Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7755362C846
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiKPSxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiKPSxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:53:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D2D663C8;
        Wed, 16 Nov 2022 10:51:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8525CB81E53;
        Wed, 16 Nov 2022 18:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3134CC433D6;
        Wed, 16 Nov 2022 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668624691;
        bh=2bAn3ICKvFEr05hk1VXUJAMzFvgGAU329b5exTzLDzo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q68PxS8yzBS70xhe0UIbDlhVRfsChJ8qfP2wEmYmq4Hh8y/lnLwM2aRFKMSgKwqfI
         Gx6xKxsUtWguvBaYGxeF7nwwB4EYwg3bb9V/W1kUwZ5rG3PG6K1vkwBJudLWQnCrjq
         0IgZBa/J46ltC2x3gh7IYH+GPtMP+7XhSLUT+2cY4p1qvIzk/Y0FH1y2lL+o2bY7YD
         HoYIlXrCkJ7IiQHE49VeNcQ0SF8IzVKyOHc1DmSSKr8tAwqQgfQyU9/TKtLsLT6GpL
         GaVnL+KK9LceKgTnRa9YMOfb1WMlgXgeSAPOZlT/32dM9Fvc1vB99t0l32YHI604+o
         W4SyxMjgijn5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D1B6E270D5;
        Wed, 16 Nov 2022 18:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdaJy5hhrMfdZWtpoBUxBEc1QnxaX4pRzQVUBoEoKqrwzA@mail.gmail.com>
References: <CACRpkdaJy5hhrMfdZWtpoBUxBEc1QnxaX4pRzQVUBoEoKqrwzA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdaJy5hhrMfdZWtpoBUxBEc1QnxaX4pRzQVUBoEoKqrwzA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-4
X-PR-Tracked-Commit-Id: 2e35b25dd8e666b8619355fc3defb1b246a5dc02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31c9c4c54ea9902af4b01545d3a10acd3cf815a9
Message-Id: <166862469110.19828.6012610062866457339.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Nov 2022 18:51:31 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Nov 2022 15:57:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31c9c4c54ea9902af4b01545d3a10acd3cf815a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
