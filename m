Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E59A73E68A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjFZRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFZReN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D15710C9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD88560F13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CFBBC433CA;
        Mon, 26 Jun 2023 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800851;
        bh=uVUhhinkbWKmcSKKmCqs6GOtREP8RvYPgi0GtFhgssE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WxHEIpWh55urYsXPveVZqIaa2XOYbI1WyUejoltduvGC1A4O6WrMZUNrzIxKP1rFM
         AoaeFZ/NENywoEclWCsk24jYcj3ewW64FITlLFLyjW4mrBnjflpoqF12XQBdfyoQvJ
         TDq/Q+l7d1lb52jdbKT3RFLlSIKkImY8Ao7ilvtYax8AvRoOP72gbkNGaNRojsYlkh
         PFg7EOhobG7K5CV24FK1paibTgWhSOYphxyRIp0lmtrTjwg7aoUlJpUF4pP/iHBloF
         grQ6rGOd5SvJAK/V5AG6ZacFYSEP/7pFVknnd9yGBY1iRUXMfTETjRYxqIaKGJnEFp
         A1254i+VA4sCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C13FC41671;
        Mon, 26 Jun 2023 17:34:11 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230618163542.1090462-1-ojeda@kernel.org>
References: <20230618163542.1090462-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230618163542.1090462-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-6.5
X-PR-Tracked-Commit-Id: def85dce1451ec276b8047da2010b6e6a159c2b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f268d6d2c244baf2c7769f33782ca532717723d
Message-Id: <168780085111.11860.9761484622645131079.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 17:34:11 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Jun 2023 18:35:17 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f268d6d2c244baf2c7769f33782ca532717723d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
