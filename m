Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE135FA6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiJJU5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJJU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF4813EA0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00058B810D2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8060C4347C;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435397;
        bh=G7z+dCtaDjBzuWQSokVn3ODByWmdzT4WQo+I5GOC2DY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bAnEuqBjUb2GtYW2C8cdshfztacHlyXq78dhErAcS4acPx5SlUiIDqJq6UUf6RnP2
         tEOEEJg6kcfMq0m3GQ9b4w499bL8xrVHukB/Hb+YP1FpjsJhW/e80aPI8AdxfUxs6I
         SlXDN/est5S2CYA3MPhbRVeBs9iYAL+E3P2rK0csxlCI76sNAf88Cqpb1I5MgCfqwk
         EAX1Lj0DbSM7/gzO72L7oS6QBk3NyGrIpA1lo7IdrlM5hMHi05wzo4ksUXpimiVT6D
         nOKMQ+uJ3JMnacpginrjJqFFTp3j6909CkmsIZ2BzSty3L7okiHU/KN6QZV61sE+ep
         ZomNr/+YgqzUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 982D2E2A05F;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0QMOy7g2nADghrJ@8bytes.org>
References: <Y0QMOy7g2nADghrJ@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0QMOy7g2nADghrJ@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.1
X-PR-Tracked-Commit-Id: 38713c6028a3172c4c256512c3fbcfc799fe2d43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f23cdfcd04f7c044ee47dac04484b8d289088776
Message-Id: <166543539761.11766.7130453309101940100.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:56:37 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 14:12:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f23cdfcd04f7c044ee47dac04484b8d289088776

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
