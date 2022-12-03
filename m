Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F536411D0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiLCAKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiLCAKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:10:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2E2E5A95
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:10:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DF33B822ED
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 00:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A28BFC433D6;
        Sat,  3 Dec 2022 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670026234;
        bh=xlK210QimcTHCPMJ+JQwKNu1yv5oHYwLgQI6Ic3rbeQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OcMlFqW9b75749v1kuhYgQVOX00RA1aTDW7jvD85golgYVnaWs67LiQTDYe4Bq+KX
         4QxWrBAOlLlW2veSs53Cc3jB+MNd0H7n0J7Sfmw/eQYNQQ2OzFrxjr5aBc+e8GuE8+
         667GjgJSFlQpd3cEREkzlcqrbmiE2eZnSaIUnTIQb3x0fk/vCld3OtjsoO74f3G9D1
         ARVYwsiAZOyotukrRoIaJbUtsjCy+42rLlIY8qrwXmAMlWZQ6DAny0UR1Y6kv4oKzX
         f/SVf1UGOdRmcuZlp1l9rmb4hl0AVv6VjxI0x9dnkiiIOOnmYOgrGkNAmcj8FMaADi
         n4s6avCspyKKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91481C395F5;
        Sat,  3 Dec 2022 00:10:34 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4oF8e7quzjm2kzD@8bytes.org>
References: <Y4oF8e7quzjm2kzD@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y4oF8e7quzjm2kzD@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc7
X-PR-Tracked-Commit-Id: 4bedbbd782ebbe7287231fea862c158d4f08a9e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f66f62f83dba3ec4237c3dd7a95b776824ac91a0
Message-Id: <167002623458.23477.8740887648769453661.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Dec 2022 00:10:34 +0000
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

The pull request you sent on Fri, 2 Dec 2022 15:04:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f66f62f83dba3ec4237c3dd7a95b776824ac91a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
