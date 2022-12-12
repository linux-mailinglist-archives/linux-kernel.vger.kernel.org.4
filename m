Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA27364A959
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiLLVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiLLVM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C20A1A229
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E838DB80E20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6B5EC4339B;
        Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879509;
        bh=0vNEfZnV2ds87LaO1jygGexe8W9vQQpM8xwBH8Cz9dI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GCIUwoEvQPKrxhZq9NseG6EKakra+7aruHQLspX0wlYYBSiB0Ewu+qsQ5sp27FtKs
         rD94u+f7Ttpxgb1RI6LoUmpx94lFiwcnpo0L7kzF78/6Y3oTzXGdXP1e3L0AWa3vGM
         3aivuhNTya7GLmtk6ia2+sHJDPyE7iVmT2Z+TmhBAyrRN8gmXHRXAr1SlUfTVzfqaM
         zAL6TOGequk2vot9tktBoBB5InEX/BSTgkVOiZO7kK6H91LAUs+gdjGPhp4WSUcrFb
         aySpBwn59otS/bkcmtHBPBVBh8AYZcX0dDAwyKPRkS4Sg6eOHzh8UVHUiaZreX2GXs
         9+FWP214Fn5Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7453C00445;
        Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167083908037.564878.14292182209678650008.tglx@xen13.tec.linutronix.de>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de> <167083908037.564878.14292182209678650008.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167083908037.564878.14292182209678650008.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-12-10
X-PR-Tracked-Commit-Id: 6132a490f9c81d621fdb4e8c12f617dc062130a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d33edb20f7e6943250d6bb96ceaf2368f674d51
Message-Id: <167087950968.1809.7691139257094856602.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:09:01 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d33edb20f7e6943250d6bb96ceaf2368f674d51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
