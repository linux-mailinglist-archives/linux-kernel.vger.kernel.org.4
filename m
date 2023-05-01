Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B626F36C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjEAT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjEAT1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2933A86;
        Mon,  1 May 2023 12:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D5B861ED1;
        Mon,  1 May 2023 19:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE703C433EF;
        Mon,  1 May 2023 19:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682969152;
        bh=EiUB4qiy4mf5r04xdafdoqJXm5MLrbQbrCjAwXtXyyc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nI9nwLnUkqn5B2mvcMk7soPs+J/2RcVFH8u0QNYj64DK0OytJSQpkk3jrtTjPP3tx
         6rhWbi80VRENRtL3UJeN89PiXwJrxR3I2MxMJ7oQSIBZBgdNX8DQlNbvZU6nwyWxex
         EYkZrVT8KH03jAGScDzF97fFrWIlRR9Gj5f106LsBCh7rB1eCg4c1NoCKU0bIWKedp
         oruPNiVbLrW4D6nfUYzRHs/LTLxqp9lPmM0A4hk5xw/kJkFi2xc9BQWrt5KfQ62h4V
         BAT8mwzqvEwFoq7D5p84Ivrbm2Kw9YCMtRlOFP6S2oGA4u75YhsQylBiw7DccGqyco
         U2uDHOOHS7ACA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC661C395C8;
        Mon,  1 May 2023 19:25:52 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230430223614c48c29a6@mail.local>
References: <20230430223614c48c29a6@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230430223614c48c29a6@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.4
X-PR-Tracked-Commit-Id: e99ab4abebf825de2ce65f6c6c32ee30e00bb077
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f2a1903af06672f416efd506f029066b9243cbd
Message-Id: <168296915276.17937.17751394775839761056.pr-tracker-bot@kernel.org>
Date:   Mon, 01 May 2023 19:25:52 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 May 2023 00:36:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f2a1903af06672f416efd506f029066b9243cbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
