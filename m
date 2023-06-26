Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2983E73EE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjFZWME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjFZWL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00346AC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E0D61073
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16E7CC4339A;
        Mon, 26 Jun 2023 22:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687817182;
        bh=8yB8Ci2tfWers9vzrg8iGis08w+N+MwmQjVdeqhIW/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QrgCVCLqw1Tvi+tX0OvJdqVZKTAyCKuwQQJmBNDlvZULUDBzD2qi7XM6TJL4m5seS
         ahAqNZqhJV+FtHZOgzSoHWoTpzOeGuHr5BOLMEDVsGbsQHGbwEKg6N0xyHA/x2aD3N
         mlngDzePcoytpMLXm7zP4vNV9VcoCeUH/HhUGOoz3bBQa4EY1AnLtPnIp/Y5ZYvjmS
         fg7s0jicEaztPNBmoQqNLxTX/X6eVH1SRlHT4enmuHXISf+5JROE4lLh32jh0ZUP+Z
         XnqG+B/9NN+fou/rNVLNpDoxVIrZHK8FEhrg/PV39Kktqemw0jzClTE8AoTkuiiiCH
         6Tsl9ZiuhhdVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F36C6E537FF;
        Mon, 26 Jun 2023 22:06:21 +0000 (UTC)
Subject: Re: [GIT pull] x86/core for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168778151644.3634408.18311962903658740097.tglx@vps.praguecc.cz>
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz> <168778151644.3634408.18311962903658740097.tglx@vps.praguecc.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168778151644.3634408.18311962903658740097.tglx@vps.praguecc.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-06-26
X-PR-Tracked-Commit-Id: 45e34c8af58f23db4474e2bfe79183efec09a18b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88afbb21d4b36fee6acaa167641f9f0fc122f01b
Message-Id: <168781718199.14634.573017856652134817.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:06:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:13:54 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88afbb21d4b36fee6acaa167641f9f0fc122f01b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
