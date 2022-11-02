Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570EF616CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiKBSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiKBSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D86DA;
        Wed,  2 Nov 2022 11:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4694DB82435;
        Wed,  2 Nov 2022 18:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E71D2C4347C;
        Wed,  2 Nov 2022 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414298;
        bh=rYOl5OTHc/ivT6RQWAuAJy/bdcOtVRO69Iaa83V8BSY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G9QaxQfcDORa4WyUiEZ+2VnnTR7VI1fhSa8AthtYSjfJEE5tWMRTE2+0UwAxKulZ5
         fGnJvZZGuOGoEELPIre/Rr+aiIA5sEW5ueI7utbAHRcfHCyg73X9qpv98w/+5MfUYH
         dXxiyZSFIj+NEbOJwbEidxfLsvn3Ge+XnsgAisxSSvkJ0Q46qy4sCMQxg/UyH3386V
         0JfvXaXrDu6/IjnJNufhiBHTizfJxJ9EZ3NrT03km1MSxN+emp0EI3OFdk95ABsPN4
         uV4XTgJRG9Th4Bu4brcD/cZSfK9OGbfyLVl0zWGG5bKakRdgpoMJ7Q6D+cbTvoLgY7
         RyN2XK1lycQZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D11D2E270D2;
        Wed,  2 Nov 2022 18:38:18 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2KaFoe7n4lkr25c@p100>
References: <Y2KaFoe7n4lkr25c@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2KaFoe7n4lkr25c@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.1-2
X-PR-Tracked-Commit-Id: 2b6ae0962b421103feb41a80406732944b0665b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a
Message-Id: <166741429885.10915.18365223380630694529.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Nov 2022 18:38:18 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Nov 2022 17:26:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
