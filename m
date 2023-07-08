Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F1574BEEF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjGHTSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjGHTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60519C5
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3BB060B05
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68558C433C8;
        Sat,  8 Jul 2023 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688843915;
        bh=VytE45UWTg3xSbX7s+3iiMrfiBiDDRMbHCAXy+7UhW4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S0VnM1OvybCQCA3l15mWzWY7/qNwveNd22//9+W23F9EMW9Dm+rbxvRFIjy4MHwm9
         Dhq1L6Nh0wJEDE6ps/qMsnWT2bfQvx/ayxdZRIkVnR7OK6yB/HkYy2k7Jldn+w6F4m
         0goj+q04beFMFvlFbT86yZay6k+/hjr1/KryvTRzyFXcMDlhsNv/H23ljh3x1oT/z7
         sf+Dh+06K04e/O6+wA+5fkwhm6eRAT35pd4eAzKIW0fsTK2PY3xJCL/qURfTm3JlfX
         0RyKjV5FRYlLM9LTPMq6UY+rYbAOC8W4ZgepFjUojDASE9hX1T3m9aSnRIlnOu/ylq
         oCz45A2idBBFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53B73C4167B;
        Sat,  8 Jul 2023 19:18:35 +0000 (UTC)
Subject: Re: [GIT PULL] bitmap changes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKG0MO5/1SgEobf5@yury-ThinkPad>
References: <ZKG0MO5/1SgEobf5@yury-ThinkPad>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKG0MO5/1SgEobf5@yury-ThinkPad>
X-PR-Tracked-Remote: https://github.com:/norov/linux.git/bitmap-6.5-rc1 bitmap-6.5-rc1
X-PR-Tracked-Commit-Id: 2a3110e3f97ddc0f53bb766797b926a35edd07e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad8258e87729e4337569c4b7d30cfdd4b299179d
Message-Id: <168884391533.19389.1882342328626055665.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jul 2023 19:18:35 +0000
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gavin Shan <gshan@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Jul 2023 10:30:24 -0700:

> https://github.com:/norov/linux.git/bitmap-6.5-rc1 bitmap-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad8258e87729e4337569c4b7d30cfdd4b299179d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
