Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB2611E66
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJ1X51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJ1X5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003471C77DA;
        Fri, 28 Oct 2022 16:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F0262AF7;
        Fri, 28 Oct 2022 23:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43050C433D6;
        Fri, 28 Oct 2022 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667001443;
        bh=KsYuk4vSab1tim0O0Xj55qxhUwIRMGlontNk9l00ZV8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jD15AB7zFKzHGXVJORQc1zfReeJrs3hViDu/DgtIpXBumkS2znHLviC48uIVeMtLy
         E7PePFSXtlU87aZRHt49q4TkrW4M99qcJBOqJW4735csucmfgpRJGIPBTHAuaZ6ZfX
         q6XFxjY4R1nhP2flEoP81m5TS+TxtGil19WFfeClMpS3BB1bdszxKRdKeOTgIGbS/g
         PqDq+x+JpapyCHf8YOFDjYQMBzcnq9R5WUzeHbnXvO2arz791Rqm8/RbsQ2yK2UklJ
         VJysXI8aidLjuAqd5zKBJaJe4gGpenRjYlqkuW+qeAs1B91z/2UocvGwEzLrr98FC9
         Wh1Lcb/K4gx9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26D9AC4314C;
        Fri, 28 Oct 2022 23:57:23 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hT3gebDJdqjoODa_z+WgJqJBgusCg1j2P8Os4=mJ0G4g@mail.gmail.com>
References: <CAJZ5v0hT3gebDJdqjoODa_z+WgJqJBgusCg1j2P8Os4=mJ0G4g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hT3gebDJdqjoODa_z+WgJqJBgusCg1j2P8Os4=mJ0G4g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc3
X-PR-Tracked-Commit-Id: 6f257934ed6170ed0094149e0e1bac09f7997103
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b872a5ecece462ba02c8cad1c0203583631db2b
Message-Id: <166700144315.1674.3221315977917085505.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Oct 2022 23:57:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 17:17:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b872a5ecece462ba02c8cad1c0203583631db2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
