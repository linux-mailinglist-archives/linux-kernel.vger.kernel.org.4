Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B430721180
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjFCSNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFCSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054091;
        Sat,  3 Jun 2023 11:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CA1060F7B;
        Sat,  3 Jun 2023 18:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC93EC4339B;
        Sat,  3 Jun 2023 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685815986;
        bh=2KbRT46jBbizlnDPvO1EieJ2IxOuqG+1VNqTJdllc0o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pa0xulaPACXZLCgeIkCAFFX+3GJI5+idHPBEfyKL55L+b4RDRJAYzv07BNADkESfn
         ZpkLCrR7KeCNVZF4KZuCjJnekSskXDM+OqaL/w+oR0DFVZbVBdwZjk9+nCQWoOFll1
         8D7rrOAYoHTL0LK8O+BhK5JWtcIV9f8BuXQOdLuNfuueGm7OEZl0u12j/2rrjVcJFO
         ZU+o264B/zwXSH2f5u0ZanW/NgpPxh6omoDC07gfIUb8W7k7huUwz2w3RfzyKwh0xU
         Vd2Rnenmo2//17y4hBxbeKqgOdIC16Em6kSvNyXx2ZOZzUXkNK/rHBVSnRrvXHjiQM
         BZKEsL5Rp+8Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB68BE52BF3;
        Sat,  3 Jun 2023 18:13:06 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHte5sPkB6-D-94G@hovoldconsulting.com>
References: <ZHte5sPkB6-D-94G@hovoldconsulting.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHte5sPkB6-D-94G@hovoldconsulting.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/johan/linux.git tags/leds-6.4-rc5
X-PR-Tracked-Commit-Id: b05d39466ba111fc3775d5d46180b73c34ebe8f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1b65edf4d1e6506349196a2f665185eeca2a114
Message-Id: <168581598667.28460.4020286528227174469.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Jun 2023 18:13:06 +0000
To:     Johan Hovold <johan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Jun 2023 17:40:22 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/johan/linux.git tags/leds-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1b65edf4d1e6506349196a2f665185eeca2a114

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
