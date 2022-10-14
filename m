Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE45FF3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiJNTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiJNTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:13:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6EE1958D0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0D616CE2751
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EDF3C433C1;
        Fri, 14 Oct 2022 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665774831;
        bh=TW4YgGyH9D58uUe4taBb5NTFujkXWmsL1Srh1A10XAs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OwpLr+eSS3mEslOE/Mytn+wOjXt2mhIDQ6/odhJHACu9FTYCIw+X99EZptHdIqlva
         FYYQ5qMikdIpLvIda2qCO7Viu9M1RvEejp2BuhC1i17h5C+Z2UwhHQWYhLEH7y/0Sk
         6X4RUPC4NBusWwElxHZ4D0e+jVSbWxTTaHiFkYOhp3lOndbLftmAIhoUkBko40zR/x
         jfndxJsS6I8i+EXI1sSfuSjbfEaDyco8WqV1lPY/zdL2nfvIB5lMwolds4xKCEbpPm
         Tp0v/1LoEVRMsQhcy2e2ORXwPq/hGJuGcwzhinSpTDOVP2BcukcvbaM1R8ytd3BMC/
         SL8SPlZPOorpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28C1AE270EF;
        Fri, 14 Oct 2022 19:13:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874jw6my2x.fsf@mpe.ellerman.id.au>
References: <874jw6my2x.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874jw6my2x.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-2
X-PR-Tracked-Commit-Id: 90d5ce82e143b42b2fdfb95401a89f86b71cedb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70609c1495ae64e6534d8db7d6280dd7c79de815
Message-Id: <166577483116.24477.15005630930379569241.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 19:13:51 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 22:41:42 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70609c1495ae64e6534d8db7d6280dd7c79de815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
