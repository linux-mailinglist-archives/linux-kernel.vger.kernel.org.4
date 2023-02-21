Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E769E90B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBUUjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjBUUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:39:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F399302B0;
        Tue, 21 Feb 2023 12:39:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D45A6B810C6;
        Tue, 21 Feb 2023 20:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82B31C4339E;
        Tue, 21 Feb 2023 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677011940;
        bh=QNtiWG7LnZ/oZkA84pBoLudNRf596An+hPKcjDTqEII=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jLFiVIXL/VC1j80R0fu9sbXFpQN+FBFL+iyNccVIy6WKn4iGiwRS/LH7drgN1x3xq
         Cw1cl+lKTaMmJO2Q3zdoVLFgXaCf7Hf4vvnrqxA1fR9DlTUlAhpxb1ZBHVBZSOJp9d
         i4i8IAw758YodgVexJyvQbbefhTaqL7XiclxMpFAwHEonft9EATL42lUhXg/64fMxG
         yKl2AZEkSRhog6u+/cuwguMKIw3P1u/j61cHmI7ABpB3fUVB5Vqn30dbl26Q9ynZiZ
         nf64CwiklM3hwwnhg3gECGnP+Hv6zqrX/perLlk97DyLI+FErnYo1Xsc9/wGCUKqxO
         +Itl8aErRFCeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63EEDC43151;
        Tue, 21 Feb 2023 20:39:00 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jXnjq+zRcsvUfuS=-5brPEdXw-BrFvkD8jR7kQ_ob_ww@mail.gmail.com>
References: <CAJZ5v0jXnjq+zRcsvUfuS=-5brPEdXw-BrFvkD8jR7kQ_ob_ww@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jXnjq+zRcsvUfuS=-5brPEdXw-BrFvkD8jR7kQ_ob_ww@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc1
X-PR-Tracked-Commit-Id: 6828e402d06f7c574430b61c05db784cd847b19f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b72607d7321e66829e11148712b3a2ba1dc83e7
Message-Id: <167701194040.12980.17324492209369764610.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 20:39:00 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 14:45:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b72607d7321e66829e11148712b3a2ba1dc83e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
