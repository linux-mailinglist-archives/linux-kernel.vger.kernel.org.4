Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6497C60E8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiJZTLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiJZTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:10:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455330F4C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74E01B8241E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E6F1C433D7;
        Wed, 26 Oct 2022 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666811302;
        bh=P3L3cdGLMXd0xVqvo/dx7s/uOxH51JWvUkupryq4KJk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WjJ7tChHSmjjiWPpdacbl2rUDcmABaF8hozC/DJ1pTgbjCci892N4waYjdvTsilkQ
         pluGYQKK7+jZ/XD4hCNw42auNnlZBZOjQ2GR+vRXGrsbhpe5Kb5foPDPxkgluQySus
         S1Jk9rKZAQJZ7YowUK+iDJpsLzbwcKqpNxV1+WPqX50/OIdRlCqkgjFF9Q304W6Zft
         6EWQozfRROP509/omKlhAmfhYB+scMOiTJi16iryZJ9WWGDxNIGapUZ+37p5ZsYRU+
         E4f4IwzSE1KTSmECOyKjjKKIKne7LduH/JamJ0eQwT/NUqSSaE8AvyoeiFizYCjqtO
         l4Nt6LW5Y3USw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B625E270DC;
        Wed, 26 Oct 2022 19:08:22 +0000 (UTC)
Subject: Re: [GIT PULL] ARC updates for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9ad919b3-b450-8e22-c422-371957c41391@kernel.org>
References: <9ad919b3-b450-8e22-c422-371957c41391@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <9ad919b3-b450-8e22-c422-371957c41391@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.1-fixes
X-PR-Tracked-Commit-Id: 4fd9df10cb7a9289fbd22d669f9f98164d95a1ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98555239e4c3aab1810d84073166eef6d54eeb3d
Message-Id: <166681130203.7871.1414736923787179270.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Oct 2022 19:08:22 +0000
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>, Pavel.Kozlov@synopsys.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Zhang Jiaming <jiaming@nfschina.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Oct 2022 21:05:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98555239e4c3aab1810d84073166eef6d54eeb3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
