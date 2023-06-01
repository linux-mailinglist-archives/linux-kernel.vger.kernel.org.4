Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA2D71F47F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjFAVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjFAVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D73412C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE68615BA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C2EFC433D2;
        Thu,  1 Jun 2023 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685654127;
        bh=XwUZxA2r88Ndegyc0Q+TyBAqXcK18pa6UrozPoC0Y+I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XUSSdKuz86Glthrf75Fe7wygO1CsYn1Bw2FT3Cx/D7xHo3ZMJuM780RXz/A4uvVc7
         sn1kkm/1jI71fXd6EG3RqM9BIWgpmLX3xmDt8B4M3YVg7QUfe0SqsS4y+OWRiBDqnr
         ixQf+Jts7wFsVmFhbQk4eGOdpEKf2iHJyv0U6x/Mn7yTbEWC1JFyzlJEdRp/VNC4rf
         qlVlWDcxTroDJJVRHx8UEPHvLIqJ1lZzrKhSb7yKBtQko2HYB0Ch6iN0x20Ext9bn8
         qzjzJQ7mVMzcqFfGBCrbFmVNUY2BB2+Ko9J8gbKTeiglQt5fwcjZsgX1ino/Fb0Ws6
         Ps6vgTi0pxISQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 295DCC43162;
        Thu,  1 Jun 2023 21:15:27 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2306011224050.29760@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2306011224050.29760@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2306011224050.29760@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023060101
X-PR-Tracked-Commit-Id: 6199d23c91ce53bfed455f09a8c5ed170d516824
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f39dda98bc7c30c42a0c2c6a51ac726437524583
Message-Id: <168565412716.3839.14818905868795942932.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jun 2023 21:15:27 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Jun 2023 12:27:24 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023060101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f39dda98bc7c30c42a0c2c6a51ac726437524583

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
