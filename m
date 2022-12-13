Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A433564BEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbiLMV4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiLMVzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE6240AA;
        Tue, 13 Dec 2022 13:53:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6CCB6173C;
        Tue, 13 Dec 2022 21:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5958CC433D2;
        Tue, 13 Dec 2022 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968430;
        bh=3EZpdAcrpEONbKnYiqKd0M11qNZHnvz65bQfZk1OmGk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Estgi/n4XP8788EwUivaB+uc7kJbLQCOxuDt658zAaMqgWwmdnYQbkkXO77NTdjlU
         YM41Zk1XhGDDL2hJPXfbJXv9ZLa5Ljwke6N8L5A8k45uey5fy5jk9b3b8Cxk6cJ6gX
         X6Q2lwEScFXA/YZBMx8RUBGAMM6sFkDf9dB9pqWTSBjYrdDcoXOZhkvy1IvgYXObjO
         pOeVztimI5TlS4aMisIvHXJvVXKitHgYfzYAlEG9k4WJvVNHfyDad80Du9vM9HojNJ
         cYGXfwfpEwM3ARXH1PJmXdVn2J6xxQPjIe8nskzvk48DVNX/6Rjdj8f3f1WyuNxkwp
         H7LOZQjpxAdqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 483C2C41612;
        Tue, 13 Dec 2022 21:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] pin control bulk changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYZDXH=_Mgv0u+B8btLjFcCSTboWFXH4u1h9V=WqLEJQA@mail.gmail.com>
References: <CACRpkdYZDXH=_Mgv0u+B8btLjFcCSTboWFXH4u1h9V=WqLEJQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYZDXH=_Mgv0u+B8btLjFcCSTboWFXH4u1h9V=WqLEJQA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.2-1
X-PR-Tracked-Commit-Id: 83e1bcaf8cef26edaaf2a6098ef760f563683483
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 361c89a0da59c04b1d3d33568965fe426b0f18de
Message-Id: <167096843029.13204.5110849272287950115.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:53:50 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 14:16:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/361c89a0da59c04b1d3d33568965fe426b0f18de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
