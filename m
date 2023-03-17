Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90686BEFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCQRjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjCQRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7028F30C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07B3A6100C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C204C433D2;
        Fri, 17 Mar 2023 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074731;
        bh=hom0UzpZvWSPclZjmUNXiy3XOk7iOqvqrLDTC0tTDXc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VqTj8vtMg67wnx6C1RWMDs2e2/ARWeAJ+1SkSfE1guRtEmFbhmMgZIa4hgFt/ATR+
         ZkKzZDdOAUlrin+H6JGSKg6dYgUaZ8Al/AYhsdNUoOosOjYGWCU581PR9unwhCOXID
         rfP4c/hN+JKxpSiBvviXnuOzDIpvXbnD4A1aXbI2iRcUo7BdbjI9GOz1IXZdKsgBC4
         8ijYFHAFJ2UvPrNTrXcgDBl1eQDhEmFPRM8hzTOhCV2NMNS/RKu7LFkQXHmAsk9dxm
         fbiS2kfELrL5eLKPEW6sdTmfdhjRv3PPwXXBqdWf51JXxAEqfzERJApZnTgRb9FOtQ
         texMASKWwa48g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B7E2E66CBF;
        Fri, 17 Mar 2023 17:38:51 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-70404d20-e840-40df-a6d9-0d67003e3ca3@palmer-ri-x1c9>
References: <mhng-70404d20-e840-40df-a6d9-0d67003e3ca3@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-70404d20-e840-40df-a6d9-0d67003e3ca3@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc3
X-PR-Tracked-Commit-Id: 47dd902aaee9b9341808a3a994793199e7eddb88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb80b960ce44e3e4e90985bb65a84c1a10c450ee
Message-Id: <167907473137.9394.2003960680286372278.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 17:38:51 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 07:56:26 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb80b960ce44e3e4e90985bb65a84c1a10c450ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
