Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB2607326
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiJUJAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJUJAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:00:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8CD356C9;
        Fri, 21 Oct 2022 02:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A211B82B6F;
        Fri, 21 Oct 2022 09:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAC23C43470;
        Fri, 21 Oct 2022 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666342811;
        bh=HK5VUIChYWOulCOh1Ui31mU7JvliKLDNu9EHGlrImYY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qWwvuBpTVtQf0vstmxHP+4LZ5mQdk3qFuB4ZTLrBxiAhTnV4d5MOOuYOJf1OPudZg
         6bPXRcq3+quXBCiPUufdktkhHODP1bKAp0FDMOP8BpAum6VyUo0Bpnz587766znfmw
         M5esSoPn4YO0JO+McWEN5hxzercSN8wPZFcOwW401dCpTzf2rXGTr0dPcCpsklvkdV
         a7pXUELoS3mzGVJbpXKoexNa96R8YuXhASRPu9uAN4vW00/UMcc5SqBq1kFxOW5UqF
         Pb+R0vULbua5ckCW/80CHDZe3F9yarxYM5KOYz6sEypAOOHBC1aU6SUV3T0ceckVQy
         ldA+0OMJizhbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC67DE270DF;
        Fri, 21 Oct 2022 09:00:10 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for the v6.1 series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbqRy5pXiy2r5CBiBXd8j7VbXKq40pmx_eXtFMynyAMug@mail.gmail.com>
References: <CACRpkdbqRy5pXiy2r5CBiBXd8j7VbXKq40pmx_eXtFMynyAMug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbqRy5pXiy2r5CBiBXd8j7VbXKq40pmx_eXtFMynyAMug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-2
X-PR-Tracked-Commit-Id: 9abf2313adc1ca1b6180c508c25f22f9395cc780
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 664609e49f1c84fc97987b2bf64544e586b8849c
Message-Id: <166634281076.24263.407964543442837334.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 09:00:10 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 10:55:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/664609e49f1c84fc97987b2bf64544e586b8849c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
