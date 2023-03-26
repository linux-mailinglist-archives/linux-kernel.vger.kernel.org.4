Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AD6C96C6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjCZQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjCZQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:21:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8F46B4;
        Sun, 26 Mar 2023 09:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE5D9B80D18;
        Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C663C433D2;
        Sun, 26 Mar 2023 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679847666;
        bh=87Jqqd2Zakrfap8kZ4QWJpa+I+rjwOr42Q5q2iCwhzE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G9wxzJ/Q7QxJSty7XLHHj9+Ltrer5ALbcaAQUaN7rclYKQ7cZ73PEqRbY35XRSNKL
         SH6FwaaHGhpAkcTJAbysgFCvNL6wf48DMnIRPQkQFjFVt4laWreu4WvsW7kCQxVNf9
         zydOR2Yhk7iwVk+QuM2LPxrlta6OK2BO3kkjQRcdXy75UN7iBO65ZpWfpgjdqE+6/R
         VChBu4AerEnw+v2ctvtyZLhrCtQDhkrYpaCS7rAL4V4QfLkuCAh4BQohyQviYcR9MM
         vfeT2W6PdYrgUUUz2qqw4W4vKYoqhpNsFlSvTZN4iYRFXCE280ktUZ4URp2gegZiHg
         EGSI62jJkCa4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D14DC41671;
        Sun, 26 Mar 2023 16:21:06 +0000 (UTC)
Subject: Re: [GIT PULL] cifs/smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms5shbVGfACT5bXkp4Fo52GXoVHPVeNsRyRd4PAKHbaRw@mail.gmail.com>
References: <CAH2r5ms5shbVGfACT5bXkp4Fo52GXoVHPVeNsRyRd4PAKHbaRw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms5shbVGfACT5bXkp4Fo52GXoVHPVeNsRyRd4PAKHbaRw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/smb3-client-fixes-6.3-rc3
X-PR-Tracked-Commit-Id: 491eafce1a51c457701351a4bf40733799745314
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6485ac65af2b204e5150576d800c92d968c065b0
Message-Id: <167984766650.13454.10319864295721275457.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Mar 2023 16:21:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Mar 2023 21:02:14 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/smb3-client-fixes-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6485ac65af2b204e5150576d800c92d968c065b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
