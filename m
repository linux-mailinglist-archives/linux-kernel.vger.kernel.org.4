Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7670D6608BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjAFVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbjAFVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:19:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF9781C2E;
        Fri,  6 Jan 2023 13:19:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF6CD61F6F;
        Fri,  6 Jan 2023 21:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A9D2C433D2;
        Fri,  6 Jan 2023 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039941;
        bh=kn1xQpFOvJgTtvRrReh5RG/lm5cqnIQ1CYjDWKrE4fU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZqBFgb4NDHeUJVRS+T3bJ89JWKByYl5IOqH4WhVQmQQf3HpKBHkqQjUHdrLWtdMY+
         I4jNIaeq8328pfSZrcg2+bMwjjCdiLVbvkydns57Djd6E5l83TE0jMU7Y19JBsXMAA
         kS7XJiklWuwlLwOCUMrR4OJsXa7mg9wBCwk7RqKIXnQWIdvsj8cnoBvdZrV6y2VmDc
         TQuJN1/25e3TNtQ4OT4HrIs7h+6Oa3hFRsKWmATVpQ+AqP22R0cjPqS0ndB8xf4bLh
         JTIf0qRG/pbI3fih02JRGX92Vz5itw35wzSjAP0+Y/jm13lLBcKSQiPAPe15qEIQzR
         +zVR3tA7nVdpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2906DE5724D;
        Fri,  6 Jan 2023 21:19:01 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230106182951.92281-1-idryomov@gmail.com>
References: <20230106182951.92281-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230106182951.92281-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc3
X-PR-Tracked-Commit-Id: 8e1858710d9a71d88acd922f2e95d1eddb90eea0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c1a712f71286b8435d48e3be5f8faf39a4cc837
Message-Id: <167303994116.10294.13009373419913022685.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 21:19:01 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  6 Jan 2023 19:29:51 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c1a712f71286b8435d48e3be5f8faf39a4cc837

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
