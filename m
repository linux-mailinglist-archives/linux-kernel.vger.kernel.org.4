Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D157464D25A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLNWZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiLNWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:25:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E12DA94
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:25:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F21C5B81A1A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB3EBC433D2;
        Wed, 14 Dec 2022 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671056722;
        bh=yEiYH+qZ59CDSBVkmMnfCWYr5FxKe+qFuuUVnncoBV4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uogb/qwLGIAqqrCy+dPHNO1LdQwXl7WZb56AeepzUCrZ/K2fIJTtdHs/rKGyVWAF9
         YQO6yuLN1RAbe3EQPFZeY7g8+Y6r4JdeJnCcwiqVzAusLunG+rGGGr+sQAGK9xlqF5
         4/VLMMfbn5MLWULTaPwOwBetOpfm298HPXAeZJeeSeOW25mHcgxz4bajLewcei+h/U
         1k2591xljcfgfKDZwA6m7S9Wo65Drxcee+RgqGR/Fi61lWM81hDiO46hP1ic+GPTDu
         +1XbXeZ1HcQlvDBsMWeo42P7o7LtUMc6sx4Weo+1/5rU3tVbS2n8CvtPtD3b66dlz/
         AVug6mOgZ/Nrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A984AC41612;
        Wed, 14 Dec 2022 22:25:22 +0000 (UTC)
Subject: Re: [GIT PULL] kernel hardening updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202212131955.22F9FD9AB@keescook>
References: <202212131955.22F9FD9AB@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202212131955.22F9FD9AB@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc1
X-PR-Tracked-Commit-Id: d272e01fa0a2f15c5c331a37cd99c6875c7b7186
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48ea09cddae0b794cde2070f106ef676703dbcd3
Message-Id: <167105672269.22509.618659168242677175.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 22:25:22 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        David Gow <davidgow@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "haifeng.xu" <haifeng.xu@shopee.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 20:04:45 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48ea09cddae0b794cde2070f106ef676703dbcd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
