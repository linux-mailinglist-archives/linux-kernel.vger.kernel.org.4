Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3986C892C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjCXXSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjCXXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:18:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082911D915;
        Fri, 24 Mar 2023 16:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9902BB82663;
        Fri, 24 Mar 2023 23:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61966C433EF;
        Fri, 24 Mar 2023 23:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679699876;
        bh=1Zvdux/QAftwlxOEVsod7xn+BWbAOGVrFQ37m8wQpz4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tw+EAz7a0dbPIwPlZdmjMsyiVaT8E3FERV+D42kdxkJNIB2BEnr+Z6aMXcrc2SpP/
         m25ClCqNlQ1Y1cfROx+xIHScrbp7UUKzzSGAkqfQKUbNWA90fwoFadX+6r2dSmJHwQ
         2C1UVvWuzk0K6uOYKuGuFe+bd9na/mAiN14SDCrE3nl5kdfhhJtlcVyzuzhJ1xYetl
         a9BjwrjlcUIIW16G9Ma4GxVAMU2SwzYEHf0NJ/d5ofxAqTkMPKAA6i8eELWxqZQvsK
         Aqmys7aO7xdG4EY7E2KWVHsOfvzXP9pazW6bGZ0Rgumk0lZ04DPQ/UOhzZjs/EMLQF
         Hpm8dC0vI7XEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 478BAC41612;
        Fri, 24 Mar 2023 23:17:56 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.3-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230324212033.empobvkrgug5l3x6@mercury.elektranox.org>
References: <20230324212033.empobvkrgug5l3x6@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230324212033.empobvkrgug5l3x6@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.3-rc
X-PR-Tracked-Commit-Id: 06615d11cc78162dfd5116efb71f29eb29502d37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7b5c942f0752894a91a925c7249116333d4ab25
Message-Id: <167969987628.13977.15985610689581515486.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 23:17:56 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 22:20:33 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.3-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7b5c942f0752894a91a925c7249116333d4ab25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
