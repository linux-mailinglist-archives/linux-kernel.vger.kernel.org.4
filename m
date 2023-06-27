Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A173EF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjF0AR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjF0ARX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DEC186
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F587601BD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9205C433C0;
        Tue, 27 Jun 2023 00:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687825041;
        bh=Oe1ipZ7JMD2QIn7BM1EYUSYj0oEPS9F0gl4WfIKeR8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ve1XBHk26yTAzGBo3fqLoKK1nn0KsIAmJEmn9udvGF8Wj7vrg2hU7wD2g4AIrzCqA
         cnZtno42HJ9julVJHT3/3Yhz8jDZvP2fqlmmCrnCNwc1GbcX904kix44ZLS8T765eh
         ouw/wTOjTYSp792tAlE7d5kcwUBxa3IpNwBqhuwD4usPZHxn8aVOtcJWynuv7ueYT9
         eFTYW35YrpoxDn6jore/WMqBAAI7gsJfDUrN0CwVVtF2K3fiGUd3iHMBXQpqZPheE7
         THjmwn5B6EeRhkm1QewT2OF2IeaiVVx2EvGmASGPQazoXSy+ackVjy+npXJ7ub3Wkk
         F3GwWSVMePBaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7B36E537FE;
        Tue, 27 Jun 2023 00:17:21 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626174435.1791242-1-catalin.marinas@arm.com>
References: <20230626174435.1791242-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626174435.1791242-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: abc17128c81ae8d6a091f24348c63cbe8fe59724
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2605e80d3438c77190f55b821c6575048c68268e
Message-Id: <168782504181.22532.13141320361218083990.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 00:17:21 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 18:44:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2605e80d3438c77190f55b821c6575048c68268e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
