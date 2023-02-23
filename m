Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322CC6A008F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjBWBXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjBWBX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:23:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1718E3A7;
        Wed, 22 Feb 2023 17:23:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E712615C7;
        Thu, 23 Feb 2023 01:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DF53C433D2;
        Thu, 23 Feb 2023 01:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677115400;
        bh=yKPk1vHtmhmxOsXv3YtvI0pBPVdSB5Ea9mv+wCUyb+k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BeUB8jBFvtW3Zqk+BMzzcvFFGOgKqOvjno1XWwk78PSlB4lNIOmr1acd3jw0LqDK4
         8XuyGv7e3etIpYSwIXb39NO3KmoSBR4G1QuBEx1/HiwU3KHY0ZmJXwImB5Jk3AlLHi
         yY0nSvvKK8Mtu4tZMiV42JF5b3onO5TPEUyCQxOiHAAOyX8Ue03v2LOeu7NoGMHi7u
         Jog8lBDWu8TR1bh91HYFt+VL88Bktn4KJsEt1VGijAwWkPQYVvyNJQu1XWT1/JB/O0
         lKaBgXEx56v+6vTMJBh0dlx8JjXjRWyaw60eFtL+BVUYvSPzmoBDQT8o5Ow4C96lu9
         tAJmX9hPSag5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85C13C43151;
        Thu, 23 Feb 2023 01:23:20 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muxu2YppXOLhwJ7hHjhaUZmEUHyc7O8GKekNnH44nd1EA@mail.gmail.com>
References: <CAH2r5muxu2YppXOLhwJ7hHjhaUZmEUHyc7O8GKekNnH44nd1EA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muxu2YppXOLhwJ7hHjhaUZmEUHyc7O8GKekNnH44nd1EA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc-smb3-client-fixes
X-PR-Tracked-Commit-Id: fdbf807215250217c83f1cb715b883cd910102fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 307e14c039063f0c9bd7a18a7add8f940580dcc9
Message-Id: <167711540053.11664.10409196972256547768.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 01:23:20 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 18:02:29 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/307e14c039063f0c9bd7a18a7add8f940580dcc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
