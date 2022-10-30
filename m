Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3FD612C48
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJ3SfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJ3Seu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40CE5FD8;
        Sun, 30 Oct 2022 11:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4139DB80E84;
        Sun, 30 Oct 2022 18:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9038C433C1;
        Sun, 30 Oct 2022 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667154886;
        bh=m2mi/pqT5CPtyJYiKpO2B/1Jr7o3gx7oAqt6o0MhILc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rbxSWLwi+zzjURhShc43BucSMpAwtHY+w/n+WWsOFsjxaFQsuRRU9j/c262D6ykcN
         TDv6OlwNwTOqQKJq2ES+zatDvLOixsvYtI6j/B9TfVKFe6o3je6OjoYN+WkDPbmD3I
         DhC7fZiE8BxafkUc5oQieG/73JOjHyIpl2+CBWjUOmSR77iqpK+zfPN2JX6LV6JQVR
         6bHzX0XRjPn4ixA/ZemHpGGVdZyxPjQRSRpAJIMeS/4W7I0JkmYurlCojX++3U/MzR
         Hdr0wxD/v/FgkV7CJEKrUWeFPzFgcYTLpgXVDnDz80ylSuELys5k6n6a1Wcwyzygzd
         E6Sby3/NtZ7fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7585C41670;
        Sun, 30 Oct 2022 18:34:46 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu1Ha1DUq8T77hf-_2njaNLUKPa=yqkZurEtzFGrEoCVg@mail.gmail.com>
References: <CAH2r5mu1Ha1DUq8T77hf-_2njaNLUKPa=yqkZurEtzFGrEoCVg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu1Ha1DUq8T77hf-_2njaNLUKPa=yqkZurEtzFGrEoCVg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc2-smb3-fixes
X-PR-Tracked-Commit-Id: 153695d36ead0ccc4d0256953c751cabf673e621
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28b7bd4ad25f7dc662a84636a619e61c97ac0e06
Message-Id: <166715488681.31922.324425096003661009.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 18:34:46 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Zeng Heng <zengheng4@huawei.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Oct 2022 21:40:29 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc2-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28b7bd4ad25f7dc662a84636a619e61c97ac0e06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
