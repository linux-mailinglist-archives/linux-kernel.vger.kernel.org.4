Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2E683795
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjAaUe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjAaUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:34:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E534C2A;
        Tue, 31 Jan 2023 12:34:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F67BB81EBA;
        Tue, 31 Jan 2023 20:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC0B5C433EF;
        Tue, 31 Jan 2023 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675197260;
        bh=5obZjGBMV4ymJZ6qd1usALR8p4c3ObZwzieGCo03pOE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ihtx2XiL3JXIudZmJxvl2nh6F1i3jmWMmqI3vvQ1rEGRbcNWh5YuftNJy3q4FCooJ
         ouJUylbW7FbgjW/pHOXwzvrqa+Q3p6AsiHpNvwn5YfFPB4JAzeu2n6pifwJbooGkGl
         LUt1hUPUlXhdNLwHf41Q7Dq4dEff2AG2OyNUQ/ayGS4XBoOoRIlnQbZzHcbHJFLYWb
         Li9gRN6Oit6fecXbb/g7ncU+MdzvhOMTIm4VFWoqVhds9mxW21uJ4GYigAl5T9TGgR
         aBZjXBT7ARPRbHsGKYaH9DLptl7Wg1s2UV8S+Xm5XVdMCHh4lyahaoop/ttwmv81rp
         LFszW6CqhXl9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2C60C4314C;
        Tue, 31 Jan 2023 20:34:20 +0000 (UTC)
Subject: Re: [GIT PULL for v6.2-rc7] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230131092439.1abf31d0@coco.lan>
References: <20230131092439.1abf31d0@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230131092439.1abf31d0@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-3
X-PR-Tracked-Commit-Id: 89c08aef8f8dcb5fc98ad8db7ca92c9dab1f26b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88b356e19199dca700b1180adc0b843a3228d4a0
Message-Id: <167519726065.29102.3097320896688058723.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Jan 2023 20:34:20 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Jan 2023 09:24:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88b356e19199dca700b1180adc0b843a3228d4a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
