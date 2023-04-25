Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9ED6EE7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjDYSzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjDYSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F2117A23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA6616312F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B597C433A4;
        Tue, 25 Apr 2023 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682448708;
        bh=lyYyIjNJEDrZgoB9u7v2ScBe0axz23V9nOh/RH1t6cs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BEjgPYTQ89zY//Fg8Ngag4uvhLAuPg5LBK4q/Ck8N1D9o7RQGLY5eZXGiAOAH5FzK
         cw0OLfk6h6QCkQivVnsLs4h2VZ5OAnJQuzPvMkHhKuc8bFg0YFWopBQcWcNoAkPjKo
         o/yJAjCU8Y+OvTFXDNLizkoOE0UUmh2mcjZk8YT5IzDv6yltZD5wSpXn+HcgX7p3ei
         u1vjMSyMhWf163UQ21N5LFmBb8R5yWFDjND2coQZop4xWzI3MNf+C935O3vmjFxCrx
         47QEtY0qrrJn++S74zwcwJypIDObDyMSqGggu3BOt+heUkKpK4fXOg4xBYq8jU7oxq
         +P2LGrFv3cVBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09CF4C395D8;
        Tue, 25 Apr 2023 18:51:48 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168235969244.840202.3708265453324842162.tglx@xen13>
References: <168235968801.840202.17752066425816055574.tglx@xen13> <168235969244.840202.3708265453324842162.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168235969244.840202.3708265453324842162.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-04-24
X-PR-Tracked-Commit-Id: f7abf14f0001a5a47539d9f60bbdca649e43536b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7989789c686e83f032acf2c4363c2c153876b96
Message-Id: <168244870803.5918.7707616702033013470.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:51:48 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 20:13:28 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7989789c686e83f032acf2c4363c2c153876b96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
