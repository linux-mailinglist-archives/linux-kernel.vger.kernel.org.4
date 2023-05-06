Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC56F93B5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjEFSzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjEFSyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AFF160BC;
        Sat,  6 May 2023 11:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B9C60920;
        Sat,  6 May 2023 18:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA019C433D2;
        Sat,  6 May 2023 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683399293;
        bh=DgcNhUvJUCd7mIUuorUQAuSXbDJx4OAxWTFbAIGHmpM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NtN0yPQAD+WaEBHXDcKi9+SGzLn6bIU3ubHYnWzPpXsESiO7G/iz3YUT66bqvdN3c
         nR0Tjh6CMCzx9CCOqzO5ZVueexZhq4E8F9dhVA2BUgOk815GPG8IPCFfG98USQmHd9
         B6AljnS0xFSja8XoYMNIErnhsBsSab4oCtuh9B640tsbRoH5299fF5waeBl6oem6mL
         9yVcKe4qLWiza6Kp7nOP0Ba/F45F3oFrNOx7qQyjI6UIa/ts62lK0bKPx+c/P9apqI
         DA2tPQHEwWEGqKaV07D31SSx8bSiR8SVPha99eNP3pKAXeoILI79F9/R7pG9dlA5di
         y9iQkc/WIFb6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7A28E5FFFA;
        Sat,  6 May 2023 18:54:53 +0000 (UTC)
Subject: Re: [GIT PULL] more hotfixes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230506104851.21c6a2846f208820e75e7559@linux-foundation.org>
References: <20230506104851.21c6a2846f208820e75e7559@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230506104851.21c6a2846f208820e75e7559@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-05-06-10-45
X-PR-Tracked-Commit-Id: 58f5f6698a72a8af5d7bfc5f49b6df60f378f167
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 706ce3caea1cc1dab8c7fd6e7d1389b46ad1570e
Message-Id: <168339929374.16735.18223709183008111135.pr-tracker-bot@kernel.org>
Date:   Sat, 06 May 2023 18:54:53 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
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

The pull request you sent on Sat, 6 May 2023 10:48:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-05-06-10-45

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/706ce3caea1cc1dab8c7fd6e7d1389b46ad1570e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
