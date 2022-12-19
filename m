Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B608650E48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiLSPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiLSPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:06:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6012B3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:06:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6436FB80D1F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01C18C433D2;
        Mon, 19 Dec 2022 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671462379;
        bh=7JPOi7Jz2ocpvXnGiZ/PRzow+uJzHO44DTAqy33x6z0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NVD3xZQ5IO2a5Ux07Z1HHPttCUDIm9hGFuRuHiYuwW0aIaKLl7f7yJqCzvVj2aQ/Z
         ud0Qo7RQ9MTrueE31v2dVkulPThi0xbdzOmbx4KeU3zN732QlAr+C42rZxH6QtzE2o
         4bEFFIanK+afnUEajrTr+l2O1vpeZG9MQQFu4dS/QfC5ZoDdYHHTb9Nl62HM7aOS2s
         f8DhR1QAkK/1rS1JQvlu55yWX9Q/9nDydTFu/U8Gin15SzUtW99PlOULa7yxvBUiMK
         kA7P6CpCjNRtF5Nk3JsvfN8W7NrOMURVbFyEh60R5BiS5R4+Ze2TN5rmYr8WgBLIPv
         dtlPDlndDetEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E67A8E21EEE;
        Mon, 19 Dec 2022 15:06:18 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y53WuKl7o4/rKNt7@8bytes.org>
References: <Y53WuKl7o4/rKNt7@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y53WuKl7o4/rKNt7@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.2
X-PR-Tracked-Commit-Id: e3eca2e4f6489ed3143c80ce90bfa7ef7e12ebc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8fd76f41820951d8a6e2521c25f54afadf338bd
Message-Id: <167146237894.24644.6518257569859310475.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 15:06:18 +0000
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

The pull request you sent on Sat, 17 Dec 2022 15:48:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8fd76f41820951d8a6e2521c25f54afadf338bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
