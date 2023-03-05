Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F96AB1EB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCEThn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCETh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:37:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F1218142
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 11:37:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 91C27CE0B2E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1F72C433EF;
        Sun,  5 Mar 2023 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678045044;
        bh=Au9TsPHCiT2w2spjB1sHUWWUHWCKRsL9wyFNp+aSzbU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aCQBaPiz5VToZwkzafXEsd7HvL9/DOks3LgiQV153EDFsKiBB/7UFUtSpz/d8qTln
         Ifd7I/IxBByg763kQ23W1HGhynuf9uNp/85Hpss1omEIsUk7d6YB5POyRczMvSgwYu
         98jcKYayiX3ZlD+4XyWMyIocKQ/9ZLPnNya1Q6518jThtveuHnWGjve0sfMOBSjR8d
         7TyiHbQAYTO5hUz3R7vzYrpMCbigSWT6sMyp4i8/OKyij0ZwJMEtbeVUYzaRNHfbt5
         sVvZ1FPneHyaam76Mn57isu+8T1EvBDyc/O/ZCvSWPL/pL9a4yOxigHBCntcByI3nx
         3wkG7Hk0frIew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C390EC41679;
        Sun,  5 Mar 2023 19:37:24 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167800644191.309766.5757985605946414576.tglx@xen13>
References: <167800644191.309766.5757985605946414576.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167800644191.309766.5757985605946414576.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-03-05
X-PR-Tracked-Commit-Id: 0fb7fb713461e44b12e72c292bf90ee300f40710
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e9c542c7a51bcc8f6ce283459900ba47a6690f5
Message-Id: <167804504479.1860.999029850534481937.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Mar 2023 19:37:24 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  5 Mar 2023 09:54:57 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-03-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e9c542c7a51bcc8f6ce283459900ba47a6690f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
