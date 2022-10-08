Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D45F8194
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJHA2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJHA2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:28:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DCBBCB88;
        Fri,  7 Oct 2022 17:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1441C61DFB;
        Sat,  8 Oct 2022 00:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C5B6C433D6;
        Sat,  8 Oct 2022 00:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665188883;
        bh=CIkAwq+SHu/PX/0vQbtnNPRt/kDsjMqcf/adaPcH834=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pmbq5GC/k5AL/QXVuXfySa+GQm9spwuM0b1xk+spi0D4OwtYYxuD5lVZU3e6N16az
         xGH3PljGlTCcjE0UHmHMu2GbMEvc0/XuQY98wmtSKwm7wrLy7YYnLQf/9nKugqy7qJ
         9sFaihCBppEUICpk/JNqRSZDg1vj0XuPfCq6thBVU1aG+z3ASt3YghKsmz5nyOyaYU
         QxXr8uR4mCEpXR6ewedD1S+8xkRCaiHQwFTQ8JQzkSASg09j/fzc9kaO2k/gpLLTmQ
         +xD8TprkdNRZGrzKBWgx/4p+WyLuZ6NDW7zBqQAIboVKXNwDObGNP1dW0TfJq3KJhz
         yiuNJudyL9mkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BC57E21ED6;
        Sat,  8 Oct 2022 00:28:03 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0BVmJb6dpD8jrFF@kroah.com>
References: <Y0BVmJb6dpD8jrFF@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0BVmJb6dpD8jrFF@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc1
X-PR-Tracked-Commit-Id: 00988f70a0763f14c97c4c0df76fb9aa4959e953
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3dcbe24a0fc6373ce7e4a65acd5c785aa8e2396
Message-Id: <166518888343.15803.8787527683491972092.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Oct 2022 00:28:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 18:36:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3dcbe24a0fc6373ce7e4a65acd5c785aa8e2396

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
