Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E27466A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDAeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjGDAeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA9E136
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E7C2610A4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B489FC433C9;
        Tue,  4 Jul 2023 00:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688430848;
        bh=a7R3HoIZJMM40dPx8k311Nr+bFIH4jTF/6bOD8n0uZs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ko7PTIT4R2UHXYo7YB8CMYB3Yx9X2nVxlKYbHbHwGe914Oq6pZisOy/zqeU4Cdj/E
         woA2BxS8t9sbdZOE+tE0McqN4fPX2Vhsmw355RyKm+X8uaDWEGTEJynWu6R1kYO8dd
         L0cMWwcBxsQUEC/ehyzNzbOWr5sO5vL9Zp9N+6P5dSgjirT44gEOm8v10U6zEOTNNw
         QIFWgi1vvHmaKVSUjOWnVz3RWwRLJ1lsop0QbulchY7bWTyF4NBLFAc+t+YwS1LukZ
         72zJSRDt9A+O2Gl28QrXgw6Z9srxS363mCZEuwpD0YH1C/AxSkRff5WeaeUK1kg3oH
         IwhHLx08UwzPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E0F8C39563;
        Tue,  4 Jul 2023 00:34:08 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230703224828.qldulem675s5y6ec@mercury.elektranox.org>
References: <20230703224828.qldulem675s5y6ec@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703224828.qldulem675s5y6ec@mercury.elektranox.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.5
X-PR-Tracked-Commit-Id: 42877c38ac78e456fd9e149842a96a3576fb36e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69c9f23070f8b4651b17557a0108d07b87437ede
Message-Id: <168843084864.6205.9096395150521645895.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 00:34:08 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Jul 2023 00:48:28 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69c9f23070f8b4651b17557a0108d07b87437ede

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
