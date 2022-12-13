Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF064BBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiLMSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiLMSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D3222BF7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:13:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8282F616CA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E89BCC433D2;
        Tue, 13 Dec 2022 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955223;
        bh=NjSuw5djg2TT4zm3Gy7G9QB9Wo7L0B7UuQ6DG1fNZ2U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NAk8S4JwdHKuiKjCRodmhHu1Rk4UJ/t2zr9TZDRPdFOfhqjnwJIJE74ftcWHCwsgZ
         u/uHPXz/FQXt6F78eiSC6ecJSu9JIkKErbj92ESfvWmxNMRpiw18drNW5eSUhjF+1L
         o6R5VsHhK5S/ThUvpB2aWMDdIjH0iib+wQ13b9/5ZwdmRhtO2NtsGC45Yz5UDmzw1k
         zQt5LbAvOKsP8QzGnhWpOyOomwTlZyxE0om8UThJ6zleehrl48MAGbHVs5Jon4/2hR
         tqUpjYageEJdACjH89pAbxqNTIemkbTxX7T9gIMFo1uClk1DFqJsfkHpOqEXZzFl6N
         A9g2wla6nyGbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6363C00445;
        Tue, 13 Dec 2022 18:13:43 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5ire5HIAi/kc3cg@infradead.org>
References: <Y5ire5HIAi/kc3cg@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5ire5HIAi/kc3cg@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.2-2022-12-13
X-PR-Tracked-Commit-Id: ffcb754584603adf7039d7972564fbf6febdc542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e529d3507a93d3c9528580081bbaf931a50de154
Message-Id: <167095522387.23919.14232615760653811121.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 18:13:43 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 17:42:35 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.2-2022-12-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e529d3507a93d3c9528580081bbaf931a50de154

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
