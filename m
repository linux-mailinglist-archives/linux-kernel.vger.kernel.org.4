Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919546F4960
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjEBR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjEBR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2CEEE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32BD4627D1
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B905C4339C;
        Tue,  2 May 2023 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683050276;
        bh=oEsaPS1Iop2INZOFVmpG0YyEDzSHqyqGokAW8uxGYas=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BOclPZpnIUMPvcrsChyFWcHwKBDPRsvYxkF/jxYHU/GiGLspMkk4xG2ZsQL/aJdIS
         fBGzHAqIgVhoLFvI8IXDeEeCEF7CkaPhvuGOLYndr3r8ZL+opIHIS60i7efeXtjdDM
         Lj+xq6DU0dCvevxgOKQD8A87iNVs+bdFpKzQKnIy6CzJ0YSoO91lsJYPWmj2fRMx8e
         FbK9WzdPIqjtU1ZaK20vvrYmEkoykdipCjazTbPgUJYS+5upM2jJkqXdu5Gy4OOxYS
         dbE/s7Xn1tspeX6jUeTRVawZEY3+ILNWNjB2BmxbgmU+q7b94WlVF4KE5VC4sQKm7V
         8KgkL7Reh9HSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82793C3959E;
        Tue,  2 May 2023 17:57:56 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230502162524.GJ620451@google.com>
References: <20230502162524.GJ620451@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230502162524.GJ620451@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.4
X-PR-Tracked-Commit-Id: 8325642d2757eba80210dec727bb0bcffb837ff1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5eb8bf76718cf2e2f36aac216a99014f00927de
Message-Id: <168305027652.6897.6369049623724649560.pr-tracker-bot@kernel.org>
Date:   Tue, 02 May 2023 17:57:56 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 May 2023 17:25:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5eb8bf76718cf2e2f36aac216a99014f00927de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
