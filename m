Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1CC748BCB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjGES0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjGES0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C41BF2;
        Wed,  5 Jul 2023 11:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21850618DB;
        Wed,  5 Jul 2023 18:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89804C433C9;
        Wed,  5 Jul 2023 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688581142;
        bh=35fE4X24iWUOG8ffPnGRK7LSwjvaZONObHYQiQz6jUc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Exdc8XWp+qr1Tj17BbpsD8VcWzEKv3d04AU8m7xYUfLy0CRtGo3lkdr8MGeCEcC03
         ESsb6fPMQxwTPPDvdvpyc2RTKJHAlMIQVQ93H9PEXbzxBjyHY9uga6ngt/VLkhBxSi
         B2kvjegwYJ/NR1y7glprI+OHVRb3ddqPbOEkA9Vz48mMYDQGmO81XODjZsKf2SpWsI
         MFZfnCFuzMYzJUzfKC2Yr9oZ6WvWAq/JIDIwu+ZFY36rYyZaPQPJLGIK3gMHhMEw81
         o3TVOlL+myRBKlJUX/aFSKILACskBap/IpTCaPsJW162oUQd9YF5PVNpJVEVbLpy+W
         0bBwavJQ0hT0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C95EC39563;
        Wed,  5 Jul 2023 18:19:02 +0000 (UTC)
Subject: Re: [GIT PULL for v6.5-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230705085045.1feaaacc@coco.lan>
References: <20230705085045.1feaaacc@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230705085045.1feaaacc@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-1
X-PR-Tracked-Commit-Id: c61480a2ea5e5b997d10dfda556d3a63e31f87cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15ac468614e5e4fee82e1eb32568f427b0e51adc
Message-Id: <168858114243.22216.17101754052234942896.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 18:19:02 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jul 2023 08:50:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15ac468614e5e4fee82e1eb32568f427b0e51adc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
