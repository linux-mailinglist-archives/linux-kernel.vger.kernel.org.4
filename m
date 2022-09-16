Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F925BAF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiIPOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiIPOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16EDB285A;
        Fri, 16 Sep 2022 07:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3585662C30;
        Fri, 16 Sep 2022 14:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DA7CC433C1;
        Fri, 16 Sep 2022 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663338100;
        bh=XAlIhYJZvtaBoIUoX2/3B9G0FFuTqN2qmEawgWB6KD8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SVcmHtAIcALNUNGC7zH2xuSqLS8e2xkudChIeP4uyBEmve5jzMhXtJgDszBhBaIT/
         Q1MZvriMqXboGBANgn3/c4jptaI5mA1WrkZ3D3xcJ+dQDvIc1Ib7EwPIQyBr29mFSQ
         Oo5HkNOdeXHARVNNAehVIXjnglTsrApGxxTXac0K2BQiCxuqSVzobNqpuY4plo4SNJ
         5517SHpG+gmNheXpSYxcssA7a/g2rYm7comHFGGfneJcfwbFKtfsmCcRvK8QSR/xiI
         UTJzevQcZYrmJpUPHWKw5pCh/5jbrhtcwb0ZfoAOY8H+QQOKgnXaObrnWaOe1W6SIk
         13KY1CijnK8kQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CB8BC73FE5;
        Fri, 16 Sep 2022 14:21:40 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for the v6.0 series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZZU51xqQgQA3tDC6ccaZ2WbDc_CPk79c3DgXPS6Wsivw@mail.gmail.com>
References: <CACRpkdZZU51xqQgQA3tDC6ccaZ2WbDc_CPk79c3DgXPS6Wsivw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZZU51xqQgQA3tDC6ccaZ2WbDc_CPk79c3DgXPS6Wsivw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.0-2
X-PR-Tracked-Commit-Id: c297561bc98ad0f2a37ce0178ee3ba89ab586d70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6879c2d3b96039ff1668b4328a4d0dd3ea952cff
Message-Id: <166333810057.10979.882761978977305774.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Sep 2022 14:21:40 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Sep 2022 14:15:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6879c2d3b96039ff1668b4328a4d0dd3ea952cff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
