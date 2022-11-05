Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F124061DDA1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKETMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKETMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4EE9FFB;
        Sat,  5 Nov 2022 12:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA84B60B8F;
        Sat,  5 Nov 2022 19:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BB05C433D7;
        Sat,  5 Nov 2022 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667675551;
        bh=csWwHWOG8YOAUIL6Y65mXfEtlcOSu0VIuwxf+2T+/uw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=INj0LfyH4c6Cs+GNKtRfY9n9a2XGWs6zTW0Y6N4zM7VNsIMFq7dkqgcbPFva31Pua
         RhJQxEcN4cCqRyd2A8R3D8U0E32mPxJRb+IvPwoTDXpz6a0uFSZ0cMtheknK7AYCNJ
         gKZsCg7431ZvptsA7R3YqqYR13lrWPWQVNF9QejNevPd4toO6ytajUvya98imuYIIf
         0mKTlD+UD+WLZd37ZBvqOZsx1PIF6ybNrE5+vVzXmXCYM8U1Au4U1N/UFh4BxLk6e/
         Czfa5D+Lcd0s2+Xsuqg46TWp2MZssYXh4FmMSDOt7JoFAjOV7DuMMI1zhMCnJ7kFOf
         5a8oL80FdypSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DB38E270DD;
        Sat,  5 Nov 2022 19:12:31 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iw2J0yVP_2hZWac24bDAjkGdLyCrLCqOsM4u62oGfvgA@mail.gmail.com>
References: <CAJZ5v0iw2J0yVP_2hZWac24bDAjkGdLyCrLCqOsM4u62oGfvgA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iw2J0yVP_2hZWac24bDAjkGdLyCrLCqOsM4u62oGfvgA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc4
X-PR-Tracked-Commit-Id: 6faf4ce500d658bcf4d1fe6fe5de2d4d50366e25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f5065a0bc9d0afb45f2ae284bd525d55ce82c33
Message-Id: <166767555104.22141.14236226192195739401.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Nov 2022 19:12:31 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Nov 2022 20:09:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f5065a0bc9d0afb45f2ae284bd525d55ce82c33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
