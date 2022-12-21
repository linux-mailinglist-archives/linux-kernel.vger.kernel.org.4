Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BF65359F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLURxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiLURxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:53:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE923176;
        Wed, 21 Dec 2022 09:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64ECF61846;
        Wed, 21 Dec 2022 17:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC22BC433EF;
        Wed, 21 Dec 2022 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671645197;
        bh=Vyud5XHXOjF6+vkQ3TYanvkkqWjJifbLLjO1YbEiwig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j9/DmBN/oJH5Shkg6TvnF6pYW7VgrW0oQq0LaP+kZqY0eXbBvLB+SsU/hnSYsJCZY
         nB48WemhzqRHpiDdhcM40izTzrSa+4PLMxuvFB/rDg6D8gLCSUTizIta/booMGw3FO
         MiGAJ2xkulByh6HuCrvfjB76lqawK9nP/LQwv6DJfAIXI/9vx7aDA6THVYOZqki8WW
         1320WQG2QbwDFZT/WKouB82+Ez1JtbgxFWDpL1nLnhCX14rrxPD2fcbZouO70FZI68
         Oaqme3TuUW38YwMTaXHXIR7cc8UGaVRYjm/Sak7mLAhezlbFRTsIOClrhUVGc3FQ52
         bIB+Q944Gmn6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0C6CC43141;
        Wed, 21 Dec 2022 17:53:17 +0000 (UTC)
Subject: Re: [GIT PULL for v6.2-rc1] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221221112350.6b046362@sal.lan>
References: <20221221112350.6b046362@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221221112350.6b046362@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-2
X-PR-Tracked-Commit-Id: 542d3c03fd895eb8370992293498332ea383a3b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5461e079009ae2732c833281c4b50dfb58d15ba5
Message-Id: <167164519771.28688.14881030316149967891.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 17:53:17 +0000
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

The pull request you sent on Wed, 21 Dec 2022 11:23:50 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5461e079009ae2732c833281c4b50dfb58d15ba5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
