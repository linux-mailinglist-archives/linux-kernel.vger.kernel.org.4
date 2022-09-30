Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24225F16A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiI3X3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiI3X3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270E124148;
        Fri, 30 Sep 2022 16:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA2F62573;
        Fri, 30 Sep 2022 23:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 891B8C433C1;
        Fri, 30 Sep 2022 23:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664580557;
        bh=IM0jxT25DVQ1dSz+COIBpCwiDoBp3UlI7uqVGbNETks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S5574L6PKfkO5D8y+DfoHq6SSZqpRaNBKeOe/+1qnvPyWkKM7BN1vjacO7/EezrC3
         oPLOVHF4PWQ41bYsO4ePHavf0ffFNH2TKEWKyFGOJqnfjw5WL9l48NQkIzJnpKcRgh
         41Azai+LhHZ+Py/1Bx6VzAGc8rmcb7ON4f+Ui/xIOzxdgqkiIqNLD5+/QjaGzsvNk8
         ZDjEzdNc8R+RUT15qeYGD8kmYG03pvRC12k1bUMwv5SSyfvEuK627D7GfI7krLj6Re
         kTA8WLWf8/KL/n2WAF2+slbJoxGDSgnCCr0+ekB6QtWVlNOgHqH5SoN9X6DO2ojtMS
         LmGf4KPd0wLVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7575BE49FA5;
        Fri, 30 Sep 2022 23:29:17 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220930211339.2945387-1-sboyd@kernel.org>
References: <20220930211339.2945387-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220930211339.2945387-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: daaa2fbe678efdaced53d1c635f4d326751addf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5fa173f9a472dec2f8d5fb63d5c8824c49c6e51
Message-Id: <166458055747.7949.1663473577169057428.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Sep 2022 23:29:17 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Sep 2022 14:13:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5fa173f9a472dec2f8d5fb63d5c8824c49c6e51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
