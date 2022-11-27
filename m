Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE268639BE8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK0ROr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK0ROp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C25DFC8;
        Sun, 27 Nov 2022 09:14:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF0260DE9;
        Sun, 27 Nov 2022 17:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A978EC433C1;
        Sun, 27 Nov 2022 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669569283;
        bh=eNWntHnxbLAV4gOOf2ZSjoUMjvCuwoALQIiJkyR8ZXY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Inn9+rgvd3iHwQH0MJDxY1GEoU8L6KQnFWrVlnMKGQpu9vNhv9Qo1bOa+NWqoWQCC
         QZxq854DT84Qv5avALn8OoWDBG1m1XfzcK6s92lEWEgOd1Ko68YI1PFEGVuQ/QzEbo
         h46hRCPfvaMgNVDxCH06t33DTc/GMKV0qEEVoS1qy14kMRLLU89Lxt1v9xD5slHzXf
         +1z7pwEDhcfFIkPkjxoWBVNJXYSMLTnJ5TbSBJMHAzYduuIad5de3ynw05Ah9CL2Ip
         j6JmjAdazcExx0u5Lpq5IrNl5203LCrtHsv7frov9KbVlQ/XXBmOmIzV6X2PexK1XN
         WQUXn0zJyw5Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96D4AE21EFD;
        Sun, 27 Nov 2022 17:14:43 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms=XKgJ0sWmYaCG+MY3RHv4vDdGO3VAZAQ=XQLzBW1dzA@mail.gmail.com>
References: <CAH2r5ms=XKgJ0sWmYaCG+MY3RHv4vDdGO3VAZAQ=XQLzBW1dzA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms=XKgJ0sWmYaCG+MY3RHv4vDdGO3VAZAQ=XQLzBW1dzA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc6-smb3-fixes
X-PR-Tracked-Commit-Id: 502487847743018c93d75b401eac2ea4c4973123
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30a853c1bdede177adedd2de537ea16158125181
Message-Id: <166956928361.3809.9583123688485858979.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Nov 2022 17:14:43 +0000
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

The pull request you sent on Sat, 26 Nov 2022 22:44:50 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc6-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30a853c1bdede177adedd2de537ea16158125181

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
