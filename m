Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE563002C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKRWer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiKRWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:34:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FCE942EB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19FD7B8244C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D13E8C433C1;
        Fri, 18 Nov 2022 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668810880;
        bh=GOikPTe4WCHtxHaIBDtUl34DUEAgSG2MlXMZdACVGfw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h5y1zpPlCczvqeXndCXJcOOoCvwntwoPK1DfmNjM6anAaUT2bNpaD9Dp+HOIfGT8f
         HOsMl2qK+rLRrYPmxO3V/S5hy7eGjxgru3cpOPxG4uuca4adPteg2f0ZSXO/VKT+wy
         FqZTNgGoH+IAOuY3UYbj7ncKm7KWMCkf55ugOce9G4aRmcArsI4oHvvzA45ZntcAY0
         rqybjK3o+AcdKCxuzdrttx7SGnK+onBSva+M4Wy5JZUioe7JgyGkiAa3Gw0JAyJ57m
         6qczSSRD5gZCf1DY9EsE7mmMBu5Pdfm1ubgvKOuAkrSMJE7ww/LKjZlALmE9slW3FS
         GTMlv+n+MPdzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAFA7C395F3;
        Fri, 18 Nov 2022 22:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3f65PV9KYD8DvY2@arm.com>
References: <Y3f65PV9KYD8DvY2@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Y3f65PV9KYD8DvY2@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 5b47348fc0b18a78c96f8474cc90b7525ad1bbfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23a60a03d9a9980d1e91190491ceea0dc58fae62
Message-Id: <166881088074.18535.4814606296547767327.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 22:34:40 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 21:36:36 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23a60a03d9a9980d1e91190491ceea0dc58fae62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
