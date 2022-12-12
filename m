Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7325264A94D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiLLVMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiLLVMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE541A209;
        Mon, 12 Dec 2022 13:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2355D6116F;
        Mon, 12 Dec 2022 21:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87FBBC433D2;
        Mon, 12 Dec 2022 21:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879501;
        bh=MtCCjj01J7FLmolQrzuF+Ufx9SocZDkA8hVoYgrCi3c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hu16aVEeK6xRciBOQr1ct03dDArDNHNjVK4ZQS/cfIb45PJPmwj8B4qyASQKjtuIf
         LE3dAh6og2y2YCO1iCk0we8engixdBbAOrBwfhsrAh14n8rGGxk2C4pYfqzohHWukN
         d2uKdb0CsVW5/wQvbCwdEeURPvNi8j1N3nfhJ0Qwx6cySzorLw8YkPzokbu7yzoB4l
         cb8bRA/oxZLYczo+IpqhYbQlRBJAfEUd/qTT7J+Q7oRG+V7dC/sXcutGGPiE/wK3Nz
         VudQf8/OdVHM/c8dkSd+y9hK6YKmyAfUWSoinxB6GAYTBGtFoesv7SVgqprcm8bDoz
         Gi+JhtYsGg3aQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7679EC00448;
        Mon, 12 Dec 2022 21:11:41 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212100149.GA4565@alpha.franken.de>
References: <20221212100149.GA4565@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212100149.GA4565@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.2
X-PR-Tracked-Commit-Id: 4c587a982603d7e7e751b4925809a1512099a690
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5977aa66c47f8e9629e88f1e983951a09801ccef
Message-Id: <167087950147.1809.7693803035715396995.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:41 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:01:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5977aa66c47f8e9629e88f1e983951a09801ccef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
