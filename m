Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B86D26A2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjCaR1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjCaR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:27:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7981D2D1;
        Fri, 31 Mar 2023 10:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AD4FB83128;
        Fri, 31 Mar 2023 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED050C4339C;
        Fri, 31 Mar 2023 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680283617;
        bh=dBsbUusW3jOtWFQt2Uxl68Y709mtCq/KYse9yU4wPao=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dq94ObvKo56CkeT/J2MLFdCERKdwTcrmO8OczYQVBCnv7WMwt7YWTZvtTyjWFUfDD
         KWcBr9OFodcN0kOdiKXWitZGEyAv0FIDLCrMUe0En780ucQjmbvGmNjb4+S6FslIsT
         M23dGJYkhZyXXZRwwFx+tPyW9KBLnDwFisOq3QVYtYl5iZJpBCYtDbM/cXlCHMSlYO
         ZJymzd21WN4l3e+CjsSh9kfnBjzq98mMhWZdaXkjnVbQLQw3V0Gu0jcNGQ2/ncluTz
         kLU0YAwH58llrM+E2FPe9+QF14QePIXg7KXdmYmX4Q0af7Rn8pRNRt/Ipn6RVarhOT
         wREXPgv3jjgSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7A48E2A032;
        Fri, 31 Mar 2023 17:26:56 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0izUZ4eY9vhHQSw=to-ozRgVqX9uXw1G_qvA4PQEEGCJA@mail.gmail.com>
References: <CAJZ5v0izUZ4eY9vhHQSw=to-ozRgVqX9uXw1G_qvA4PQEEGCJA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0izUZ4eY9vhHQSw=to-ozRgVqX9uXw1G_qvA4PQEEGCJA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc5
X-PR-Tracked-Commit-Id: c56610a869bce03490faf4f157076370c71b8ae3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f964333194b877effae897314d89818347ed90d7
Message-Id: <168028361681.4567.15770590581406141591.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 17:26:56 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 12:15:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f964333194b877effae897314d89818347ed90d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
