Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6F68B198
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBEUge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBEUg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:36:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B11816C;
        Sun,  5 Feb 2023 12:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF11FB80CC3;
        Sun,  5 Feb 2023 20:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64BEEC433D2;
        Sun,  5 Feb 2023 20:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675629386;
        bh=Zd++yy93y1YAgsUE7046plKGX85J7FnA1O7AZD4zPT4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WJDAqG1ouKVsZd0ibWde3wGvLRb8qGQnHmiaCFc5N7rycGRMdcwZ9koTGv3W4azSd
         76FtuTGuyL0QDvxxszzSVkra9wZWSbiACCoQ7EMhJuDBWyF3OURQUFH5K3CMAAFZU8
         JclqcxGWxayBXMkX9xZvlsAj+Sb2nrlXvEDLhP6iZMId9cxqO7EDDXPpA0oWztwe3V
         q0B9GCSrCG6tTHXdRyFUQyzAqS5vLRPv1tMPCh0aiW8lZJr6vVg76tGWtB644OgxhY
         1gU7WemVU949DNaMaifc0/XdVcPKCwozqv6UmZPPzY1DIaFRGoVrkbRHB1V11BhBNU
         7SSkNcukCobkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54004E21ED0;
        Sun,  5 Feb 2023 20:36:26 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9+nI9o/v/RjiWne@kroah.com>
References: <Y9+nI9o/v/RjiWne@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9+nI9o/v/RjiWne@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc7
X-PR-Tracked-Commit-Id: f82060da749c611ed427523b6d1605d87338aac1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c608f6b58f306ce0e4f459af69a196f5ed6ccf45
Message-Id: <167562938634.30640.9658797093784140065.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Feb 2023 20:36:26 +0000
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

The pull request you sent on Sun, 5 Feb 2023 13:54:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c608f6b58f306ce0e4f459af69a196f5ed6ccf45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
