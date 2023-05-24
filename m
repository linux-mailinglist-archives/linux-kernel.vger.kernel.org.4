Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BA70FE00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjEXSsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbjEXSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD27618D;
        Wed, 24 May 2023 11:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FC964030;
        Wed, 24 May 2023 18:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EF9FC433EF;
        Wed, 24 May 2023 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684954098;
        bh=lLxUlIJbJZVTuFd50SXGCjvUDQR4jSXbGVMVjkfHBtw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ic7ZcLQeszh2jogl9g5Brv5DDjgx4UhQ6GOhmEbXCcxWN6e45vaVjcvUlST2d4oGa
         Hb9bwF0F5UnJAo0zwv5qr5VDJ8UcyYSX+wwjXcoYKKyWtOJco/4EJb1Lo8R3w4z0SM
         sZo6uxlpWkRIN8rzMIQZVpR676wqWuNeImc1D93UiZAI/MOjPZ957wD3Xg1ES2cJVb
         4KudpOkYYE0lzYHRORVlYhMziKma/W1gFOQQEPTsp6bidpzpCDNVR0jij0/kpD6Lhf
         bcpBDwH/4/JIFIiZuZobpGSPQ2u83LozX2R/Rz/kroYuw3vA+WkV9eGl4rTkhENtXZ
         vPl49NU0u8N6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 471B6C395F8;
        Wed, 24 May 2023 18:48:18 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230524101329.ACD94C4339B@smtp.kernel.org>
References: <20230524101329.ACD94C4339B@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230524101329.ACD94C4339B@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc3
X-PR-Tracked-Commit-Id: 6afe2ae8dc48e643cb9f52e86494b96942440bc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 933174ae28ba72ab8de5b35cb7c98fc211235096
Message-Id: <168495409828.10364.16001112219753704548.pr-tracker-bot@kernel.org>
Date:   Wed, 24 May 2023 18:48:18 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 May 2023 11:13:17 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/933174ae28ba72ab8de5b35cb7c98fc211235096

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
