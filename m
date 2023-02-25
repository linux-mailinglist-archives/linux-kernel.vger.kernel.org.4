Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7FC6A2C91
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBYXWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 18:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjBYXWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 18:22:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154AF168A4;
        Sat, 25 Feb 2023 15:22:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4C8E4CE0CF9;
        Sat, 25 Feb 2023 23:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BDA8C433D2;
        Sat, 25 Feb 2023 23:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677367337;
        bh=vX+kEKbX2qHJtUk0O7jFcyhvB+G2TgHnLofmiPwtXaE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lsZo8FVXcL0IDBjYUWAX6OGsHgSfr9Zq5Xuqz1wqknjUwtTiaBUIoPkOGRSM+wDdU
         Fi0gwAf93W3GZyyykOdsIFmkSyc2F3xx73C+GMMtQ3hw8+aAZ3rBr7kpSsBbU93t8l
         O6GzLPfPhHv0P55chWNpYwxF12pOWJZB6I7mcRFRhkWG4HgoblXIkUMSetcMeSYHwY
         iCasmHd+T/ylG5tGpQVGiLQgc7WaIaUcMKGAt54+YIscGMdrit/yFNVaUCx1OY1QV3
         NT3DzmqP1TadhWQKP2b8gtqCxp4ztGjVoWd3YGRVoTgTHO3bc6I37ReDVEYUzZaRjL
         YIvlGhlYPvxBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 879D2E68D34;
        Sat, 25 Feb 2023 23:22:17 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.3-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/hc1bPMmOlD+vW2@google.com>
References: <Y/hc1bPMmOlD+vW2@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/hc1bPMmOlD+vW2@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc0
X-PR-Tracked-Commit-Id: 7ae9fb1b7ecbb5d85d07857943f677fd1a559b18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60e2bf7d10e9cd5641f4a5183a19058d9a2c8782
Message-Id: <167736733754.9412.1249316629314100017.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 23:22:17 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Feb 2023 22:44:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60e2bf7d10e9cd5641f4a5183a19058d9a2c8782

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
