Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0D740707
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 02:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjF1AFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 20:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjF1AFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2412945
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 17:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FB276124A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 00:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 745A2C433C8;
        Wed, 28 Jun 2023 00:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687910729;
        bh=/ym3sp7DMtOlREnUD1d10fxnqoUHiNu+IKfRJPjaMlk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JC3KPClbyA91Oqzyskdy51X61oqt6gSIBqDx/5GE6bdPopXcrjy5Zr/zle2dcgj7m
         3ghzRUl+Us1a/0uo0vKz5b0xt7ZKIZ3DX4+wca2q3EUlnpXAGGsby8Wk18Dc1YxTaW
         refpRtERDYZ3O8jIBuBypA6RphlaBUpbx6+Ov5jX9KC+bXxqp1gqSHuL+0FnQIH9rZ
         UjYRCbjHzn7lUNKgw7gmHTxrWKAkmtROwW1nSdTLWRMyrsx9Piif5gmND9ZiNV9oLT
         lffE9Eop0gNY++OIEfSJjFcSNkcX1NKVWTShcu+Sc1C8GlwjYOAwFfWB8GR1NEosv/
         5A1TiXmZyptIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54BEEE5380A;
        Wed, 28 Jun 2023 00:05:29 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for-6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJoG-BptcGoHII35@slm.duckdns.org>
References: <ZJoG-BptcGoHII35@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJoG-BptcGoHII35@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.5
X-PR-Tracked-Commit-Id: 18c8ae813156a6855f026de80fffb91e1a28ab3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ab044a4f42aecba23db5ce96e763e5ec807bf42
Message-Id: <168791072932.16670.8605609594139028733.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 00:05:29 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 11:45:28 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ab044a4f42aecba23db5ce96e763e5ec807bf42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
