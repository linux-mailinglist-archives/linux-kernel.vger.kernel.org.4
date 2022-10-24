Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A38460BCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiJXWCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiJXWCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EC1BBECC;
        Mon, 24 Oct 2022 13:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74680615B5;
        Mon, 24 Oct 2022 20:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4E49C433D6;
        Mon, 24 Oct 2022 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666642017;
        bh=1O8kPqGqfncUU4O4brSRbT/W18WlIHFlz2KbrcN85e8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EAns6jPgpTO3FcNvvcMc7p3jlmjSRKVmIaCDgZOVqa3iMZC/XnbBabaIJ0OMe0iE8
         VORZi1QGjBFzK2kMoYHD/dRzaUG3f1b3TkqSa02sCpfMOHgpUbiLJT/+sVWRMZLCzm
         xd/Bl2bZ/hsX4g5ZTC1XP4+67IEK1CsrD97ou4aQjZLj2SLCy2XW9qUvkwsM+sIIg+
         waVuSeQo+zTqOd/wD43Kcv+NC3ZuVei9x6sMU6cLURQvdcd9k1lxjhrtFg37e6J3yD
         Tz+Gdv+ou8Rbtqc3bi3EbnkfDU+Ggd/SdWbpUEnhGkj6zjS0XSEC++vrURb+moGyOY
         ImEDnY8PLpJHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0F0DC4166D;
        Mon, 24 Oct 2022 20:06:57 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for the v6.1 series, nocheinmal
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbG5kktL1qV1BTVvcp178sS6YZa8Uq4m7pbRNFbZe2zyw@mail.gmail.com>
References: <CACRpkdbG5kktL1qV1BTVvcp178sS6YZa8Uq4m7pbRNFbZe2zyw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbG5kktL1qV1BTVvcp178sS6YZa8Uq4m7pbRNFbZe2zyw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-3
X-PR-Tracked-Commit-Id: e9945b2633deccda74a769d94060df49c53ff181
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74d5b415a5ec37efd9f764782d3c6d952ba55844
Message-Id: <166664201778.4311.14543119139053026309.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Oct 2022 20:06:57 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Oct 2022 09:24:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74d5b415a5ec37efd9f764782d3c6d952ba55844

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
