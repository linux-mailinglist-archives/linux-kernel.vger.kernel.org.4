Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B66D73AE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjFWBDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjFWBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90692210A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F86261949
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82FB0C433CC;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687482214;
        bh=Vri/YbzS0NKveeCPqaZTZuYXIFhP96iw9gWfzmr/GQk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ww5OWBeBUTWFoyhRRPsiB0k9KWlBcMlRq2QSGHSweba6dZUrse9QM3u22OYpzZSSR
         F0euVGxl0ARsBhKkd3TYSCME3eLzZRPfxeWFIW3kEeErqdkRZtQdG9SeV9fgmAeKDS
         8oXm2WkFTv67n72I4xV98q6W6EfUK+5MtPizk7GaoCqbhVUnYNHb+GW5FgGykl6BgW
         isRw8B7hD2qTRM27C5pgYXaHgW+qUru1gVqRctSgMtfp++YIEPyglNK4EuyXlP3hwo
         mA/hDXkVr5dYKj6WeicydLeNS9NdPnfqGGadBtVunLJf0ZuMX0Yrgj1Vxndga75MkQ
         ve7okybUhzLsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73334C691F0;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.4-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230622151656.54164-1-pabeni@redhat.com>
References: <20230622151656.54164-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230622151656.54164-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.4-rc8
X-PR-Tracked-Commit-Id: 2ba7e7ebb6a71407cbe25cd349c9b05d40520bf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb
Message-Id: <168748221446.12146.913932329704204041.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 01:03:34 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Jun 2023 17:16:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.4-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
