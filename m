Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE75FAB56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJKDni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJKDnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C37F138;
        Mon, 10 Oct 2022 20:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E26610A2;
        Tue, 11 Oct 2022 03:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D69DC43140;
        Tue, 11 Oct 2022 03:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665459794;
        bh=l0uMiKxbh2cBe9j9ye2ttSVW7T5Xp18cA/LM7MxTh0k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=saCRDHPvxhl+SIAcYE2Ao3R0dDTJ9DxwqVdPNO8ucBMzKWRJT6UwGCS5RkfEvYhqx
         F8azxWXiqkvfA9nI7H7Dw4qAbR1nDXjSC86Q0pzEvsKcZI3sU4hl47DQ6P+vWfb3cT
         /Z2xuBLh/5Lhkl3MHxm5VvTgxICl22vglvoUjc/6Aa/OyWn3z9oCuXdIDMAyrIFqRK
         LlGyopFZISyrhE7T5C2gS2dXL0tvDbk7ivvqzGupZ4JWSnXtcsDRkyEAAIpaBDEQTg
         GIn+XI9s8iJnU3mHOayVRVfcD2myEy6wD8pGPsCwAZ21diu4VSMQCp3RS6b76spvBL
         xeiQzPgaUKA1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A177E29F34;
        Tue, 11 Oct 2022 03:43:14 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muHt_9eBuE7GOHNvV+9zHH8X=+sVmK3Qj1R8uEWNydn_Q@mail.gmail.com>
References: <CAH2r5muHt_9eBuE7GOHNvV+9zHH8X=+sVmK3Qj1R8uEWNydn_Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muHt_9eBuE7GOHNvV+9zHH8X=+sVmK3Qj1R8uEWNydn_Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc-smb3-client-fixes-part1
X-PR-Tracked-Commit-Id: 958553d13478ad0e35fa09fecad3ce73277ccaf5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac1e8c6c95bf805c699656046aef0a05205edfbd
Message-Id: <166545979436.4678.13983540243723521763.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 03:43:14 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Oct 2022 00:50:33 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc-smb3-client-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac1e8c6c95bf805c699656046aef0a05205edfbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
