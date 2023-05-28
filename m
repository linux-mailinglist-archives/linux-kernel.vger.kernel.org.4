Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1B713953
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjE1Lqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE1Lqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AB7BE
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 04:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F858616A8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 11:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3329C433A4;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685274402;
        bh=m3CaeezyoEiwFoEs3RWSbWE7TNCR1p5fKbCo34lEVYA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lkf5urGECF9AYs66Pexo2vtONmM/pKTlbeus6iM5Bk+ml4eJJOdJbqLb6jZcvs7ut
         CjSYE4XRD/9GXgow4pUmhhrMjWj+tq3TnIrZwEl4gXL3wCCj7U0QDPMf7CkNsQJbaa
         tMs+Pi2PAfx96G3whcPLWbXI9AFEpnvNrgJIpB/krq/zcHRBq2mXw9JDS0Kv/pg7Jr
         cfZjLUoCwgCwOgyeb9U2MZGxdquB6LWTbuLTmIwWeyPbUlO2t/7GB7uzoiQDGADDNt
         escFLbxQhN/0jawpyis+u7Zvc6VpsvO8Kx+6IpNqoJ+adAT7x3+7jfg/57X3bSpnom
         cvUsMyAZ3eC5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C40A1E45BE3;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168526036137.3457722.17274974250309862601.tglx@xen13>
References: <168526035526.3457722.14103350194452732675.tglx@xen13> <168526036137.3457722.17274974250309862601.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168526036137.3457722.17274974250309862601.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-05-28
X-PR-Tracked-Commit-Id: edc0a2b5957652f4685ef3516f519f84807087db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8b2507c263d6c1478d179c7c260064a61f14542
Message-Id: <168527440279.32373.5553660649309336146.pr-tracker-bot@kernel.org>
Date:   Sun, 28 May 2023 11:46:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 09:53:02 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-05-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8b2507c263d6c1478d179c7c260064a61f14542

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
