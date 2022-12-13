Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9B964BBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiLMSNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiLMSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C7617E35
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6D7E616CA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 353DEC433D2;
        Tue, 13 Dec 2022 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955219;
        bh=bqaJ18uJaviaiBwrju9qWeeFts51QNbiEjk9ldsOj6Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eZtMLwgwMnwUR9P6Z2Q9SBiXZ+IyGDS3QQ8BSu19CcdST2ifBG10iQtnKSz++b0Ei
         JY/1Fhfiru93Wtp8e2bLJHtjBP2xz/EHEgWtNfBRTs84PRX7I+a8gcWvpPAesD4PUh
         5Uy+n5g8ff8MuU+KoyWhUR4+kFGcCJHGrPfj2eZ+5ndb7BTTRwDCBiMGvfIXSftzrx
         5oRblpg0Gx+cGyTEbmzdjCDKn0H1d1YzYmsNLsabADyOqUSBUyyPhdtLD0e/6IZhTr
         1olGalwJSRAHyXAYVe6jWrLiGJXrbCvUAZga3lj87ANfpfx7jAH5esjUvmitAPLqgw
         srlbffK5zOzkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23490C00445;
        Tue, 13 Dec 2022 18:13:39 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTiYVO5SV6-P6gPcqR1chzwpEvwnDZaYEQACcU1kgvugw@mail.gmail.com>
References: <CAHC9VhTiYVO5SV6-P6gPcqR1chzwpEvwnDZaYEQACcU1kgvugw@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhTiYVO5SV6-P6gPcqR1chzwpEvwnDZaYEQACcU1kgvugw@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20221212
X-PR-Tracked-Commit-Id: 50979953c0c41e929e5f955800da68e1bb24c7ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbdf4d54618ca1d4af304eab6631d68fd2d6ce39
Message-Id: <167095521914.23919.14566100970871486298.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 18:13:39 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 22:05:07 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20221212

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbdf4d54618ca1d4af304eab6631d68fd2d6ce39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
