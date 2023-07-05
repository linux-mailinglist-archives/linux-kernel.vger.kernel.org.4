Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29316748BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjGES0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjGES0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A39A173F;
        Wed,  5 Jul 2023 11:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E000618E6;
        Wed,  5 Jul 2023 18:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADCB3C433CC;
        Wed,  5 Jul 2023 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688581142;
        bh=9VcYs0PMk5JY8uCae4b17HmH7IMWdH6ohnEQAF6mZEY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UtdZ+jOYFJGn6cyBIW+Zi/WEUESiaLnhjh5UHGuXRMQIuKHEwtNGLQ2fxS2BFAkmn
         YZqCkaVI9LXumU8UCsc8U7TcHGFWc5q4eN/4TTWDp4sVdEFDnwv73fILIj8WIrOS6U
         Vk7EaNRCG9lHVRQfpgEmGFxI0+w1ef5o3zBHFTa1U+EhGH6U3XCDcPPP96rTtnn9Lo
         H/aGvoNQlJ8wLtMe0duJ+J9BiVWDTaovZyZYphBUDAsRdDmTKfTUesoRKWPGE4TIn9
         dUF2x5YALlMlLVi8wRWRs3GbufG0IRhbrnJx7KRjtQGMUdpxgVsG+zsFQrqKuCLJhU
         L9LpxO8VIOp5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 927D2C0C40E;
        Wed,  5 Jul 2023 18:19:02 +0000 (UTC)
Subject: Re: [GIT PULL] more parisc architecture fixes & updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKUZFS4CGOHNJR1S@p100>
References: <ZKUZFS4CGOHNJR1S@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKUZFS4CGOHNJR1S@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc1-2
X-PR-Tracked-Commit-Id: f8a473bf5db7a6abaa7cad40303e395dff702819
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a95b03d4cf780611ac6903fddc79e6d9789966e
Message-Id: <168858114259.22216.4732138613267479688.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 18:19:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jul 2023 09:17:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a95b03d4cf780611ac6903fddc79e6d9789966e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
