Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3338E64BEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiLMV43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiLMVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3241A25C6C;
        Tue, 13 Dec 2022 13:53:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8BBBB815DE;
        Tue, 13 Dec 2022 21:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BA67C433EF;
        Tue, 13 Dec 2022 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968436;
        bh=5f0D9E0Yrv1abE9PbsJ0kK9G+F4j7OT/+oZ/cwnmFMI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VaPisyoKCf6mtxpI/ey4gLlolEdS8qlfqlLxA9fwgQO/swWlV+1ihmNvc0S5jBM41
         XZBZjj3hGd04Jf9nbDcZxT0Vn1u30R0q9CL4dFJnebtdjVVmCI2eI9uuJpwNtdxxX3
         bw9Pe12uXnzM34xkh0J17tuC48wCuPpXarHAcwQxm8wkMFuYtN2y4u/9VTMYew06zQ
         4OcA1+zSK8Zb+cn+x8XTpbVwAe0Dpdk3m3AKn51tFigShTTNKqvm1C4UaoBKP8Nb8x
         LRRxzLsxBwziPTj+cKTrdvi4MYHPrRRlVU26LV7rRoaqhozVwS1zMZ3s8XwOMBghOE
         amMf3IurFGqSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C79CC00445;
        Tue, 13 Dec 2022 21:53:56 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.2-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5eCBO0BlBsr1smj@google.com>
References: <Y5eCBO0BlBsr1smj@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5eCBO0BlBsr1smj@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.2-rc0
X-PR-Tracked-Commit-Id: e291c116f60f3c1ca98090f0f8e7c77e658562fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86a0b4255e84563739d137ad374af6c7215bb3ff
Message-Id: <167096843650.13204.8266130137703542387.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:53:56 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:33:24 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.2-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86a0b4255e84563739d137ad374af6c7215bb3ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
