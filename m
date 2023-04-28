Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A0E6F1D54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbjD1RXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbjD1RXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA52D51
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25548644B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8671EC4339B;
        Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682702588;
        bh=UYRQL35wd1gCICfS/cr7HhkUpCutj0cq26S46iTsTqE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KlmoFdRBXGWxQyra+ypSj4U7OHvot+75/6IDNtMlFxAifNjVqwFmXK9N71jTQFk3t
         IVNZWheH3HMX0Dh5+dcA70S+BEaIJPVNI0YYNt+YuM2sKgpNyADaa9uprlFFQijFAg
         KmDx+yk+wFMJz5zqBXwfrmVYM/j82bI9BuaaDVtrEMquKaQjkXVipUJHTNe5befprp
         2cBUcI4YBap80sTr1wRBB6yNbLzqKZvnGz5OaG7OK7D4N/eh2s4eUYJs4CaSeG6Lkm
         jge4Oz5BQO1Izjf1TlHS/Dtx8zpTkczeKa+sg4C0NTmGC9Oia5QzlRacIXkdvmNKCP
         Gs/acVNDzDzVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B93CC3959E;
        Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427160739.1053203-1-dave.hansen@linux.intel.com>
References: <20230427160739.1053203-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427160739.1053203-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_6.4
X-PR-Tracked-Commit-Id: 322b72e0fd10101f2da8985b31b4af70f184bf79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4980c176a71706f3621d5c1674266de54a689cb1
Message-Id: <168270258843.30920.13135547162122801173.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 17:23:08 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 09:07:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4980c176a71706f3621d5c1674266de54a689cb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
