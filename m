Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685A74A317
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGFR3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjGFR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:29:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F21FC3;
        Thu,  6 Jul 2023 10:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E02161085;
        Thu,  6 Jul 2023 17:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA34DC433C8;
        Thu,  6 Jul 2023 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688664545;
        bh=oC5zOYYPcSWHZ/Kg2RT67pNLIhkdnLtfr8RPrB+TvH0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KKrRM49x234de8FLWT2gOGcQaNTKUC5W3tQZ90ZUpXeV+T3OeJyR35rBt6vZHQeNR
         y+PJce1UkCPv9NnK+uecfY/mRWWQWqxy+W6WaNIZpBKp0jWp1Gq0izMr7lhz9M65Ef
         /2LYD63wy7FkrtxJY8JvojI9nAeKX4O62TyR4ZvwRZyyeMZot9MHHpOG3M0wUrD8wl
         XaiWnak9amWkthDv+oypD99xMYxQjay/hGiSsNA9cDttFMEhUXJ5FzUSJ70n62L9qG
         PVz/dikHB8DyAZeP3iEhydAXOeSW9DxU6iOcbALiL72+dIuD/0cpUDw12px2f+5nf7
         z1VZv9LWqBhDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B774DE5381B;
        Thu,  6 Jul 2023 17:29:05 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.5 release cycle.
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230705122357.GA14855@www.linux-watchdog.org>
References: <20230705122357.GA14855@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230705122357.GA14855@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-6.5-rc1
X-PR-Tracked-Commit-Id: 009637de1f65cff452ad49554d1e8ef9fda99e43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c91e587be8e2680786cbf0b87fa7ae92c345857f
Message-Id: <168866454574.8259.8596833359998686243.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jul 2023 17:29:05 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jul 2023 14:23:57 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c91e587be8e2680786cbf0b87fa7ae92c345857f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
