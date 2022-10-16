Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2A6002CD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJPSSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJPSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4AB45F62;
        Sun, 16 Oct 2022 11:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C053860DB9;
        Sun, 16 Oct 2022 18:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F669C433C1;
        Sun, 16 Oct 2022 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665944330;
        bh=dPCZkyY2kZfHHrgWdQUXCc+K1FpEJBieGor3sHYxmZA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T1fgwMFIfqe7e5iKp1ykJvlLyPBwEL7KPeu4FJr1BxTHkXLFKBTvqE4M1oukcoOxM
         Lkfm3eqBhNJvif0MdsGsdhn7J6r+KyUlXc38PmfPG2gCQcRM3ijnzk0vCvKDj76+qX
         BqOd7jVgE0bAuiDuCw6lG4sf1PjSei9SY+oXvuYi2a2bhca5+YGoKsykudAiMknowH
         1Zy5Hch3Ri4AMsHh29XFWiqdCEFVNpfgPPmyHfw2j3S5r/KtUcY/McUKwpxSBfWDKH
         lz5YkHKrgO4KjDZElA0KHieYlzmCPOpxsTZ2cZaNqp9fJCHw+HCa6PMu3LGmrtjF9X
         C2VNcZ/4VB9Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CACBE270EE;
        Sun, 16 Oct 2022 18:18:50 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu+WTsmhrmJpGWqj4Wn9J2TQnEaqZv+pHLsLd91g=8wdA@mail.gmail.com>
References: <CAH2r5mu+WTsmhrmJpGWqj4Wn9J2TQnEaqZv+pHLsLd91g=8wdA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu+WTsmhrmJpGWqj4Wn9J2TQnEaqZv+pHLsLd91g=8wdA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: e3e9463414f610e91528f2b920b8cb655f4bae33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b08cd74448fafaa302ce2bc11beab5e5a55d0065
Message-Id: <166594433009.2997.11932594239257071601.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Oct 2022 18:18:50 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Oct 2022 19:33:08 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b08cd74448fafaa302ce2bc11beab5e5a55d0065

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
