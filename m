Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1467474AAC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjGGFvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjGGFvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1311BE9;
        Thu,  6 Jul 2023 22:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1220B6173D;
        Fri,  7 Jul 2023 05:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7327AC433C7;
        Fri,  7 Jul 2023 05:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688709070;
        bh=11k1vnbA1cPrCfQynh805r6zSDzqNrptwJ3lrUnq7lc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K9C7+Im8tmVzCJugSnK/Tj8/5xZnFv52WgnEysCFbRJPU0hFGBdoqTHVX5nqctW/J
         b1CUQB0D4ypkh2n3ShQJraz7Sz0+lVSJvQqOm2NRyPdcZH65X3mFJm4uPIu9d3Q1/+
         v1kCMvJTFSp4IBYYJ7Fmg1WRRg+c8zfKmhYAqihbuFiZpBAUecpPJTHg4dhFXpVjg1
         TMusn5sL5CgUi6Ib/OC9/XRWdlTFa7EujKLtMcLMfmpA8SQRTa/IHT5paLXIGit/kz
         g194DOCEjj0JrNrRBDz9+VT6dZ/QTfUY2mcgdry0UvWD7EPYL2PzZYAgy+4wcMP/8G
         Ulu2O3vWiGOfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54E32C4167B;
        Fri,  7 Jul 2023 05:51:10 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hN3FW_wgM_GP6oqLZe=9=aNmHE3_rWnzoAFrgcHXYA+Q@mail.gmail.com>
References: <CAJZ5v0hN3FW_wgM_GP6oqLZe=9=aNmHE3_rWnzoAFrgcHXYA+Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hN3FW_wgM_GP6oqLZe=9=aNmHE3_rWnzoAFrgcHXYA+Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc1-3
X-PR-Tracked-Commit-Id: 2e178ee13b02d95c7380f6a21149de535ccdfc7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94e0d43e51ff8577ad273032bb1cacfd68e9297b
Message-Id: <168870907034.5711.11444793123262678993.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 05:51:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jul 2023 19:48:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94e0d43e51ff8577ad273032bb1cacfd68e9297b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
