Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5726390D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKYUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiKYUsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:48:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F22E9E4;
        Fri, 25 Nov 2022 12:48:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DC48B82C1A;
        Fri, 25 Nov 2022 20:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF9A3C433D7;
        Fri, 25 Nov 2022 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669409314;
        bh=nV/0zMx9ZPG2GlgoG5mn8LcuJykPbtK2t6NT7FRDnPo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=soH+nPv1EtysSqce11d/KhsJHiba7QllfwBH41M7/Plk1WTjIOAzTS5WwQkid6jTf
         EkIg6ryUmZmRXa5a+f4fniV5JV/WgfEguhO22n3mTCUhNfaoth3dsu0aHL7gHR//gy
         +YzPM0oRAQWLMApCxsnHMqBuh7TIV7jtsnOAlumfA9dRlr8zx9nsPy5DPMFGzsQKmF
         IHDQP11bEI8jo84smr6J3dODRAdsrmXalHUhNp9BHc4gPXBqZB0nCwYt2K9ZVy/kk/
         afsBabTJxdgL2Lx/t/IVsRjZDo/QTneP/potEnQ/QIrbAWrNZF5Aq1BdND2/YzE3a/
         UXYVsr+im7+KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3D5DC395EC;
        Fri, 25 Nov 2022 20:48:34 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ifxCo1ZLw8OqUMbnJHQLxP7dKjnxzN1wpogmt+dpm_=Q@mail.gmail.com>
References: <CAJZ5v0ifxCo1ZLw8OqUMbnJHQLxP7dKjnxzN1wpogmt+dpm_=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ifxCo1ZLw8OqUMbnJHQLxP7dKjnxzN1wpogmt+dpm_=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc7
X-PR-Tracked-Commit-Id: 1056d314709d0607a22e589c54b1e47e0da57b9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88817acb8b75fe533fb5dfb6234a4e2104465e53
Message-Id: <166940931479.23524.4705958189760763521.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Nov 2022 20:48:34 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

The pull request you sent on Fri, 25 Nov 2022 18:42:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88817acb8b75fe533fb5dfb6234a4e2104465e53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
