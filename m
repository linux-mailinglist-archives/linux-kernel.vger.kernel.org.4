Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A986A4974
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjB0SSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjB0SSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:18:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFCE05F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:18:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF7960EF6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0861BC433EF;
        Mon, 27 Feb 2023 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521891;
        bh=QiQzYSGEYbDulghC9uA026aE6bWEsEXAa4zZo+ohEvY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E3IhVg6k32sq0J+Un2fg9lf0m6o7vudDkrmKK5C3vUwH9g0FYKfosA+if3n3YZ1/t
         niFCFs1t5iANq535xt84kLKn9DptOA6PUY6lgasTdL7W5idOy0DdpTwGW+cJxH4Z0s
         NPD+kN8J2l1ihIyz4S4MGgXid7S0Z8Mq5TVE78DwaaV0cFwb2eWda8YNPL3c/L79kQ
         TFk+tuYODZbSc3h1uf2ywD9sNUwfDb0EfV2KlNxfc5x2kk87hRAv7zyq8utVTkCPfL
         hlis56vpfuEjXcpbZns8SAn0U/fsrv4idmTe92FWZuJGhdDmE3gTttYFncd+GcMiv/
         odlRTKF2Lq96w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC5CEE1CF31;
        Mon, 27 Feb 2023 18:18:10 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/yz1im8klkg0J84@infradead.org>
References: <Y/yz1im8klkg0J84@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y/yz1im8klkg0J84@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2022-02-27
X-PR-Tracked-Commit-Id: 9b07d27d0fbb7f7441aa986859a0f53ec93a0335
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ffb575bebb983b982240372ecf976188451dd1c
Message-Id: <167752189096.27343.9543390132973660152.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Feb 2023 18:18:10 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 06:44:54 -0700:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2022-02-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ffb575bebb983b982240372ecf976188451dd1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
