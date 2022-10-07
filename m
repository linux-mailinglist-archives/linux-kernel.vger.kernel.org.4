Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15485F8146
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 01:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJGXiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 19:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiJGXhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:37:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628FC9DDAC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDDECB8247F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 23:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0E60C43141;
        Fri,  7 Oct 2022 23:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665185870;
        bh=41fS9pWQOKMlkykLG0e7SABBR3L0m/UB6iiRKM9sbrE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AmFDgZi0Pqr0L7P3FFRUcSk5v4OqCj8LoPps6lVdZNw+IVgS3r8NW2YIhdcwTV4rL
         U0RwUOTpS+h8wjlGOA7NnEpLH56bFmF09ic10Fq+nXrR1/0jXmfLipnqLaPdSblxV9
         7beKo0ZbovukwMLCSO+VQWpNbkZ8J1+QoGWr1VP4RDK6cIDQRrf//DsO7ufvyZ5pBz
         qw4DfeJGGVOWvlIuplyZTXMQsVzwwEQL8SwsCcq21/+lJJ21vRgL9WbuYCe88nuYMO
         7kn3m5vVEuh8E5O79SC8g+QivU8wijCiGwHFOUlId7tYF2ah/xLEyAUvYVnWr2tAr2
         B1WjzTdh3FRDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D656E43EFB;
        Fri,  7 Oct 2022 23:37:50 +0000 (UTC)
Subject: Re: [GIT PULL]: SoundWire subsystem updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0AnSpbH3B9U0H8I@matsya>
References: <Y0AnSpbH3B9U0H8I@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0AnSpbH3B9U0H8I@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.1-rc1
X-PR-Tracked-Commit-Id: 503ae285944a5e99ad3e0c36852ffe2680288418
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 881eccbef52563feb4fde0d19d375884798783f7
Message-Id: <166518587064.18327.8803938563174079745.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 23:37:50 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 18:49:06 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/881eccbef52563feb4fde0d19d375884798783f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
