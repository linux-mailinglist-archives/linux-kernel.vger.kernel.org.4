Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC674669F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGDAeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGDAeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9C1134;
        Mon,  3 Jul 2023 17:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1743161086;
        Tue,  4 Jul 2023 00:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8048EC433C7;
        Tue,  4 Jul 2023 00:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688430848;
        bh=i4iZoZrJPpBvbufVavPmxP4C6vkvFMM3YtLbM1mznso=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sHvxokQqlW6HO1LWXfHk/P4/eInUvhHJvUqRN5AyDRO1471ow9nlSIvwSANQ+dxcB
         cPJn47p5G1oQImOvz9pqtw9TOhuy4i6LVkk7py0fZlgz/z79mO1vuogtXrHnFuuchw
         Vae8anuDniHuW2rEZYJfazwyWj5y1UiqxDObC7u+2gzDllRUXK4GxpzHdeiXtwvqzA
         HP0vCTp/qQ2pKm1DjwTZI1kMNlQnvy5OZO971PY0suh/h13BwihFiRE/Srzz+cUIjR
         Nenn5akusU0+KhHdjkrGnabteoyKXhROIoxysvHj/bN+p+x1tmuwS8fskDquv+zm4h
         hOmzZPchZWMmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67030C04E32;
        Tue,  4 Jul 2023 00:34:08 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230703224717.r74bjlyx5ikbk4bh@mercury.elektranox.org>
References: <20230703224717.r74bjlyx5ikbk4bh@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703224717.r74bjlyx5ikbk4bh@mercury.elektranox.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.5
X-PR-Tracked-Commit-Id: ef8d95b4a3af4ebfe47e3563c3bc5767dda28207
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0df241385b69616f5d7d41824348528b189ffd01
Message-Id: <168843084841.6205.6642824579453578413.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 00:34:08 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Jul 2023 00:47:17 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0df241385b69616f5d7d41824348528b189ffd01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
