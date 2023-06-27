Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6473EF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjF0ARZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjF0ARW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C42106
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DFB60FA4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3965EC433C8;
        Tue, 27 Jun 2023 00:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687825040;
        bh=odJZG0Qo/kdmfnVP7eOy6+AJISu+sl21vzsiNiEIPn8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uvz3QoV4vaAHHvFEdjbflVsOVNN1oceKUnQLLnSOFTqM3MNlBTxHap8Mt3K7bipcI
         hc4hcqjJuoYs0hOXmjve4ylsncS7prVGPmHAVDSeZllxQPt0T55Do6y0m0B4QS47pc
         Cl86heMWGJA6u4aik/jxVnKJy1tfubz5c70na4yUoxoyMBdR3N3lB8sSbszVmzLJ+P
         Na4Js1UOL9z+0wavUl/BFbaN59bioARg2AoOktv+IqAHbYl6fSRIlWfs9y/y12MsFg
         XYMl1nSvgrZEfXgE/sLSFgMPThQJR7xWys93FLq9o6s6viyAjyQM7tXSCnlYRCldk/
         b1Y3kUi5aEONg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2845FC43170;
        Tue, 27 Jun 2023 00:17:20 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626101648.3052015-1-geert@linux-m68k.org>
References: <20230626101648.3052015-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626101648.3052015-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.5-tag1
X-PR-Tracked-Commit-Id: 4055eabe04a26f5d113b5a02588b20b5e166a753
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f810c182366acd2eb7eb5efb3c06b1fc9f719835
Message-Id: <168782504015.22532.4244069438493180765.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 00:17:20 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 12:16:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.5-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f810c182366acd2eb7eb5efb3c06b1fc9f719835

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
