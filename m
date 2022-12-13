Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801E464BBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiLMSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiLMSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62FBDF04;
        Tue, 13 Dec 2022 10:13:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 434C261638;
        Tue, 13 Dec 2022 18:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6A10C433EF;
        Tue, 13 Dec 2022 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955214;
        bh=m1ksPm9cm8rw6iNUF/v2I55H7JacOD8i4PV09IoeNxc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dQbZzJMfoeGdcNEJGJzU90q9UDW7R8dpYc0gY81vc0rWUVeN95L41NWYLl2/dgtwX
         nBLNoiETUxzpoSLTopWYjeMJIf0uUHw5fkWeSnwKGdp/kmlGt+OMT3nYPNAglyRP3C
         hyUOR+yIQQtlkiL85gug8u8P/IGdGItHL8wOxu+8DTz0i26U1uAO9BVCUTE45mu+Ic
         qahzhgQMK6Qv7IpC3c7G8dZB+0nSk3otEz/Df9gTed3MSTusmnKJaWR79ZtKZkSMhd
         go7g7F9aapndRDL5y00M+6uEY0NjPvrf7CWfiXTSEVYIj7N/sP4zsJZXrpN88+E33E
         SMPBqOuFsmdXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9434EC00445;
        Tue, 13 Dec 2022 18:13:34 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
References: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20221212
X-PR-Tracked-Commit-Id: 048be156491ff1aeb0fe5ff0862644d38cd39015
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57888f7b952d3f2696f82a701f1b3d9de7e346d3
Message-Id: <167095521459.23919.6377615402983045765.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 18:13:34 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 22:05:32 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20221212

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57888f7b952d3f2696f82a701f1b3d9de7e346d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
