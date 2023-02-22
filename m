Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358CA69FC94
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjBVT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjBVT4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:56:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E862725;
        Wed, 22 Feb 2023 11:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 016EF61588;
        Wed, 22 Feb 2023 19:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3E08C433EF;
        Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095632;
        bh=B0q65rVdXVc1MMneVl2bNAFF4k1o1J80lgduEtwKD6M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FpyMcxrJTrJmwLbLRQDd+sAiEWeV26nvkpdGIu3PbOow3vDW7hJJ5U59RF+XSZ5Ap
         J8j/HXk+CL0gprZysyMjZLGbkVoLDGRGaEnbBGFVJVzeYqptyU0AxEBCX3pNxlpRgz
         Jkh8p5C30WI7tqa9TK9cbCbtBvfJySTHqhWi5Y6jF9BivU2WEo4lMKI8lg6HJDNdhZ
         4au324VtPCNGH6Ac6MNjW5JclXj/QUsERUm8b8nqcR8O9UIijkB5W2COhU/AfnqUg1
         bXhif7iV3iCFuQBsK+cwWFR03c4cdVzav1cCoG8prfp972NPcfA4tltR2iBq8tIrCd
         sKhPEORcZJ6+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1D23C43151;
        Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
Subject: Re: [GIT PULL] pin control bulk changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdY_jnEF=qcrkqtZHQ7U=8CmY5Uaz61STHw0nYF_p6-PRg@mail.gmail.com>
References: <CACRpkdY_jnEF=qcrkqtZHQ7U=8CmY5Uaz61STHw0nYF_p6-PRg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdY_jnEF=qcrkqtZHQ7U=8CmY5Uaz61STHw0nYF_p6-PRg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.3-1
X-PR-Tracked-Commit-Id: 099f37a539e616f762241ab999495fb8aa2f5971
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5176cdbf64ce7d4eebf339205f17c23118e9f72
Message-Id: <167709563278.30115.13825988223502554498.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:52 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 13:01:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5176cdbf64ce7d4eebf339205f17c23118e9f72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
