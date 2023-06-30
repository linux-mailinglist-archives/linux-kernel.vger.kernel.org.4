Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3774336D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjF3EQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjF3EQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:16:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B41FE9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 612C96167E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C008AC433C0;
        Fri, 30 Jun 2023 04:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688098609;
        bh=znCQpmhTfXUE877jJ4hkyBv2ALfcZH3Ig1NWgRLP3T4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QolZP0SNKkAIUO9cJ+WQoD0VWdtX4mVQEn9qyovtJsAbTa9LDEgT0c3G234H2xiD8
         S4KuVx5rVL4AARGXYnIToti1O7yN+B3Z+wAnCKtza/6p2HiKSMP0OX0LuBGYUpVwbM
         VXcSNdIJEtpxAnxGbTrYgd7aw+aQ/oHcy/IKWoadWmnw2SXI1/c0K14gzPTN9DOQ2X
         NWL8/nq/p/pXrwMNTdd+TXM5Py6Yam1dnV+Oqv0ZO3M4cvaysg/G9YXp4wD7wTubcM
         9UCKK76HFwZR9Nn0xdBLmtG8D7ThUabKbcsHswgNilMVg3ldJLiZ0GB5kO4wsjDd09
         GGpy6DNE47e5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF865C64458;
        Fri, 30 Jun 2023 04:16:49 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJWfBNRk89N0jfgi@8bytes.org>
References: <ZJWfBNRk89N0jfgi@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZJWfBNRk89N0jfgi@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.5
X-PR-Tracked-Commit-Id: a7a334076dd725b8c3b5d64f68e3992ffcfd1d25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d35ac6ac0e80e55bcea79af18d935f19a3e8554c
Message-Id: <168809860971.23778.6044069114339914650.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 04:16:49 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jun 2023 15:32:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d35ac6ac0e80e55bcea79af18d935f19a3e8554c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
