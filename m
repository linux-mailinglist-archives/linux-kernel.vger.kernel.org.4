Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE35FBA3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJKSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJKSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4670C60688
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5148B81649
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FDD6C433C1;
        Tue, 11 Oct 2022 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665512529;
        bh=OhfKOgvhB+cW1HDYkoS9U38sl6bjBRJz53QSpQlrVTY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=utVEf/nUOyy92WVIHJOOxb7ghLy1DhcHFh1dp7CUKvKwZVXWyaro1vPsp/wUrJ/HM
         SUHrQh+V1+GPS17og/r/rNzq6QkTvSLk9vKwOKijMpj1em6fRG71QQMAyDRQkIS/hY
         WwV8qu5UvsG8QJb33Pv+/iN6bOV/hvICMWlyY8PBwT5W2Z32dGjANTyWcgZzmxBfIt
         qHfMQsgwszJXlbiWy9T71rzTvShHs8Ast2x50MUZyFKZnT8lwDPunWR8SuAU2ex+1+
         K2Jp8cROEZ32RMq5K9fiDkod7tDiNPLvJuOt8kP5cICLV3R3K2byWHRZeHUNvabvR4
         sHF0tlv8RzHlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EA57E29F33;
        Tue, 11 Oct 2022 18:22:09 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzyxuBHS9MKcells@dell1.minyard.net>
References: <YzyxuBHS9MKcells@dell1.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzyxuBHS9MKcells@dell1.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.1-1
X-PR-Tracked-Commit-Id: 05763c996f72ef934432639fe412f5193816fd9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8de1037a96ef33363727302f9afadb6535fd8b05
Message-Id: <166551252944.20259.16827686194387592842.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 18:22:09 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Oct 2022 17:20:40 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8de1037a96ef33363727302f9afadb6535fd8b05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
