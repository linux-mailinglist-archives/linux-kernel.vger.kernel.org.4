Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2874076C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjF1BBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjF1BB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5091A296D;
        Tue, 27 Jun 2023 18:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA45561251;
        Wed, 28 Jun 2023 01:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E25CC43397;
        Wed, 28 Jun 2023 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687914085;
        bh=3xwm+OnEeWUcBEa00kXJpj5zuv7nhIRIBsV1z1yJYGc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DpY30CDQZqgi24G/D2oIwkWsMzQ2Ay7Uk/hKpbGxVzQ/O9EbCxEjXSE2+izZDJCls
         rwWoW2XKBG1/HF2gPyUenU5h2Z1qD9OqJaHsomxpildbOUWHIwExXfMNARCh0b7eJF
         L3NYVchp5St7QYicx/VHXzK7WhyDDiWcSBG45LnMK976oGa1Z3i9JU9DHDcKcbUiXP
         fkO33dhhIS4BKJfUa0aOeMoO+Nz23mXZrN5FSebu1z4Mh746navC/PyggV6dDMW9J4
         FFbMudNHW+3F7fVYfyfNKbfj1z0TXqHVBS+nhMM52OvtASIoT5gA3RtiheCqsmXsOC
         UdOh8kTrWVXYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A419E53800;
        Wed, 28 Jun 2023 01:01:25 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTcPVRAoxWn+EpMcGPThgtfhB=z3LM3BkMtxKv6aQYPFw@mail.gmail.com>
References: <CAHC9VhTcPVRAoxWn+EpMcGPThgtfhB=z3LM3BkMtxKv6aQYPFw@mail.gmail.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTcPVRAoxWn+EpMcGPThgtfhB=z3LM3BkMtxKv6aQYPFw@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20230626
X-PR-Tracked-Commit-Id: e455ca40dbcf2cd50d1e59bf4b2752b300bcdad4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cae72026b5ecf059687ccb431cb0e5965e863fea
Message-Id: <168791408523.14121.16768196063703848992.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 01:01:25 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        audit@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 16:57:23 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20230626

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cae72026b5ecf059687ccb431cb0e5965e863fea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
