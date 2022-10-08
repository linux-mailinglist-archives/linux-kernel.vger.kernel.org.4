Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8485F8191
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJHA2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiJHA2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:28:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF5FBEAF0;
        Fri,  7 Oct 2022 17:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12582B8248D;
        Sat,  8 Oct 2022 00:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C45CCC433C1;
        Sat,  8 Oct 2022 00:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665188880;
        bh=tSKxD+7DM97US3J5vjTOfbW2UmoEfcSMZd6+WVTErD0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YpQ/q/sFKeQ6DaNnD1j8uA5T5CK94zPrwSuAS/FS8hakWhf7pFu4xeq/rr08ORCja
         bYxsmc+sM+2ssD3c0XJzgzQeIr7W3Hts33Fa64zZjOSDf1k1CNxE4HulKOslFZ9ofW
         0QT3jstb0Sq9A50rO2mi/qHzi7nLDh/4qh9sjSMQPNjcfornAkYWdbmQiVEGj13UMy
         USVFe77UfmM7u7O8M0wPgZnRWXiishoQYaBncEuY5Mp8m+11jRN6ePRp5tRv33qbbg
         bcjn3ix9iu7lGzF/YxDphwSwsBaUS6xibSeNwr6GtAnjKDEoMCnxrd+sqWMu6yerE3
         yYfzIDqli0TSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4684E2A05C;
        Sat,  8 Oct 2022 00:28:00 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0BVfL9lPd7jz5/s@kroah.com>
References: <Y0BVfL9lPd7jz5/s@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0BVfL9lPd7jz5/s@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.1-rc1
X-PR-Tracked-Commit-Id: 30963b2f75bfdbbcf1cc5d80bf88fec7aaba808d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6181073dd6a7e5deafc60e7981bd765b6c93da8c
Message-Id: <166518888073.15803.6158125558399199781.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Oct 2022 00:28:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 18:36:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6181073dd6a7e5deafc60e7981bd765b6c93da8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
