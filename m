Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B40B5F3AB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJDAhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJDAgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B0A2873B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3749F61238
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 999B8C43143;
        Tue,  4 Oct 2022 00:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664843808;
        bh=Siyy3l8KR6cSwnAcBBMlM4t3S5uWGlCwu54meOTpBjM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dnjNNUBwPSnmmerZ1tDch79sRz5pDNow4zg8S7jmq4XsQAuHLOdqvdz90dAe4Kycw
         s3Y1OOEfie7hAcDFtKJBZwzGYuV2jmBUhGQfYSL62FY6PFXmsI6RAR+we5ZlzRaTDb
         jcysq/pvShxl71nlzMyg8BSt2ChHO/WwCnTl3raW2pjFzPJfngBG1j1OC3PoawxExt
         GKo/sUs5V/ebbesW+pyFHmD7OFDdZkc9cDDgddadJhbd3yU8bORBaD7oDnnm/sbgSa
         0YlXWy7/FVSvXL95hylfrAaQxXO6ZOqykHE1ZaOqg/+9ygIRWoLuHfrfvdDN4B2PY4
         UNbKmu4CduPmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89E1AE4D013;
        Tue,  4 Oct 2022 00:36:48 +0000 (UTC)
Subject: Re: [GIT PULL] kernel hardening updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202210011003.B89BF8B@keescook>
References: <202210011003.B89BF8B@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202210011003.B89BF8B@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc1
X-PR-Tracked-Commit-Id: 2120635108b35ecad9c59c8b44f6cbdf4f98214e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0989d01c66fed6a741820a96b8cca6688f183ff
Message-Id: <166484380855.25503.17236336422918861409.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 00:36:48 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Bill Wendling <morbo@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 10:46:51 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0989d01c66fed6a741820a96b8cca6688f183ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
