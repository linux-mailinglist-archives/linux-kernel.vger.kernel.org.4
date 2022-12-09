Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D035C6488AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLISyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiLISye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:54:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70D12D3D;
        Fri,  9 Dec 2022 10:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA8B622FD;
        Fri,  9 Dec 2022 18:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09090C433D2;
        Fri,  9 Dec 2022 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670612073;
        bh=scus3a6MhyMwodnNEPWWldx3bilo5cxKsdcu+s48gso=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cDbMItMNYITPkxjoQ/7BmGOWl0zMDXstvhChixmUQoSOuTyaBM/MT/6TiI4nGGSr/
         K8vDJA6y7mxBfWHZpUCtAhGOV+DLRUTWlSpwHePYHUq5ciT8hqD1YVWJUhhTNZ6xZQ
         p5yb0rfH4gZw0KeRUMWFMLXbIbQiWWuKaE3aJdAvXRQElLm5MxI9rB+DSAhV/d/37D
         H2tIkNa2XbrlpzpBOE2Ze26K3mfW/hFEg/HcNhcidM54DRrciGVL13Yty/itjgw8D+
         yXu01bylCORB3EBe+6xEUHDtSt7Ec+4L6B0wak20Gv0CsY3H/pBA/I4CjFCX+i+NX0
         KiEw7NtfqYTWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCC88E1B4D8;
        Fri,  9 Dec 2022 18:54:32 +0000 (UTC)
Subject: Re: [GIT PULL for v6.1] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221209184129.1fdf3973@sal.lan>
References: <20221209184129.1fdf3973@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221209184129.1fdf3973@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-4
X-PR-Tracked-Commit-Id: 5eef2141776da02772c44ec406d6871a790761ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ecc37918c80ffdbfa8f08d3e75a0a9fca1c1979
Message-Id: <167061207289.31558.15258797660823042350.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Dec 2022 18:54:32 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Dec 2022 18:41:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ecc37918c80ffdbfa8f08d3e75a0a9fca1c1979

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
