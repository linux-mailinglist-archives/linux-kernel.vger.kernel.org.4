Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EAF66AC93
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjANQVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjANQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:21:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81054699;
        Sat, 14 Jan 2023 08:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E63760B8B;
        Sat, 14 Jan 2023 16:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3D1EC433EF;
        Sat, 14 Jan 2023 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673713264;
        bh=w0VDn70wqRnCrd4MDALS1fxv+kQFjGJT3MpwbTane9c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BwEDmAOtURXbI48eqa/hZmHhBEApiudO8rwUO8hS/uzlZa6SPKCohZ8HuNdJzqQ/N
         vGY5nTSFnBQnmuUtACz2ME9vQLgKr3wU22hqImv5L1JGVdAyclSBR7lKR763/Et7wL
         YoomSm7t1aB9WUIFOzZ3oAXd4WlkcU51Qip/Ya+VBVmBM3Go34ry+R40YotygkmpeV
         ww9s/GNajHPFkMUlECLyDThNf+bpOBWliqX0wEXpo1W6Bpiv2ql6+Vu4LHkMC2QWcb
         IB5uz9JwYAX/f1ZKrrCe1ge1PUH1x5/XFJ+tCkhNOZmwePpVQZ5aPOzBPlGBfMD/hV
         hgAkQf2P+m+4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BA3CC395C8;
        Sat, 14 Jan 2023 16:21:04 +0000 (UTC)
Subject: Re: [GIT PULL] modules changes for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8HnmbSvgli7fbQI@bombadil.infradead.org>
References: <Y8HnmbSvgli7fbQI@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8HnmbSvgli7fbQI@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc4
X-PR-Tracked-Commit-Id: da35048f2600633a7f9ba5fa7d6e3b1d0195938b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b7be52f3f0d0c24ee147ba7cab6c7fa4f9bcfbb
Message-Id: <167371326438.7515.4993088341393310829.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Jan 2023 16:21:04 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        thunder.leizhen@huawei.com, swboyd@chromium.org,
        yang.lee@linux.alibaba.com, linux@rasmusvillemoes.dk,
        petr.pavlu@suse.com, mwilck@suse.com, pmladek@suse.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 15:22:01 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b7be52f3f0d0c24ee147ba7cab6c7fa4f9bcfbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
