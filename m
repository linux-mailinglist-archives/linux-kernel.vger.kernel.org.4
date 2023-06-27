Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E173EF89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjF0ABR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjF0ABK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1079D1998
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9770760FB7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07C5AC433C0;
        Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687824069;
        bh=FXb1Kw/Ic98TWihezO36v12tVNTykRQ+dG0PMPPI8tY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vKXcswTaLdqlaHJ+DRWsuYPmPY4O/OsUToIHiNGefiiTboqhNMzII+LRUSRz5S5aL
         jGu5Cwp+O7ZdLa6KAuXfIRpQIkms1AdDH2Yh4k4QnGgX2nc4xY3Z33jzfzECFrCY9h
         kVs5H8BOUmaEUrSw2R4dIkPv55W7CEPNx+l7Ne1u+9u3ouOosPeFPHuxURYJgx12n/
         RvxRH8xHepHzx8VtLioFOjIcK4Pf4RdKv01hcMVOKDxzOcuukPv35QXpDsVMp+IRMR
         rIcvUcG8q/M7dq1ZkUNGVqbku+Pp/W3hRrpeNyQvyJcg7a3UZ6bFALz5i7oTzho6nU
         MGIndmI4ehw6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFD29C43170;
        Tue, 27 Jun 2023 00:01:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626192209.1529129-1-dave.hansen@linux.intel.com>
References: <20230626192209.1529129-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626192209.1529129-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_6.5
X-PR-Tracked-Commit-Id: 73b3108dfd9d53ea565c0777a27007c1c621467d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36db314440502c1a3a283ba5a16cb5075c19f3d9
Message-Id: <168782406891.12263.2816665061913835963.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 00:01:08 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 12:22:09 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36db314440502c1a3a283ba5a16cb5075c19f3d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
