Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A66C89F0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjCYBTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjCYBSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:18:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93611A97B;
        Fri, 24 Mar 2023 18:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87148B8265F;
        Sat, 25 Mar 2023 01:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 352DDC433D2;
        Sat, 25 Mar 2023 01:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679707125;
        bh=JkFBFDGfb+d/TW4oXbN4lHuDKzlmJoVsJnHZ6t+HV1I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FIIwgFgyiwYSglH0kmy4nJCzi9FlrBgHbD67kY1uqxMj8jyyTEFpGmGzb7U95vjbW
         2G4oDAitROuOSNDa3cCrz7/Rm2HQUDxl/jWiXvQFRKH5DzHJ5Nq/Y6lilKt03uVoRk
         tg6YNIYNZaTa3GHx6wlrY+18CR3esmmtNOvmVZg8bd5Jx3P2tQxvKeu53/AR7O0z1N
         Yq73SjzBtTyZfkbnxvIKoaSyR3Re2J1S/C5evZl9zek2TEqR6qBuWEPRjDP0bElC4h
         K3mhOu0E3fMGcsxvWta33WJ0e5pBlYcHqXoVDtdWxotFiCa+VFaIiGSCuxGgE7Nzyp
         H5CisX05ts2Fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22A47E43EFD;
        Sat, 25 Mar 2023 01:18:45 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muJC14LVd3LA2mhZH+zVkyuULm-KQXXxnP8J7LDe4y6bg@mail.gmail.com>
References: <CAH2r5muJC14LVd3LA2mhZH+zVkyuULm-KQXXxnP8J7LDe4y6bg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muJC14LVd3LA2mhZH+zVkyuULm-KQXXxnP8J7LDe4y6bg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.3-rc3-ksmbd-smb3-server-fixes
X-PR-Tracked-Commit-Id: 39b291b86b5988bf8753c3874d5c773399d09b96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90c8ce31dbe93f277fc1157e34740e841094c254
Message-Id: <167970712513.29265.15070897807211952356.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Mar 2023 01:18:45 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 19:00:44 -0500:

> git://git.samba.org/ksmbd.git tags/6.3-rc3-ksmbd-smb3-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90c8ce31dbe93f277fc1157e34740e841094c254

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
