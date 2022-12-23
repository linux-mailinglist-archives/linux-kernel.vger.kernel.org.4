Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65216553D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiLWTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiLWTXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:23:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A31DA7B;
        Fri, 23 Dec 2022 11:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A280B80A26;
        Fri, 23 Dec 2022 19:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C69B1C433F0;
        Fri, 23 Dec 2022 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671823382;
        bh=a4p/P2fMXzcbdDzExSp3coWJaSXqB3Sg/QuyaghOlvA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W3AAl6f6al/dC5+MLy8Dy+YpTkTVhhKebWoyYEbBDh4A+9TRQcGJCAVii8As6EG1Z
         hCz+6S+CWl7Bpp5GVH5GdLbjDoI4sJoTb8IFfZky94AN0N4t7nGNjifbtJkJqw+s13
         4Tldyr5+NUroc9eaYH6MlVUef3Splnn80Y+1rMhBnJCQQZ7R+/f2eT1h5tRW32oBNJ
         +t9SdgYQ6sNXbz7XWK9ccPB5YmHWywt5H3mnRsA1CS1y1tbchicuT1grMkaPQJp7A7
         qLHJ6n5J0Pk/mePaIgvBQK0+lkdYU0ux8AXNTstPl2NKRP2YYehLE8DpeGbv8bs9xz
         U9jF+dHis/myw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4413C00448;
        Fri, 23 Dec 2022 19:23:02 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221223093431.GA4961@alpha.franken.de>
References: <20221223093431.GA4961@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221223093431.GA4961@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.2_1
X-PR-Tracked-Commit-Id: 24b333a866a10d4be47b9968b9c05a3e9f326ff5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06d65a6f640118430b894273914aa8d62d2cf637
Message-Id: <167182338273.13713.83362762388500494.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 19:23:02 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Dec 2022 10:34:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.2_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06d65a6f640118430b894273914aa8d62d2cf637

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
