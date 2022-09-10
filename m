Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001B85B47C0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIJRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIJRiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1805348EAB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED49F60DCC
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A711C433C1;
        Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662831532;
        bh=vXcG7YDzIID+VlyN2jEDEB0FovINJ6ZqRj+CEZecMWA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DE7DzarpJ8qPIMmmAvLsTj0FFU/c5uVqxdOg8ZhKIjW5zouWsghIlnD/NfTgVhy+0
         BeOtQ87eTXAA9O7hXJBO5Wbdny1gMWHtif5IsqhyngU135WSSR8q/U7aSG3bSWLU26
         RELAecTq+SJ0BhMUggZhsigE6okbWDHync3yrS+bq2YUY3e694b8sCUIKJJLRyQ21/
         rEK6DAovl43foDfZQWMf8NwCVxO25+UBw8QlDNQvMvQ2CCisnYnC0ncrTmm7d3XzPd
         vgY5A8YW9eBSr8JM1eYkJaBtrEFqM5YN/F5qHTGy7+Kdo7Bwf4/X7kxZzFjytp1TFr
         34B6kUUmtUMZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47183C73FE7;
        Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yxw1CiX1qG9msudX@infradead.org>
References: <Yxw1CiX1qG9msudX@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yxw1CiX1qG9msudX@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.0-2022-09-10
X-PR-Tracked-Commit-Id: 9fc18f6d56d5b79d527c17a8100a0965d18345cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16547b21b1c6c8e8c5546a5206ebccef3e28c92a
Message-Id: <166283153228.31692.13153209837002110738.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Sep 2022 17:38:52 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Sep 2022 08:56:10 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.0-2022-09-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16547b21b1c6c8e8c5546a5206ebccef3e28c92a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
