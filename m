Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1474AAC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjGGFv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGGFvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F84D1BEE;
        Thu,  6 Jul 2023 22:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 349256173F;
        Fri,  7 Jul 2023 05:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AD7AC433CA;
        Fri,  7 Jul 2023 05:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688709070;
        bh=chm3pFneSxGMrL2frbc8rgxhCRE6r2Wq/BvmnW77hRI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BvZ252kGZ/FtF9qkunWwad469l5zVGxoFs6CKdn8Bt1SFpEufgpa3tcmvTOqN6Ucq
         tR4d143Dle9Thy42az4k3oaaqyj7W+Qg/5CcxxUu9mDbdsc04EsYxFE1+zkGiXxPDE
         dIi7Uzsev+6/XQsN1mRrG5PUHA1+DOhdVEEMSEtzynCfKTMQaoXYhYlJuA5cvyUZXh
         whH81IZ+d038OCcjsfDhoIbgujjNp8OscXc4zoxC/Pc3RdD2Le1OLZe2X6owclbchj
         Tbixqxz7TZEUZB+F5UNJGZIpbkyw4KWUnZtArrcYh3MLMUT1MikVnp21bGpNxJminy
         A1r7JOU9wPsoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85F63C0C40E;
        Fri,  7 Jul 2023 05:51:10 +0000 (UTC)
Subject: Re: [GIT PULL] A few more documentation changes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87cz14d4ld.fsf@meer.lwn.net>
References: <87cz14d4ld.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87cz14d4ld.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.5-2
X-PR-Tracked-Commit-Id: e27cb89a22ada4e3e7bee1567a8daa1fb2260b78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7210de3a328c4df5cb8b25b2ef5703c72d8842e9
Message-Id: <168870907054.5711.789342435153678631.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 05:51:10 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Jul 2023 17:04:30 -0600:

> git://git.lwn.net/linux.git tags/docs-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7210de3a328c4df5cb8b25b2ef5703c72d8842e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
