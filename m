Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4732C7406C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjF0XK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjF0XKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0D294A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A19C61239
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 23:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FE2FC433C8;
        Tue, 27 Jun 2023 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687907417;
        bh=hVCHUpOlEoxqwmxafSXGLFkBksh6GMy+hjOQjrGKxaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BgtBaukGQmymLrFGCN4p71oIXWzS+/pWezypnwZenfcxJ9Udc6clfpKFDjt+sYfFs
         aRlCrfGybqV7yJEd2mZTVKaCnx8gKLAXINhYUyocdVp+xRZtVLBgjnl+5jxU3UHFso
         XtmIlYuIQ32Q55/K8p207RvBhpN6i7QWF4ZxAoutuARu2FQVM9pCCKUkPGM0ezyLSM
         Cs0ncNi8SNR0cvghwTA/b1SVbQeXSkRUS/127mSBoMn+aaHRdXu2TnzUmd/5YmgH0a
         VyHFR8/75KLDp5sUMEO4gPGdgXnAfcclWp1fUUrrBY6O6XSr3pz379mstbBR4AXtvC
         DS63EeQZaHCtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CC45E53807;
        Tue, 27 Jun 2023 23:10:17 +0000 (UTC)
Subject: Re: [PULL 00/18] xtensa updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627105451.803122-1-jcmvbkbc@gmail.com>
References: <20230627105451.803122-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627105451.803122-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230627
X-PR-Tracked-Commit-Id: f7667ca106df50ff8b776db54f85074dc9c52e1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d8026f376c8e46cc90c59de91256d8ee4322ad8
Message-Id: <168790741743.21322.13459979108280112690.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 23:10:17 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 03:54:51 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230627

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d8026f376c8e46cc90c59de91256d8ee4322ad8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
