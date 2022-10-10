Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7B5FA486
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJJUFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJJUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:05:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA3A481DA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58121B810B5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 172DAC43470;
        Mon, 10 Oct 2022 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665432313;
        bh=cyTD1Y42r7dV7F2IBJN53bVlnJCVpmpvoXrssNpKgLc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vs5FpPS4CIEkp5bTR8vgvS+A5QToPkii4C6WqCZqXDd/ypvMCqSKN3Yw57Auc7EN3
         +/geRtmVKLKLpLMNz99NSjsFb3aIzVQFcjm/QlhiLQeVJy4nfLAqYgiEllUh055JHa
         PnfOXtSO0bFps1J7q6Zd4fpleZtfLR/sVt1xMKgDwGn+vdQQHai7J3F4EhCYTUyE97
         hxjTHKgxq/jUOwug6D7WXFdhmwDpZNYOW0yrw5XcwvjficuegSheZeRsVC+hLN+4zu
         3mD1o4AhP0Uki/YLXlJQzmI1odMVDYwNhV8AAZSL9t90lNt+2C8Cq6Y0S/Ils+KdNt
         9kQGPsH+vVmxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06339E2A05F;
        Mon, 10 Oct 2022 20:05:13 +0000 (UTC)
Subject: Re: [GIT PULL] bitmap changes for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzpC+uJlYq1nbcIw@yury-laptop>
References: <YzpC+uJlYq1nbcIw@yury-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzpC+uJlYq1nbcIw@yury-laptop>
X-PR-Tracked-Remote: https://github.com/norov/linux.git tags/bitmap-6.1-rc1
X-PR-Tracked-Commit-Id: 78e5a3399421ad79fc024e6d78e2deb7809d26af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90d482908eedd56f01a707325aa541cf9c40f936
Message-Id: <166543231302.6988.14666777932366448622.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:05:13 +0000
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Oct 2022 19:03:38 -0700:

> https://github.com/norov/linux.git tags/bitmap-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90d482908eedd56f01a707325aa541cf9c40f936

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
