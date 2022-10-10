Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89945FA6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJJU5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJJU4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7116413F18
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 276F4B810D9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0862C433D7;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435397;
        bh=pNF7gHCSe+kJUfSTxqJFJYPIheJegj87NjCPCeAO4gU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g90bj1KgAVR/7kX1L82GNcSE4Dwys6MZm0xkR+hNfLs47sK4SBsWMvRveEWtbZU++
         pF0xjxFAMbycxXG1qqFM5PsTOlEf701wwfaow7T4PBmtS0c0/49L2tQ+raA6wFm0Hz
         8tKE2y1P+iJAYKn6YF4OSLI50mx4GZgnoxXW88gJ/JGazpCP2Q60JgW07unRrK8ugd
         q4f67Pyf1MopOM1lWICMFasBeTH7c2rZnllPgV0YvXeZFEgHKtcb3SFwkQRWeVNkbK
         /eV9WHq3scQsog1c/aB8ExCl3iZ00jSrBOo+bgaIvxFzvzxABoBwkCskkDwCpmU9wz
         6EiXC7Q4LPJzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9AA7E4D00E;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0Qx8pLF+vCjItiu@infradead.org>
References: <Y0Qx8pLF+vCjItiu@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0Qx8pLF+vCjItiu@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.1-2022-10-10
X-PR-Tracked-Commit-Id: c9cb01369b926a074004714ab9f9b65f75bf3c60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10b22b533ee2c9621f8ab74cf9df1021b5731dbc
Message-Id: <166543539775.11766.10643892919315566054.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:56:37 +0000
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

The pull request you sent on Mon, 10 Oct 2022 16:53:38 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.1-2022-10-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10b22b533ee2c9621f8ab74cf9df1021b5731dbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
