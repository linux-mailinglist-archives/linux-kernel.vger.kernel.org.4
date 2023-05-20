Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE970AA81
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjETSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjETSdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2DA171E;
        Sat, 20 May 2023 11:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC0ED616DA;
        Sat, 20 May 2023 18:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 392A3C433D2;
        Sat, 20 May 2023 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607498;
        bh=X2VGAPCVLCsc6/NzhzGn215Og+8S4PHUAyLBQgeh6rg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SQxFnCMTRIFMl2jHFKChsQkxaHB5whuykjYiAyX1yqWBU3zjSEsRzDxy7sASFDwlw
         0elCmQmPAbch11hosz8TvrzlGvl3c3GnPaFY24anwU/ZirJsnyMRPEJXTXUGmxu1iZ
         kak1eC9qtXGjd2TX/oC7R3Xy+4zAbdV3LOXsk44VX9ARAXLzgEgp0HMiMcouN30v4e
         4wh7uB5TXR+S44sZt6gxhDpu9FyJ3fHumnHzxcaxue/ow2g7Rh6S0mAVVT58G6HioW
         +SoD/vtYbqEkuh6cJzl4nfRiWyAjuebOo3I2d0hdviT99PKGS/SdxVInESd0a3ikY7
         bDN1INMJX6ECg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 270DBC73FE0;
        Sat, 20 May 2023 18:31:38 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZGj-S_GkMqxVBlDe@kroah.com>
References: <ZGj-S_GkMqxVBlDe@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZGj-S_GkMqxVBlDe@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc3
X-PR-Tracked-Commit-Id: 8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dd2a6fb1e34d6dcb96806bc6b111388ad324722
Message-Id: <168460749815.29791.4858353528788159525.pr-tracker-bot@kernel.org>
Date:   Sat, 20 May 2023 18:31:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 May 2023 18:07:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dd2a6fb1e34d6dcb96806bc6b111388ad324722

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
