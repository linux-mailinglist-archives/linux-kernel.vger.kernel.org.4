Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4436EC0E4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDWPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDWPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050851701;
        Sun, 23 Apr 2023 08:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94A3861B1F;
        Sun, 23 Apr 2023 15:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05982C433D2;
        Sun, 23 Apr 2023 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682265007;
        bh=zNkp3GHigrbf7hoDaccb9vLskZXLzFsz2p3Nzxs8cho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dRhGmvldyqnJRRTN4gajw1+UKXcRQ0/2IcoAGOgUFaoTu1R8pfKWI4xN7kSYyzy/y
         WIguC1UDBZYhJ2zY5DFTpC2o1CaaCrhhKgRGe+9ZucO0PUOEmQQlRNqZf66CgirnVP
         W7o8XtRN6JUAOZNQW+WMPWsuIvGg4AAdL1FfDcEmCFQ3LYIF92uZFwxMp18Zchnjsx
         15C4dZpJ95vo4fEAlNMsytlO47MCc/WXLPIXhERthjIf2tSPbx8IIxfybiDeUawvEg
         ZyIip1bV1F0XbTZrkHOBqjt9eQjg1Gls3xpuuZj1N61KY/v1unLbXf8iGcvOoGXVIH
         PfVU9lbpXWZeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E600AE270E1;
        Sun, 23 Apr 2023 15:50:06 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZES2ldRn0nqkf9v2@google.com>
References: <ZES2ldRn0nqkf9v2@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZES2ldRn0nqkf9v2@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc7
X-PR-Tracked-Commit-Id: 5dc63e56a9cf8df0b59c234a505a1653f1bdf885
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6b78224c65e395db6aa66ea74522d9899c8aefb
Message-Id: <168226500693.30621.14085476133923490032.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Apr 2023 15:50:06 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Apr 2023 21:39:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6b78224c65e395db6aa66ea74522d9899c8aefb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
