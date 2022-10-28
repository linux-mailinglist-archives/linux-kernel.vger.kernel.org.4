Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB6611C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJ1VLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJ1VKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:10:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC58E73D;
        Fri, 28 Oct 2022 14:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E436FB82CC0;
        Fri, 28 Oct 2022 21:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A481C43141;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666991449;
        bh=yOR04xL5t+Exjfy5tJZMEyWkMcBCjXqLnRCmu0vEGNg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=luYgVURTDRofgY/EMU+zJPQR8ZZGe/0mU3wbF79KLdQsvTc/xYuSFr9NWpd54H0A0
         MCvD2BQTSLXlzLk83TFaWwddmV5KlRLdlGMtM90BSCmEw38GX0g7yavqN9x2SpqGek
         1ymv5fX0MUpmqc+3nbf/mOOeiiSXUcy/lbIKc9is8s4gik5bSuWG4bBJuchi18aZ7D
         SAjEVC4NghfUiAWfrbi/sQ40BecoVWFQIk3g3v4N1NE3Fm440ZbxgO+WPA4MVvrog9
         vYJryDK2DhCVThzFs6FUi7I8CzHjmX+Ol421dMlZN7/of60K2wPPJB7/C74VXAjV6I
         wTj4OI3Q0WwUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88E23C41676;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
Subject: Re: [GIT PULL] RTC fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y1v99D722uI1nu1M@mail.local>
References: <Y1v99D722uI1nu1M@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1v99D722uI1nu1M@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.1-fixes
X-PR-Tracked-Commit-Id: db4e955ae333567dea02822624106c0b96a2f84f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd7e2a25863d3a8104dc1e414b2d49e2418e250c
Message-Id: <166699144955.13387.3137724697178045369.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Oct 2022 21:10:49 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 18:06:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd7e2a25863d3a8104dc1e414b2d49e2418e250c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
