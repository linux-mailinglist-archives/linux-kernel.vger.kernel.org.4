Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B173692B77
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBJXjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBJXjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:39:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95438A253;
        Fri, 10 Feb 2023 15:39:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C46BA61EDA;
        Fri, 10 Feb 2023 23:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35868C433D2;
        Fri, 10 Feb 2023 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676072328;
        bh=tWF3stMTI3D2fjeGMM2sCw7H6XS4vtyDCXpcCtpVuXQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oqlaz3HROov+GzG8Y2iaJs1u77pmLnvP925eDVkyhD5SonjcqS8+/718Ez8Ta9HUo
         2ufrLSLulkeQ2/Y8QRRpE9Cvu14NtePY7nrv28ZSQokp9Svm8BjCu/2/9BitAx0ryc
         ig/3NJje7daKbRgSysQZ5CK7kiPktb1hiMiYQHu0QGgITXXzsZnYDZRSTY/lff3a0g
         jU/ElLetxIoYWZwdks8EAanPfVjrQykxzvCOPPpMZ5PyvqJdzrQO9XHfjOGXMcofCp
         bni8VCG/KPJTqGqV3WP4tJ/whUmguQz3XXepStPBPaaIJSsEA1QrRL6zvFPZqYGJqo
         ktQMMT7R6ZSqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22738E55F00;
        Fri, 10 Feb 2023 23:38:48 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for the v6.2 series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdax4qmftH974q+269YD65oMfLNFe-FrRSLyAZ_HY1OF0Q@mail.gmail.com>
References: <CACRpkdax4qmftH974q+269YD65oMfLNFe-FrRSLyAZ_HY1OF0Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdax4qmftH974q+269YD65oMfLNFe-FrRSLyAZ_HY1OF0Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.2-3
X-PR-Tracked-Commit-Id: a8520be3ffef3d25b53bf171a7ebe17ee0154175
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 545c80ab3428df0d693f6b99b57f3c6ada34494d
Message-Id: <167607232812.6240.942893665514908197.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Feb 2023 23:38:48 +0000
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

The pull request you sent on Fri, 10 Feb 2023 23:41:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/545c80ab3428df0d693f6b99b57f3c6ada34494d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
