Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4E742F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjF2Uwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjF2Uvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F653594
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4752461632
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0EB5C433C8;
        Thu, 29 Jun 2023 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071900;
        bh=8A7A32gALfnhjzft8+IJHdrDaXDUT1+cutM2HkVtR64=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UrJRbarGqCBDMCGrLFUxTQBrj5zG63N4XFpHc5vAyfBsFmW4nVM9LeMiIxSlSVeeR
         e7iqTu3fxBI1YK0LpIEYehdG/nFa5889b2CJJkmYkxZ5pA8PwyRfj1pwe6x0p670pm
         gSEbe6kpkbQFYLaYrbZNJ6wMDFQJDNyQQA8Bw4E/kTs5zJ+OSy2vtK+HRmED0QqgJp
         O9GiGsJkCfb29tfEcoGERFjasI5Ewztjmr47DMg7wHwY0Ifld6l+U1YOzC8h+z5rhn
         dbz+cph0gt1GiWq5XeAshl/er+h0cijcrrKiADNf5oosz45x0Mf36sPxcV50GkUKfY
         Ns2k4+uzDbFNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EC79C40C5E;
        Thu, 29 Jun 2023 20:51:40 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0c277be9-a3be-2c23-a016-82238fc946eb@oracle.com>
References: <0c277be9-a3be-2c23-a016-82238fc946eb@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0c277be9-a3be-2c23-a016-82238fc946eb@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.5
X-PR-Tracked-Commit-Id: 95e2b352c03b0a86c5717ba1d24ea20969abcacc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9d02c224d00a412d9c7fb1f92c358604038a783
Message-Id: <168807190064.21634.1464816030990376881.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 20:51:40 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 09:07:41 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9d02c224d00a412d9c7fb1f92c358604038a783

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
