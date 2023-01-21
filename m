Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF367685D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjAUTXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjAUTXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:23:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D11F90A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7843660B6A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 741B6C433A4;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674329018;
        bh=JNIW2/JBTbJDuOjJ79HWPfSfiLn5Lct9A4EBp2IWwQM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pff22k/7tcyn07wSO79xzO7FCEWoG3P/qheqnVvwpXGyD0QfLRLhB0p0CSd1vnuAV
         XaaB3eF6F7yLbTAy3NU7bbGZpuXv13/uR2SHdpPVB13cdoYS63V2CFl1cF0YYOoGHd
         pcs3IEo9hXVxVn8F8OA4yePVnicjEBL6R/L9YH7heXy17oobcTBcX0CWnkd1cXl6N+
         ZCKJLLspc0CsIGd/V5540xqoUwWRCUm1A/gRSZCcedZFKsVo29jZrZFKW1U7wrtG2F
         8H0r9anNGGUvGyync19PtOQsxTe9WDqhNiYi/0XqivxMQintwc+pbbHw+f3d8gM6OO
         oBa2iKDuHY/hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6137CC04E31;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8wFD5eLWHUzCuNJ@kroah.com>
References: <Y8wFD5eLWHUzCuNJ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8wFD5eLWHUzCuNJ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc5
X-PR-Tracked-Commit-Id: 3daed6345d5880464f46adab871d208e1baa2f3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f67144022885344375ad03593e7a290cc614da34
Message-Id: <167432901839.17568.13121455575343689618.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Jan 2023 19:23:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Jan 2023 16:30:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f67144022885344375ad03593e7a290cc614da34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
