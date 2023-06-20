Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF367374D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFTTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjFTTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EC294;
        Tue, 20 Jun 2023 12:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3C656143A;
        Tue, 20 Jun 2023 19:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E500C433C8;
        Tue, 20 Jun 2023 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287712;
        bh=KNu5p5uu06AfWiVxNIprgD7LT894vJcga0bYRy+BUjc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OIYkn1BpmVNFAK7+fVxP/mbPP6G9FAJqJ7j/tvYlc+ZcawTIK4xM8r9QPI8Ld1kaT
         ioYSiCBtt8za56Q8eYTkHhN8D4a8ifabOisOWPq3nafPhMTU5Kv3pMjWzWgPQnY8N5
         rOsVyIupyU82YjnHxp68ulYHAMkBHX6X8oAlRJy9oxKPRmIkP/kmU/CtUaWLr9VSp2
         H8GPMX9c6v6scFr9n4wQMlLl6sFaQffKM6RBvGuIfGra83YQKk6MPyjhWzy9Xp1oEf
         jZN0aMT1CM6yYFG7WS/1IlNiNZoWa90dCEKMaU3ezB0DdVv0tap7Nhxm9DOlNPUl0y
         NANEX5L45twOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 280BDC43157;
        Tue, 20 Jun 2023 19:01:52 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtp7foUpjRP4MDgP=1SjXoTA0RAofYxavNGuAFE3R=y-g@mail.gmail.com>
References: <CAH2r5mtp7foUpjRP4MDgP=1SjXoTA0RAofYxavNGuAFE3R=y-g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtp7foUpjRP4MDgP=1SjXoTA0RAofYxavNGuAFE3R=y-g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.4-rc6-smb3-server-fixes
X-PR-Tracked-Commit-Id: 5005bcb4219156f1bf7587b185080ec1da08518e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99ec1ed7c2ed358280588ab1d013387e8c7a9333
Message-Id: <168728771215.31884.18134918001102939496.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Jun 2023 19:01:52 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Jun 2023 23:45:04 -0500:

> git://git.samba.org/ksmbd.git tags/6.4-rc6-smb3-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99ec1ed7c2ed358280588ab1d013387e8c7a9333

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
