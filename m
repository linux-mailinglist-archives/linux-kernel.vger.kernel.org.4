Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2450C5F7DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJGTVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJGTUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99586F90;
        Fri,  7 Oct 2022 12:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477B061751;
        Fri,  7 Oct 2022 19:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 184E7C43143;
        Fri,  7 Oct 2022 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170413;
        bh=Iu17HPfPp9N3wrvrQDMTeZI03jpk1YE5VCkvpTHQ8To=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vRLAKweRLWu7Zvv4NtquG/IVIJUzAz+WdgmjRNujqiTY9u/nBZMeVhxH4hFMIgM29
         l+HwPvulgGxgSGifevR0FFmwUSumx7WngUQ18PlgqXc9DdAF4rLZbHAZgdiJ8IKhpm
         NJ12LokHbbYgshXwtk7D/5GSOjgyf4bKuPP4+YeWCcDu0Ul+TYac4cjnB9ScpfwkLD
         KFfVFrGltVDY/HaHuPsD/7ITJ8JjIohsC4t16wDw5LDyybY9qeLha59TDTKW3qepsF
         xiMFlYz9ygVZTPCQaH1o+chDlHQyuDX0e0/0FpoIldQBVNapXE/tmm67jxzAn7VoRK
         44lJcnvs3JUJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07BE6E2A05C;
        Fri,  7 Oct 2022 19:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221006153325.2253653-1-thierry.reding@gmail.com>
References: <20221006153325.2253653-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221006153325.2253653-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.1-rc1
X-PR-Tracked-Commit-Id: 4709f9ea338d34276d747c88323f964e148c0c09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fb55dd14036b875b96c39d6e18fc53feb891891
Message-Id: <166517041302.8063.15667367820730054947.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:13 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Oct 2022 17:33:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fb55dd14036b875b96c39d6e18fc53feb891891

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
