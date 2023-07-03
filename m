Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D7746412
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGCUaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGCUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC34E76;
        Mon,  3 Jul 2023 13:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D33161036;
        Mon,  3 Jul 2023 20:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 503E0C433CB;
        Mon,  3 Jul 2023 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688416205;
        bh=f7s7kjg9UfWUhrVvIC7anIJohlAI7H4fbXqQEF6AjM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cWPygz37b90Qpt0O4XKvJpePwY4wxcMKrps+BHdEkvXiY95WleqQOxULGPcKbY2nD
         vc/QYc4EklEc60Ki88cNAKTTIKx57Lp9/RUxHsxTeLk+r2KbzCwMcf1oTSsMu5qQma
         Kf7iAu/QEh5gNe9W4A/8aXngrxsyhX3+qikKf/PpdEIJlRd2bHh8HcBk0ssZVyCuhz
         QXXEvOtAJzUSbHWiP091Vqmn+ESRtGRUG3gldTuPn8W4bPuSupthVr3njvbWyPnoZ1
         iMkSYDV4zWzUAMqLs6V6XaA6NcX78cXx3AAniJAlhBxClRonOI8NebcjQvc30B3kF4
         VkWQ03CRKi+5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A729C4167B;
        Mon,  3 Jul 2023 20:30:05 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver updates for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKKejqr0Db74u8TB@kroah.com>
References: <ZKKejqr0Db74u8TB@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKKejqr0Db74u8TB@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc1
X-PR-Tracked-Commit-Id: 18af4b5c97915a6daef9de28a30ae1d3786bc2ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56cbceab928d7ac3702de172ff8dcc1da2a6aaeb
Message-Id: <168841620523.1331.14586131400664399944.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 20:30:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 12:10:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56cbceab928d7ac3702de172ff8dcc1da2a6aaeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
