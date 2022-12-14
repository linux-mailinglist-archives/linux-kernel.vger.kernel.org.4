Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28C64D257
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiLNWZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiLNWZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:25:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8532A731
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319F461C2F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E895C433F0;
        Wed, 14 Dec 2022 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671056712;
        bh=emkK7uVHAHPPisbFPZLarrUOcQaWU4gAdZxQW/RfXlg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sMP5m9IkiqW8KW9KnCGvYHm97busFKqJUKRk9jfNAXorxWqdc9I3MBoSHATuMqNBX
         qxGwsZqb2FGJ/4u6lDJIaVAJZYM+fnCP0MXD6R+ffGokyXD2ByPAf/spa1SzFfnDWG
         ETuLXsc2rsn81yJJvUzT92AXL/i4iywB6u18e1LSe/9hx4NZlBUsFMPM8SPP3h7XzX
         LrcMDDgAlWCBOBVKc4elq8VNIsCyVqmRbvaw9Pwdl6I/VpfAhgV/JGT9ex1UsBgah2
         agZzsZaV7qNTEWp1mkxiFWvoa+o+WvEAS5tbsMGK5J1YaMkfq4ShHIkv30zsBrbwRc
         D1yhci72gKYTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B4BBC395EA;
        Wed, 14 Dec 2022 22:25:12 +0000 (UTC)
Subject: Re: [GIT PULL] memblock updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5gxEtdyZuqp6hZd@kernel.org>
References: <Y5gxEtdyZuqp6hZd@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <Y5gxEtdyZuqp6hZd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.2-rc1
X-PR-Tracked-Commit-Id: 80c2fe022ef5d29f3bafee90c37dbcff18cab57a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad76bf1ff18e059d64b70047940d298641d4cc2f
Message-Id: <167105671250.22509.5519394715684413803.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 22:25:12 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 10:00:18 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad76bf1ff18e059d64b70047940d298641d4cc2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
