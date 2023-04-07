Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C569E6DB586
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjDGU5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjDGU5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B3CC2F;
        Fri,  7 Apr 2023 13:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6531665489;
        Fri,  7 Apr 2023 20:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC9DFC4339B;
        Fri,  7 Apr 2023 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680901012;
        bh=dU79tieKM4VC67oKiVBYZQaEtEoiZte3V/l8FFakNJs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VHzRtc2eZ648VeR4nFIhGpDRwTw6ORDq48ds/nutZleCX/V3uS7AqlZAuzb0c3S0c
         jTn79T51Ul5p/Ltfi5H5awE02UABb/jOMtQbyZr7cG6URZSeBqBREPC+aP+szbieNy
         QDnvSQ4YWdwyKETyUWjcwHWlmfvXPAtANZAQPeIPDOlpeo/R1rIjtUFB/+x8vRqBJF
         nboDE6znj/6EhIizqV3sJEVVKNCVqv3td8uiYuaEf3LadLqOCeWcN1e7Bk8va1wLSU
         f8OC7lcoV3NgVWY9i9Z9j0OCLP/G7CfiIvtWjk7eq3yQ6DOQlNPFoF9I71dNps1A7f
         0Z57SmnjArkUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7E3DE4D029;
        Fri,  7 Apr 2023 20:56:52 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hE_eVO0S_MSfB=X287XZR+Cisa1f5nKU5VAEwTtxdnOA@mail.gmail.com>
References: <CAJZ5v0hE_eVO0S_MSfB=X287XZR+Cisa1f5nKU5VAEwTtxdnOA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hE_eVO0S_MSfB=X287XZR+Cisa1f5nKU5VAEwTtxdnOA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc6
X-PR-Tracked-Commit-Id: a5b2781dcab2c77979a4b8adda781d2543580901
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9797dba13141de7d7211aacfadb4cdba67a4716
Message-Id: <168090101274.23908.6826872717398010960.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Apr 2023 20:56:52 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Apr 2023 13:32:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9797dba13141de7d7211aacfadb4cdba67a4716

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
