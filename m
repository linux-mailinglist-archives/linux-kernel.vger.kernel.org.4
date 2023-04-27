Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5137F6F0C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbjD0TUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245127AbjD0TUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3A4EDD;
        Thu, 27 Apr 2023 12:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CDFA63F5B;
        Thu, 27 Apr 2023 19:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9D5BC4339E;
        Thu, 27 Apr 2023 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623205;
        bh=LIl2nhifBwQRIHAMBr6SJptmW/yP19KhfyzCbp7hDfw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pwNlcm4odUBFpQP4UKQsZG0Ouwj2/SKkvLdGL39qCY2BLqgzhM5oyt2bGRdcq4GbO
         Bvfwx+TYesvVvB6A0kdYSR8/UAzLSii2lb3j6nQtT2VFUGOxf+o0AVKC/0bBrKOxy+
         ib7fTvc1rVTnx74pWVteqgucp0DwUqCAS3zBd1s+d0iqbNEfzjtG/B/GNXEpD5sZMp
         FuxAyBumx6S1SkNZeO2oXOvGcXaC6bbplDFYNRN0hYTtnQvKr2xIL5Czii3Ws8FxPd
         NzsHi55Cr7NARonwgN9ZDxPbZP81NqMELCxaOAn2J30etuW5nW3SjCcsu5ihtw4aow
         c2rf0rxeftiAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93674C43158;
        Thu, 27 Apr 2023 19:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230426122801.5B1D0C433EF@smtp.kernel.org>
References: <20230426122801.5B1D0C433EF@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230426122801.5B1D0C433EF@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.4
X-PR-Tracked-Commit-Id: cc5f6fa4f6590e3b9eb8d34302ea43af4a3cfed7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc2e58b8b7c94b8fe23977775550de00472f6a74
Message-Id: <168262320559.21394.9091039543608025583.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 13:27:51 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc2e58b8b7c94b8fe23977775550de00472f6a74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
