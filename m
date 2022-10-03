Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40CF5F3496
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJCRdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJCRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:32:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3FB3B719
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2BB7B811D2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94055C43142;
        Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664818324;
        bh=wF/ZXwn+w8nhlJRPzrVEBPrBPfzeeXzxJDvoeNX2CgI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lFjFxjZC0hV2Ag5nsDbAkAC1RD/4F3Ja+mmU0yX6cjrjPjLCFluMLdWoSx1FoPAF6
         Pl72TLuR7hdQyqe1/CNgyoLLWyuEGsCsAZu6WH5N9KEzJCBGoW/fS66mnKz6mB9h2+
         Lu1r1ZNhC2BSa1G9y7LbcAVUHf4ly9muPOLsP/zspSfTmg60qRJLvE8cbPX8oNJlRK
         WLSKAZ7pfXDSVKDNq3U9uiV83qmFLvS/f67al+YzrWwWZgUqP9vJ8sRdB6DjFHmESd
         pkM4UoTwB99PX/04fojBEs9jxJ00kahrDd4FPElqvWM4Lzm+pqVx0Mw2pLLS7DYkLo
         haBb9+2cc+SwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81AE9E49FA3;
        Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003104529.2437138-1-geert@linux-m68k.org>
References: <20221003104529.2437138-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003104529.2437138-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.1-tag1
X-PR-Tracked-Commit-Id: dc63a086daee92c63e392e4e7cd7ed61f3693026
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75003fa726e990883bba5b38c4c4d873dab45d62
Message-Id: <166481832452.20277.6973751682427455307.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Oct 2022 17:32:04 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  3 Oct 2022 12:45:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.1-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75003fa726e990883bba5b38c4c4d873dab45d62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
