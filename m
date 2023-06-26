Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3048573EEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFZWyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjFZWyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2A6E7B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF5C860F99
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D8EC433BB;
        Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687820050;
        bh=8cHpXFOFVamypdam1Buvem6aB1xmIY3/R6l+bpgQcdA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t+B6wyjhT2JcN9VTE3gS6sLIxEAyL0gwyvPqRL7ixY9rkWMl22VkCw4LEpKmvN2PZ
         TgSuq0qzDMYC9nnGxzY0AtQmz5lPPLtTc07Eci52/Vl/4ooxwrIQr/wTEr8L3YZZRA
         /tsJhCQm2n4A0f2dYAb1R5Yx4sSt6H6ExHNbzoUxuEMBJjEwiXNe/vOSkomAu9JRX8
         mvR2Y+pYf4byPnERSXxN19DaS6EELfSnbU5NSSyXUuxhhfn4zYaKz+th1b0xHBpjNX
         V/kiWK0Hm5i164yO5QhZnySk26Xsm+TLbOoyqZFiu8vn4rMMGvHcv6YkfOw/sRbmWF
         rYhie9b70UOIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A054C43170;
        Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cc for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626180624.GJZJnToMIWeCuisF7L@fat_crate.local>
References: <20230626180624.GJZJnToMIWeCuisF7L@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626180624.GJZJnToMIWeCuisF7L@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v6.5
X-PR-Tracked-Commit-Id: 84b9b44b99780d35fe72ac63c4724f158771e898
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c96136a3f8dad6bfe35b003fb8b312f13a107e8
Message-Id: <168782005023.10634.3041403344122236167.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:54:10 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 20:06:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c96136a3f8dad6bfe35b003fb8b312f13a107e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
