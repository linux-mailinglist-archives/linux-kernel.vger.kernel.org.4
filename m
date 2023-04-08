Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F536DBC80
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDHTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDHTBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97510BBA9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 12:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D5061222
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 19:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E07B5C4339B;
        Sat,  8 Apr 2023 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680980470;
        bh=lHhMzvY2hG1A2HWWzlW2b890+Tu5YuZzm1Z+CDR+OoM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tGRBz8YKspIUpyzjFJMYdZuNvCebkJ4uMO9xsdkd2iPn79zvSU9fjGVLoJP7chyrp
         j5q7DDRSkn3yn5WxDB3vsWfTovI94vttfnSnz8RKGa9qHUAw9siC4+ZUNUekHqRLjX
         jJHosr0Mvy6+OzAMpsW0vgIRJMupikbX+tlzfnqK0SYsykjtycFW5+LrpKLSc7fOfo
         8He5FrODpH1UynEE/SkndU4vy7Y2t6FN9ArvNzdFcFSgcGmvCMbKtS+fVv9d8PKkRE
         8uIQQfhoUwdO+uyMWS0is0zsXoMqjNVN9pkBSwC1FoNqEWFPGTHTwUeD55rUyXmrpg
         Px/BFgEgy6hSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0047C4167B;
        Sat,  8 Apr 2023 19:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZDEERJRl1jrw2kQn@infradead.org>
References: <ZDEERJRl1jrw2kQn@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZDEERJRl1jrw2kQn@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2023-04-08
X-PR-Tracked-Commit-Id: bbb73a103fbbed6f63cb738d3783261c4241b4b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 973ad544f04a5eff3435fd36e02392c5afeafc0f
Message-Id: <168098047084.1995.4863005389013524611.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Apr 2023 19:01:10 +0000
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

The pull request you sent on Sat, 8 Apr 2023 08:05:56 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2023-04-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/973ad544f04a5eff3435fd36e02392c5afeafc0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
