Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4911F6C833C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCXRVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCXRV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D4F149AE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:21:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D6762C1D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C03EC433EF;
        Fri, 24 Mar 2023 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679678149;
        bh=Sucp0yBdmA5wuFWYxBMiZRdQcUTiMd2RWfUoCqPCMNM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EPMDQBKIrGvsfVIAg9OyNCjwN22tH0OFr8DF86qoEg+AJRPPpoydOsr9DQ3enRsCS
         X8upGR2oU5wtTHh29Pm+YOR8a7ZNCU9PmRItVdRqzFIcJJ9RYBJZmhGW5RI01zgphM
         B7Q4DTAczfUKwNO10LUrV1zCPgTxpGbDFFBQ+Ib0HbVTb1CGJpFX1qrZxfbQIptQn3
         dBa4UNqw9EcH4vVyKHLjMEiTcH35gW4DS0+hZcr8YM/bCzLw1T/Emi5tYw/zFw7DfS
         Skief0BlplmTeCfRuVSpALh+DZojS1jtqOE1D6rZD90Dw1gmAjP81zFsmGo43cP7++
         4XkpUJYJ1QVHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89A6AE2A039;
        Fri, 24 Mar 2023 17:15:49 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230324113550.8218-1-jgross@suse.com>
References: <20230324113550.8218-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230324113550.8218-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc4-tag
X-PR-Tracked-Commit-Id: aadbd07ff8a75ed342388846da78dfaddb8b106a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2495697422d374b097151205d399ff0dcbaa08e0
Message-Id: <167967814955.905.2593283607607592203.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 17:15:49 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 12:35:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2495697422d374b097151205d399ff0dcbaa08e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
