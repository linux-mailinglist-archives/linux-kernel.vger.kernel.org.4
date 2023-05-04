Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB716F632B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjEDDNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEDDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807F107;
        Wed,  3 May 2023 20:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C33761142;
        Thu,  4 May 2023 03:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E06DFC433D2;
        Thu,  4 May 2023 03:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683170008;
        bh=4fzGFUbk2IxyPs28j1fiZXOG5k6nDVG5tTY8Mi72EuE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MwDc2ycPv2+Af97IALXrpnkooInfwhFRzK4/JOlafdTnSNmkBh4AFdpCPWdAgGkR3
         WlNAxNz/yZWYDa4bskczLIFB2U31cVLdkle1GNxAx3zW4uCQTYtfbQOcgIGbGMZpCn
         M36KZj1DmonR1bqJSd4bDAukNRpAln7NUhNoF1JxdWsHWDl5I32QT9a0z+1IQbuqOt
         uS5rhQXWhebhnT0S+J3nU7ut6xncJAZqCAGRmQgUbMtbR+59GmFpAiPpajHMJ4mVNd
         YgnhmtQHNi2mkEawmzkonzRvEYfx2wuqgvyz/sQCEi+PI2Kv83cH2OXgvqQFcn7wIi
         hdmCkl+s8yaMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEAF4E5FFC9;
        Thu,  4 May 2023 03:13:28 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFLGNBvD7LbjKbu7@p100>
References: <ZFLGNBvD7LbjKbu7@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZFLGNBvD7LbjKbu7@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-1
X-PR-Tracked-Commit-Id: 6e3220ba3323a2c24be834aebf5d6e9f89d0993f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a5304fecee523060f26e2778d9d8e33c0562df3
Message-Id: <168317000883.23861.1282965046184313922.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 03:13:28 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 22:38:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a5304fecee523060f26e2778d9d8e33c0562df3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
