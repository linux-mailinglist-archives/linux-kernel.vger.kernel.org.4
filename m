Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6770D5F8EEC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 23:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiJIVSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 17:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiJIVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 17:17:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C08918E14
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 14:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C8D3BCE0FF7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03A60C433D7;
        Sun,  9 Oct 2022 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665350237;
        bh=nXvn7RxMyw4pSQFJA75jANc+pkT5QrH8en/0Msg0ykI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gmAadQAnSdEDdda9Y0uwSHRND00vUzxyEKtPV65fNsyQXGg6x37feQUxK0cruYeI4
         G1hrWrKVn6nShqQYhtV5k+8NauMVzRK79xWi1tr039Iq+RHBH0rVmRFPHKAmruLzc5
         7UEoicQnRkEmF1plzgrCGTNxwKllpQDYMHxZ24YDM2DU5O0OoyIkiAlLDud6zHeNwt
         Oo+YdtDe8GnXFcVqDllUC3s5lTbX/VQ/92+GeKEK5GR2kBm5fcI77Vy22dL+oTGES3
         SIAQxlRLk+133QDWplEILbsau2oTqQ5zDe9RitSCgdmoRyy7aokpUbhewYqXvd+hQW
         ex1LN+Ob/h9KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E879EC73FE7;
        Sun,  9 Oct 2022 21:17:16 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8a07f7df-bb5d-6b9d-e4fd-5c227de2a5aa@monstr.eu>
References: <8a07f7df-bb5d-6b9d-e4fd-5c227de2a5aa@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8a07f7df-bb5d-6b9d-e4fd-5c227de2a5aa@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.1
X-PR-Tracked-Commit-Id: adc4cefae9cfafc1c88b789021266d6f09a0ecef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57c92724c8c19fc1b099826610fdb51985de12ba
Message-Id: <166535023694.11566.4786246544406331291.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 21:17:16 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 09:43:31 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57c92724c8c19fc1b099826610fdb51985de12ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
