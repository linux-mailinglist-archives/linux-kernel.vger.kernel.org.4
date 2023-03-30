Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096186D12FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjC3XYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjC3XYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:24:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86471B5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74361B82A92
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17284C433D2;
        Thu, 30 Mar 2023 23:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680218685;
        bh=LklYGXMs8HFwHiz1yt1R3s/R2+XoOWGfipko482NkMo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QWyjtfVubUTaNnWWmFy3PO+AQRekaaRrro6AF46WEZ7JUNtv9cHOwMd0Etw4JAFwc
         bdapEKw+luWwCj6dx3u28qYDTRr8zWO7ectzMkRGYiuMna2rwElry9bD5qPAAgABxu
         gVCiWCq/4kSVsH4v925WhgzeAB5bVe8v7YyDLbeq5M9aZO4qXnnFU88kJhQQDLypkq
         IBmTscihOMaDL3dBXQPKmCUxxmzMwKmS4RRuoxEH5slfThGFrre3BGj7clzo1gWi0C
         /uuSHWeBgKuiTYGobD3XzoVO6LcGxJy2tVnIWv/gCQCLT43x2c2ePEm93B8zT8K53j
         3kqTHxP2OpwXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 056F9E2A03F;
        Thu, 30 Mar 2023 23:24:45 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZCYQqGH+kCQLDLa0@infradead.org>
References: <ZCYQqGH+kCQLDLa0@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZCYQqGH+kCQLDLa0@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2023-03-31
X-PR-Tracked-Commit-Id: 0eee5ae1025699ea93d44fdb6ef2365505082103
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62bad54b26db8bc98e28749cd76b2d890edb4258
Message-Id: <168021868501.13292.1611448441271691057.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Mar 2023 23:24:45 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 07:43:52 +0900:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2023-03-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62bad54b26db8bc98e28749cd76b2d890edb4258

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
