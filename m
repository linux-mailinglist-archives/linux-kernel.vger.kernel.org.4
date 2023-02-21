Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467F769E90C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBUUjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBUUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:39:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17148311C5;
        Tue, 21 Feb 2023 12:39:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB1DB611B0;
        Tue, 21 Feb 2023 20:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5246EC433D2;
        Tue, 21 Feb 2023 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677011940;
        bh=mNsf84hgljs4zphgoXWF5xtSuQNE5JQkh3HQImjAGJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q1EmEp6rqFqBOAAw9OuCk0H7FQPnUKKA0lfvxFyo7jJ7QyJ8qHGw1ws5+H07WBPKH
         /TEv3+lusAeGFjwoNuPiI1Aruhe9ni2HXTTIGwxNhMcUZHeLgBeqwaJQbf6IeVOJOt
         riePLQ0el/Jao9CdsOndZ0aTWn4lksNYPKKCUO8GWUuYtk4wK/P+SvjnzvsRV7fy1e
         Iw2E07a+Utlj8VtS8b9DjnfErNLIuXMOonRbFNmCXjKI0lH2a3ma7IW7jRg6JDmLzJ
         G4H4DpOaCY6Rquulc3UVJTPk2yrbcjM0bjh3bJE0HBSIKkEBYTS7opTxj/YPp05wHH
         SVxIKqgNok82g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24997C43158;
        Tue, 21 Feb 2023 20:39:00 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iCmhEQSVZ8nKPZz63uQ+svRst_3N-WoxwOa617H4h9=w@mail.gmail.com>
References: <CAJZ5v0iCmhEQSVZ8nKPZz63uQ+svRst_3N-WoxwOa617H4h9=w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iCmhEQSVZ8nKPZz63uQ+svRst_3N-WoxwOa617H4h9=w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.3-rc1
X-PR-Tracked-Commit-Id: dd855f01e8d194d2dfeda36b620203c623c10430
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2504ba8b01634319a6f95b7fa9bf9c101437e158
Message-Id: <167701194014.12980.2614567996032245105.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 20:39:00 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 14:40:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2504ba8b01634319a6f95b7fa9bf9c101437e158

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
