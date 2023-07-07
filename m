Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2374A8FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGGC1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjGGC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE71FD8;
        Thu,  6 Jul 2023 19:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75BED614F6;
        Fri,  7 Jul 2023 02:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9103C433C8;
        Fri,  7 Jul 2023 02:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688696865;
        bh=qAINlI8aMVcSE33oZflWbJOaHcnjsrDGkMis0TSWGLI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hQtGy2IOVFNhevC8zS9W/HsB1pRVKuKxYs7mGiuJ7SuVIf22f8y1mH1iMykEezEDP
         hEJomJXLG6feNhfc+hHcF40IqapL5JNEfbRTyCrGiQJSu/al7RJB9urZy6hiDIiGih
         /kaQp3JMalkgH/DEEjCjEkGPAcklWdoDjvIe6w+kud0pYEYCiNhFOSj++Rakq5IX4+
         7STvlEZT7uPoeLpSDKsrD+xUhceFSygKCVeIprHYpWr1WJuOA4Mp1eYeyqLXKWTKJ/
         1eeRtqur92i/lSK4XaxM8xiDSrUI1PdQQtuRkduUUTCwQB/2wpwA7+6/S22ThkRuHf
         jffSUo89qRGWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC3B2C73FE1;
        Fri,  7 Jul 2023 02:27:45 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.5-merge-window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230706144126.DFF70C433C8@smtp.kernel.org>
References: <20230706144126.DFF70C433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230706144126.DFF70C433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-merge-window
X-PR-Tracked-Commit-Id: 879a879c216a41f5403d8d3dbc204a48501912bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1793eac148d0136f9afe877766b9d8f4458fbf21
Message-Id: <168869686576.32373.10926827550661333360.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 02:27:45 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Jul 2023 15:41:15 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1793eac148d0136f9afe877766b9d8f4458fbf21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
