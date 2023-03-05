Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC86AB1EA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCEThc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCETh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:37:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DC216ADF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 11:37:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FB6060B55
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03F59C4339C;
        Sun,  5 Mar 2023 19:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678045045;
        bh=bUFkFfLJWJWV74RrQ/Eee3Ybj9CDZaE86ARA1IFoyYE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z3o+m0Mjfx7W2AN/g3kGtFUPELrskOeNcEs80H8lpUk3YsZyZUiNyYm6cRSU/8tUf
         MnYqQFjhuDxKgFlvmaZOhsExgK8yvMB9zLg9Xe0HI/3XjN3YlAHkUZA7lnY+6/YIj/
         0pxDb4AeMe8teqWBo6aaIsoP5OoZtP3ekqzJEDzg1UeFvaES3Qa14D/kemNf2kE/rX
         hcQySEfmlcBxuAwJNUQtopTFx0gGKM5fVhwDID1KyvtWub4VDP8G1hHSaqMafXKu4k
         O3XebUpaHwJTmkOMlvy8qfICDj1YqbYd9vv4B8eam7Bn28p5cVDmzyaYBmaVGcEoNP
         QYrnYdS2iwzTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3A0CE68D22;
        Sun,  5 Mar 2023 19:37:24 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167800644337.309766.13683413258889415288.tglx@xen13>
References: <167800644191.309766.5757985605946414576.tglx@xen13> <167800644337.309766.13683413258889415288.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167800644337.309766.13683413258889415288.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-03-05
X-PR-Tracked-Commit-Id: dd093fb08e8f8a958fec4eef36f9f09eac047f60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f9ec7d8169b5281eff2b907d8ffb1bf56045f73
Message-Id: <167804504492.1860.1190810168147944920.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun,  5 Mar 2023 09:54:58 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-03-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f9ec7d8169b5281eff2b907d8ffb1bf56045f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
