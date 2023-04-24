Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16156ED4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjDXSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjDXSuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE4B446;
        Mon, 24 Apr 2023 11:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB563628B8;
        Mon, 24 Apr 2023 18:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BA12C4339E;
        Mon, 24 Apr 2023 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682362056;
        bh=QGZGRHrKvn2Zs2YQBPPiRvla6MKTQuzTSE9rJKLsdLw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MtE6DdFCuMRf5Hm4B9Yci7e376JtcgImeRlO7O1cLn5OW2lauC7K+5ehtveH94KYN
         9HVc7UrpKMMp/eu+03zCFW1NmZiMTM/uugg0+W57PSSgJJaUdpWiZRFOJLO3Voddvw
         vi1hSrBi9G4wpxAtUzSEu6miT8wAe142XogKa1y3301PyhmmouGeM12pc0K43Jw8l5
         F32z1YwKSvQ/I/huSiRgLchq4VUg9hiqIzv6LejMSJEXTbbSfcUZiNvzguOHWS/PV6
         TNFhyprgqqJkYsgSjm9tV/CPWgC8b4RQ8SYVCbACxUMpw65V3Hg4HeCzDE8qhgDTm5
         ZlsIq686qBJsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B7D3E5FFC7;
        Mon, 24 Apr 2023 18:47:36 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d4160d44-6dd4-abdf-e125-e3f5673445c9@schaufler-ca.com>
References: <d4160d44-6dd4-abdf-e125-e3f5673445c9.ref@schaufler-ca.com> <d4160d44-6dd4-abdf-e125-e3f5673445c9@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d4160d44-6dd4-abdf-e125-e3f5673445c9@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.4
X-PR-Tracked-Commit-Id: de93e515db306767549bb29a926f523ca2a601ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc7e22a368c2a217d2d3338b3bd984fdd0301173
Message-Id: <168236205617.5635.17082386310757265160.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 18:47:36 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        XU pengfei <xupengfei@nfschina.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 11:01:40 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc7e22a368c2a217d2d3338b3bd984fdd0301173

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
