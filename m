Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC16161A320
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKDVR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKDVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:17:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53911C16
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C1D46163B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 21:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CE94C433C1;
        Fri,  4 Nov 2022 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667596666;
        bh=fnk5t4Yuj75KWDEUfyMXDF8Aw8hOS9widc+P/CP1qSA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C8WUiXgCCvUsH/EXcrIhTeK4WJzplTY17Gq/WafAtXsovJeAElhalPd8u0m98NQza
         CXZPfGgUYN3sL2PIz6ND+goDVmFvxqMJUlOmhl8Zi+KVTrogrJnZz4PGAzC010XXc7
         6C3Uxul2ur0Qlng7yajB92sf7ExlZ7Ztef7yx7AtTBCigY/F+kqTHTlWj1Ho1Uc7em
         jVG7scPiZeLDUFqyqJf1OTvOjPE9xBWnpUHZmSkEk0gGIgTwYTOlNTWLyNoORoOIF6
         pazETlU7Shbr1n2Ve8Re8vXfBQGD4NMbW0kkjCzpZ5sWoptkqbLKOS/vXBR3F7WCCS
         XBiOQi4GKY/wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0554E270FB;
        Fri,  4 Nov 2022 21:17:45 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty0XRutgBy8fg13q-h-jm3uKQ+x1XyoT_6UcT5i+5uN9A@mail.gmail.com>
References: <CAPM=9ty0XRutgBy8fg13q-h-jm3uKQ+x1XyoT_6UcT5i+5uN9A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty0XRutgBy8fg13q-h-jm3uKQ+x1XyoT_6UcT5i+5uN9A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-04-1
X-PR-Tracked-Commit-Id: 6295f1d8b4503ad8a18519b781dd2d1fe5e88c52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fde25beb382b7dd6f2eab8022ab017cbdfaa3ff6
Message-Id: <166759666598.9521.9955542501930086653.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Nov 2022 21:17:45 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Nov 2022 13:21:02 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-04-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fde25beb382b7dd6f2eab8022ab017cbdfaa3ff6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
