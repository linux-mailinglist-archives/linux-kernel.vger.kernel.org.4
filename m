Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6150267F02F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjA0VOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjA0VOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:14:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13FB783C7;
        Fri, 27 Jan 2023 13:14:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C7B661DB6;
        Fri, 27 Jan 2023 21:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF7B2C433D2;
        Fri, 27 Jan 2023 21:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674854074;
        bh=zcC1UiK64oYAreeaBjKYVmkULRYajGgkdLY36bK4mDQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lh/4WXE/lejtRrP8TysNZAOPDjFXo0nqZjAEIbxv8Bsh19PctiPlS3+hug06EgIkX
         apNIbWMYNbyD9CcEU12Uqd1G87pPZ6NvJNAViC8SHbyvNlf4yrmHocusBcipKlhS8a
         9MoNGiSfYcGlMQMGFBpV3ePX3ndrwLf9aoQtuQZ5CbvnBLCPPP6cdr/eSI3GGBi+BD
         6vlhTJpCV4u8jENCtCHGHZyvnfYis/EKMww1hYpxfDDS0rgmmteUlu9VQLWk1fFo3/
         ORjJjhuDRO0cDwELSOhapeCjqJOtPTMhrc5UspbGSeDOxsP1FX2ArBNmDwmPhX9b/b
         NrcqpoQaBW8Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92565F83ECF;
        Fri, 27 Jan 2023 21:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gPyShdVDECk=h6ouiqa5AsgV7sqvFC=DzJ3dhS_cw-Jw@mail.gmail.com>
References: <CAJZ5v0gPyShdVDECk=h6ouiqa5AsgV7sqvFC=DzJ3dhS_cw-Jw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gPyShdVDECk=h6ouiqa5AsgV7sqvFC=DzJ3dhS_cw-Jw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc6
X-PR-Tracked-Commit-Id: e6b3086fddc0065a5ffb947d4d29dd0e6efc327b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04ad927cacc678371ea9b187cd7e6eb71894b422
Message-Id: <167485407459.14056.10441401114915094553.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:14:34 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Jan 2023 15:48:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04ad927cacc678371ea9b187cd7e6eb71894b422

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
