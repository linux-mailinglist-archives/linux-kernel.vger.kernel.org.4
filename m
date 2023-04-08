Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D506DBCC7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDHTbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjDHTbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:31:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F346CC140
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 12:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A863616B6
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 19:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09E97C433D2;
        Sat,  8 Apr 2023 19:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680982271;
        bh=lP7RpDgIKv4MkiM3+gY2OXdlcH3nhmbQyqtNCqGYcV8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=InWyDhWY0MnZ02MqL6M3peGaksWWwHXYK02+4EYbST8Nr9xjAA+qN7NiYRrA/DUTt
         aWVD7RPNVS4wgNQ+P3eBNUirhiqKiL9EBZRrCVSwxA7egCzItzQp+OXMaLuHIVjozo
         uiWgh8UPZaVqFhZsC+sW1q638UNsYrdQcEDHJIjhOUoz5M8EnsU5+P4LWq2piIDTdm
         nwSRz3sAI3QIMv2mGrh+OHEfFe3Z1vp1tYm9zGSpYdCj/WCBy7JV+KJGKH+v/avgkS
         PBaU4KjcQ/GLlCAs+oCBvvneIxkLS/51QbHrmIOgEeb9/xM5r+3CE2ZQ4Mkd8+FNNU
         i39QQs7xz6hlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E97A8E4D02F;
        Sat,  8 Apr 2023 19:31:10 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver updates for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZDFU437akoy8b8cX@kroah.com>
References: <ZDFU437akoy8b8cX@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZDFU437akoy8b8cX@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc6
X-PR-Tracked-Commit-Id: 4bffd2c7a3fc165fc70bc69211b8e6436f41a5c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68047c48b2288803c441df9f3e61d0d26bed87df
Message-Id: <168098227095.15421.12552316884711936021.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Apr 2023 19:31:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Apr 2023 13:49:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68047c48b2288803c441df9f3e61d0d26bed87df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
