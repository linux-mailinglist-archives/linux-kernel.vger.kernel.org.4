Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5074DC32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjGJRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGJRUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6CB135;
        Mon, 10 Jul 2023 10:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0256C61141;
        Mon, 10 Jul 2023 17:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6440AC433C8;
        Mon, 10 Jul 2023 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689009637;
        bh=L2pGXrDr/cI1ZJ1jeRvI/Ht0S1PqmM2+vVbj7x81Dig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QVT4hBzLzycErcewb93WQZUenRzXs53jfaLeMQ9j2fFS/gUq7XLyiE8w/wax79/s2
         DmwG0194GgakK0KORVj8p7Sbi/sJGz7jOJEbUbtroa6pe/wX+KMPOs8FFzJ7YRvuBG
         XnEcFHbWKZi8PSv1OE8YgAN/S9Bt7+KgHaUcKoJGBiW7JrcwYYVxoRFOYr0vFHK/SS
         6DGYzfNx3LJoN/x6MWYKGQMkYBuCswlebLKzass2R+amNt4NWRi1NLGTX9cBHCvUcy
         gd5CpndIve7qEvLgebOd6gWlNuyLgSS9M37zCLcKVf/LnDSnIRV1ASmYVvLSBDS+n0
         FDmEoekGuS/lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 506A8E5380A;
        Mon, 10 Jul 2023 17:20:37 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.5 release cycle (v6.5-rc2).
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230710115653.GA23810@www.linux-watchdog.org>
References: <20230710115653.GA23810@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230710115653.GA23810@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.5-rc2
X-PR-Tracked-Commit-Id: 2500df55a615f2f177bacf1a261f927790a137db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
Message-Id: <168900963732.24521.3544872459115394948.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jul 2023 17:20:37 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Keguang Zhang <keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jul 2023 13:56:53 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
